# Sets the minimum version of CMake required to build the native
# library. You should either keep the default value or only pass a
# value of 3.4.0 or lower.

cmake_minimum_required(VERSION 3.4.1)

#预编译宏给外部代码使用
set(USE_SHARE_LIB OFF)   #使用使用动态库，预设置USE_SHARE_LIB值为OFF，若需要开启则设置ON
IF(USE_SHARE_LIB)
    add_definitions(-DUSE_SHARE_LIB) #宏定义USE_SHARE_LIB
    message(STATUS "Use share library")
ELSE()
    message(STATUS "Use static library")
ENDIF()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -Wno-deprecated-declarations -fblocks -fPIC")
#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -Wno-deprecated-declarations")
IF((${ANDROID_ABI} STREQUAL armeabi-v7a) OR (${ANDROID_ABI} STREQUAL x86_64)) #32位平台时开启
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wall -v -Wl,--no-warn-shared-textrel")
ENDIF()

#设置生成的so动态库最后输出的路径
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/libs_export/${ANDROID_ABI})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/libs_export/${ANDROID_ABI})


#设置工程源码根目录
set(JNI_Root ${CMAKE_SOURCE_DIR}/src/main/jni)

#设置头文件目录
INCLUDE_DIRECTORIES(${JNI_Root})

#收集源代码
file(GLOB JNI_src_list ${JNI_Root}/*.hpp ${JNI_Root}/*.cpp ${JNI_Root}/*.h ${JNI_Root}/*.c)

#封装成库
add_library(JMLog SHARED ${JNI_src_list})

#链接库
IF(USE_SHARE_LIB)   #动态链接
    target_link_libraries(JMLog android log z)
ELSE()  #静态链接
    target_link_libraries(JMLog android log z)
ENDIF()
