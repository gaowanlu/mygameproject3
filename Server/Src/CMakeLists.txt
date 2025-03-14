cmake_minimum_required(VERSION 2.8.9)
project(GameProject)
set(CMAKE_VERBOSE_MAKEFILE OFF)
# Add the source in project root directory
aux_source_directory(. DIRSRCS)
# Add header file include directories
include_directories(./ ../../Common/protobuf/src /usr/include/lua5.3 ../../Common/Sqlite /usr/include/mysql )

# Add block directories
add_subdirectory(ServerEngine)
add_subdirectory(ProxyServer)
add_subdirectory(GameServer)
add_subdirectory(DBServer)
add_subdirectory(AccountServer)
add_subdirectory(CenterServer)
add_subdirectory(LogicServer)
add_subdirectory(LoginServer)
add_subdirectory(LogServer)
add_subdirectory(WatchServer)


if(CMAKE_COMPILER_IS_GNUCXX)
	add_definitions(-std=c++17)
endif()
