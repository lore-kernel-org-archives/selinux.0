Subject: Re: SE Android Maguro denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: seandroid@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <CAFftDdpbeKgz06P1LNmW4M461q-X04ZAuvnwbvFdeA3Y23r1xA@mail.gmail.com>
References: 
	 <CAFftDdpbeKgz06P1LNmW4M461q-X04ZAuvnwbvFdeA3Y23r1xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 May 2012 09:35:34 -0400
Message-ID: <1338471334.11009.31.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-05-30 at 17:47 -0400, William Roberts wrote:
> I have a lot of denials on a Maguro handset and was wondering if we
> should handle these in the common policy or per device. I am thinking
> common policy, but any feedback is welcome. Below are the allow rules
> for the denials...
> 
> 
> The adbd denial is for abd push to sdcard. Should we even allow that?
> In my mind it's a yes.
> 
> 
> I am also curious as to why rild needs access to the sdcard.. I shall
> look into that.
> 
> 
> #============= adbd ==============
> allow adbd sdcard:dir { write search getattr add_name };
> allow adbd sdcard:file { write getattr setattr read create open };

I'd rewrite these using the global macros and add to common policy.


> #============= nfc ==============
> allow nfc device:chr_file { read write ioctl open };

Need to label the tty03 device with the nfc_device type.

> allow nfc sysfs:file write;

Could be added to common policy, or we could label the specific sysfs
node with a type writable by nfc to be finer-grained.

> #============= rild ==============
> allow rild block_device:blk_file { read open };
> allow rild block_device:lnk_file read;
> allow rild device:chr_file { read write ioctl open };

These are device labeling problems; need to add entries to the .fc files
for the devices identified in the device/tuna/ueventd.rc file that need
to be accessible to domains other than just the system server.

> allow rild radio_data_file:dir { write search read remove_name open
> add_name };
> allow rild radio_data_file:file { write getattr read lock create
> unlink open };
> allow rild sdcard:dir search;
> allow rild system_data_file:dir { write remove_name add_name
> setattr };
> allow rild system_data_file:file { write create unlink open setattr };
> allow rild system_file:file execute_no_trans;

Rewrite using the macros and add to common policy.

> allow rild unlabeled:file { read getattr open };

Need to fix the labeling problem.

> #============= surfaceflinger ==============
> allow surfaceflinger device:chr_file { read write ioctl open };

Need to label the dsscomp device with an appropriate type.

> #============= ueventd ==============
> allow ueventd efs_file:dir search;
> allow ueventd efs_file:file { read getattr open };
> allow ueventd self:capability { sys_rawio dac_override };

Likely can be allowed in common policy.  Might want to split up efs_file
further at some point.

> Here is the dmesg deny logs:
> <5>[    5.130615] type=1400 audit(948325880.070:3): avc:  denied
>  { sys_rawio } for  pid=97 comm="ueventd" capability=17
>  scontext=u:r:ueventd:s0 tcontext=u:r:ueventd:s0 tclass=capability
> <5>[    5.211212] type=1400 audit(948325880.156:4): avc:  denied
>  { search } for  pid=99 comm="ueventd" name="/" dev=mmcblk0p3 ino=2
> scontext=u:r:ueventd:s0 tcontext=u:object_r:efs_file:s0 tclass=dir
> <5>[    5.211944] type=1400 audit(948325880.156:5): avc:  denied
>  { dac_override } for  pid=99 comm="ueventd" capability=1
>  scontext=u:r:ueventd:s0 tcontext=u:r:ueventd:s0 tclass=capability
> <5>[    5.212493] type=1400 audit(948325880.156:6): avc:  denied
>  { read } for  pid=99 comm="ueventd" name="hdcp.keys" dev=mmcblk0p3
> ino=26 scontext=u:r:ueventd:s0 tcontext=u:object_r:efs_file:s0
> tclass=file
> <5>[    5.213043] type=1400 audit(948325880.156:7): avc:  denied
>  { open } for  pid=99 comm="ueventd" name="hdcp.keys" dev=mmcblk0p3
> ino=26 scontext=u:r:ueventd:s0 tcontext=u:object_r:efs_file:s0
> tclass=file
> <5>[    5.213470] type=1400 audit(948325880.156:8): avc:  denied
>  { getattr } for  pid=99 comm="ueventd" path="/factory/hdcp.keys"
> dev=mmcblk0p3 ino=26 scontext=u:r:ueventd:s0
> tcontext=u:object_r:efs_file:s0 tclass=file
> <5>[    5.890441] type=1400 audit(948325880.835:12): avc:  denied
>  { search } for  pid=117 comm="rild"
> name="com.android.providers.telephony" dev=mmcblk0p12 ino=578318
> scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0 tclass=dir
> <5>[    5.891723] type=1400 audit(948325880.835:13): avc:  denied
>  { write } for  pid=117 comm="rild"
> name="com.android.providers.telephony" dev=mmcblk0p12 ino=578318
> scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0 tclass=dir
> <5>[    5.892364] type=1400 audit(948325880.835:14): avc:  denied
>  { add_name } for  pid=117 comm="rild" name="optable.db"
> scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0 tclass=dir
> <5>[    5.892913] type=1400 audit(948325880.835:15): avc:  denied
>  { create } for  pid=117 comm="rild" name="optable.db"
> scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0
> tclass=file
> <5>[    5.906738] type=1400 audit(948325880.851:16): avc:  denied
>  { read write open } for  pid=117 comm="rild" name="optable.db"
> dev=mmcblk0p12 ino=578428 scontext=u:r:rild:s0
> tcontext=u:object_r:radio_data_file:s0 tclass=file
> <5>[    5.907348] type=1400 audit(948325880.851:17): avc:  denied
>  { getattr } for  pid=117 comm="rild"
> path="/data/data/com.android.providers.telephony/optable.db"
> dev=mmcblk0p12 ino=578428 scontext=u:r:rild:s0
> tcontext=u:object_r:radio_data_file:s0 tclass=file
> <5>[    5.909515] type=1400 audit(948325880.851:18): avc:  denied
>  { lock } for  pid=117 comm="rild"
> path="/data/data/com.android.providers.telephony/optable.db"
> dev=mmcblk0p12 ino=578428 scontext=u:r:rild:s0
> tcontext=u:object_r:radio_data_file:s0 tclass=file
> <5>[    5.917327] type=1400 audit(948325880.851:19): avc:  denied
>  { read } for  pid=117 comm="rild"
> name="com.android.providers.telephony" dev=mmcblk0p12 ino=578318
> scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0 tclass=dir
> <5>[    5.917938] type=1400 audit(948325880.859:20): avc:  denied
>  { open } for  pid=117 comm="rild"
> name="com.android.providers.telephony" dev=mmcblk0p12 ino=578318
> scontext=u:r:rild:s0 tcontext=u:object_r:radio_data_file:s0 tclass=dir
> <5>[    6.071685] type=1400 audit(948325881.015:21): avc:  denied
>  { remove_name } for  pid=117 comm="rild" name="optable.db-journal"
> dev=mmcblk0p12 ino=578430 scontext=u:r:rild:s0
> tcontext=u:object_r:radio_data_file:s0 tclass=dir
> <5>[    6.072326] type=1400 audit(948325881.015:22): avc:  denied
>  { unlink } for  pid=117 comm="rild" name="optable.db-journal"
> dev=mmcblk0p12 ino=578430 scontext=u:r:rild:s0
> tcontext=u:object_r:radio_data_file:s0 tclass=file
> <5>[    6.127838] type=1400 audit(948325881.070:23): avc:  denied
>  { execute_no_trans } for  pid=158 comm="sh"
> path="/system/bin/toolbox" dev=mmcblk0p10 ino=224 scontext=u:r:rild:s0
> tcontext=u:object_r:system_file:s0 tclass=file
> <5>[    6.161285] type=1400 audit(948325881.101:24): avc:  denied
>  { setattr } for  pid=162 comm="chmod" name="log" dev=mmcblk0p12
> ino=773682 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=dir
> <5>[    6.206909] type=1400 audit(948325881.148:25): avc:  denied
>  { read write } for  pid=117 comm="rild" name="umts_boot0" dev=tmpfs
> ino=2898 scontext=u:r:rild:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[    6.207092] type=1400 audit(948325881.148:26): avc:  denied
>  { open } for  pid=117 comm="rild" name="umts_boot0" dev=tmpfs
> ino=2898 scontext=u:r:rild:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[    6.208190] type=1400 audit(948325881.148:27): avc:  denied
>  { ioctl } for  pid=117 comm="rild" path="/dev/umts_boot0" dev=tmpfs
> ino=2898 scontext=u:r:rild:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[    6.443878] type=1400 audit(948325881.382:28): avc:  denied
>  { read } for  pid=117 comm="rild" name="radio" dev=tmpfs ino=2793
> scontext=u:r:rild:s0 tcontext=u:object_r:block_device:s0
> tclass=lnk_file
> <5>[    6.444549] type=1400 audit(948325881.390:29): avc:  denied
>  { read } for  pid=117 comm="rild" name="mmcblk0p9" dev=tmpfs ino=2792
> scontext=u:r:rild:s0 tcontext=u:object_r:block_device:s0
> tclass=blk_file
> <5>[    6.444946] type=1400 audit(948325881.390:30): avc:  denied
>  { open } for  pid=117 comm="rild" name="mmcblk0p9" dev=tmpfs ino=2792
> scontext=u:r:rild:s0 tcontext=u:object_r:block_device:s0
> tclass=blk_file
> <5>[    6.763000] type=1400 audit(948325881.703:31): avc:  denied
>  { read write } for  pid=168 comm="SurfaceFlinger" name="dsscomp"
> dev=tmpfs ino=2872 scontext=u:r:surfaceflinger:s0
> tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[    6.763183] type=1400 audit(948325881.703:32): avc:  denied
>  { open } for  pid=168 comm="SurfaceFlinger" name="dsscomp" dev=tmpfs
> ino=2872 scontext=u:r:surfaceflinger:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[    6.764251] type=1400 audit(948325881.703:33): avc:  denied
>  { ioctl } for  pid=168 comm="SurfaceFlinger" path="/dev/dsscomp"
> dev=tmpfs ino=2872 scontext=u:r:surfaceflinger:s0
> tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[   10.293914] type=1400 audit(948325885.234:121): avc:  denied
>  { getattr } for  pid=117 comm="rild" path="/factory/.nv_data.bak"
> dev=mmcblk0p3 ino=24 scontext=u:r:rild:s0
> tcontext=u:object_r:unlabeled:s0 tclass=file
> <5>[   10.294525] type=1400 audit(948325885.234:122): avc:  denied
>  { read } for  pid=117 comm="rild" name=".nv_state" dev=mmcblk0p3
> ino=17 scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0
> tclass=file
> <5>[   10.295074] type=1400 audit(948325885.234:123): avc:  denied
>  { open } for  pid=117 comm="rild" name=".nv_state" dev=mmcblk0p3
> ino=17 scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0
> tclass=file
> <5>[   10.305938] type=1400 audit(948325885.250:124): avc:  denied
>  { open } for  pid=117 comm="rild" name="nv_data.bin" dev=mmcblk0p12
> ino=773683 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[   10.458526] type=1400 audit(948325885.398:125): avc:  denied
>  { write } for  pid=117 comm="rild" name="nv_data.bin" dev=mmcblk0p12
> ino=773683 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[   10.922363] type=1400 audit(948325885.867:126): avc:  denied
>  { read write } for  pid=117 comm="rild" name="umts_ipc0" dev=tmpfs
> ino=2896 scontext=u:r:rild:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   10.922607] type=1400 audit(948325885.867:127): avc:  denied
>  { open } for  pid=117 comm="rild" name="umts_ipc0" dev=tmpfs ino=2896
> scontext=u:r:rild:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[   11.924743] type=1400 audit(948325886.867:128): avc:  denied
>  { search } for  pid=146 comm="rild" name="/" dev=fuse ino=1
> scontext=u:r:rild:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
> <5>[   11.948028] type=1400 audit(948325886.890:129): avc:  denied
>  { write } for  pid=198 comm="rm" name="radio" dev=mmcblk0p12
> ino=138462 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=dir
> <5>[   11.948272] type=1400 audit(948325886.890:130): avc:  denied
>  { remove_name } for  pid=198 comm="rm" name="ahrh" dev=mmcblk0p12
> ino=138467 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=dir
> <5>[   11.948425] type=1400 audit(948325886.890:131): avc:  denied
>  { unlink } for  pid=198 comm="rm" name="ahrh" dev=mmcblk0p12
> ino=138467 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[   13.930969] type=1400 audit(948325888.875:132): avc:  denied
>  { ioctl } for  pid=191 comm="rild" path="/dev/umts_ipc0" dev=tmpfs
> ino=2896 scontext=u:r:rild:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   20.185607] type=1400 audit(948325895.125:133): avc:  denied
>  { read write } for  pid=445 comm=4173796E635461736B202331
> name="ttyO3" dev=tmpfs ino=2751 scontext=u:r:nfc:s0
> tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[   20.185760] type=1400 audit(948325895.125:134): avc:  denied
>  { open } for  pid=445 comm=4173796E635461736B202331 name="ttyO3"
> dev=tmpfs ino=2751 scontext=u:r:nfc:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   20.187011] type=1400 audit(948325895.132:135): avc:  denied
>  { ioctl } for  pid=445 comm=4173796E635461736B202331
> path="/dev/ttyO3" dev=tmpfs ino=2751 scontext=u:r:nfc:s0
> tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[   20.197570] type=1400 audit(948325895.140:136): avc:  denied
>  { write } for  pid=445 comm=4173796E635461736B202331 name="nfc_power"
> dev=sysfs ino=855 scontext=u:r:nfc:s0 tcontext=u:object_r:sysfs:s0
> tclass=file
> <5>[   20.609497] type=1400 audit(948325895.554:137): avc:  denied
>  { open } for  pid=192 comm="rild" name="nv_data.bin" dev=mmcblk0p12
> ino=773683 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[   20.723052] type=1400 audit(948325895.664:138): avc:  denied
>  { write } for  pid=192 comm="rild" name="nv_data.bin" dev=mmcblk0p12
> ino=773683 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[   21.223114] type=1400 audit(948325896.164:139): avc:  denied
>  { write } for  pid=192 comm="rild" name="radio" dev=mmcblk0p12
> ino=138462 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=dir
> <5>[   21.223266] type=1400 audit(948325896.164:140): avc:  denied
>  { add_name } for  pid=192 comm="rild" name="ahrh"
> scontext=u:r:rild:s0 tcontext=u:object_r:system_data_file:s0
> tclass=dir
> <5>[   21.223480] type=1400 audit(948325896.164:141): avc:  denied
>  { create } for  pid=192 comm="rild" name="ahrh" scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[   21.251007] type=1400 audit(948325896.195:142): avc:  denied
>  { execute_no_trans } for  pid=500 comm="sh"
> path="/system/bin/toolbox" dev=mmcblk0p10 ino=224 scontext=u:r:rild:s0
> tcontext=u:object_r:system_file:s0 tclass=file
> <5>[   21.259979] type=1400 audit(948325896.203:143): avc:  denied
>  { setattr } for  pid=500 comm="chmod" name="ahrh" dev=mmcblk0p12
> ino=138467 scontext=u:r:rild:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[   21.261383] type=1400 audit(948325896.203:144): avc:  denied
>  { getattr } for  pid=192 comm="rild"
> path="/factory/bluetooth/bt_addr" dev=mmcblk0p3 ino=20
> scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
> <5>[   21.261566] type=1400 audit(948325896.203:145): avc:  denied
>  { read } for  pid=192 comm="rild" name="bt_addr" dev=mmcblk0p3 ino=20
> scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
> <5>[   21.261749] type=1400 audit(948325896.203:146): avc:  denied
>  { open } for  pid=192 comm="rild" name="bt_addr" dev=mmcblk0p3 ino=20
> scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
> <5>[   21.262084] type=1400 audit(948325896.203:147): avc:  denied
>  { read } for  pid=192 comm="rild" name="mps_code.dat" dev=mmcblk0p3
> ino=21 scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0
> tclass=file
> <5>[   21.262207] type=1400 audit(948325896.203:148): avc:  denied
>  { open } for  pid=192 comm="rild" name="mps_code.dat" dev=mmcblk0p3
> ino=21 scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0
> tclass=file
> <5>[   21.262420] type=1400 audit(948325896.203:149): avc:  denied
>  { getattr } for  pid=192 comm="rild"
> path="/factory/imei/mps_code.dat" dev=mmcblk0p3 ino=21
> scontext=u:r:rild:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
> <5>[   25.215148] type=1400 audit(948325900.156:150): avc:  denied
>  { ioctl } for  pid=191 comm="rild" path="/dev/umts_ipc0" dev=tmpfs
> ino=2896 scontext=u:r:rild:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   48.440490] type=1400 audit(948325923.382:151): avc:  denied
>  { search } for  pid=728 comm="adbd" name="/" dev=fuse ino=1
> scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
> <5>[   48.441406] type=1400 audit(948325923.382:152): avc:  denied
>  { getattr } for  pid=728 comm="adbd" path="/mnt/sdcard/hello"
> dev=fuse ino=31609656 scontext=u:r:adbd:s0
> tcontext=u:object_r:sdcard:s0 tclass=file
> <5>[   48.480072] type=1400 audit(948325923.421:153): avc:  denied
>  { read } for  pid=728 comm="adbd" name="hello" dev=fuse ino=31609656
> scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file
> <5>[   48.480651] type=1400 audit(948325923.421:154): avc:  denied
>  { open } for  pid=728 comm="adbd" name="hello" dev=fuse ino=31609656
> scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file
> <5>[   62.199890] type=1400 audit(948325937.140:155): avc:  denied
>  { getattr } for  pid=734 comm="adbd" path="/mnt/sdcard" dev=fuse
> ino=1 scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
> <5>[   62.244323] type=1400 audit(948325937.187:156): avc:  denied
>  { write } for  pid=734 comm="adbd" name="/" dev=fuse ino=1
> scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
> <5>[   62.244750] type=1400 audit(948325937.187:157): avc:  denied
>  { add_name } for  pid=734 comm="adbd" name="property.te"
> scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
> <5>[   62.245391] type=1400 audit(948325937.187:158): avc:  denied
>  { create } for  pid=734 comm="adbd" name="property.te"
> scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=file
> <5>[   62.248016] type=1400 audit(948325937.187:159): avc:  denied
>  { write open } for  pid=734 comm="adbd" name="property.te" dev=fuse
> ino=31604760 scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0
> tclass=file
> <5>[   62.250396] type=1400 audit(948325937.195:160): avc:  denied
>  { search } for  pid=734 comm="adbd" name="/" dev=fuse ino=1
> scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0 tclass=dir
> <5>[   62.250823] type=1400 audit(948325937.195:161): avc:  denied
>  { setattr } for  pid=734 comm="adbd" name="property.te" dev=fuse
> ino=31604760 scontext=u:r:adbd:s0 tcontext=u:object_r:sdcard:s0
> tclass=file
> 
> 
> -- 
> Respectfully,
> 
> William C Roberts
> 
> 
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
