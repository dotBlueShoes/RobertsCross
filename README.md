# Roberts Cross

### Preperation
Replace Needed Compilators Paths inside CMakePresets.json with your paths

### Initialize CMAKE
Run the following:
...
For my machine it is:
.quail/cmake_refresh.bat 'D:\Storage\Projects\RobertsCross' 'C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build'

### Build a Profile
Run the following:
...
For my machine it is:
.quail/build.bat 'D:\Storage\Projects\RobertsCross' 'C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build' 'windows-debug'
or
.quail/build.bat 'D:\Storage\Projects\RobertsCross' 'C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build' 'windows-release'


### Run the Compilation
...
For my machine it is
.quail/exe_with_res.ps1 'D:\Storage\Projects\RobertsCross\build\windows-debug\project\' 'RobertsCross'
or
.quail/exe_with_res.ps1 'D:\Storage\Projects\RobertsCross\build\windows-release\project\' 'RobertsCross'
