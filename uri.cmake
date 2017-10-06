
if(NOT TARGET uri)
    include(ExternalProject)

    ExternalProject_Add (
        uri
        URL  "https://github.com/reBass/uri/archive/master.zip"
        CMAKE_ARGS "-G${CMAKE_GENERATOR}"
            "-DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -fPIC"
            "-DBOOST_INCLUDEDIR=${BOOST_INCLUDEDIR}"
            "-DBOOST_LIBRARYDIR=${BOOST_LIBRARYDIR}"
            "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}"
            "-DUri_BUILD_TESTS=OFF"
        INSTALL_COMMAND ""
    )
    set_target_properties(uri  PROPERTIES POSITION_INDEPENDENT_CODE ON)
    ExternalProject_Get_Property(uri source_dir binary_dir)

    add_library(liburi IMPORTED STATIC GLOBAL)
    set_target_properties(liburi PROPERTIES
        "IMPORTED_LOCATION" "${binary_dir}/src/libnetwork-uri.a"
    )

    set(URI_INCLUDE "${source_dir}/include"
            CACHE INTERNAL "${PROJECT_NAME}: Include Directories" FORCE)
endif()

add_dependencies(${PROJECT_NAME} uri)
include_directories(${URI_INCLUDE})
target_link_libraries(${PROJECT_NAME} liburi )
