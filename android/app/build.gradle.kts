plugins {
    id("com.android.application")
    id("kotlin-android")
    // Tambahkan plugin Flutter
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.dbank_modern" // Ganti sesuai namespace project
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.dbank_modern" // Ganti sesuai ID app
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.9.10")
    // Tambahkan dependency tambahan di sini jika perlu
}
