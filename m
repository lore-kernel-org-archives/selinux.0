Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9F3wj6V013357
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 23:58:45 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9F3wiH6016775
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2008 03:58:45 GMT
Received: by wf-out-1314.google.com with SMTP id 28so3729532wff.30
        for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 20:58:44 -0700 (PDT)
Message-ID: <dd18b0c30810142058v76b83aacw2adbbd7a74aa14fc@mail.gmail.com>
Date: Tue, 14 Oct 2008 20:58:44 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: tresys <refpolicy@oss.tresys.com>
Subject: keep getting the same avc denial: tmpfs_t:dir search;
Cc: "SE Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With the latest refpolicy I keep receiving these avc's:

[   14.555115] type=1400 audit(1224041938.550:3): avc:  denied  {
getattr } for  pid=1392 comm="alsa-utils" path="/var/lib/alsa"
dev=sda1 ino=2146537 scontext=system_u:system_r:udev_t
tcontext=system_u:object_r:alsa_var_lib_t tclass=dir
[   14.575795] type=1300 audit(1224041938.550:3): arch=40000003
syscall=195 success=yes exit=0 a0=806082c a1=bfd2d50c a2=b7efcff4
a3=806082c items=0 ppid=1 pid=1392 auid=4294967295 uid=0 gid=0 euid=0
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295
comm="alsa-utils" exe="/bin/dash" subj=system_u:system_r:udev_t
key=(null)
[   14.642388] type=1400 audit(1224041938.640:4): avc:  denied  {
search } for  pid=1392 comm="alsa-utils" name="alsa" dev=sda1
ino=2146537 scontext=system_u:system_r:udev_t
tcontext=system_u:object_r:alsa_var_lib_t tclass=dir
[   14.665440] type=1400 audit(1224041938.640:4): avc:  denied  {
getattr } for  pid=1392 comm="alsa-utils"
path="/var/lib/alsa/asound.state" dev=sda1 ino=2146748
scontext=system_u:system_r:udev_t
tcontext=system_u:object_r:alsa_var_lib_t tclass=file
[   14.689253] type=1300 audit(1224041938.640:4): arch=40000003
syscall=195 success=yes exit=0 a0=8062d4c a1=bfd2d39c a2=b7efcff4
a3=8062d4c items=0 ppid=1 pid=1392 auid=4294967295 uid=0 gid=0 euid=0
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295
comm="alsa-utils" exe="/bin/dash" subj=system_u:system_r:udev_t
key=(null)
[   14.728721] type=1400 audit(1224041938.725:5): avc:  denied  {
search } for  pid=1407 comm="alsactl" name="/" dev=tmpfs ino=1721
scontext=system_u:system_r:alsa_t tcontext=system_u:object_r:tmpfs_t
tclass=dir
[   14.753962] type=1300 audit(1224041938.725:5): arch=40000003
syscall=5 success=yes exit=3 a0=bf93db82 a1=0 a2=1e a3=bf93db82
items=0 ppid=1392 pid=1407 auid=4294967295 uid=0 gid=0 euid=0 suid=0
fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="alsactl"
exe="/sbin/alsactl" subj=system_u:system_r:alsa_t key=(null)
[   14.800199] usb 1-2: USB disconnect, address 2
[   14.800324] usbcore: registered new interface driver appletouch
[   14.827628] usbcore: registered new interface driver uvcvideo
[   14.841746] USB Video Class driver (v0.1.0)
[   14.948734] type=1400 audit(1224041938.942:6): avc:  denied  {
search } for  pid=1454 comm="hwclock" name="/" dev=tmpfs ino=1721
scontext=system_u:system_r:hwclock_t
tcontext=system_u:object_r:tmpfs_t tclass=dir
[   14.976585] type=1300 audit(1224041938.942:6): arch=40000003
syscall=5 success=no exit=-2 a0=804db7e a1=8000 a2=0 a3=8000 items=0
ppid=1451 pid=1454 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=tty1 ses=4294967295 comm="hwclock"
exe="/sbin/hwclock" subj=system_u:system_r:hwclock_t key=(null)
[   15.085240] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[   15.110068] usb 3-2: USB disconnect, address 2
[   15.163081] type=1400 audit(1224041939.162:7): avc:  denied  { read
write } for  pid=1506 comm="modprobe" name="console" dev=sda1
ino=32780 scontext=system_u:system_r:insmod_t
tcontext=system_u:object_r:file_t tclass=chr_file

audit2allow -d reports:

allow hwclock_t tmpfs_t:dir search;
allow alsa_t tmpfs_t:dir search;
allow udev_t alsa_var_lib_t:dir { getattr search };
allow udev_t alsa_var_lib_t:file getattr;

With the previous refpolicy I do remember these showing up but never
had an issue of reappearing
after defining.
At first I thought it might be a boolean rejecting something, but
after setting true to all of them this still appears. could gvfs be
causing this?
Any ideas would be appreciated.
regards;


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
