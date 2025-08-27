pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localProperties = rootDir.resolve("local.properties")
        if (localProperties.exists()) {
            localProperties.inputStream().use { properties.load(it) }
        }
        properties.getProperty("flutter.sdk")!!
    }
    val flutterRoot = File(flutterSdkPath)
    val flutterPluginVersion = File(flutterSdkPath + "/packages/flutter_tools/gradle")
    includeBuild(flutterPluginVersion)

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }

    plugins {
        id("dev.flutter.flutter-plugin-loader") version "1.0.0"
        id("com.android.application") version "7.4.2" apply false
        id("com.android.library") version "7.4.2" apply false
    }
}
include(":app")
