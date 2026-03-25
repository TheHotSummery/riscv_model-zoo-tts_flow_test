# 编译与运行（简版）

更完整的说明见 [README.md](README.md) 与 [API.md](API.md)。

## 1. 依赖（Debian/Ubuntu 示例）

```bash
sudo apt-get update
sudo apt-get install -y build-essential cmake pkg-config \
  libsndfile1-dev libfftw3-dev espeak-ng libcurl4-openssl-dev libespeak-ng-dev
```

- **ONNX Runtime**：必须能用到 C++ 头文件 `onnxruntime_cxx_api.h` 与 `libonnxruntime.so`。未安装时 CMake 会告警，链接/编译会失败。
- **Python 绑定（可选）**：`pip install pybind11` 与 `python3-dev`，配置成功后才会编 `_spacemit_tts`。

## 2. 配置与编译（独立仓库，在仓库根目录执行）

若已通过包管理器安装 ORT，且能被 CMake 自动找到，可直接：

```bash
cmake -B build -S .
cmake --build build -j"$(nproc)"
```

否则显式传入 ONNX 路径（按本机实际路径修改）：

```bash
cmake -B build -S . \
  -DONNXRUNTIME_INCLUDE_DIR=/path/to/include \
  -DONNXRUNTIME_LIB="/path/to/libonnxruntime.so"
```

**Bianbu / SpacemiT 板卡（apt 安装 `onnxruntime` 时）** 一般为：

```bash
cmake -B build -S . \
  -DONNXRUNTIME_INCLUDE_DIR=/usr/include \
  -DONNXRUNTIME_LIB="/usr/lib/libonnxruntime.so;/usr/lib/libspacemit_ep.so"
cmake --build build -j"$(nproc)"
```

## 3. 运行示例

```bash
./build/bin/tts_file_demo
./build/bin/tts_file_demo -p "你好世界" -l matcha:zh
```

模型默认在 `~/.cache/models/tts/`（首次运行可自动下载，见 README）。

## 4. Python 示例（需先启用绑定并成功安装）

```bash
cmake --build build --target tts-install-python
python3 python/examples/tts_file_demo.py
```

## 5. 说明

- **流式 demo** `tts_stream_demo`：依赖 SDK 内 audio 组件与 PortAudio；仅 clone 本仓库时默认 **不** 编译，见 `CMakeLists.txt` 中 `BUILD_STREAM_DEMO`。
- 修改 `CMakeLists.txt` 后建议重新执行 `cmake -B build -S .` 再编译。
