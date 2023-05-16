# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class Manajer(models.Model):
    id_manajer = models.OneToOneField('NonPemain', models.DO_NOTHING, db_column='id_manajer', primary_key=True)
    username = models.ForeignKey('UserSystem', models.DO_NOTHING, db_column='username', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'manajer'


class NonPemain(models.Model):
    id = models.UUIDField(primary_key=True)
    nama_depan = models.CharField(max_length=50)
    nama_belakang = models.CharField(max_length=50)
    nomor_hp = models.CharField(max_length=15)
    email = models.CharField(max_length=50)
    alamat = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'non_pemain'


class Panitia(models.Model):
    id_panitia = models.OneToOneField(NonPemain, models.DO_NOTHING, db_column='id_panitia', primary_key=True)
    jabatan = models.CharField(max_length=50)
    username = models.ForeignKey('UserSystem', models.DO_NOTHING, db_column='username', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'panitia'


class Pelatih(models.Model):
    id_pelatih = models.OneToOneField(NonPemain, models.DO_NOTHING, db_column='id_pelatih', primary_key=True)
    nama_tim = models.ForeignKey('Tim', models.DO_NOTHING, db_column='nama_tim', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pelatih'


class Pemain(models.Model):
    id_pemain = models.UUIDField(primary_key=True)
    nama_tim = models.ForeignKey('Tim', models.DO_NOTHING, db_column='nama_tim', blank=True, null=True)
    nama_depan = models.CharField(max_length=50)
    nama_belakang = models.CharField(max_length=50)
    nomor_hp = models.CharField(max_length=15)
    tgl_lahir = models.DateField()
    is_captain = models.BooleanField()
    posisi = models.CharField(max_length=50)
    npm = models.CharField(max_length=20)
    jenjang = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'pemain'


class PembelianTiket(models.Model):
    nomor_receipt = models.CharField(primary_key=True, max_length=50)
    id_penonton = models.ForeignKey('Penonton', models.DO_NOTHING, db_column='id_penonton', blank=True, null=True)
    jenis_tiket = models.CharField(max_length=50)
    jenis_pembayaran = models.CharField(max_length=50)
    id_pertandingan = models.ForeignKey('Pertandingan', models.DO_NOTHING, db_column='id_pertandingan', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pembelian_tiket'


class Peminjaman(models.Model):
    id_manajer = models.OneToOneField(Manajer, models.DO_NOTHING, db_column='id_manajer', primary_key=True)
    start_datetime = models.DateTimeField()
    end_datetime = models.DateTimeField()
    id_stadium = models.ForeignKey('Stadium', models.DO_NOTHING, db_column='id_stadium', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'peminjaman'
        unique_together = (('id_manajer', 'start_datetime'),)


class Penonton(models.Model):
    id_penonton = models.OneToOneField(NonPemain, models.DO_NOTHING, db_column='id_penonton', primary_key=True)
    username = models.ForeignKey('UserSystem', models.DO_NOTHING, db_column='username', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'penonton'


class Peristiwa(models.Model):
    id_pertandingan = models.OneToOneField('Pertandingan', models.DO_NOTHING, db_column='id_pertandingan', primary_key=True)
    datetime = models.DateTimeField()
    jenis = models.CharField(max_length=50)
    id_pemain = models.ForeignKey(Pemain, models.DO_NOTHING, db_column='id_pemain', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'peristiwa'
        unique_together = (('id_pertandingan', 'datetime'),)


class PerlengkapanStadium(models.Model):
    id_stadium = models.OneToOneField('Stadium', models.DO_NOTHING, db_column='id_stadium', primary_key=True)
    item = models.CharField(max_length=255)
    kapasitas = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'perlengkapan_stadium'
        unique_together = (('id_stadium', 'item', 'kapasitas'),)


class Pertandingan(models.Model):
    id_pertandingan = models.UUIDField(primary_key=True)
    start_datetime = models.DateTimeField()
    end_datetime = models.DateTimeField()
    stadium = models.ForeignKey('Stadium', models.DO_NOTHING, db_column='stadium', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pertandingan'


class Rapat(models.Model):
    id_pertandingan = models.ForeignKey(Pertandingan, models.DO_NOTHING, db_column='id_pertandingan', blank=True, null=True)
    datetime = models.DateTimeField(primary_key=True)
    perwakilan_panitia = models.ForeignKey(Panitia, models.DO_NOTHING, db_column='perwakilan_panitia')
    manajer_tim_a = models.ForeignKey(Manajer, models.DO_NOTHING, db_column='manajer_tim_a')
    manajer_tim_b = models.ForeignKey(Manajer, models.DO_NOTHING, db_column='manajer_tim_b')
    isi_rapat = models.TextField()

    class Meta:
        managed = False
        db_table = 'rapat'
        unique_together = (('datetime', 'perwakilan_panitia', 'manajer_tim_a', 'manajer_tim_b'),)


class SpesialisasiPelatih(models.Model):
    id_pelatih = models.OneToOneField(Pelatih, models.DO_NOTHING, db_column='id_pelatih', primary_key=True)
    spesialisasi = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'spesialisasi_pelatih'
        unique_together = (('id_pelatih', 'spesialisasi'),)


class Stadium(models.Model):
    id_stadium = models.UUIDField(primary_key=True)
    nama = models.CharField(max_length=50)
    alamat = models.CharField(max_length=255)
    kapasitas = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'stadium'


class StatusNonPemain(models.Model):
    id_non_pemain = models.OneToOneField(NonPemain, models.DO_NOTHING, db_column='id_non_pemain', primary_key=True)
    status = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'status_non_pemain'
        unique_together = (('id_non_pemain', 'status'),)


class Tim(models.Model):
    nama_tim = models.CharField(primary_key=True, max_length=50)
    universitas = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'tim'


class TimManajer(models.Model):
    id_manajer = models.OneToOneField(Manajer, models.DO_NOTHING, db_column='id_manajer', primary_key=True)
    nama_tim = models.ForeignKey(Tim, models.DO_NOTHING, db_column='nama_tim')

    class Meta:
        managed = False
        db_table = 'tim_manajer'
        unique_together = (('id_manajer', 'nama_tim'),)


class TimPertandingan(models.Model):
    nama_tim = models.OneToOneField(Tim, models.DO_NOTHING, db_column='nama_tim', primary_key=True)
    id_pertandingan = models.ForeignKey(Pertandingan, models.DO_NOTHING, db_column='id_pertandingan')
    skor = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'tim_pertandingan'
        unique_together = (('nama_tim', 'id_pertandingan'),)


class UserSystem(models.Model):
    username = models.CharField(primary_key=True, max_length=50)
    password = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'user_system'


class Wasit(models.Model):
    id_wasit = models.OneToOneField(NonPemain, models.DO_NOTHING, db_column='id_wasit', primary_key=True)
    lisensi = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'wasit'


class WasitBertugas(models.Model):
    id_wasit = models.OneToOneField(Wasit, models.DO_NOTHING, db_column='id_wasit', primary_key=True)
    id_pertandingan = models.ForeignKey(Pertandingan, models.DO_NOTHING, db_column='id_pertandingan')
    posisi_wasit = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'wasit_bertugas'
        unique_together = (('id_wasit', 'id_pertandingan'),)
