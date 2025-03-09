package com.aqsa.clipboad_image

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import android.app.Activity
import android.content.Context
import android.content.ClipboardManager
import android.content.ContentResolver
import android.content.ContextWrapper
import android.net.Uri
import android.graphics.Bitmap
import java.io.ByteArrayOutputStream
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding


/** ClipboadImagePlugin */
class ClipboadImagePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var applicationContext: Context? = null
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "clipboad_image")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getImage") {
      val imageBytes = getClipboardImage()
      if (imageBytes != null) {
          result.success(imageBytes)
      } else {
          result.success(null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun getClipboardImage(): ByteArray? {
    val clipboard = applicationContext?.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
    if (!clipboard.hasPrimaryClip()) {
        return null
    }

    val clipData = clipboard.primaryClip
    if (clipData != null && clipData.itemCount > 0) {
        val item = clipData.getItemAt(0)
        val uri = item.uri

        if (uri != null) {
            try {
                val inputStream = applicationContext?.contentResolver?.openInputStream(uri)
                val bitmap = android.graphics.BitmapFactory.decodeStream(inputStream)
                inputStream?.close()
                if (bitmap != null) {
                    val stream = ByteArrayOutputStream()
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 90, stream)
                    val byteArray = stream.toByteArray()
                    bitmap.recycle()
                    stream.close()
                    return byteArray
                }
            } catch (e: Exception) {
                e.printStackTrace()
                return null
            }
        }
    }
    return null
}
}
