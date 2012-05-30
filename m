MIME-Version: 1.0
Date: Wed, 30 May 2012 17:47:40 -0400
Message-ID: <CAFftDdpbeKgz06P1LNmW4M461q-X04ZAuvnwbvFdeA3Y23r1xA@mail.gmail.com>
Subject: SE Android Maguro denials
From: William Roberts <bill.c.roberts@gmail.com>
To: seandroid@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=bcaec501672777866404c147e6b7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec501672777866404c147e6b7
Content-Type: text/plain; charset=ISO-8859-1

I have a lot of denials on a Maguro handset and was wondering if we should
handle these in the common policy or per device. I am thinking common
policy, but any feedback is welcome. Below are the allow rules for the
denials...

The adbd denial is for abd push to sdcard. Should we even allow that? In my
mind it's a yes.

I am also curious as to why rild needs access to the sdcard.. I shall look
into that.

#============= adbd ==============
allow adbd sdcard:dir { write search getattr add_name };
allow adbd sdcard:file { write getattr setattr read create open };

#============= nfc ==============
allow nfc device:chr_file { read write ioctl open };
allow nfc sysfs:file write;

#============= rild ==============
allow rild block_device:blk_file { read open };
allow rild block_device:lnk_file read;
allow rild device:chr_file { read write ioctl open };
allow rild radio_data_file:dir { write search read remove_name open
add_name };
allow rild radio_data_file:file { write getattr read lock create unlink
open };
allow rild sdcard:dir search;
allow rild system_data_file:dir { write remove_name add_name setattr };
allow rild system_data_file:file { write create unlink open setattr };
allow rild system_file:file execute_no_trans;
allow rild unlabeled:file { read getattr open };

#============= surfaceflinger ==============
allow surfaceflinger device:chr_file { read write ioctl open };

#============= ueventd ==============
allow ueventd efs_file:dir search;
allow ueventd efs_file:file { read getattr open };
allow ueventd self:capability { sys_rawio dac_override };

Here is the dmesg deny logs:
<5>[    5.130615] type=1400 audit(948325880.070:3): avc:  denied  {
sys_rawio } for  pid=97 comm="ueventd" capability=17
 scontext=u:r:ueventd:s0 tcontext=u:r:ueventd:s0 tclass=capability
<5>[    5.211212] type=1400 audit(948325880.156:4): avc:  denied  { search
} for  pid=99 comm="ueventd" name="/" dev=mmcblk0p3 ino=2
scontext=u:r:ueventd:s0 tcontext=u:object_r:efs_file:s0 tclass=dir
<5>[    5.211944] type=1400 audit(948325880.156:5): avc:  denied  {
dac_override } for  pid=99 comm="ueventd" capability=1
 scontext=u:r:ueventd:s0 tcontext=u:r:ueventd:s0 tclass=capability
<5>[    5.212493] type=1400 audit(948325880.156:6): avc:  denied  { read }
for  pid=99 comm="ueventd" name="hdcp.keys" dev=mmcblk0p3 ino=26
scontext=u:r:ueventd:s0 tcontext=u:object_r:efs_file:s0 tclass=file
<5>[    5.213043] type=1400 audit(948325880.156:7): avc:  denied  { open }
for  pid=99 comm="ueventd" name="hdcp.keys" dev=mmcblk0p3 ino=26
scontext=u:r:ueventd:s0 tcontext=u:object_r:efs_file:s0 tclass=file
<5>[    5.213470] type=1400 audit(948325880.156:8): avc:  denied  { getattr
} for  pid=99 comm="ueventd" path="/factory/hdcp.keys" dev=mmcblk0p3 ino=26
scontext=u:r:ueventd:s0 tcontext=u:object_r:efs_file:s0 tclass=file
<5>[    5.890441] type=1400 audit(948325880.835:12): avc:  denied  { search
} for  pid=117 comm="rild" name="com.android.providers.telephony"
dev=mmcblk0p12 ino=578318 scontext=u:r:rild:s0
tcontext=u:object_r:radio_data_file:s0 tclass=dir
<5>[    5.891723] type=1400 audit(948325880.835:13): avc:  denied  { write
} for  pid=117 comm="rild" name="com.android.providers.telephony"
dev=mmcblk0p12 ino=578318 scontext=u:r:rild:s0
tcontext=u:object_r:radio_data_file:s0 tclass=dir
<5>[    5.892364] type=1400 audit(948325880.835:14): avc:  denied  {
add_name } for  pid=117 comm="rild" name="optable.db" scontext=u:r:rild:s0
tcontext=u:object_r:radio_data_file:s0 tclass=dir
<5>[    5.892913] type=1400 audit(948325880.835:15): avc:  denied  { create
} for  pid=117 comm="rild" name="optable.db" scontext=u:r:rild:s0
tcontext=u:object_r:radio_data_file:s0 tclass=file
<5>[    5.906738] type=1400 audit(948325880.851:16): avc:  denied  { read
write open } for  pid=117 comm="rild" name="optable.db" dev=mmcblk0p12
ino=578428 scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0
tclass=file
<5>[    5.907348] type=1400 audit(948325880.851:17): avc:  denied  {
getattr } for  pid=117 comm="rild"
path="/data/data/com.android.providers.telephony/optable.db" dev=mmcblk0p12
ino=578428 scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0
tclass=file
<5>[    5.909515] type=1400 audit(948325880.851:18): avc:  denied  { lock }
for  pid=117 comm="rild"
path="/data/data/com.android.providers.telephony/optable.db" dev=mmcblk0p12
ino=578428 scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0
tclass=file
<5>[    5.917327] type=1400 audit(948325880.851:19): avc:  denied  { read }
for  pid=117 comm="rild" name="com.android.providers.telephony"
dev=mmcblk0p12 ino=578318 scontext=u:r:rild:s0
tcontext=u:object_r:radio_data_file:s0 tclass=dir
<5>[    5.917938] type=1400 audit(948325880.859:20): avc:  denied  { open }
for  pid=117 comm="rild" name="com.android.providers.telephony"
dev=mmcblk0p12 ino=578318 scontext=u:r:rild:s0
tcontext=u:object_r:radio_data_file:s0 tclass=dir
<5>[    6.071685] type=1400 audit(948325881.015:21): avc:  denied  {
remove_name } for  pid=117 comm="rild" name="optable.db-journal"
dev=mmcblk0p12 ino=578430 scontext=u:r:rild:s0
tcontext=u:object_r:radio_data_file:s0 tclass=dir
<5>[    6.072326] type=1400 audit(948325881.015:22): avc:  denied  { unlink
} for  pid=117 comm="rild" name="optable.db-journal" dev=mmcblk0p12
ino=578430 scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0
tclass=file
<5>[    6.127838] type=1400 audit(948325881.070:23): avc:  denied  {
execute_no_trans } for  pid=158 comm="sh" path="/system/bin/toolbox"
dev=mmcblk0p10 ino=224 scontext=u:r:rild:s0
tcontext=u:object_r:system_file:s0 tclass=file
<5>[    6.161285] type=1400 audit(948325881.101:24): avc:  denied  {
setattr } for  pid=162 comm="chmod" name="log" dev=mmcblk0p12 ino=773682
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=dir
<5>[    6.206909] type=1400 audit(948325881.148:25): avc:  denied  { read
write } for  pid=117 comm="rild" name="umts_boot0" dev=tmpfs ino=2898
scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[    6.207092] type=1400 audit(948325881.148:26): avc:  denied  { open }
for  pid=117 comm="rild" name="umts_boot0" dev=tmpfs ino=2898
scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[    6.208190] type=1400 audit(948325881.148:27): avc:  denied  { ioctl
} for  pid=117 comm="rild" path="/dev/umts_boot0" dev=tmpfs ino=2898
scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[    6.443878] type=1400 audit(948325881.382:28): avc:  denied  { read }
for  pid=117 comm="rild" name="radio" dev=tmpfs ino=2793
scontext=u:r:rild:s0 tcontext=u:object_r:block_device:s0 tclass=lnk_file
<5>[    6.444549] type=1400 audit(948325881.390:29): avc:  denied  { read }
for  pid=117 comm="rild" name="mmcblk0p9" dev=tmpfs ino=2792
scontext=u:r:rild:s0 tcontext=u:object_r:block_device:s0 tclass=blk_file
<5>[    6.444946] type=1400 audit(948325881.390:30): avc:  denied  { open }
for  pid=117 comm="rild" name="mmcblk0p9" dev=tmpfs ino=2792
scontext=u:r:rild:s0 tcontext=u:object_r:block_device:s0 tclass=blk_file
<5>[    6.763000] type=1400 audit(948325881.703:31): avc:  denied  { read
write } for  pid=168 comm="SurfaceFlinger" name="dsscomp" dev=tmpfs
ino=2872 scontext=u:r:surfaceflinger:s0 tcontext=u:object_r:device:s0
tclass=chr_file
<5>[    6.763183] type=1400 audit(948325881.703:32): avc:  denied  { open }
for  pid=168 comm="SurfaceFlinger" name="dsscomp" dev=tmpfs ino=2872
scontext=u:r:surfaceflinger:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[    6.764251] type=1400 audit(948325881.703:33): avc:  denied  { ioctl
} for  pid=168 comm="SurfaceFlinger" path="/dev/dsscomp" dev=tmpfs ino=2872
scontext=u:r:surfaceflinger:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   10.293914] type=1400 audit(948325885.234:121): avc:  denied  {
getattr } for  pid=117 comm="rild" path="/factory/.nv_data.bak"
dev=mmcblk0p3 ino=24 scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0
tclass=file
<5>[   10.294525] type=1400 audit(948325885.234:122): avc:  denied  { read
} for  pid=117 comm="rild" name=".nv_state" dev=mmcblk0p3 ino=17
scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
<5>[   10.295074] type=1400 audit(948325885.234:123): avc:  denied  { open
} for  pid=117 comm="rild" name=".nv_state" dev=mmcblk0p3 ino=17
scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
<5>[   10.305938] type=1400 audit(948325885.250:124): avc:  denied  { open
} for  pid=117 comm="rild" name="nv_data.bin" dev=mmcblk0p12 ino=773683
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[   10.458526] type=1400 audit(948325885.398:125): avc:  denied  { write
} for  pid=117 comm="rild" name="nv_data.bin" dev=mmcblk0p12 ino=773683
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[   10.922363] type=1400 audit(948325885.867:126): avc:  denied  { read
write } for  pid=117 comm="rild" name="umts_ipc0" dev=tmpfs ino=2896
scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   10.922607] type=1400 audit(948325885.867:127): avc:  denied  { open
} for  pid=117 comm="rild" name="umts_ipc0" dev=tmpfs ino=2896
scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   11.924743] type=1400 audit(948325886.867:128): avc:  denied  {
search } for  pid=146 comm="rild" name="/" dev=fuse ino=1
scontext=u:r:rild:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
<5>[   11.948028] type=1400 audit(948325886.890:129): avc:  denied  { write
} for  pid=198 comm="rm" name="radio" dev=mmcblk0p12 ino=138462
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=dir
<5>[   11.948272] type=1400 audit(948325886.890:130): avc:  denied  {
remove_name } for  pid=198 comm="rm" name="ahrh" dev=mmcblk0p12 ino=138467
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=dir
<5>[   11.948425] type=1400 audit(948325886.890:131): avc:  denied  {
unlink } for  pid=198 comm="rm" name="ahrh" dev=mmcblk0p12 ino=138467
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[   13.930969] type=1400 audit(948325888.875:132): avc:  denied  { ioctl
} for  pid=191 comm="rild" path="/dev/umts_ipc0" dev=tmpfs ino=2896
scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   20.185607] type=1400 audit(948325895.125:133): avc:  denied  { read
write } for  pid=445 comm=4173796E635461736B202331 name="ttyO3" dev=tmpfs
ino=2751 scontext=u:r:nfc:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   20.185760] type=1400 audit(948325895.125:134): avc:  denied  { open
} for  pid=445 comm=4173796E635461736B202331 name="ttyO3" dev=tmpfs
ino=2751 scontext=u:r:nfc:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   20.187011] type=1400 audit(948325895.132:135): avc:  denied  { ioctl
} for  pid=445 comm=4173796E635461736B202331 path="/dev/ttyO3" dev=tmpfs
ino=2751 scontext=u:r:nfc:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   20.197570] type=1400 audit(948325895.140:136): avc:  denied  { write
} for  pid=445 comm=4173796E635461736B202331 name="nfc_power" dev=sysfs
ino=855 scontext=u:r:nfc:s0 tcontext=u:object_r:sysfs:s0 tclass=file
<5>[   20.609497] type=1400 audit(948325895.554:137): avc:  denied  { open
} for  pid=192 comm="rild" name="nv_data.bin" dev=mmcblk0p12 ino=773683
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[   20.723052] type=1400 audit(948325895.664:138): avc:  denied  { write
} for  pid=192 comm="rild" name="nv_data.bin" dev=mmcblk0p12 ino=773683
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[   21.223114] type=1400 audit(948325896.164:139): avc:  denied  { write
} for  pid=192 comm="rild" name="radio" dev=mmcblk0p12 ino=138462
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=dir
<5>[   21.223266] type=1400 audit(948325896.164:140): avc:  denied  {
add_name } for  pid=192 comm="rild" name="ahrh" scontext=u:r:rild:s0
tcontext=u:object_r:system_data_file:s0 tclass=dir
<5>[   21.223480] type=1400 audit(948325896.164:141): avc:  denied  {
create } for  pid=192 comm="rild" name="ahrh" scontext=u:r:rild:s0
tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[   21.251007] type=1400 audit(948325896.195:142): avc:  denied  {
execute_no_trans } for  pid=500 comm="sh" path="/system/bin/toolbox"
dev=mmcblk0p10 ino=224 scontext=u:r:rild:s0
tcontext=u:object_r:system_file:s0 tclass=file
<5>[   21.259979] type=1400 audit(948325896.203:143): avc:  denied  {
setattr } for  pid=500 comm="chmod" name="ahrh" dev=mmcblk0p12 ino=138467
scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[   21.261383] type=1400 audit(948325896.203:144): avc:  denied  {
getattr } for  pid=192 comm="rild" path="/factory/bluetooth/bt_addr"
dev=mmcblk0p3 ino=20 scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0
tclass=file
<5>[   21.261566] type=1400 audit(948325896.203:145): avc:  denied  { read
} for  pid=192 comm="rild" name="bt_addr" dev=mmcblk0p3 ino=20
scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
<5>[   21.261749] type=1400 audit(948325896.203:146): avc:  denied  { open
} for  pid=192 comm="rild" name="bt_addr" dev=mmcblk0p3 ino=20
scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
<5>[   21.262084] type=1400 audit(948325896.203:147): avc:  denied  { read
} for  pid=192 comm="rild" name="mps_code.dat" dev=mmcblk0p3 ino=21
scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
<5>[   21.262207] type=1400 audit(948325896.203:148): avc:  denied  { open
} for  pid=192 comm="rild" name="mps_code.dat" dev=mmcblk0p3 ino=21
scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
<5>[   21.262420] type=1400 audit(948325896.203:149): avc:  denied  {
getattr } for  pid=192 comm="rild" path="/factory/imei/mps_code.dat"
dev=mmcblk0p3 ino=21 scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0
tclass=file
<5>[   25.215148] type=1400 audit(948325900.156:150): avc:  denied  { ioctl
} for  pid=191 comm="rild" path="/dev/umts_ipc0" dev=tmpfs ino=2896
scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   48.440490] type=1400 audit(948325923.382:151): avc:  denied  {
search } for  pid=728 comm="adbd" name="/" dev=fuse ino=1
scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
<5>[   48.441406] type=1400 audit(948325923.382:152): avc:  denied  {
getattr } for  pid=728 comm="adbd" path="/mnt/sdcard/hello" dev=fuse
ino=31609656 scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file
<5>[   48.480072] type=1400 audit(948325923.421:153): avc:  denied  { read
} for  pid=728 comm="adbd" name="hello" dev=fuse ino=31609656
scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file
<5>[   48.480651] type=1400 audit(948325923.421:154): avc:  denied  { open
} for  pid=728 comm="adbd" name="hello" dev=fuse ino=31609656
scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file
<5>[   62.199890] type=1400 audit(948325937.140:155): avc:  denied  {
getattr } for  pid=734 comm="adbd" path="/mnt/sdcard" dev=fuse ino=1
scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
<5>[   62.244323] type=1400 audit(948325937.187:156): avc:  denied  { write
} for  pid=734 comm="adbd" name="/" dev=fuse ino=1 scontext=u:r:adbd:s0
tcontext=u:object_r:sdcard:s0 tclass=dir
<5>[   62.244750] type=1400 audit(948325937.187:157): avc:  denied  {
add_name } for  pid=734 comm="adbd" name="property.te" scontext=u:r:adbd:s0
tcontext=u:object_r:sdcard:s0 tclass=dir
<5>[   62.245391] type=1400 audit(948325937.187:158): avc:  denied  {
create } for  pid=734 comm="adbd" name="property.te" scontext=u:r:adbd:s0
tcontext=u:object_r:sdcard:s0 tclass=file
<5>[   62.248016] type=1400 audit(948325937.187:159): avc:  denied  { write
open } for  pid=734 comm="adbd" name="property.te" dev=fuse ino=31604760
scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file
<5>[   62.250396] type=1400 audit(948325937.195:160): avc:  denied  {
search } for  pid=734 comm="adbd" name="/" dev=fuse ino=1
scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
<5>[   62.250823] type=1400 audit(948325937.195:161): avc:  denied  {
setattr } for  pid=734 comm="adbd" name="property.te" dev=fuse ino=31604760
scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file

-- 
Respectfully,

William C Roberts

--bcaec501672777866404c147e6b7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have a lot of denials on a Maguro handset and was wondering if we should =
handle these in the common policy or per device. I am thinking common polic=
y, but any feedback is welcome. Below are the allow rules for the denials..=
.<div>
<br></div><div>The adbd denial is for abd push to sdcard. Should we even al=
low that? In my mind it&#39;s a yes.</div><div><br></div><div>I am also cur=
ious as to why rild needs access to the sdcard.. I shall look into that.</d=
iv>
<div><br></div><div><div>#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D adbd =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>allow adbd sdcard:dir { w=
rite search getattr add_name };</div><div>allow adbd sdcard:file { write ge=
tattr setattr read create open };</div><div><br></div>
<div>#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D nfc =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</div><div>allow nfc device:chr_file { read write ioctl o=
pen };</div><div>allow nfc sysfs:file write;</div><div><br></div><div>#=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D rild =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div>allow rild block_device:blk_file { read open };</div>
<div>allow rild block_device:lnk_file read;</div><div>allow rild device:chr=
_file { read write ioctl open };</div><div>allow rild radio_data_file:dir {=
 write search read remove_name open add_name };</div><div>allow rild radio_=
data_file:file { write getattr read lock create unlink open };</div>
<div>allow rild sdcard:dir search;</div><div>allow rild system_data_file:di=
r { write remove_name add_name setattr };</div><div>allow rild system_data_=
file:file { write create unlink open setattr };</div><div>allow rild system=
_file:file execute_no_trans;</div>
<div>allow rild unlabeled:file { read getattr open };</div><div><br></div><=
div>#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D surfaceflinger =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>allow surfaceflinger device:chr_file =
{ read write ioctl open };</div><div><br></div><div>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ueventd =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D</div><div>allow ueventd efs_file:dir search;</div><div>a=
llow ueventd efs_file:file { read getattr open };</div><div>allow ueventd s=
elf:capability { sys_rawio dac_override };</div><div>
<br></div><div>Here is the dmesg deny logs:</div><div><div>&lt;5&gt;[ =A0 =
=A05.130615] type=3D1400 audit(948325880.070:3): avc: =A0denied =A0{ sys_ra=
wio } for =A0pid=3D97 comm=3D&quot;ueventd&quot; capability=3D17 =A0scontex=
t=3Du:r:ueventd:s0 tcontext=3Du:r:ueventd:s0 tclass=3Dcapability</div>
<div>&lt;5&gt;[ =A0 =A05.211212] type=3D1400 audit(948325880.156:4): avc: =
=A0denied =A0{ search } for =A0pid=3D99 comm=3D&quot;ueventd&quot; name=3D&=
quot;/&quot; dev=3Dmmcblk0p3 ino=3D2 scontext=3Du:r:ueventd:s0 tcontext=3Du=
:object_r:efs_file:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 =A05.211944] type=3D1400 audit(948325880.156:5): avc: =
=A0denied =A0{ dac_override } for =A0pid=3D99 comm=3D&quot;ueventd&quot; ca=
pability=3D1 =A0scontext=3Du:r:ueventd:s0 tcontext=3Du:r:ueventd:s0 tclass=
=3Dcapability</div><div>
&lt;5&gt;[ =A0 =A05.212493] type=3D1400 audit(948325880.156:6): avc: =A0den=
ied =A0{ read } for =A0pid=3D99 comm=3D&quot;ueventd&quot; name=3D&quot;hdc=
p.keys&quot; dev=3Dmmcblk0p3 ino=3D26 scontext=3Du:r:ueventd:s0 tcontext=3D=
u:object_r:efs_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A05.213043] type=3D1400 audit(948325880.156:7): avc: =
=A0denied =A0{ open } for =A0pid=3D99 comm=3D&quot;ueventd&quot; name=3D&qu=
ot;hdcp.keys&quot; dev=3Dmmcblk0p3 ino=3D26 scontext=3Du:r:ueventd:s0 tcont=
ext=3Du:object_r:efs_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A05.213470] type=3D1400 audit(948325880.156:8): avc: =
=A0denied =A0{ getattr } for =A0pid=3D99 comm=3D&quot;ueventd&quot; path=3D=
&quot;/factory/hdcp.keys&quot; dev=3Dmmcblk0p3 ino=3D26 scontext=3Du:r:ueve=
ntd:s0 tcontext=3Du:object_r:efs_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A05.890441] type=3D1400 audit(948325880.835:12): avc: =
=A0denied =A0{ search } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&qu=
ot;com.android.providers.telephony&quot; dev=3Dmmcblk0p12 ino=3D578318 scon=
text=3Du:r:rild:s0 tcontext=3Du:object_r:radio_data_file:s0 tclass=3Ddir</d=
iv>
<div>&lt;5&gt;[ =A0 =A05.891723] type=3D1400 audit(948325880.835:13): avc: =
=A0denied =A0{ write } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quo=
t;com.android.providers.telephony&quot; dev=3Dmmcblk0p12 ino=3D578318 scont=
ext=3Du:r:rild:s0 tcontext=3Du:object_r:radio_data_file:s0 tclass=3Ddir</di=
v>
<div>&lt;5&gt;[ =A0 =A05.892364] type=3D1400 audit(948325880.835:14): avc: =
=A0denied =A0{ add_name } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&=
quot;optable.db&quot; scontext=3Du:r:rild:s0 tcontext=3Du:object_r:radio_da=
ta_file:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 =A05.892913] type=3D1400 audit(948325880.835:15): avc: =
=A0denied =A0{ create } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&qu=
ot;optable.db&quot; scontext=3Du:r:rild:s0 tcontext=3Du:object_r:radio_data=
_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A05.906738] type=3D1400 audit(948325880.851:16): avc: =
=A0denied =A0{ read write open } for =A0pid=3D117 comm=3D&quot;rild&quot; n=
ame=3D&quot;optable.db&quot; dev=3Dmmcblk0p12 ino=3D578428 scontext=3Du:r:r=
ild:s0 tcontext=3Du:object_r:radio_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A05.907348] type=3D1400 audit(948325880.851:17): avc: =
=A0denied =A0{ getattr } for =A0pid=3D117 comm=3D&quot;rild&quot; path=3D&q=
uot;/data/data/com.android.providers.telephony/optable.db&quot; dev=3Dmmcbl=
k0p12 ino=3D578428 scontext=3Du:r:rild:s0 tcontext=3Du:object_r:radio_data_=
file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A05.909515] type=3D1400 audit(948325880.851:18): avc: =
=A0denied =A0{ lock } for =A0pid=3D117 comm=3D&quot;rild&quot; path=3D&quot=
;/data/data/com.android.providers.telephony/optable.db&quot; dev=3Dmmcblk0p=
12 ino=3D578428 scontext=3Du:r:rild:s0 tcontext=3Du:object_r:radio_data_fil=
e:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A05.917327] type=3D1400 audit(948325880.851:19): avc: =
=A0denied =A0{ read } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;com.android.providers.telephony&quot; dev=3Dmmcblk0p12 ino=3D578318 sconte=
xt=3Du:r:rild:s0 tcontext=3Du:object_r:radio_data_file:s0 tclass=3Ddir</div=
>
<div>&lt;5&gt;[ =A0 =A05.917938] type=3D1400 audit(948325880.859:20): avc: =
=A0denied =A0{ open } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;com.android.providers.telephony&quot; dev=3Dmmcblk0p12 ino=3D578318 sconte=
xt=3Du:r:rild:s0 tcontext=3Du:object_r:radio_data_file:s0 tclass=3Ddir</div=
>
<div>&lt;5&gt;[ =A0 =A06.071685] type=3D1400 audit(948325881.015:21): avc: =
=A0denied =A0{ remove_name } for =A0pid=3D117 comm=3D&quot;rild&quot; name=
=3D&quot;optable.db-journal&quot; dev=3Dmmcblk0p12 ino=3D578430 scontext=3D=
u:r:rild:s0 tcontext=3Du:object_r:radio_data_file:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 =A06.072326] type=3D1400 audit(948325881.015:22): avc: =
=A0denied =A0{ unlink } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&qu=
ot;optable.db-journal&quot; dev=3Dmmcblk0p12 ino=3D578430 scontext=3Du:r:ri=
ld:s0 tcontext=3Du:object_r:radio_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A06.127838] type=3D1400 audit(948325881.070:23): avc: =
=A0denied =A0{ execute_no_trans } for =A0pid=3D158 comm=3D&quot;sh&quot; pa=
th=3D&quot;/system/bin/toolbox&quot; dev=3Dmmcblk0p10 ino=3D224 scontext=3D=
u:r:rild:s0 tcontext=3Du:object_r:system_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 =A06.161285] type=3D1400 audit(948325881.101:24): avc: =
=A0denied =A0{ setattr } for =A0pid=3D162 comm=3D&quot;chmod&quot; name=3D&=
quot;log&quot; dev=3Dmmcblk0p12 ino=3D773682 scontext=3Du:r:rild:s0 tcontex=
t=3Du:object_r:system_data_file:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 =A06.206909] type=3D1400 audit(948325881.148:25): avc: =
=A0denied =A0{ read write } for =A0pid=3D117 comm=3D&quot;rild&quot; name=
=3D&quot;umts_boot0&quot; dev=3Dtmpfs ino=3D2898 scontext=3Du:r:rild:s0 tco=
ntext=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 =A06.207092] type=3D1400 audit(948325881.148:26): avc: =
=A0denied =A0{ open } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;umts_boot0&quot; dev=3Dtmpfs ino=3D2898 scontext=3Du:r:rild:s0 tcontext=3D=
u:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 =A06.208190] type=3D1400 audit(948325881.148:27): avc: =
=A0denied =A0{ ioctl } for =A0pid=3D117 comm=3D&quot;rild&quot; path=3D&quo=
t;/dev/umts_boot0&quot; dev=3Dtmpfs ino=3D2898 scontext=3Du:r:rild:s0 tcont=
ext=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 =A06.443878] type=3D1400 audit(948325881.382:28): avc: =
=A0denied =A0{ read } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;radio&quot; dev=3Dtmpfs ino=3D2793 scontext=3Du:r:rild:s0 tcontext=3Du:obj=
ect_r:block_device:s0 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[ =A0 =A06.444549] type=3D1400 audit(948325881.390:29): avc: =
=A0denied =A0{ read } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;mmcblk0p9&quot; dev=3Dtmpfs ino=3D2792 scontext=3Du:r:rild:s0 tcontext=3Du=
:object_r:block_device:s0 tclass=3Dblk_file</div>
<div>&lt;5&gt;[ =A0 =A06.444946] type=3D1400 audit(948325881.390:30): avc: =
=A0denied =A0{ open } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;mmcblk0p9&quot; dev=3Dtmpfs ino=3D2792 scontext=3Du:r:rild:s0 tcontext=3Du=
:object_r:block_device:s0 tclass=3Dblk_file</div>
<div>&lt;5&gt;[ =A0 =A06.763000] type=3D1400 audit(948325881.703:31): avc: =
=A0denied =A0{ read write } for =A0pid=3D168 comm=3D&quot;SurfaceFlinger&qu=
ot; name=3D&quot;dsscomp&quot; dev=3Dtmpfs ino=3D2872 scontext=3Du:r:surfac=
eflinger:s0 tcontext=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 =A06.763183] type=3D1400 audit(948325881.703:32): avc: =
=A0denied =A0{ open } for =A0pid=3D168 comm=3D&quot;SurfaceFlinger&quot; na=
me=3D&quot;dsscomp&quot; dev=3Dtmpfs ino=3D2872 scontext=3Du:r:surfacefling=
er:s0 tcontext=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 =A06.764251] type=3D1400 audit(948325881.703:33): avc: =
=A0denied =A0{ ioctl } for =A0pid=3D168 comm=3D&quot;SurfaceFlinger&quot; p=
ath=3D&quot;/dev/dsscomp&quot; dev=3Dtmpfs ino=3D2872 scontext=3Du:r:surfac=
eflinger:s0 tcontext=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 10.293914] type=3D1400 audit(948325885.234:121): avc: =
=A0denied =A0{ getattr } for =A0pid=3D117 comm=3D&quot;rild&quot; path=3D&q=
uot;/factory/.nv_data.bak&quot; dev=3Dmmcblk0p3 ino=3D24 scontext=3Du:r:ril=
d:s0 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 10.294525] type=3D1400 audit(948325885.234:122): avc: =
=A0denied =A0{ read } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;.nv_state&quot; dev=3Dmmcblk0p3 ino=3D17 scontext=3Du:r:rild:s0 tcontext=
=3Du:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 10.295074] type=3D1400 audit(948325885.234:123): avc: =
=A0denied =A0{ open } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;.nv_state&quot; dev=3Dmmcblk0p3 ino=3D17 scontext=3Du:r:rild:s0 tcontext=
=3Du:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 10.305938] type=3D1400 audit(948325885.250:124): avc: =
=A0denied =A0{ open } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;nv_data.bin&quot; dev=3Dmmcblk0p12 ino=3D773683 scontext=3Du:r:rild:s0 tco=
ntext=3Du:object_r:system_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 10.458526] type=3D1400 audit(948325885.398:125): avc: =
=A0denied =A0{ write } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quo=
t;nv_data.bin&quot; dev=3Dmmcblk0p12 ino=3D773683 scontext=3Du:r:rild:s0 tc=
ontext=3Du:object_r:system_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 10.922363] type=3D1400 audit(948325885.867:126): avc: =
=A0denied =A0{ read write } for =A0pid=3D117 comm=3D&quot;rild&quot; name=
=3D&quot;umts_ipc0&quot; dev=3Dtmpfs ino=3D2896 scontext=3Du:r:rild:s0 tcon=
text=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 10.922607] type=3D1400 audit(948325885.867:127): avc: =
=A0denied =A0{ open } for =A0pid=3D117 comm=3D&quot;rild&quot; name=3D&quot=
;umts_ipc0&quot; dev=3Dtmpfs ino=3D2896 scontext=3Du:r:rild:s0 tcontext=3Du=
:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 11.924743] type=3D1400 audit(948325886.867:128): avc: =
=A0denied =A0{ search } for =A0pid=3D146 comm=3D&quot;rild&quot; name=3D&qu=
ot;/&quot; dev=3Dfuse ino=3D1 scontext=3Du:r:rild:s0 tcontext=3Du:object_r:=
sdcard:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 11.948028] type=3D1400 audit(948325886.890:129): avc: =
=A0denied =A0{ write } for =A0pid=3D198 comm=3D&quot;rm&quot; name=3D&quot;=
radio&quot; dev=3Dmmcblk0p12 ino=3D138462 scontext=3Du:r:rild:s0 tcontext=
=3Du:object_r:system_data_file:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 11.948272] type=3D1400 audit(948325886.890:130): avc: =
=A0denied =A0{ remove_name } for =A0pid=3D198 comm=3D&quot;rm&quot; name=3D=
&quot;ahrh&quot; dev=3Dmmcblk0p12 ino=3D138467 scontext=3Du:r:rild:s0 tcont=
ext=3Du:object_r:system_data_file:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 11.948425] type=3D1400 audit(948325886.890:131): avc: =
=A0denied =A0{ unlink } for =A0pid=3D198 comm=3D&quot;rm&quot; name=3D&quot=
;ahrh&quot; dev=3Dmmcblk0p12 ino=3D138467 scontext=3Du:r:rild:s0 tcontext=
=3Du:object_r:system_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 13.930969] type=3D1400 audit(948325888.875:132): avc: =
=A0denied =A0{ ioctl } for =A0pid=3D191 comm=3D&quot;rild&quot; path=3D&quo=
t;/dev/umts_ipc0&quot; dev=3Dtmpfs ino=3D2896 scontext=3Du:r:rild:s0 tconte=
xt=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 20.185607] type=3D1400 audit(948325895.125:133): avc: =
=A0denied =A0{ read write } for =A0pid=3D445 comm=3D4173796E635461736B20233=
1 name=3D&quot;ttyO3&quot; dev=3Dtmpfs ino=3D2751 scontext=3Du:r:nfc:s0 tco=
ntext=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 20.185760] type=3D1400 audit(948325895.125:134): avc: =
=A0denied =A0{ open } for =A0pid=3D445 comm=3D4173796E635461736B202331 name=
=3D&quot;ttyO3&quot; dev=3Dtmpfs ino=3D2751 scontext=3Du:r:nfc:s0 tcontext=
=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 20.187011] type=3D1400 audit(948325895.132:135): avc: =
=A0denied =A0{ ioctl } for =A0pid=3D445 comm=3D4173796E635461736B202331 pat=
h=3D&quot;/dev/ttyO3&quot; dev=3Dtmpfs ino=3D2751 scontext=3Du:r:nfc:s0 tco=
ntext=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 20.197570] type=3D1400 audit(948325895.140:136): avc: =
=A0denied =A0{ write } for =A0pid=3D445 comm=3D4173796E635461736B202331 nam=
e=3D&quot;nfc_power&quot; dev=3Dsysfs ino=3D855 scontext=3Du:r:nfc:s0 tcont=
ext=3Du:object_r:sysfs:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 20.609497] type=3D1400 audit(948325895.554:137): avc: =
=A0denied =A0{ open } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&quot=
;nv_data.bin&quot; dev=3Dmmcblk0p12 ino=3D773683 scontext=3Du:r:rild:s0 tco=
ntext=3Du:object_r:system_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 20.723052] type=3D1400 audit(948325895.664:138): avc: =
=A0denied =A0{ write } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&quo=
t;nv_data.bin&quot; dev=3Dmmcblk0p12 ino=3D773683 scontext=3Du:r:rild:s0 tc=
ontext=3Du:object_r:system_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.223114] type=3D1400 audit(948325896.164:139): avc: =
=A0denied =A0{ write } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&quo=
t;radio&quot; dev=3Dmmcblk0p12 ino=3D138462 scontext=3Du:r:rild:s0 tcontext=
=3Du:object_r:system_data_file:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 21.223266] type=3D1400 audit(948325896.164:140): avc: =
=A0denied =A0{ add_name } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&=
quot;ahrh&quot; scontext=3Du:r:rild:s0 tcontext=3Du:object_r:system_data_fi=
le:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 21.223480] type=3D1400 audit(948325896.164:141): avc: =
=A0denied =A0{ create } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&qu=
ot;ahrh&quot; scontext=3Du:r:rild:s0 tcontext=3Du:object_r:system_data_file=
:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.251007] type=3D1400 audit(948325896.195:142): avc: =
=A0denied =A0{ execute_no_trans } for =A0pid=3D500 comm=3D&quot;sh&quot; pa=
th=3D&quot;/system/bin/toolbox&quot; dev=3Dmmcblk0p10 ino=3D224 scontext=3D=
u:r:rild:s0 tcontext=3Du:object_r:system_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.259979] type=3D1400 audit(948325896.203:143): avc: =
=A0denied =A0{ setattr } for =A0pid=3D500 comm=3D&quot;chmod&quot; name=3D&=
quot;ahrh&quot; dev=3Dmmcblk0p12 ino=3D138467 scontext=3Du:r:rild:s0 tconte=
xt=3Du:object_r:system_data_file:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.261383] type=3D1400 audit(948325896.203:144): avc: =
=A0denied =A0{ getattr } for =A0pid=3D192 comm=3D&quot;rild&quot; path=3D&q=
uot;/factory/bluetooth/bt_addr&quot; dev=3Dmmcblk0p3 ino=3D20 scontext=3Du:=
r:rild:s0 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.261566] type=3D1400 audit(948325896.203:145): avc: =
=A0denied =A0{ read } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&quot=
;bt_addr&quot; dev=3Dmmcblk0p3 ino=3D20 scontext=3Du:r:rild:s0 tcontext=3Du=
:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.261749] type=3D1400 audit(948325896.203:146): avc: =
=A0denied =A0{ open } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&quot=
;bt_addr&quot; dev=3Dmmcblk0p3 ino=3D20 scontext=3Du:r:rild:s0 tcontext=3Du=
:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.262084] type=3D1400 audit(948325896.203:147): avc: =
=A0denied =A0{ read } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&quot=
;mps_code.dat&quot; dev=3Dmmcblk0p3 ino=3D21 scontext=3Du:r:rild:s0 tcontex=
t=3Du:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.262207] type=3D1400 audit(948325896.203:148): avc: =
=A0denied =A0{ open } for =A0pid=3D192 comm=3D&quot;rild&quot; name=3D&quot=
;mps_code.dat&quot; dev=3Dmmcblk0p3 ino=3D21 scontext=3Du:r:rild:s0 tcontex=
t=3Du:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 21.262420] type=3D1400 audit(948325896.203:149): avc: =
=A0denied =A0{ getattr } for =A0pid=3D192 comm=3D&quot;rild&quot; path=3D&q=
uot;/factory/imei/mps_code.dat&quot; dev=3Dmmcblk0p3 ino=3D21 scontext=3Du:=
r:rild:s0 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 25.215148] type=3D1400 audit(948325900.156:150): avc: =
=A0denied =A0{ ioctl } for =A0pid=3D191 comm=3D&quot;rild&quot; path=3D&quo=
t;/dev/umts_ipc0&quot; dev=3Dtmpfs ino=3D2896 scontext=3Du:r:rild:s0 tconte=
xt=3Du:object_r:device:s0 tclass=3Dchr_file</div>
<div>&lt;5&gt;[ =A0 48.440490] type=3D1400 audit(948325923.382:151): avc: =
=A0denied =A0{ search } for =A0pid=3D728 comm=3D&quot;adbd&quot; name=3D&qu=
ot;/&quot; dev=3Dfuse ino=3D1 scontext=3Du:r:adbd:s0 tcontext=3Du:object_r:=
sdcard:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 48.441406] type=3D1400 audit(948325923.382:152): avc: =
=A0denied =A0{ getattr } for =A0pid=3D728 comm=3D&quot;adbd&quot; path=3D&q=
uot;/mnt/sdcard/hello&quot; dev=3Dfuse ino=3D31609656 scontext=3Du:r:adbd:s=
0 tcontext=3Du:object_r:sdcard:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 48.480072] type=3D1400 audit(948325923.421:153): avc: =
=A0denied =A0{ read } for =A0pid=3D728 comm=3D&quot;adbd&quot; name=3D&quot=
;hello&quot; dev=3Dfuse ino=3D31609656 scontext=3Du:r:adbd:s0 tcontext=3Du:=
object_r:sdcard:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 48.480651] type=3D1400 audit(948325923.421:154): avc: =
=A0denied =A0{ open } for =A0pid=3D728 comm=3D&quot;adbd&quot; name=3D&quot=
;hello&quot; dev=3Dfuse ino=3D31609656 scontext=3Du:r:adbd:s0 tcontext=3Du:=
object_r:sdcard:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 62.199890] type=3D1400 audit(948325937.140:155): avc: =
=A0denied =A0{ getattr } for =A0pid=3D734 comm=3D&quot;adbd&quot; path=3D&q=
uot;/mnt/sdcard&quot; dev=3Dfuse ino=3D1 scontext=3Du:r:adbd:s0 tcontext=3D=
u:object_r:sdcard:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 62.244323] type=3D1400 audit(948325937.187:156): avc: =
=A0denied =A0{ write } for =A0pid=3D734 comm=3D&quot;adbd&quot; name=3D&quo=
t;/&quot; dev=3Dfuse ino=3D1 scontext=3Du:r:adbd:s0 tcontext=3Du:object_r:s=
dcard:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 62.244750] type=3D1400 audit(948325937.187:157): avc: =
=A0denied =A0{ add_name } for =A0pid=3D734 comm=3D&quot;adbd&quot; name=3D&=
quot;property.te&quot; scontext=3Du:r:adbd:s0 tcontext=3Du:object_r:sdcard:=
s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 62.245391] type=3D1400 audit(948325937.187:158): avc: =
=A0denied =A0{ create } for =A0pid=3D734 comm=3D&quot;adbd&quot; name=3D&qu=
ot;property.te&quot; scontext=3Du:r:adbd:s0 tcontext=3Du:object_r:sdcard:s0=
 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 62.248016] type=3D1400 audit(948325937.187:159): avc: =
=A0denied =A0{ write open } for =A0pid=3D734 comm=3D&quot;adbd&quot; name=
=3D&quot;property.te&quot; dev=3Dfuse ino=3D31604760 scontext=3Du:r:adbd:s0=
 tcontext=3Du:object_r:sdcard:s0 tclass=3Dfile</div>
<div>&lt;5&gt;[ =A0 62.250396] type=3D1400 audit(948325937.195:160): avc: =
=A0denied =A0{ search } for =A0pid=3D734 comm=3D&quot;adbd&quot; name=3D&qu=
ot;/&quot; dev=3Dfuse ino=3D1 scontext=3Du:r:adbd:s0 tcontext=3Du:object_r:=
sdcard:s0 tclass=3Ddir</div>
<div>&lt;5&gt;[ =A0 62.250823] type=3D1400 audit(948325937.195:161): avc: =
=A0denied =A0{ setattr } for =A0pid=3D734 comm=3D&quot;adbd&quot; name=3D&q=
uot;property.te&quot; dev=3Dfuse ino=3D31604760 scontext=3Du:r:adbd:s0 tcon=
text=3Du:object_r:sdcard:s0 tclass=3Dfile</div>
</div><div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><=
br>
</div>

--bcaec501672777866404c147e6b7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
