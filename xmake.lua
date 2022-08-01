
set_project("MaaArknightsAssistant")
set_languages("cxx17")

add_rules("mode.debug", "mode.release")
-- TODO: add set_version

-- Options
option('build_jni')
    set_default(false)
    set_description("Build JNI library")
option_end()

option("build_demo")
    set_default(false)
    set_description("Build a demo")
option_end()

option("paddle_model_type")
option_end()
package("PaddleOCR")
package_end()

-- Dependencies
add_requires("opencv 4.5.3")
add_requires("zlib")

target("MeoAssistant")
    set_kind("shared")
    add_files("src/MeoAssistant/*.cpp")
    add_defines("ASST_DLL_EXPORTS")
    add_includedirs("3rdparty/include", "./include") 
    add_packages("opencv 4.5.3", "zlib")
    -- add compiler flags
    if is_host("windows") then
        add_cxxflags("/utf-8",  "/MP")
        add_cxxflags("/W4", "/WX")
        if is_mode("debug") then
            add_cxxflags("/MTd") 
        else
            add_cxxflags("/MT")
        end
    else
        add_cxxflags("-Wall", "-Wextra", "-Wpedantic") 
    end
target_end()
-- Set compiler options
