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

researchers = [
    researcher(
        (first="Zengchao", last="Xu"),
        "xuzengchao@shnu.edu.cn",
        "Shanghai Normal University", 
        "Department of Mathematics", # Lab for Educational Big Data and Policymaking
        "100 Guilin Road, Xuhui District, Shanghai",
        "xu-zc.site"
    ),
    researcher(
        (first="Shan", last="Luo"), 
        "sluomath@sjtu.edu.cn",
        "Shanghai Jiao Tong University", 
        "School of Mathematical Sciences",
        "800 Donghuan Road, Minhang District, Shanghai",
        "https://math.sjtu.edu.cn/Default/teachershow/tags/MDAwMDAwMDAwMLKIetw"
    ),
    researcher(
        (first="Zehua", last="Chen"),
        "stachenz@nus.edu.sg",
        "National University of Singapore",
        "Department of Statistics and Applied Probability",
        "",
        "https://www.stat.nus.edu.sg/chen-zehua/",
    ),
    researcher(
        (first="Yi", last="Zhang"),
        "zhangyi@lixin.edu.cn",
        "Shanghai Lixin University of Accounting and Finance",
        "School of Insurance",
        "995 Shangchuan Road, Pudong New Area, Shanghai",
        ""
    ),
]




struct student
    year::String
    major::String
    level::String
    name::String
end

students = [
    student("2023-09", "应用统计", "专硕", "倪苑溶一"), 
    student("2023-09", "应用统计", "专硕", "杨钰婷"), 
    student("2023-09", "应用统计", "专硕", "肖梨"), 
]





struct teaching
    year::String
    semester::String
    level::String
    course::String
end

courses = [
    teaching("2024", "春", "本科生", "统计计算"),
    teaching("2024", "春", "本科生", "概率论与数理统计"),
    teaching("2023", "秋", "研究生", "应用数理统计"),
    teaching("2023", "春", "本科生", "概率论与数理统计"),
]
