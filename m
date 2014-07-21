Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6LN3eZk020651
 for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2014 19:03:40 -0400
Message-ID: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_3f7709a0-9a72-4d78-8ccc-9702a92888fb_"
From: Avijit Das <avijitnsec@live.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: File-system is not mounting when I am enabling selinux
Date: Mon, 21 Jul 2014 16:03:42 -0700
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_3f7709a0-9a72-4d78-8ccc-9702a92888fb_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi=2C
I am trying to enable SELinux in Android platform. I am getting the followi=
ng error message:
[   16.331402] init: invalid uid 'fm_radio'[   17.759590] EXT4-fs (mmcblk0p=
24): mounted filesystem with ordered data mode. Opts: barrier=3D1[   17.767=
028] SELinux: (dev mmcblk0p24=2C type ext4) has no security xattr handler[ =
  17.775651] fs_mgr: __mount(source=3D/dev/block/bootdevice/by-name/system=
=2Ctarget=3D/system=2Ctype=3Dext4)=3D-1[   17.783817] fs_mgr: Failed to mou=
nt an un-encryptable or wiped partition on/dev/block/bootdevice/by-name/sys=
tem at /system options: barrier=3D1 error: Operation not supported on trans=
port endpoint[   17.802215] EXT4-fs (mmcblk0p29): Ignoring removed nomblk_i=
o_submit option[   17.821190] EXT4-fs (mmcblk0p29): mounted filesystem with=
 ordered data mode. Opts: nomblk_io_submit=2Cerrors=3Dremount-ro[   17.8308=
19] SELinux: (dev mmcblk0p29=2C type ext4) has no security xattr handler[  =
 17.840383] fs_mgr: check_fs(): mount(/dev/block/bootdevice/by-name/userdat=
a=2C/data=2Cext4)=3D-1[   17.847781] fs_mgr: Not running /system/bin/e2fsck=
 on /dev/block/bootdevice/by-name/userdata (executable not in system image)=
[   17.865028] EXT4-fs (mmcblk0p29): mounted filesystem with ordered data m=
ode. Opts: barrier=3D1=2Cnoauto_da_alloc[   17.873877] SELinux: (dev mmcblk=
0p29=2C type ext4) has no security xattr handler[   17.883072] fs_mgr: __mo=
unt(source=3D/dev/block/bootdevice/by-name/userdata=2Ctarget=3D/data=2Ctype=
=3Dext4)=3D-1[   17.892845] fs_mgr: fs_mgr_mount_all(): possibly an encrypt=
able blkdev /dev/block/bootdevice/by-name/userdata for mount /data type ext=
4 )[   17.904640] init: fs_mgr_mount_all returned an error[   17.909559] in=
it (273) used greatest stack depth: 12824 bytes left[   17.915496] init: fs=
_mgr_mount_all returned unexpected error 255[   17.926673] EXT4-fs (mmcblk0=
p25): mounted filesystem with ordered data mode. Opts: barrier=3D1[   17.93=
4144] SELinux: (dev mmcblk0p25=2C type ext4) has no security xattr handler[=
   17.948220] EXT4-fs (mmcblk0p26): mounted filesystem with ordered data mo=
de. Opts: barrier=3D1[   17.955632] SELinux: (dev mmcblk0p26=2C type ext4) =
has no security xattr handler[   17.964734] SELinux: Could not set context =
for /persist:  Operation not supported on transport endpoint[   17.983614] =
SELinux: Could not set context for /cache:  Read-only file system

The device is booting fine to home screen=2C But executable files inside sy=
stem/bin is not accessible. It seems system image is not getting mounted pr=
operly. And because of that we are not able to do adb shell. Is this a know=
n issue?
I found this fix: http://permalink.gmane.org/gmane.comp.security.selinux/18=
999

Is this relevant?
Thanks=2CAvijit







 		 	   		  =

--_3f7709a0-9a72-4d78-8ccc-9702a92888fb_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'><div><div>Hi=2C</div><div><br></=
div><div>I am trying to enable&nbsp=3BSELinux&nbsp=3Bin Android platform. I=
 am getting the following error message:</div><div><br></div><div>[ &nbsp=
=3B 16.331402] init: invalid uid 'fm_radio'</div><div>[ &nbsp=3B 17.759590]=
 EXT4-fs (mmcblk0p24): mounted filesystem with ordered data mode. Opts: bar=
rier=3D1</div><div>[ &nbsp=3B 17.767028] SELinux: (dev mmcblk0p24=2C type e=
xt4) has no security xattr handler</div><div>[ &nbsp=3B 17.775651] fs_mgr: =
__mount(source=3D/dev/block/bootdevice/by-name/system=2Ctarget=3D/system=2C=
type=3Dext4)=3D-1</div><div>[ &nbsp=3B 17.783817] fs_mgr: Failed to mount a=
n un-encryptable or wiped partition on/dev/block/bootdevice/by-name/system =
at /system options: barrier=3D1 error: Operation not supported on transport=
 endpoint</div><div>[ &nbsp=3B 17.802215] EXT4-fs (mmcblk0p29): Ignoring re=
moved nomblk_io_submit option</div><div>[ &nbsp=3B 17.821190] EXT4-fs (mmcb=
lk0p29): mounted filesystem with ordered data mode. Opts: nomblk_io_submit=
=2Cerrors=3Dremount-ro</div><div>[ &nbsp=3B 17.830819] SELinux: (dev mmcblk=
0p29=2C type ext4) has no security xattr handler</div><div>[ &nbsp=3B 17.84=
0383] fs_mgr: check_fs(): mount(/dev/block/bootdevice/by-name/userdata=2C/d=
ata=2Cext4)=3D-1</div><div>[ &nbsp=3B 17.847781] fs_mgr: Not running /syste=
m/bin/e2fsck on /dev/block/bootdevice/by-name/userdata (executable not in s=
ystem image)</div><div>[ &nbsp=3B 17.865028] EXT4-fs (mmcblk0p29): mounted =
filesystem with ordered data mode. Opts: barrier=3D1=2Cnoauto_da_alloc</div=
><div>[ &nbsp=3B 17.873877] SELinux: (dev mmcblk0p29=2C type ext4) has no s=
ecurity xattr handler</div><div>[ &nbsp=3B 17.883072] fs_mgr: __mount(sourc=
e=3D/dev/block/bootdevice/by-name/userdata=2Ctarget=3D/data=2Ctype=3Dext4)=
=3D-1</div><div>[ &nbsp=3B 17.892845] fs_mgr: fs_mgr_mount_all(): possibly =
an encryptable blkdev /dev/block/bootdevice/by-name/userdata for mount /dat=
a type ext4 )</div><div>[ &nbsp=3B 17.904640] init: fs_mgr_mount_all return=
ed an error</div><div>[ &nbsp=3B 17.909559] init (273) used greatest stack =
depth: 12824 bytes left</div><div>[ &nbsp=3B 17.915496] init: fs_mgr_mount_=
all returned unexpected error 255</div><div>[ &nbsp=3B 17.926673] EXT4-fs (=
mmcblk0p25): mounted filesystem with ordered data mode. Opts: barrier=3D1</=
div><div>[ &nbsp=3B 17.934144] SELinux: (dev mmcblk0p25=2C type ext4) has n=
o security xattr handler</div><div>[ &nbsp=3B 17.948220] EXT4-fs (mmcblk0p2=
6): mounted filesystem with ordered data mode. Opts: barrier=3D1</div><div>=
[ &nbsp=3B 17.955632] SELinux: (dev mmcblk0p26=2C type ext4) has no securit=
y xattr handler</div><div>[ &nbsp=3B 17.964734] SELinux: Could not set cont=
ext for /persist: &nbsp=3BOperation not supported on transport endpoint</di=
v><div>[ &nbsp=3B 17.983614] SELinux: Could not set context for /cache: &nb=
sp=3BRead-only file system</div></div><div><br></div><div><br></div><div>Th=
e device is booting fine to home screen=2C But executable files inside syst=
em/bin is not accessible. It seems system image is not getting mounted prop=
erly. And because of that we are not able to do adb shell. Is this a known =
issue?</div><div><br></div><div>I found this fix:&nbsp=3B<a href=3D"http://=
permalink.gmane.org/gmane.comp.security.selinux/18999" target=3D"_blank" st=
yle=3D"font-size: 12pt=3B">http://permalink.gmane.org/gmane.comp.security.s=
elinux/18999<br></a></div><div><br></div><div>Is this relevant?</div><div><=
br></div><div>Thanks=2C</div><div>Avijit</div><div><br></div><div><br></div=
><div><br></div><div><br></div><div><br></div><div><br></div><div><br></div=
><div><br></div> 		 	   		  </div></body>
</html>=

--_3f7709a0-9a72-4d78-8ccc-9702a92888fb_--
