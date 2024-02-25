using Dates

using HTTP
using Franklin
using TikzCDs
using TikzPictures

import Bibliography: import_bibtex

include("data.jl")


# example
function hfun_bar(vname)
    val = Meta.parse(vname[1])
    return round(sqrt(val), digits=2)
end

# example
function hfun_m1fill(vname)
    var = vname[1]
    return pagevar("index", var)
end

# example
function lx_baz(com, _)
    # keep this first line
    brace_content = Franklin.content(com.braces[1]) # input string
    # do whatever you want here
    return uppercase(brace_content)
end


"""
    \begin{tikzcd}{name} ... \end{tikzcd}

See [Demo: TikzCDs](https://franklinjl.org/demos/#009_custom_environment_for_tikzcd)
"""
function env_tikzcd(e, _)
    content = strip(Franklin.content(e))
    name = strip(Franklin.content(e.braces[1]))
    # save SVG at __site/assets/[path/to/file]/$name.svg
    rpath = joinpath("assets", splitext(Franklin.locvar(:fd_rpath))[1], "$name.svg")
    outpath = joinpath(Franklin.path(:site), rpath)
    # if the directory doesn't exist, create it
    outdir = dirname(outpath)
    isdir(outdir) || mkpath(outdir)
    # save the file and show it
    isfile(outpath) || save(SVG(outpath), TikzCD(content))
    return "\\fig{/$(Franklin.unixify(rpath))}"
end



"""
    \begin{tikzpicture}{name} ... \end{tikzpicture}

Supported by [TikzPictures](https://github.com/JuliaTeX/TikzPictures.jl)
"""
function env_tikzpicture(e, _)
    content = strip(Franklin.content(e))
    name = strip(Franklin.content(e.braces[1]))
    options = Franklin.locvar(:options)
    preamble = Franklin.locvar(:preamble)
    
    rpath = joinpath("assets", splitext(Franklin.locvar(:fd_rpath))[1], "$name.svg")
    outpath = joinpath(Franklin.path(:site), rpath)
    outdir = dirname(outpath)
    isdir(outdir) || mkpath(outdir)
    
    isfile(outpath) || save(SVG(outpath), TikzPicture(content; options=options, preamble=preamble))

    texFile = joinpath(outdir, "$name.tex")
    isfile(texFile) || save(TEX(texFile), TikzPicture(content; options=options, preamble=preamble))
    # mv("$outpath.tex", "$outpath.txt", force=true)
    texPath = joinpath("/assets", splitext(Franklin.locvar(:fd_rpath))[1], "$name.tex")

    return """
    \\fig{/$(Franklin.unixify(rpath))} \n
    #
    \\input{tex}{$texPath}
    """
end



"""
    {{ show_pub_list }}

Render `research/publications.bib` in a chronological order.
"""
function hfun_show_pub_list()
    bib = import_bibtex(Franklin.locvar("pubbib"); check=:none)
    card = Franklin.locvar("card")

    io = IOBuffer()
    for iKey in bib.keys  # reverse(bib.keys)
        x = bib[iKey]

        authors = map(x.authors) do name
                abbr::String = titlecase("$(name.last), $(name.first[1]).")
                if name.first == "Zengchao"
                    abbr = card ? "*Xu, Z.*" : "**Xu, Z.**"
                end
                # if card & haskey(authorURL, titlecase(abbr))
                #   abbr = "\\link{$(abbr)}{$(authorURL[abbr])}"
                # end
                return abbr
            end |> (x) -> join(x, ", ", " and ")
        title = replace("$(x.title)", r"({|})" => "")
        journal = get(x.fields, "journaltitle", nothing)
        date = get(x.fields, "date", nothing) |> Dates.Date |> Dates.year
        doi = " [\\link{link}{http://dx.doi.org/$(getfield(x.access, :doi))}] " # x.access.doi
        pkg = get(x.fields, "shorttitle", "") |>
            (x) -> replace(x, r"({|})" => "") |>
            (x) -> get(packages, x, nothing) |>
            (x) -> isnothing(x) ? "" : " [\\link{pkg}{$x}] "

        info = if card 
            """
            \\itemcolor{
            \\icon{card-heading}  $title \n
            \\icon{people-fill}  $authors \n
            \\icon{journal-bookmark-fill}  $journal, $date. $doi $pkg
            }"""
        else
            """
            \\item{
            **$title** \n
            *Authors*: $authors \n
            *Journal*: $journal, $date.
            }"""
        end

        write(io, info)
    end
    
    return  "<ol reversed=''>" * Franklin.fd2html( String(take!(io)), internal=true ) * "</ol>"
end



"""
    {{ show_talk_list }}

Render `research/talks.bib`.

# Others
Icons are available for some elements:
  * Event: card-heading.svg
  * Org: building.svg
  * Loc: pin-map-fill.svg
"""
function hfun_show_talk_list()
    bib = import_bibtex(Franklin.locvar("talkbib"); check=:none)

    io = IOBuffer()
    for iKey in bib.keys
        x = bib[iKey]
        write(io, """\\item{ $(x.title) ($(x.fields["location"]), $(x.fields["date"]))}""")
    end
    
    return Franklin.fd2html( "\\list" * String(take!(io)) * "\\endlist", internal=true )
end



"""
    {{ show_md_list }}
    
Render the list of md files.

# Source
[blogposts](https://github.com/JuliaLang/www.julialang.org/blob/4c998de90c1e39c8d2e62a1f5a41e34f524872ad/utils.jl#L27-L58)
"""
function hfun_show_md_list()
    exclude = Franklin.locvar("exclude")
    if isnothing(exclude)
        exclude = ["index.md", ]
    else
        exclude = union(exclude, "index.md")
    end

    base = Franklin.locvar("base")
    posts = filter(endswith(".md"), readdir(base)) |> (x) -> setdiff(x, exclude)
    posts = map(posts) do x
        post = splitext(x)[1]
        surl = strip("$base/$post", '/')
        title = Franklin.pagevar(surl, :title; default="")
        date = Franklin.pagevar(surl, :date) |>
            (x) -> isnothing(x) ? "" : "[$x]"

        link = Franklin.pagevar(surl, :link)
        if isnothing(link) 
            link = "/$base/$post" 
        end
        link = "\\link{$title}{$link}"

        return "\\item{ $link }"  # "\\item{ $date $link }"
    end
    
    io = IOBuffer()
    write(io, "\\list \n")
    join(io, sort(posts))
    write(io, "\\endlist")
    
    return Franklin.fd2html(String(take!(io)), internal=true)
end



"""
  {{ get_r_pkg_status }}
"""
function hfun_get_r_pkg_status()
    versionURL = "https://www.r-pkg.org/badges/version-last-release/"
    countURL = "https://cranlogs.r-pkg.org/badges/last-month/"
    
    io = IOBuffer()
    write(io, "\\list\n")
    for iK in keys(packages)
        info = try
            version = HTTP.request(:GET, versionURL * iK) # HTTP.get(url)
            # count = HTTP.request(:GET, countURL * iK)
            "\\item{ **$iK** \n\n [~~~ $( String(version.body) ) ~~~]($(packages[iK])) }"
        catch
            "\\item{ \\link{$iK}{$(packages[iK])} }"
        end
        write(io, info)
    end
    write(io, "\\endlist")

    return Franklin.fd2html( String(take!(io)), internal=true )
end
