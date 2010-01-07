Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o07Ke558005296
	for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2010 15:40:05 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o07KckCI019489
	for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2010 20:38:46 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o07KdaGt000732
	for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2010 15:39:36 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o07KdaWP000730
	for selinux@tycho.nsa.gov; Thu, 7 Jan 2010 15:39:36 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA8FD9.3CD55EFC"
Subject: Help with an SELinux AVC event...
Date: Thu, 7 Jan 2010 15:37:32 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D02DF4964@de01exm68.ds.mot.com>
References: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com> <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA8FD9.3CD55EFC
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

I have a C application task called "sswd" on my Linux system, that opens =
up the /var/log/audit/audit.log file every 5 seconds, and checks to see =
if there are any new AVC denies.

I have had this same task doing the same thing for the last few years on =
a Linux system running selinux. And I have never seen these events in =
audit.log before complaining about the sswd task... I used to use older =
selinux packages, and ran the Fedora Core 7 'strict' policy together =
with some custom policies.

Recently we upgraded our SELinux packages to the very latest (similar to =
Fedora 12), and we are using Refpolicy as a base policy.

In the /var/log/audit/audit.log file, I see the following event pop up =
every 5 seconds, and I am guessing its because "sswd" tries to open up =
the audit.log file every 5 seconds for reading.=20

1. Can you help me understand what this event is really saying?
2. I have already taken the audit.log file, and used audit2allow to =
generate any allow rules necessary, but it didnt help to get rid of this =
particular event.
3. Can I add any specific policy allow lines or transition rules in my =
custom policy files to get rid of this repeated event ?

Thanks in advance.

The event that pops up every 5 seconds in audit.log is:

type=3DSYSCALL msg=3Daudit(1262874266.422:260): arch=3D14 syscall=3D5 =
success=3Dyes exit=3D24 a0=3D1002b9e4 a1=3D0 a2=3D1b6 a3=3D1b6 items=3D1 =
ppid=3D2463 pid=3D2794 auid=3D4294967295 uid=3D0 gid=3D601 euid=3D0 =
suid=3D0 fsuid=3D0 egid=3D601 sgid=3D601 fsgid=3D601 tty=3D(none) =
ses=3D4294967295 comm=3D"sswd" exe=3D"/usr/app/bin/sswd" =
subj=3Dsystem_u:system_r:init_t:s0-s15:c0.c255 key=3D"LOG_audit"
type=3DCWD msg=3Daudit(1262874266.422:260):  cwd=3D"/data"
type=3DPATH msg=3Daudit(1262874266.422:260): item=3D0 =
name=3D"/var/log/audit/audit.log" inode=3D2061 dev=3Dfd:07 =
mode=3D0100600 ouid=3D0 ogid=3D0 rdev=3D00:00 =
obj=3Dsystem_u:object_r:auditd_log_t:s15:c0.c255

root@hapWibbSc2:/var/log/audit# ps -eZ | grep sswd
system_u:system_r:init_t:s0-s15:c0.c255 2781 ? 00:00:00 sswd

root@hapWibbSc2:/var/log/audit# cd /usr/app/bin
root@hapWibbSc2:/usr/app/bin# ls -l sswd
-rwxrwxr-x 1 root root 217204 Jan  1 07:49 sswd

root@hapWibbSc2:/usr/app/bin# cd /var/log/audit/
root@hapWibbSc2:/var/log/audit#=20
root@hapWibbSc2:/var/log/audit# ls -lZ
-rw-------  root root system_u:object_r:auditd_log_t:s15:c0.c255 =
audit.log
=20

------_=_NextPart_001_01CA8FD9.3CD55EFC
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Help with an SELinux AVC event...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi All,<BR>
<BR>
I have a C application task called &quot;sswd&quot; on my Linux system, =
that opens up the /var/log/audit/audit.log file every 5 seconds, and =
checks to see if there are any new AVC denies.<BR>
<BR>
I have had this same task doing the same thing for the last few years on =
a Linux system running selinux. And I have never seen these events in =
audit.log before complaining about the sswd task... I used to use older =
selinux packages, and ran the Fedora Core 7 'strict' policy together =
with some custom policies.<BR>
<BR>
Recently we upgraded our SELinux packages to the very latest (similar to =
Fedora 12), and we are using Refpolicy as a base policy.<BR>
<BR>
In the /var/log/audit/audit.log file, I see the following event pop up =
every 5 seconds, and I am guessing its because &quot;sswd&quot; tries to =
open up the audit.log file every 5 seconds for reading.<BR>
<BR>
1. Can you help me understand what this event is really saying?<BR>
2. I have already taken the audit.log file, and used audit2allow to =
generate any allow rules necessary, but it didnt help to get rid of this =
particular event.<BR>
3. Can I add any specific policy allow lines or transition rules in my =
custom policy files to get rid of this repeated event ?<BR>
<BR>
Thanks in advance.<BR>
<BR>
The event that pops up every 5 seconds in audit.log is:<BR>
<BR>
type=3DSYSCALL msg=3Daudit(1262874266.422:260): arch=3D14 syscall=3D5 =
success=3Dyes exit=3D24 a0=3D1002b9e4 a1=3D0 a2=3D1b6 a3=3D1b6 items=3D1 =
ppid=3D2463 pid=3D2794 auid=3D4294967295 uid=3D0 gid=3D601 euid=3D0 =
suid=3D0 fsuid=3D0 egid=3D601 sgid=3D601 fsgid=3D601 tty=3D(none) =
ses=3D4294967295 comm=3D&quot;sswd&quot; =
exe=3D&quot;/usr/app/bin/sswd&quot; =
subj=3Dsystem_u:system_r:init_t:s0-s15:c0.c255 =
key=3D&quot;LOG_audit&quot;<BR>
type=3DCWD msg=3Daudit(1262874266.422:260):&nbsp; =
cwd=3D&quot;/data&quot;<BR>
type=3DPATH msg=3Daudit(1262874266.422:260): item=3D0 =
name=3D&quot;/var/log/audit/audit.log&quot; inode=3D2061 dev=3Dfd:07 =
mode=3D0100600 ouid=3D0 ogid=3D0 rdev=3D00:00 =
obj=3Dsystem_u:object_r:auditd_log_t:s15:c0.c255<BR>
<BR>
root@hapWibbSc2:/var/log/audit# ps -eZ | grep sswd<BR>
system_u:system_r:init_t:s0-s15:c0.c255 2781 ? 00:00:00 sswd<BR>
<BR>
root@hapWibbSc2:/var/log/audit# cd /usr/app/bin<BR>
root@hapWibbSc2:/usr/app/bin# ls -l sswd<BR>
-rwxrwxr-x 1 root root 217204 Jan&nbsp; 1 07:49 sswd<BR>
<BR>
root@hapWibbSc2:/usr/app/bin# cd /var/log/audit/<BR>
root@hapWibbSc2:/var/log/audit#<BR>
root@hapWibbSc2:/var/log/audit# ls -lZ<BR>
-rw-------&nbsp; root root system_u:object_r:auditd_log_t:s15:c0.c255 =
audit.log<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA8FD9.3CD55EFC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
