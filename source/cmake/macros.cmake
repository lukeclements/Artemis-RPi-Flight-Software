# run this to create QtCreatorDeployment.txt for remote device deployment
# http://qt-project.org/doc/qtcreator-3.0/creator-project-cmake.html
# CHANGE THIS DIRECTORY TO THE DESIRED TARGET FOLDER
file(WRITE "${CMAKE_SOURCE_DIR}/QtCreatorDeployment.txt" "/home/localuser/cosmos/bin/\n")

macro(add_deployment_binary SRC DEST)
    file(RELATIVE_PATH path ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
    file(APPEND "${CMAKE_SOURCE_DIR}/QtCreatorDeployment.txt" "${path}/${SRC}:${DEST}\n")
endmacro()

macro(add_deployment_source SRC DEST)
    file(RELATIVE_PATH path ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
    file(APPEND "${CMAKE_SOURCE_DIR}/QtCreatorDeployment.txt" "${path}/${SRC}:${DEST}\n")
endmacro()

macro(add_deployment_directory SRC DEST)
    file(GLOB_RECURSE files RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${SRC}/*")
    foreach(filename ${files})
        get_filename_component(path ${filename} PATH)
        add_deployment_binary("${filename}" "${DEST}/${path}")
    endforeach(filename)
endmacro()

macro(add_deployment_source_directory SRC DEST)
    message("add_deployment_source_directory ${SRC} ${DEST}")
    file(GLOB files RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${SRC}/*.cpp")
    foreach(filename ${files})
        get_filename_component(path ${filename} PATH)
        add_deployment_source("${filename}" "${DEST}/${path}")
    endforeach(filename)
    file(GLOB files RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${SRC}/*.h")
    foreach(filename ${files})
        get_filename_component(path ${filename} PATH)
        add_deployment_source("${filename}" "${DEST}/${path}")
    endforeach(filename)
endmacro()