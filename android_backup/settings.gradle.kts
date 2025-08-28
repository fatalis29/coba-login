pluginManagement {
    val localProperties = java.util.Properties().apply {
        load(rootDir.resolve("local.properties").inputStream())
    }
    val flutterSdkPath = localProperties.getProperty("flutter.sdk")!!

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven { url = uri("$flutterSdkPath/packages/flutter_tools/gradle") }
    }

    plugins {
        id("dev.flutter.flutter-gradle-plugin") version "1.0.0" apply false
        id("com.android.application") version "8.7.2" apply false // versi AGP cocok Flutter 3.32
        id("org.jetbrains.kotlin.android") version "2.0.20" apply false // versi Kotlin cocok AGP terbaru
    }
}
include(":app")
