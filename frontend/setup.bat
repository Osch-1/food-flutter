@echo off
powershell Set-ExecutionPolicy RemoteSigned
powershell %~dp0scripts\setup.ps1
