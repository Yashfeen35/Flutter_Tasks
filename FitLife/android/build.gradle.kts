// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    dependencies {
        // ✅ Google Services plugin for Firebase
        classpath("com.google.gms:google-services:4.4.2")
    }
}

plugins {
    // ✅ Use the same versions Flutter uses internally
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    id("dev.flutter.flutter-gradle-plugin") apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Fix build directory paths
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

// ✅ Ensure app module is evaluated before others
subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
