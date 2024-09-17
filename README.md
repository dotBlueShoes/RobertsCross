# Roberts Cross
CUDA program for an image edge detection using Roberts Cross operator.

Uses CMAKE, SPDLOG & STB headers.

![alt text](https://github.com/dotBlueShoes/RobertsCross/blob/master/extras/example.jpg)

---

### Preperation
- Ensure that you do have an installed "vcvarsall" program that comes with the installation of Visual Studio software.
  > That's for windows execution of the program only.
- Edit **"CMakePresets.json"** file. Provide your own paths to necessery compilers.

---

### Initialize CMAKE
`.quail/cmake_refresh.bat [PROJECT_DIR] [VCVARSALL_DIR]`

example:

`.quail/cmake_refresh.bat 'D:\Storage\Projects\RobertsCross' 'C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build'`

---

### Build a Profile
`.quail/build.bat [PROJECT_DIR] [VCVARSALL_DIR] [BUILD_PROFILE_NAME]`

example `windows-debug`:

`.quail/build.bat 'D:\Storage\Projects\RobertsCross' 'C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build' 'windows-debug'`

example `windows-release`:

`.quail/build.bat 'D:\Storage\Projects\RobertsCross' 'C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build' 'windows-release'`

---

### Run the Compilation
`.quail/exe_with_res.ps1 [EXECUTABLE_DIR] 'RobertsCross'`

example `windows-debug`:

`.quail/exe_with_res.ps1 'D:\Storage\Projects\RobertsCross\build\windows-debug\project\' 'RobertsCross'`

example `windows-release`:

`.quail/exe_with_res.ps1 'D:\Storage\Projects\RobertsCross\build\windows-release\project\' 'RobertsCross'`
