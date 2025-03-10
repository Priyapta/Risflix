# Movie App Flutter

### Package
- dio
- google_nav_bar
- font_awesome_flutter
- Caroussel_slider
- http

### Penjelasan
Pada Aplikasi ini merupakan Aplikasi untuk melihat review dari film dan dapat melihat film yang sedang tayang ataupun yang populer. Fitur tersedia berupa fitur search film dimana user dapat mencari film yang ingin mereka lihat reviewnya. Dalam pembuatanya dimulai dengan membagi kebeberapa page seperti homepage, mainScreen, detailPage, searchPage, welcomePage, dan profile Page. Data yang diambil untuk membuat aplikasi ini dari TMBD API dimana semua api movies ini sudah disediakan dengan TMBD. Pertama aplikasi ini memakai mode untuk mengambil data javascript yang mana nanti diconvert ke dart. Dengan menggunakan model pengambilan data menjadi mudah hanya memanggil variabel yang sudah didefine pada model tersebut maka data pada api akan terambil. Dalam mengambil data ada beberapa function yang saya declare pada file service yang mana semua data yang diambil melalui method yang ada didalam file tersebut. Penggunaan future build harus dilakukan karena sejatinya data yang diambil dari dart sendiri harus menunggu data tersebut sampai ada baru data akan difinalisasi apakah null atau tidak. Sebelum data diambil tentu saya melakukan pengecekan pada postman sehingga data yang terambil dapat terlihat jelas melalui aplikasi tersebut. Dalam pembuatan aplikasi ini saya sangat dibantu dengan tutorial youtube yang telah diberikan maupun tutorial lain terkait pengambilan data melalui api.

Package yang dipakai cukup banyak seperti http untuk melakukan HTTP request, seperti GET dan POST, ke API atau server. Carrousel untuk  membuat tampilan slider atau carousel dalam aplikasi Flutter. dio Mendukung interceptor, timeout, form-data, dan error handling yang lebih fleksibel. Google nav bar untuk tampilan bottom nav bar yang lebih menarik.
