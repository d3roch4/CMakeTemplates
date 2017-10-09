
if(NOT TARGET beast)
    include(ExternalProject)

    ExternalProject_Add (
        beast
        URL  "https://github.com/d3roch4/beast/archive/develop.zip"
        BUILD_COMMAND ""
        BUILD_IN_SOURCE 1
        INSTALL_COMMAND cmake -E echo "Skipping install step."
    )
    ExternalProject_Get_Property(beast source_dir binary_dir)

    set(BEAST_INCLUDE "${source_dir}/include"
            CACHE INTERNAL "${PROJECT_NAME}: Include Directories" FORCE)
endif()

add_dependencies(${PROJECT_NAME} beast)
include_directories(${BEAST_INCLUDE})
