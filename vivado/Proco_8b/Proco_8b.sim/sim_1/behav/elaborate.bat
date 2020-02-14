@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto f3dac7bf593048a6b71f7d48488ad2b3 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot PC_tb_behav xil_defaultlib.PC_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
