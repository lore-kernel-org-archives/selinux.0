Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6AGHOaT004613
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 12:17:24 -0400
Received: from mail132-va3 (localhost [127.0.0.1])	by
 mail132-va3-R.bigfish.com (Postfix) with ESMTP id 1A30EC011E	for
 <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 16:15:03 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.239])	by
 mail132-va3.bigfish.com (Postfix) with ESMTP id E25502C0208	for
 <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 16:14:59 +0000 (UTC)
Received: from il06msg02.am.mot-solutions.com (il06vts03.mot.com
 [129.188.137.143])	by il06msg02.am.mot-solutions.com (8.14.3/8.14.3) with
 ESMTP id q6AGHFYG026236	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012
 12:17:15 -0400 (EDT)
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])	by
 il06msg02.am.mot-solutions.com (8.14.3/8.14.3) with ESMTP id q6AGHFRf026233
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)	for
 <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 12:17:15 -0400 (EDT)
Received: from mail166-co1 (localhost [127.0.0.1])	by
 mail166-co1-R.bigfish.com (Postfix) with ESMTP id 74F8C1C01F1	for
 <selinux@tycho.nsa.gov.FOPE.CONNECTOR.OVERRIDE>; Tue, 10 Jul 2012 16:14:55
 +0000 (UTC)
Received: from CO1EHSMHS021.bigfish.com (unknown [10.243.78.244])	by
 mail166-co1.bigfish.com (Postfix) with ESMTP id C61098C0049	for
 <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 16:14:52 +0000 (UTC)
From: Palarz Thomas-DCJ738 <tom.palarz@motorolasolutions.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Anon_inodefs denials in SEAndroid with genlock
Date: Tue, 10 Jul 2012 16:17:08 +0000
Message-ID: <535CAAB8CFB77F45B4140FC615F0F21E1D2AD9EC@CH1PRD0410MB381.namprd04.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_535CAAB8CFB77F45B4140FC615F0F21E1D2AD9ECCH1PRD0410MB381_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_535CAAB8CFB77F45B4140FC615F0F21E1D2AD9ECCH1PRD0410MB381_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I've been working with trying SEAndroid on a Qualcomm dev board that uses t=
he genlock driver as part of it's integration with SurfaceFlinger and have =
seen some denials that I'm having a hard time tracking down what is going o=
n.

The anon_inode is showing as unlabeled. Do I need to add some sort of trans=
ition rule?

Initially, the anon_inodefs was showing as not supporting XATTRs in the SEL=
inux init output, but I've gotten past that and added a genfscon (I used in=
otify as an example).

Here's the dmesg of init:
<6>[    0.150434] SELinux:  Initializing.
<7>[    0.150495] SELinux:  Starting in permissive mode
<7>[    0.478010] SELinux:  Registering netfilter hooks
<7>[   34.297817] SELinux: 512 avtab hash slots, 1093 rules.
<7>[   34.298275] SELinux: 512 avtab hash slots, 1093 rules.
<7>[   34.298336] SELinux:  1 users, 2 roles, 208 types, 7 bools, 1 sens, 1=
024 cats
<7>[   34.298336] SELinux:  84 classes, 1093 rules
<7>[   34.299069] SELinux:  Completing initialization.
<7>[   34.299069] SELinux:  Setting up existing superblocks.
<7>[   34.299099] SELinux: initialized (dev sysfs, type sysfs), uses genfs_=
contexts
<7>[   34.299130] SELinux: initialized (dev rootfs, type rootfs), uses genf=
s_contexts
<7>[   34.299160] SELinux: initialized (dev bdev, type bdev), not configure=
d for labeling
<7>[   34.299160] SELinux: initialized (dev proc, type proc), uses genfs_co=
ntexts
<7>[   34.299191] SELinux: initialized (dev tmpfs, type tmpfs), uses transi=
tion SIDs
<7>[   34.299221] SELinux: initialized (dev debugfs, type debugfs), uses ge=
nfs_contexts
<7>[   34.303799] SELinux: initialized (dev sockfs, type sockfs), uses task=
 SIDs
<7>[   34.303830] SELinux: initialized (dev pipefs, type pipefs), uses task=
 SIDs
<7>[   34.303830] SELinux: initialized (dev anon_inodefs, type anon_inodefs=
), uses genfs_contexts
<7>[   34.303860] SELinux: initialized (dev devpts, type devpts), uses tran=
sition SIDs
<7>[   34.303891] SELinux: initialized (dev selinuxfs, type selinuxfs), use=
s genfs_contexts
<7>[   34.303952] SELinux: initialized (dev tmpfs, type tmpfs), uses transi=
tion SIDs
<7>[   34.303982] SELinux: initialized (dev sysfs, type sysfs), uses genfs_=
contexts
<7>[   35.223927] SELinux: initialized (dev cgroup, type cgroup), uses genf=
s_contexts
<7>[   35.224416] SELinux: initialized (dev tmpfs, type tmpfs), uses transi=
tion SIDs
<7>[   35.224538] SELinux: initialized (dev tmpfs, type tmpfs), uses transi=
tion SIDs
<7>[   35.253990] SELinux: initialized (dev cgroup, type cgroup), uses genf=
s_contexts
<7>[   35.320128] SELinux: initialized (dev mmcblk0p12, type ext4), uses xa=
ttr
<7>[   35.820998] SELinux: initialized (dev mmcblk0p13, type ext4), uses xa=
ttr
<7>[   35.834365] SELinux: initialized (dev mmcblk0p14, type ext4), uses xa=
ttr
<7>[   35.850053] SELinux: initialized (dev mmcblk0p15, type ext4), uses xa=
ttr
<7>[   35.865771] SELinux: initialized (dev mmcblk0p16, type ext4), uses xa=
ttr
<7>[   35.884571] SELinux: initialized (dev mmcblk0p1, type vfat), uses gen=
fs_contexts
<7>[   43.505386] SELinux: initialized (dev mmcblk1p1, type vfat), uses gen=
fs_contexts
<7>[   43.513016] SELinux: initialized (dev tmpfs, type tmpfs), uses transi=
tion SIDs


Here's the dmesg of the denials:
<5>[   42.744025] type=3D1400 audit(3442688.979:4): avc:  denied  { write }=
 for  pid=3D185 comm=3D"surfaceflinger" path=3D"anon_inode:genlock" dev=3Da=
non_inodefs ino=3D1868 scontext=3Du:r:trusted_app:s0:c19 tcontext=3Du:objec=
t_r:unlabeled:s0 tclass=3Dfile
<5>[   42.775949] type=3D1400 audit(3442689.019:5): avc:  denied  { write }=
 for  pid=3D470 comm=3D"ndroid.launcher" name=3D"genlock" dev=3Dtmpfs ino=
=3D5048 scontext=3Du:r:trusted_app:s0:c19 tcontext=3Du:object_r:genlock_dev=
ice:s0 tclass=3Dchr_file
<5>[   89.797741] type=3D1400 audit(3442736.039:6): avc:  denied  { write }=
 for  pid=3D291 comm=3D42696E646572205468726561642023 path=3D"anon_inode:ge=
nlock" dev=3Danon_inodefs ino=3D1868 scontext=3Du:r:trusted_app:s0:c4 tcont=
ext=3Du:object_r:unlabeled:s0 tclass=3Dfile
<5>[   89.805157] type=3D1400 audit(3442736.049:7): avc:  denied  { write }=
 for  pid=3D809 comm=3D"oid.calculator2" name=3D"genlock" dev=3Dtmpfs ino=
=3D5048 scontext=3Du:r:trusted_app:s0:c4 tcontext=3Du:object_r:genlock_devi=
ce:s0 tclass=3Dchr_file
<5>[  100.623409] type=3D1400 audit(3442746.861:8): avc:  denied  { write }=
 for  pid=3D185 comm=3D"surfaceflinger" path=3D"anon_inode:genlock" dev=3Da=
non_inodefs ino=3D1868 scontext=3Du:r:trusted_app:s0:c19 tcontext=3Du:objec=
t_r:unlabeled:s0 tclass=3Dfile
<5>[  100.646207] type=3D1400 audit(3442746.891:9): avc:  denied  { write }=
 for  pid=3D470 comm=3D"ndroid.launcher" name=3D"genlock" dev=3Dtmpfs ino=
=3D5048 scontext=3Du:r:trusted_app:s0:c19 tcontext=3Du:object_r:genlock_dev=
ice:s0 tclass=3Dchr_file

/proc/291/comm =3D Binder Thread #
/proc/291/cmdline =3D /system/bin/surfaceflinger

The rest of the processes should be self explanatory.

I add the following policy statements to at least allow me to move forward =
for the time being, but still get the denials.

allow trusted_app genlock_device:chr_file write;
allow trusted_app unlabeled:file write;

I've verified that the above lines do make it into the policy.conf in the s=
epolicy_intermediates build output.

I made the SEAndroid changes to the Qualcomm based on seandroid-4.0.3 and h=
ave double-checked the work. The kernel defconfig was rather different and =
I did have to add EXT4_FS_SECURITY=3Dy.

Any help?

-Tom

--_000_535CAAB8CFB77F45B4140FC615F0F21E1D2AD9ECCH1PRD0410MB381_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">I've been working with trying SEAndroid on a Qualcomm dev board that=
 uses the genlock driver as part of it's integration with SurfaceFlinger an=
d have seen some denials that I'm
 having a hard time tracking down what is going on.<br>
<br>
The anon_inode is showing as unlabeled. Do I need to add some sort of trans=
ition rule?<br>
<br>
Initially, the anon_inodefs was showing as not supporting XATTRs in the SEL=
inux init output, but I've gotten past that and added a genfscon (I used in=
otify as an example).<br>
<br>
Here's the dmesg of init:<br>
&lt;6&gt;[&nbsp;&nbsp;&nbsp; 0.150434] SELinux:&nbsp; Initializing.<br>
&lt;7&gt;[&nbsp;&nbsp;&nbsp; 0.150495] SELinux:&nbsp; Starting in permissiv=
e mode<br>
&lt;7&gt;[&nbsp;&nbsp;&nbsp; 0.478010] SELinux:&nbsp; Registering netfilter=
 hooks<br>
&lt;7&gt;[&nbsp;&nbsp; 34.297817] SELinux: 512 avtab hash slots, 1093 rules=
.<br>
&lt;7&gt;[&nbsp;&nbsp; 34.298275] SELinux: 512 avtab hash slots, 1093 rules=
.<br>
&lt;7&gt;[&nbsp;&nbsp; 34.298336] SELinux:&nbsp; 1 users, 2 roles, 208 type=
s, 7 bools, 1 sens, 1024 cats<br>
&lt;7&gt;[&nbsp;&nbsp; 34.298336] SELinux:&nbsp; 84 classes, 1093 rules<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299069] SELinux:&nbsp; Completing initialization.=
<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299069] SELinux:&nbsp; Setting up existing superb=
locks.<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299099] SELinux: initialized (dev sysfs, type sys=
fs), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299130] SELinux: initialized (dev rootfs, type ro=
otfs), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299160] SELinux: initialized (dev bdev, type bdev=
), not configured for labeling<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299160] SELinux: initialized (dev proc, type proc=
), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299191] SELinux: initialized (dev tmpfs, type tmp=
fs), uses transition SIDs<br>
&lt;7&gt;[&nbsp;&nbsp; 34.299221] SELinux: initialized (dev debugfs, type d=
ebugfs), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 34.303799] SELinux: initialized (dev sockfs, type so=
ckfs), uses task SIDs<br>
&lt;7&gt;[&nbsp;&nbsp; 34.303830] SELinux: initialized (dev pipefs, type pi=
pefs), uses task SIDs<br>
&lt;7&gt;[&nbsp;&nbsp; 34.303830] SELinux: initialized (dev anon_inodefs, t=
ype anon_inodefs), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 34.303860] SELinux: initialized (dev devpts, type de=
vpts), uses transition SIDs<br>
&lt;7&gt;[&nbsp;&nbsp; 34.303891] SELinux: initialized (dev selinuxfs, type=
 selinuxfs), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 34.303952] SELinux: initialized (dev tmpfs, type tmp=
fs), uses transition SIDs<br>
&lt;7&gt;[&nbsp;&nbsp; 34.303982] SELinux: initialized (dev sysfs, type sys=
fs), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 35.223927] SELinux: initialized (dev cgroup, type cg=
roup), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 35.224416] SELinux: initialized (dev tmpfs, type tmp=
fs), uses transition SIDs<br>
&lt;7&gt;[&nbsp;&nbsp; 35.224538] SELinux: initialized (dev tmpfs, type tmp=
fs), uses transition SIDs<br>
&lt;7&gt;[&nbsp;&nbsp; 35.253990] SELinux: initialized (dev cgroup, type cg=
roup), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 35.320128] SELinux: initialized (dev mmcblk0p12, typ=
e ext4), uses xattr<br>
&lt;7&gt;[&nbsp;&nbsp; 35.820998] SELinux: initialized (dev mmcblk0p13, typ=
e ext4), uses xattr<br>
&lt;7&gt;[&nbsp;&nbsp; 35.834365] SELinux: initialized (dev mmcblk0p14, typ=
e ext4), uses xattr<br>
&lt;7&gt;[&nbsp;&nbsp; 35.850053] SELinux: initialized (dev mmcblk0p15, typ=
e ext4), uses xattr<br>
&lt;7&gt;[&nbsp;&nbsp; 35.865771] SELinux: initialized (dev mmcblk0p16, typ=
e ext4), uses xattr<br>
&lt;7&gt;[&nbsp;&nbsp; 35.884571] SELinux: initialized (dev mmcblk0p1, type=
 vfat), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 43.505386] SELinux: initialized (dev mmcblk1p1, type=
 vfat), uses genfs_contexts<br>
&lt;7&gt;[&nbsp;&nbsp; 43.513016] SELinux: initialized (dev tmpfs, type tmp=
fs), uses transition SIDs<br>
<br>
<br>
Here's the dmesg of the denials:<br>
&lt;5&gt;[&nbsp;&nbsp; 42.744025] type=3D1400 audit(3442688.979:4): avc:&nb=
sp; denied&nbsp; { write } for&nbsp; pid=3D185 comm=3D&quot;surfaceflinger&=
quot; path=3D&quot;anon_inode:genlock&quot; dev=3Danon_inodefs ino=3D1868 s=
context=3Du:r:trusted_app:s0:c19 tcontext=3Du:object_r:unlabeled:s0 tclass=
=3Dfile<br>
&lt;5&gt;[&nbsp;&nbsp; 42.775949] type=3D1400 audit(3442689.019:5): avc:&nb=
sp; denied&nbsp; { write } for&nbsp; pid=3D470 comm=3D&quot;ndroid.launcher=
&quot; name=3D&quot;genlock&quot; dev=3Dtmpfs ino=3D5048 scontext=3Du:r:tru=
sted_app:s0:c19 tcontext=3Du:object_r:genlock_device:s0 tclass=3Dchr_file<b=
r>
&lt;5&gt;[&nbsp;&nbsp; 89.797741] type=3D1400 audit(3442736.039:6): avc:&nb=
sp; denied&nbsp; { write } for&nbsp; pid=3D291 comm=3D42696E646572205468726=
561642023 path=3D&quot;anon_inode:genlock&quot; dev=3Danon_inodefs ino=3D18=
68 scontext=3Du:r:trusted_app:s0:c4 tcontext=3Du:object_r:unlabeled:s0 tcla=
ss=3Dfile<br>
&lt;5&gt;[&nbsp;&nbsp; 89.805157] type=3D1400 audit(3442736.049:7): avc:&nb=
sp; denied&nbsp; { write } for&nbsp; pid=3D809 comm=3D&quot;oid.calculator2=
&quot; name=3D&quot;genlock&quot; dev=3Dtmpfs ino=3D5048 scontext=3Du:r:tru=
sted_app:s0:c4 tcontext=3Du:object_r:genlock_device:s0 tclass=3Dchr_file<br=
>
&lt;5&gt;[&nbsp; 100.623409] type=3D1400 audit(3442746.861:8): avc:&nbsp; d=
enied&nbsp; { write } for&nbsp; pid=3D185 comm=3D&quot;surfaceflinger&quot;=
 path=3D&quot;anon_inode:genlock&quot; dev=3Danon_inodefs ino=3D1868 sconte=
xt=3Du:r:trusted_app:s0:c19 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfil=
e<br>
&lt;5&gt;[&nbsp; 100.646207] type=3D1400 audit(3442746.891:9): avc:&nbsp; d=
enied&nbsp; { write } for&nbsp; pid=3D470 comm=3D&quot;ndroid.launcher&quot=
; name=3D&quot;genlock&quot; dev=3Dtmpfs ino=3D5048 scontext=3Du:r:trusted_=
app:s0:c19 tcontext=3Du:object_r:genlock_device:s0 tclass=3Dchr_file<br>
<br>
/proc/291/comm =3D Binder Thread #<br>
/proc/291/cmdline =3D /system/bin/surfaceflinger<br>
<br>
The rest of the processes should be self explanatory.<br>
<br>
I add the following policy statements to at least allow me to move forward =
for the time being, but still get the denials.<br>
<br>
allow trusted_app genlock_device:chr_file write;<br>
allow trusted_app unlabeled:file write;<br>
<br>
I've verified that the above lines do make it into the policy.conf in the s=
epolicy_intermediates build output.<br>
<br>
I made the SEAndroid changes to the Qualcomm based on seandroid-4.0.3 and h=
ave double-checked the work. The kernel defconfig was rather different and =
I did have to add EXT4_FS_SECURITY=3Dy.<br>
<br>
Any help?<br>
<br>
-Tom<br>
</div>
</body>
</html>

--_000_535CAAB8CFB77F45B4140FC615F0F21E1D2AD9ECCH1PRD0410MB381_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
