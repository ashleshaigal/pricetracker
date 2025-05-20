# Flutter-specific rules
-keep class io.flutter.** { *; }
-keep class com.example.** { *; }  # Replace `com.example` with your actual package name

# Keep Glide or other image loading libraries (if used)
-keep class com.bumptech.glide.** { *; }
-keep class okhttp3.** { *; }
-keep class com.squareup.picasso.** { *; }

# Keep resources
#-keepresourcexmlelements manifest/application/meta-data

# Prevent stripping of Flutter assets
-keep class io.flutter.view.FlutterMain { *; }
-keep class io.flutter.embedding.engine.FlutterJNI { *; }

# Keep all R class resources (prevents missing images and resources)
-keepclassmembers class **.R$* { *; }

# Prevent obfuscation of asset paths
-keep class * implements android.content.res.XmlResourceParser { *; }

# Avoid obfuscating Retrofit models (if using Retrofit)
-keep class com.yourpackage.models.** { *; }

# Keep Provider package
-keep class androidx.lifecycle.** { *; }
-keep class androidx.lifecycle.viewmodel.** { *; }
-keep class androidx.lifecycle.ViewModel { *; }
-keep class io.flutter.plugins.pathprovider.** { *; }

# Keep Retrofit models
-keep class com.yourpackage.models.** { *; }
-keep class retrofit2.** { *; }
-keep class com.google.gson.** { *; }
-keep class okhttp3.** { *; }

-keep class com.google.android.play.** { *; }
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-keepattributes *Annotation*
-keep class * implements android.os.Parcelable { *; }
-dontwarn com.google.android.play.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**




