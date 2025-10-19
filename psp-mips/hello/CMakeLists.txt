cmake_minimum_required(VERSION 3.20)
project(bgd2_homebrew C CXX ASM)

# Detect PSP SDK path
execute_process(
    COMMAND psp-config --pspsdk-path
    OUTPUT_VARIABLE PSPSDK_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Set PSP SDK environment
if(NOT PSPSDK_PATH)
    message(FATAL_ERROR "PSPSDK not found. Please install pspdev and ensure psp-config is in PATH.")
endif()

include_directories(${PSPSDK_PATH}/include ${PSPSDK_PATH}/include/psp)
link_directories(${PSPSDK_PATH}/lib)

# Target name
set(TARGET bgd2_homebrew)

# Source files
set(SRC
    src/main.c
)

# Compiler flags
set(CMAKE_C_FLAGS "-O2 -G0 -Wall")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}")


# Libraries
set(PSP_LIBS pspdebug pspdisplay pspge pspctrl pspsdk)

# Add executable for PSP
add_executable(${TARGET}.elf ${SRC})

# Link libraries
target_link_libraries(${TARGET}.elf ${PSP_LIBS})

# Custom command to generate EBOOT.PBP
set(EBOOT ${CMAKE_CURRENT_BINARY_DIR}/EBOOT.PBP)

add_custom_command(
    OUTPUT ${EBOOT}
    DEPENDS ${TARGET}.elf
    COMMAND mksfo "BennuGD2 Homebrew" PARAM.SFO
    COMMAND psp-fixup-imports ${TARGET}.elf
    COMMAND pack-pbp ${EBOOT} PARAM.SFO NULL NULL NULL NULL NULL ${TARGET}.elf NULL
    COMMENT "Generating EBOOT.PBP"
)

# Custom target so we can build EBOOT
add_custom_target(build_eboot ALL
    DEPENDS ${EBOOT}
)
