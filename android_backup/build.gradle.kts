buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Android Gradle Plugin (AGP) sesuai Flutter 3.22.2
        classpath("com.android.tools.build:gradle:8.1.4")
        // Kotlin plugin sesuai kompatibilitas
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
