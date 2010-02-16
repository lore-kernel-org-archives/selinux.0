Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1GEu2pX024400
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 09:56:02 -0500
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1GEtnIP022609
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 14:55:49 GMT
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o1GEvkMw028844
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 08:57:46 -0600
From: Alan Rouse <alan.rouse@ericsson.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Tue, 16 Feb 2010 09:55:59 -0500
Subject: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/alternative;
	boundary="_000_5A5E55DF96F73844AF7DFB0F48721F0F529A558532EUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_5A5E55DF96F73844AF7DFB0F48721F0F529A558532EUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I've been trying to get SELinux working in OpenSUSE 11.2.  So far I can get=
 to runlevel 3 with enforcing=3D0.  Before I start tinkering with audit2all=
ow, I thought I should get some advice.

The 11.2 repository gives me these policy rpms:

http://download.opensuse.org/repositories/openSUSE:/11.2/standard/noarch/se=
linux-policy-2.20081210-3.1.noarch.rpm
http://download.opensuse.org/repositories/openSUSE:/11.2/standard/src/selin=
ux-policy-2.20081210-3.1.src.rpm

But that version of policy has some issues in OpenSUSE:

1) failure to allow the graphical desktop to load (even with enforcing=3D0)=
 .   The following message appears in the console during boot:

** (gdm:1073): WARNING **: Couldn't connect to system bus: A SELinux policy=
 prevents this sender from sending this message to this recipient (rejected=
 message had sender "(unset)" interface "org.freedesktop.DBus" member "Hell=
o" erro name "(unset)" destination "org.freedesktop.DBus") startproc: exit =
status of parent of /usr/sbin/gdm: 1

Since enforcing is off, I'm surprised to see a message like that.  SELinux =
shouldn't be preventing anything, so I don't see how modifying policy will =
solve that.  Ideas?

2) Attempting to boot to runlevel 5 with kernel parms "security=3Dselinux s=
elinux=3D1 enforcing=3D0", I'm dropped off in runlevel 3 instead. I'm getti=
ng a couple of pages of AVC errors after boot (see below).

I've tried several other versions of the policy without luck:
- the version included in Fedora 12  (refpolicy-2.2009117
- the latest release from Tresys
- the latest from the repository at Tresys

They all give basically the same problems.  Any advice would be appreciated=
.

Thanks,
Alan

Following are the AVC messages I've been getting:

type=3DDAEMON_START msg=3Daudit(1265904613.457:3152): auditd start, ver=3D1=
.7.13 format=3Draw kernel=3D2.6.31.5-0.1-desktop auid=3D4294967295 pid=3D23=
37 subj=3Dsystem_u:system_r:sysadm_t res=3Dsuccess
type=3DAVC msg=3Daudit(1265904613.473:202): avc:  denied  { write } for  pi=
d=3D2342 comm=3D"auditctl" path=3D"/dev/blog" dev=3Dtmpfs ino=3D1836 sconte=
xt=3Dsystem_u:system_r:auditctl_t tcontext=3Dsystem_u:object_r:tmpfs_t tcla=
ss=3Dfifo_file
type=3DAVC msg=3Daudit(1265904613.689:203): avc:  denied  { execstack } for=
  pid=3D2382 comm=3D"cupsd" scontext=3Dsystem_u:system_r:sysadm_t tcontext=
=3Dsystem_u:system_r:sysadm_t tclass=3Dprocess
type=3DAVC msg=3Daudit(1265904613.690:204): avc:  denied  { execmem } for  =
pid=3D2382 comm=3D"cupsd" scontext=3Dsystem_u:system_r:sysadm_t tcontext=3D=
system_u:system_r:sysadm_t tclass=3Dprocess
type=3DAVC msg=3Daudit(1265904614.260:205): avc:  denied  { read write } fo=
r  pid=3D2448 comm=3D"smartd" name=3D"sda" dev=3Dtmpfs ino=3D1749 scontext=
=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:fixed_disk_devic=
e_t tclass=3Dblk_file
type=3DAVC msg=3Daudit(1265904614.260:206): avc:  denied  { open } for  pid=
=3D2448 comm=3D"smartd" name=3D"sda" dev=3Dtmpfs ino=3D1749 scontext=3Dsyst=
em_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:fixed_disk_device_t tcl=
ass=3Dblk_file
type=3DAVC msg=3Daudit(1265904614.261:207): avc:  denied  { ioctl } for  pi=
d=3D2448 comm=3D"smartd" path=3D"/dev/sda" dev=3Dtmpfs ino=3D1749 scontext=
=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:fixed_disk_devic=
e_t tclass=3Dblk_file
type=3DAVC msg=3Daudit(1265904615.964:208): avc:  denied  { read } for  pid=
=3D287 comm=3D"stapio" path=3D"/sys/kernel/debug/systemtap/preloadtrace/tra=
ce0" dev=3Ddebugfs ino=3D4136 scontext=3Dsystem_u:system_r:sysadm_t tcontex=
t=3Dsystem_u:object_r:debugfs_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904615.964:209): avc:  denied  { read } for  pid=
=3D2337 comm=3D"auditd" scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsy=
stem_u:system_r:sysadm_t tclass=3Dnetlink_audit_socket
type=3DAVC msg=3Daudit(1265904616.052:210): avc:  denied  { read } for  pid=
=3D2728 comm=3D"modprobe" path=3D"/dev/console" dev=3Dtmpfs ino=3D3969 scon=
text=3Dsystem_u:system_r:insmod_t tcontext=3Dsystem_u:object_r:console_devi=
ce_t tclass=3Dchr_file
type=3DAVC msg=3Daudit(1265904616.053:211): avc:  denied  { write } for  pi=
d=3D2728 comm=3D"modprobe" path=3D"/dev/blog" dev=3Dtmpfs ino=3D1836 sconte=
xt=3Dsystem_u:system_r:insmod_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=
=3Dfifo_file
type=3DAVC msg=3Daudit(1265904616.063:212): avc:  denied  { read } for  pid=
=3D308 comm=3D"udevd" scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsyst=
em_u:system_r:sysadm_t tclass=3Dnetlink_kobject_uevent_socket
type=3DAVC msg=3Daudit(1265904616.063:213): avc:  denied  { write } for  pi=
d=3D308 comm=3D"udevd" scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsys=
tem_u:system_r:sysadm_t tclass=3Dnetlink_kobject_uevent_socket
type=3DAVC msg=3Daudit(1265904616.069:214): avc:  denied  { write } for  pi=
d=3D2729 comm=3D"mount" path=3D"/dev/blog" dev=3Dtmpfs ino=3D1836 scontext=
=3Dsystem_u:system_r:mount_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3D=
fifo_file
type=3DAVC msg=3Daudit(1265904617.858:215): avc:  denied  { write } for  pi=
d=3D2779 comm=3D"ip6tables" path=3D"/tmp/SuSEfirewall2_iptables.2F1un9MP" d=
ev=3Dsda2 ino=3D132181 scontext=3Dsystem_u:system_r:iptables_t tcontext=3Ds=
ystem_u:object_r:user_tmp_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904617.859:216): avc:  denied  { write } for  pi=
d=3D2779 comm=3D"ip6tables" path=3D"/dev/blog" dev=3Dtmpfs ino=3D1836 scont=
ext=3Dsystem_u:system_r:iptables_t tcontext=3Dsystem_u:object_r:tmpfs_t tcl=
ass=3Dfifo_file
type=3DAVC msg=3Daudit(1265904617.889:217): avc:  denied  { write } for  pi=
d=3D2785 comm=3D"modprobe" path=3D"/tmp/SuSEfirewall2_iptables.2F1un9MP" de=
v=3Dsda2 ino=3D132181 scontext=3Dsystem_u:system_r:insmod_t tcontext=3Dsyst=
em_u:object_r:user_tmp_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904618.183:218): avc:  denied  { read } for  pid=
=3D2831 comm=3D"iptables-batch" name=3D"SuSEfirewall2_iptables.2F1un9MP" de=
v=3Dsda2 ino=3D132181 scontext=3Dsystem_u:system_r:iptables_t tcontext=3Dsy=
stem_u:object_r:user_tmp_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904618.183:219): avc:  denied  { open } for  pid=
=3D2831 comm=3D"iptables-batch" name=3D"SuSEfirewall2_iptables.2F1un9MP" de=
v=3Dsda2 ino=3D132181 scontext=3Dsystem_u:system_r:iptables_t tcontext=3Dsy=
stem_u:object_r:user_tmp_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904618.183:220): avc:  denied  { getattr } for  =
pid=3D2831 comm=3D"iptables-batch" path=3D"/tmp/SuSEfirewall2_iptables.2F1u=
n9MP" dev=3Dsda2 ino=3D132181 scontext=3Dsystem_u:system_r:iptables_t tcont=
ext=3Dsystem_u:object_r:user_tmp_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904618.473:221): avc:  denied  { setattr } for  =
pid=3D2853 comm=3D"mingetty" name=3D"tty1" dev=3Dtmpfs ino=3D3984 scontext=
=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:tty_device_t tcl=
ass=3Dchr_file
type=3DAVC msg=3Daudit(1265904618.480:222): avc:  denied  { getattr } for  =
pid=3D2853 comm=3D"mingetty" path=3D"/sys/kernel/debug/systemtap/preloadtra=
ce/.cmd" dev=3Ddebugfs ino=3D4137 scontext=3Dsystem_u:system_r:sysadm_t tco=
ntext=3Dsystem_u:object_r:debugfs_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904621.738:223): avc:  denied  { write } for  pi=
d=3D286 comm=3D"stapio" path=3D"/sys/kernel/debug/systemtap/preloadtrace/.c=
md" dev=3Ddebugfs ino=3D4137 scontext=3Dsystem_u:system_r:sysadm_t tcontext=
=3Dsystem_u:object_r:debugfs_t tclass=3Dfile
type=3DAVC msg=3Daudit(1265904621.783:224): avc:  denied  { search } for  p=
id=3D2868 comm=3D"staprun" name=3D"/" dev=3Ddebugfs ino=3D1 scontext=3Dsyst=
em_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:debugfs_t tclass=3Ddir
type=3DAVC msg=3Daudit(1265904621.783:225): avc:  denied  { open } for  pid=
=3D2868 comm=3D"staprun" name=3D".cmd" dev=3Ddebugfs ino=3D4137 scontext=3D=
system_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:debugfs_t tclass=3D=
file
type=3DAVC msg=3Daudit(1265904621.784:226): avc:  denied  { sys_module } fo=
r  pid=3D2868 comm=3D"staprun" capability=3D16 scontext=3Dsystem_u:system_r=
:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dcapability
type=3DAVC msg=3Daudit(1265904628.319:227): avc:  denied  { create } for  p=
id=3D2853 comm=3D"login" scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Ds=
ystem_u:system_r:sysadm_t tclass=3Dnetlink_audit_socket
type=3DAVC msg=3Daudit(1265904628.320:228): avc:  denied  { write } for  pi=
d=3D2853 comm=3D"login" scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsy=
stem_u:system_r:sysadm_t tclass=3Dnetlink_audit_socket
type=3DAVC msg=3Daudit(1265904628.320:229): avc:  denied  { nlmsg_relay } f=
or  pid=3D2853 comm=3D"login" scontext=3Dsystem_u:system_r:sysadm_t tcontex=
t=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_audit_socket
type=3DAVC msg=3Daudit(1265904628.321:230): avc:  denied  { audit_write } f=
or  pid=3D2853 comm=3D"login" capability=3D29 scontext=3Dsystem_u:system_r:=
sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dcapability
type=3DAVC msg=3Daudit(1265904628.370:231): avc:  denied  { audit_control }=
 for  pid=3D2853 comm=3D"login" capability=3D30 scontext=3Dsystem_u:system_=
r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dcapability



--_000_5A5E55DF96F73844AF7DFB0F48721F0F529A558532EUSAACMS0703e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>I've been trying to get SELinux working in OpenSUSE 11.2.&nbsp; So far=
 I can get to runlevel 3 with enforcing=3D0.&nbsp; Before I start tinkering=
 with audit2allow, I thought I should get some advice.</div>
<div>&nbsp;</div>
<div>The 11.2 repository gives me these policy rpms:</div>
<div>&nbsp;</div>
<div><a href=3D"http://download.opensuse.org/repositories/openSUSE:/11.2/st=
andard/noarch/selinux-policy-2.20081210-3.1.noarch.rpm"><font color=3D"#000=
0FF"><u>http://download.opensuse.org/repositories/openSUSE:/11.2/standard/n=
oarch/selinux-policy-2.20081210-3.1.noarch.rpm</u></font></a></div>
<div><a href=3D"http://download.opensuse.org/repositories/openSUSE:/11.2/st=
andard/src/selinux-policy-2.20081210-3.1.src.rpm"><font color=3D"#0000FF"><=
u>http://download.opensuse.org/repositories/openSUSE:/11.2/standard/src/sel=
inux-policy-2.20081210-3.1.src.rpm</u></font></a></div>
<div>&nbsp;</div>
<div>But that version of policy has some issues in OpenSUSE:</div>
<div>&nbsp;</div>
<div>1) failure to allow the graphical desktop to load (even with enforcing=
=3D0) .&nbsp;&nbsp; The following message appears in the console during boo=
t:</div>
<div>&nbsp;</div>
<div style=3D"padding-left: 19pt; ">** (gdm:1073): WARNING **: Couldn't con=
nect to system bus: A SELinux policy prevents this sender from sending this=
 message to this recipient (rejected message had sender &quot;(unset)&quot;=
 interface &quot;org.freedesktop.DBus&quot; member &quot;Hello&quot;
erro name &quot;(unset)&quot; destination &quot;org.freedesktop.DBus&quot;)=
 startproc: exit status of parent of /usr/sbin/gdm: 1</div>
<div>&nbsp;</div>
<div>Since enforcing is off, I'm surprised to see a message like that.&nbsp=
; SELinux shouldn't be preventing anything, so I don't see how modifying po=
licy will solve that.&nbsp; Ideas?</div>
<div>&nbsp;</div>
<div>2) Attempting to boot to runlevel 5 with kernel parms &quot;security=
=3Dselinux selinux=3D1 enforcing=3D0&quot;, I'm dropped off in runlevel 3 i=
nstead. I'm getting a couple of pages of AVC errors after boot (see below).=
</div>
<div>&nbsp;</div>
<div>I've tried several other versions of the policy without luck: </div>
<div>- the version included in Fedora 12&nbsp; (refpolicy-2.2009117</div>
<div>- the latest release from Tresys</div>
<div>- the latest from the repository at Tresys</div>
<div>&nbsp;</div>
<div>They all give basically the same problems.&nbsp; Any advice would be a=
ppreciated.</div>
<div><br>

Thanks,</div>
<div>Alan</div>
<div>&nbsp;</div>
<div>Following are the AVC messages I've been getting:</div>
<div>&nbsp;</div>
<div>type=3DDAEMON_START msg=3Daudit(1265904613.457:3152): auditd start, ve=
r=3D1.7.13 format=3Draw kernel=3D2.6.31.5-0.1-desktop auid=3D4294967295 pid=
=3D2337 subj=3Dsystem_u:system_r:sysadm_t res=3Dsuccess</div>
<div>type=3DAVC msg=3Daudit(1265904613.473:202): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D2342 comm=3D&quot;auditctl&quot; path=3D&quot;/dev/=
blog&quot; dev=3Dtmpfs ino=3D1836 scontext=3Dsystem_u:system_r:auditctl_t t=
context=3Dsystem_u:object_r:tmpfs_t tclass=3Dfifo_file</div>
<div>type=3DAVC msg=3Daudit(1265904613.689:203): avc:&nbsp; denied&nbsp; { =
execstack } for&nbsp; pid=3D2382 comm=3D&quot;cupsd&quot; scontext=3Dsystem=
_u:system_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dprocess=
</div>
<div>type=3DAVC msg=3Daudit(1265904613.690:204): avc:&nbsp; denied&nbsp; { =
execmem } for&nbsp; pid=3D2382 comm=3D&quot;cupsd&quot; scontext=3Dsystem_u=
:system_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dprocess</=
div>
<div>type=3DAVC msg=3Daudit(1265904614.260:205): avc:&nbsp; denied&nbsp; { =
read write } for&nbsp; pid=3D2448 comm=3D&quot;smartd&quot; name=3D&quot;sd=
a&quot; dev=3Dtmpfs ino=3D1749 scontext=3Dsystem_u:system_r:sysadm_t tconte=
xt=3Dsystem_u:object_r:fixed_disk_device_t tclass=3Dblk_file</div>
<div>type=3DAVC msg=3Daudit(1265904614.260:206): avc:&nbsp; denied&nbsp; { =
open } for&nbsp; pid=3D2448 comm=3D&quot;smartd&quot; name=3D&quot;sda&quot=
; dev=3Dtmpfs ino=3D1749 scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Ds=
ystem_u:object_r:fixed_disk_device_t tclass=3Dblk_file</div>
<div>type=3DAVC msg=3Daudit(1265904614.261:207): avc:&nbsp; denied&nbsp; { =
ioctl } for&nbsp; pid=3D2448 comm=3D&quot;smartd&quot; path=3D&quot;/dev/sd=
a&quot; dev=3Dtmpfs ino=3D1749 scontext=3Dsystem_u:system_r:sysadm_t tconte=
xt=3Dsystem_u:object_r:fixed_disk_device_t tclass=3Dblk_file</div>
<div>type=3DAVC msg=3Daudit(1265904615.964:208): avc:&nbsp; denied&nbsp; { =
read } for&nbsp; pid=3D287 comm=3D&quot;stapio&quot; path=3D&quot;/sys/kern=
el/debug/systemtap/preloadtrace/trace0&quot; dev=3Ddebugfs ino=3D4136 scont=
ext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:debugfs_t tcl=
ass=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904615.964:209): avc:&nbsp; denied&nbsp; { =
read } for&nbsp; pid=3D2337 comm=3D&quot;auditd&quot; scontext=3Dsystem_u:s=
ystem_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_aud=
it_socket</div>
<div>type=3DAVC msg=3Daudit(1265904616.052:210): avc:&nbsp; denied&nbsp; { =
read } for&nbsp; pid=3D2728 comm=3D&quot;modprobe&quot; path=3D&quot;/dev/c=
onsole&quot; dev=3Dtmpfs ino=3D3969 scontext=3Dsystem_u:system_r:insmod_t t=
context=3Dsystem_u:object_r:console_device_t tclass=3Dchr_file</div>
<div>type=3DAVC msg=3Daudit(1265904616.053:211): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D2728 comm=3D&quot;modprobe&quot; path=3D&quot;/dev/=
blog&quot; dev=3Dtmpfs ino=3D1836 scontext=3Dsystem_u:system_r:insmod_t tco=
ntext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfifo_file</div>
<div>type=3DAVC msg=3Daudit(1265904616.063:212): avc:&nbsp; denied&nbsp; { =
read } for&nbsp; pid=3D308 comm=3D&quot;udevd&quot; scontext=3Dsystem_u:sys=
tem_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_kobje=
ct_uevent_socket</div>
<div>type=3DAVC msg=3Daudit(1265904616.063:213): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D308 comm=3D&quot;udevd&quot; scontext=3Dsystem_u:sy=
stem_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_kobj=
ect_uevent_socket</div>
<div>type=3DAVC msg=3Daudit(1265904616.069:214): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D2729 comm=3D&quot;mount&quot; path=3D&quot;/dev/blo=
g&quot; dev=3Dtmpfs ino=3D1836 scontext=3Dsystem_u:system_r:mount_t tcontex=
t=3Dsystem_u:object_r:tmpfs_t tclass=3Dfifo_file</div>
<div>type=3DAVC msg=3Daudit(1265904617.858:215): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D2779 comm=3D&quot;ip6tables&quot; path=3D&quot;/tmp=
/SuSEfirewall2_iptables.2F1un9MP&quot; dev=3Dsda2 ino=3D132181 scontext=3Ds=
ystem_u:system_r:iptables_t tcontext=3Dsystem_u:object_r:user_tmp_t tclass=
=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904617.859:216): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D2779 comm=3D&quot;ip6tables&quot; path=3D&quot;/dev=
/blog&quot; dev=3Dtmpfs ino=3D1836 scontext=3Dsystem_u:system_r:iptables_t =
tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfifo_file</div>
<div>type=3DAVC msg=3Daudit(1265904617.889:217): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D2785 comm=3D&quot;modprobe&quot; path=3D&quot;/tmp/=
SuSEfirewall2_iptables.2F1un9MP&quot; dev=3Dsda2 ino=3D132181 scontext=3Dsy=
stem_u:system_r:insmod_t tcontext=3Dsystem_u:object_r:user_tmp_t tclass=3Df=
ile</div>
<div>type=3DAVC msg=3Daudit(1265904618.183:218): avc:&nbsp; denied&nbsp; { =
read } for&nbsp; pid=3D2831 comm=3D&quot;iptables-batch&quot; name=3D&quot;=
SuSEfirewall2_iptables.2F1un9MP&quot; dev=3Dsda2 ino=3D132181 scontext=3Dsy=
stem_u:system_r:iptables_t tcontext=3Dsystem_u:object_r:user_tmp_t tclass=
=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904618.183:219): avc:&nbsp; denied&nbsp; { =
open } for&nbsp; pid=3D2831 comm=3D&quot;iptables-batch&quot; name=3D&quot;=
SuSEfirewall2_iptables.2F1un9MP&quot; dev=3Dsda2 ino=3D132181 scontext=3Dsy=
stem_u:system_r:iptables_t tcontext=3Dsystem_u:object_r:user_tmp_t tclass=
=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904618.183:220): avc:&nbsp; denied&nbsp; { =
getattr } for&nbsp; pid=3D2831 comm=3D&quot;iptables-batch&quot; path=3D&qu=
ot;/tmp/SuSEfirewall2_iptables.2F1un9MP&quot; dev=3Dsda2 ino=3D132181 scont=
ext=3Dsystem_u:system_r:iptables_t tcontext=3Dsystem_u:object_r:user_tmp_t =
tclass=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904618.473:221): avc:&nbsp; denied&nbsp; { =
setattr } for&nbsp; pid=3D2853 comm=3D&quot;mingetty&quot; name=3D&quot;tty=
1&quot; dev=3Dtmpfs ino=3D3984 scontext=3Dsystem_u:system_r:sysadm_t tconte=
xt=3Dsystem_u:object_r:tty_device_t tclass=3Dchr_file</div>
<div>type=3DAVC msg=3Daudit(1265904618.480:222): avc:&nbsp; denied&nbsp; { =
getattr } for&nbsp; pid=3D2853 comm=3D&quot;mingetty&quot; path=3D&quot;/sy=
s/kernel/debug/systemtap/preloadtrace/.cmd&quot; dev=3Ddebugfs ino=3D4137 s=
context=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:debugfs_t=
 tclass=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904621.738:223): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D286 comm=3D&quot;stapio&quot; path=3D&quot;/sys/ker=
nel/debug/systemtap/preloadtrace/.cmd&quot; dev=3Ddebugfs ino=3D4137 sconte=
xt=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:debugfs_t tcla=
ss=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904621.783:224): avc:&nbsp; denied&nbsp; { =
search } for&nbsp; pid=3D2868 comm=3D&quot;staprun&quot; name=3D&quot;/&quo=
t; dev=3Ddebugfs ino=3D1 scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Ds=
ystem_u:object_r:debugfs_t tclass=3Ddir</div>
<div>type=3DAVC msg=3Daudit(1265904621.783:225): avc:&nbsp; denied&nbsp; { =
open } for&nbsp; pid=3D2868 comm=3D&quot;staprun&quot; name=3D&quot;.cmd&qu=
ot; dev=3Ddebugfs ino=3D4137 scontext=3Dsystem_u:system_r:sysadm_t tcontext=
=3Dsystem_u:object_r:debugfs_t tclass=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1265904621.784:226): avc:&nbsp; denied&nbsp; { =
sys_module } for&nbsp; pid=3D2868 comm=3D&quot;staprun&quot; capability=3D1=
6 scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm=
_t tclass=3Dcapability</div>
<div>type=3DAVC msg=3Daudit(1265904628.319:227): avc:&nbsp; denied&nbsp; { =
create } for&nbsp; pid=3D2853 comm=3D&quot;login&quot; scontext=3Dsystem_u:=
system_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_au=
dit_socket</div>
<div>type=3DAVC msg=3Daudit(1265904628.320:228): avc:&nbsp; denied&nbsp; { =
write } for&nbsp; pid=3D2853 comm=3D&quot;login&quot; scontext=3Dsystem_u:s=
ystem_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_aud=
it_socket</div>
<div>type=3DAVC msg=3Daudit(1265904628.320:229): avc:&nbsp; denied&nbsp; { =
nlmsg_relay } for&nbsp; pid=3D2853 comm=3D&quot;login&quot; scontext=3Dsyst=
em_u:system_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dnetli=
nk_audit_socket</div>
<div>type=3DAVC msg=3Daudit(1265904628.321:230): avc:&nbsp; denied&nbsp; { =
audit_write } for&nbsp; pid=3D2853 comm=3D&quot;login&quot; capability=3D29=
 scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:system_r:sysadm_=
t tclass=3Dcapability</div>
<div>type=3DAVC msg=3Daudit(1265904628.370:231): avc:&nbsp; denied&nbsp; { =
audit_control } for&nbsp; pid=3D2853 comm=3D&quot;login&quot; capability=3D=
30 scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:system_r:sysad=
m_t tclass=3Dcapability</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_5A5E55DF96F73844AF7DFB0F48721F0F529A558532EUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
