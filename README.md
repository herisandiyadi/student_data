# test_student_app

Test App Student

## Test tulis

1. Ya, Untuk push notification terbiasa menggunakan firebase cloud messaging.
   Mudah untuk implementasi dan adaptasi nya.
   
2. - Dilakukan fungsi pengecekan koneksi terlebih dahulu saat akan post/input data absen ke internet/API
   - jika koneksi online maka internet dikirim ke API/internet dan jika offline/tidak ada signal data di simpan di local storage (sqflite) terlebih dahulu.
   - Dan diberikan tambahan fungsi sinkronisasi data yang akan aktif saat terdapat koneksi internet, dan disable saat tidak ada koneksi.
   - setelah itu data yang terdapat di local storage bisa dikirimkan ke API/internet kembali.
