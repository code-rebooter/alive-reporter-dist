# alive-reporter

Android SDK 的二进制发布仓库，由构建流程自动维护。

## 接入

在 `settings.gradle` 中添加仓库：

```groovy
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }
    }
}
```

在应用模块中添加依赖；版本号使用本仓库的固定版本 tag：

```groovy
implementation 'com.github.code-rebooter:alive-reporter-dist:1.0.2'
```

SDK 不再创建账户或使用账户同步保活。已有设备在应用正常升级后，后台会自动删除本 SDK
创建的旧 `SyncService` 账户并停用兼容认证器，无需客户手动清理或安装过渡包。

已有项目请继续保留原来的 `lib_autorun_sync_account_type` 资源覆盖，用于准确识别旧账户类型；
多 flavor 项目仍按各应用的历史配置保留。例如：

```groovy
resValue 'string', 'lib_autorun_sync_account_type', 'com.example.app.sync.account'
```

升级此版本后可删除旧的 `lib_autorun_sync_authority` 配置。新应用无需额外账户配置。

最低 Android API 为 23。POM 包含 SDK 的依赖，使用者无需手动补齐。
AAR 自带 Gson 和 JNI 所需的混淆规则，64 位原生库支持 16 KB 内存页。

已验证构建环境：JDK 17、AGP 8.11.1、Gradle 8.13、compileSdk 36、Kotlin 2.2.20。

## 版本与完整性

- 每个版本对应一个不可覆盖的 tag，例如 `1.0.0`、`1.0.1`。
- `release.json` 记录当前版本、构建源码 commit 和文件 SHA-256。
- `SHA256SUMS` 校验 AAR 和 POM；`install.sh` 供 JitPack 安装现成 AAR。
- 本仓库只分发编译产物及其元数据。
