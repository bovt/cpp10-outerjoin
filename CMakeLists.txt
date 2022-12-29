cmake_minimum_required(VERSION 3.2)

set(PATCH_VERSION "1" CACHE INTERNAL "Patch version")
set(PROJECT_VESRION 0.0.${PATCH_VERSION})

project(join_server VERSION ${PROJECT_VESRION})

set(CMAKE_CXX_STANDARD 17)

find_package(Boost REQUIRED COMPONENTS program_options system REQUIRED)
if(NOT Boost_FOUND)
    message(SEND_ERROR "Failed to find boost")
    return()
endif()

set(HEADERS
    src/include/logic/database.h
    src/include/logic/message.h
    src/include/logic/command.h

    src/include/network/server.h
    src/include/network/session.h

    src/include/utils/thread_pool.h)

set(DATABASE
    src/logic/database.cpp
    src/logic/message.cpp
    src/logic/command.cpp)

set(NETWORK
    src/network/server.cpp
    src/network/session.cpp)

set(UTILS
    src/utils/thread_pool.cpp)

SET(SOURCES ${DATABASE} ${NETWORK} ${UTILS})

add_executable(${PROJECT_NAME} src/main.cpp ${SOURCES} ${HEADERS})

target_include_directories(${PROJECT_NAME} PRIVATE "${CMAKE_BINARY_DIR}" "src/include")
target_link_libraries(${PROJECT_NAME} PRIVATE Boost::program_options Boost::system pthread stdc++fs)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)

set(CPACK_GENERATOR DEB)
set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")
set(CPACK_PACKAGE_CONTACT example@example.com)
include(CPack)


