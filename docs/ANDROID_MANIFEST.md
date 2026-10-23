# Catatan opsional predictive back

Buka `android/app/src/main/AndroidManifest.xml`. Pada elemen `<application>` yang sudah ada, tambahkan atribut berikut apabila konfigurasi proyek membutuhkannya:

```xml
android:enableOnBackInvokedCallback="true"
```

Contoh bentuk atribut (bukan pengganti seluruh manifest):

```xml
<application
    android:name="${applicationName}"
    android:label="quiz"
    android:icon="@mipmap/ic_launcher"
    android:enableOnBackInvokedCallback="true">
    ...
</application>
```

Pertahankan atribut dan konfigurasi lain milik proyek. Dukungan predictive back tergantung versi Flutter, versi Android, dan konfigurasi aplikasi. Gestur sistemnya terutama dapat diamati di Android 14/API 34 atau yang lebih baru; pada platform/perangkat lain, transisi dapat memakai fallback.
