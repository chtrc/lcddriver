################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include arch/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: helloworld.elf helloworld.ihex

# Output Target
helloworld.ihex: helloworld.elf
	@echo 'Outputing file $@'
	csky-abiv2-elf-objcopy -O ihex "$<" "$@"
	@echo 'Finished outputing: $@'
	@echo ' '

# Tool invocations
helloworld.elf: $(OBJS) $(USER_OBJS) C:\week2\workspace\helloworld\ckcpu.ld
	@echo 'Building target: $@'
	@echo 'Invoking: CSky Elf Linker'
	csky-abiv2-elf-gcc -nostartfiles -Wl,--gc-sections  -T"C:\week2\workspace\helloworld\ckcpu.ld" -o "helloworld.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo ' '
	@echo 'Size of $@:'
	@csky-abiv2-elf-size "$@"
	@echo ' '
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) helloworld.ihex
	-$(RM) $(OBJS)$(C_DEPS)$(ASM_DEPS)$(S_DEPS)$(S_UPPER_DEPS) helloworld.elf
	-@echo ' '

.PHONY: all clean dependents


-include ../makefile.targets
