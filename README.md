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
implementation 'com.github.code-rebooter:alive-reporter-dist:1.0.1'
```

SDK 的账号同步配置需要与宿主的最终 `applicationId` 一致。在宿主应用中覆盖以下资源
（示例包名替换为实际值；有 productFlavor 时按各 flavor 的最终包名配置）：

```groovy
android {
    defaultConfig {
        resValue 'string', 'lib_autorun_sync_account_type', 'com.example.app.sync.account'
        resValue 'string', 'lib_autorun_sync_authority', 'com.example.app.sync.provider'
    }
}
```

最低 Android API 为 23。POM 包含 SDK 的依赖，使用者无需手动补齐。
AAR 自带 Gson 和 JNI 所需的混淆规则，64 位原生库支持 16 KB 内存页。

已验证构建环境：JDK 17、AGP 8.11.1、Gradle 8.13、compileSdk 36、Kotlin 2.2.20。

## 版本与完整性

- 每个版本对应一个不可覆盖的 tag，例如 `1.0.0`、`1.0.1`。
- `release.json` 记录当前版本、构建源码 commit 和文件 SHA-256。
- `SHA256SUMS` 校验 AAR 和 POM；`install.sh` 供 JitPack 安装现成 AAR。
- 本仓库只分发编译产物及其元数据。
