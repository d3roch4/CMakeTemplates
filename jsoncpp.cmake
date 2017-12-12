
if(NOT TARGET libjsoncpp)
    include(ExternalProject)
    ExternalProject_Add (
        jsoncpp
        URL  "https://github.com/open-source-parsers/jsoncpp/archive/1.7.2.zip"
        INSTALL_COMMAND ""
        CMAKE_ARGS 
            "-G${CMAKE_GENERATOR}"
            "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -fPIC"
            "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
            "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
            "-DJSONCPP_WITH_TESTS=OFF"
            "-DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF"
            "-DJSONCPP_WITH_PKGCONFIG_SUPPORT=OFF"
    )
    set_target_properties(jsoncpp  PROPERTIES POSITION_INDEPENDENT_CODE ON)
    ExternalProject_Get_Property(jsoncpp source_dir binary_dir)

    # Create a libjsoncpp target to be used as a dependency by test programs
    add_library(libjsoncpp IMPORTED STATIC GLOBAL)
    # Set libjsoncpp properties
    set_target_properties(libjsoncpp PROPERTIES
        "IMPORTED_LOCATION" "${binary_dir}/src/lib_json/libjsoncpp.a"
    )
    set(JSONCPP_INCLUDE "${source_dir}/include"
        CACHE INTERNAL "${PROJECT_NAME}: Include Directories" FORCE)
endif()

include_directories(${JSONCPP_INCLUDE})
if(NOT TARGET ${PROJECT_NAME})
    add_dependencies(${PROJECT_NAME} jsoncpp)
    target_link_libraries(${PROJECT_NAME} libjsoncpp )
endif()
