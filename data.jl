authorURL = Dict(
  "Luo Shan" => "https://math.sjtu.edu.cn/Default/teachershow/tags/MDAwMDAwMDAwMLKIetw",
  "Chen Zehua" => "https://www.stat.nus.edu.sg/chen-zehua/",
)


packages = Dict(
  "PLFD" => "https://cran.r-project.org/package=PLFD",
  "PPSFS" => "https://cran.r-project.org/package=PPSFS",
)



struct researcher
    name::NamedTuple
    email::String
    affiliation::String
    department::String
    address::String
    url::String
end

xuzengchao = researcher(
    (first="Zengchao", last="Xu"),
    "xuzengchao@shnu.edu.cn",
    "Shanghai Normal University", 
    "Department of Mathematics", # Lab for Educational Big Data and Policymaking
    "100 Guilin Road, Xuhui District, Shanghai",
    "xu-zc.site"
)

luoshan = researcher(
    (first="Shan", last="Luo"), 
    "sluomath@sjtu.edu.cn",
    "Shanghai Jiao Tong University", 
    "School of Mathematical Sciences",
    "800 Donghuan Road, Minhang District, Shanghai",
    "https://math.sjtu.edu.cn/Default/teachershow/tags/MDAwMDAwMDAwMLKIetw"
)

chenzehua = researcher(
    (first="Zehua", last="Chen"),
    "stachenz@nus.edu.sg",
    "National University of Singapore",
    "Department of Statistics and Applied Probability",
    "",
    "https://www.stat.nus.edu.sg/chen-zehua/",
)

zhangyi = researcher(
    (first="Yi", last="Zhang"),
    "zhangyi@lixin.edu.cn",
    "Shanghai Lixin University of Accounting and Finance",
    "School of Insurance",
    "995 Shangchuan Road, Pudong New Area, Shanghai",
    ""
)


