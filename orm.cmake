set(ZIP_DEP ${CMAKE_BINARY_DIR}/orm.zip)
if(NOT EXISTS ${ZIP_DEP})
    file(DOWNLOAD https://github.com/d3roch4/orm/archive/master.zip ${ZIP_DEP})
    execute_process(COMMAND unzip -o ${ZIP_DEP}
                  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                  RESULT_VARIABLE rv
    )

    if(NOT rv EQUAL 0)
      message(FATAL_ERROR "error: extract of '${ZIP_DEP}' failed")
    endif()
endif()

add_subdirectory(${CMAKE_BINARY_DIR}/orm-master)
