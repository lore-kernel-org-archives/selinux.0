Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1JHr574013581
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 12:53:05 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so7101642qac.8
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 09:53:04 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 19 Feb 2015 09:53:04 -0800
Message-ID: <CAMPpu2Up6bvquf2fXZbFd+jW1KcSSPJZhQEhmgRysgigNDnU7A@mail.gmail.com>
Subject: Odd occurrence of /sbin/setfiles running
From: Mark Lee <markleee50@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113347c29a8866050f749bba
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113347c29a8866050f749bba
Content-Type: text/plain; charset=UTF-8

Hello List,

I'm dealing with some strange occurrences in my audit log and was wondering
if anyone could shed some light.

First off "/sbin/setfiles" ran, for no apparent reason,  I didn't run the
command, wasn't applying any new selinux policies or in any way interacting
with the system.  I looked back through the logs and there was no other
occurrences of this happening other then twice yesterday. Example:

linux-audit type=SYSCALL msg=audit(1424298673.524:35003): arch=c000003e
syscall=59 success=yes exit=0 a0=23fcc10 a1=2892c10 a2=7fffbfbdac58
a3=7473616d5f6e6f69 items=0 ppid=728 pid=757 auid=0 uid=0 gid=0 euid=0
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=3490 comm="restorecon"
exe="/sbin/setfiles" subj=unconfined_u:system_r:setfiles_t:s0 key=(null)


Secondly, I have a bunch of selinux denied messages, such as:


linux-audit type=AVC msg=audit(1424298673.524:35003): avc:  denied  { read
write } for  pid=757 comm="restorecon" path="[eventfd]" dev=anon_inodefs
ino=3791 scontext=unconfined_u:system_r:setfiles_t:s0
tcontext=system_u:object_r:anon_inodefs_t:s0 tclass=file

The inodes for these selinux denied events trace back to:

/sys/devices/virtual/block/ram10/trace/end_lba
/sys/devices/virtual/block/ram10/queue/max_segments

I am completely stumped and would appreciate any help.

Thanks,
Mark

--001a113347c29a8866050f749bba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello List,<div><br></div><div>I&#39;m dealing with some s=
trange occurrences in my audit log and was wondering if anyone could shed s=
ome light.</div><div><br></div><div>First off &quot;/sbin/setfiles&quot; ra=
n, for no apparent reason, =C2=A0I didn&#39;t run the command, wasn&#39;t a=
pplying any new selinux policies or in any way interacting with the system.=
=C2=A0 I looked back through the logs and there was no other occurrences of=
 this happening other then twice yesterday. Example:</div><div><br></div><d=
iv><div>linux-audit type=3DSYSCALL msg=3Daudit(1424298673.524:35003): arch=
=3Dc000003e syscall=3D59 success=3Dyes exit=3D0 a0=3D23fcc10 a1=3D2892c10 a=
2=3D7fffbfbdac58 a3=3D7473616d5f6e6f69 items=3D0 ppid=3D728 pid=3D757 auid=
=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D=
0 tty=3D(none) ses=3D3490 comm=3D&quot;restorecon&quot; exe=3D&quot;/sbin/s=
etfiles&quot; subj=3Dunconfined_u:system_r:setfiles_t:s0 key=3D(null)</div>=
</div><div><br></div><div><br></div><div>Secondly, I have a bunch of selinu=
x denied messages, such as:</div><div><br></div><div><br></div><div>linux-a=
udit type=3DAVC msg=3Daudit(1424298673.524:35003): avc: =C2=A0denied =C2=A0=
{ read write } for =C2=A0pid=3D757 comm=3D&quot;restorecon&quot; path=3D&qu=
ot;[eventfd]&quot; dev=3Danon_inodefs ino=3D3791 scontext=3Dunconfined_u:sy=
stem_r:setfiles_t:s0 tcontext=3Dsystem_u:object_r:anon_inodefs_t:s0 tclass=
=3Dfile<br></div><div><br></div><div>The inodes for these selinux denied ev=
ents trace back to:</div><div><br></div><div><div>/sys/devices/virtual/bloc=
k/ram10/trace/end_lba</div><div>/sys/devices/virtual/block/ram10/queue/max_=
segments</div></div><div><br></div><div>I am completely stumped and would a=
ppreciate any help.</div><div><br></div><div>Thanks,</div><div>Mark</div><d=
iv><br></div><div><br></div></div>

--001a113347c29a8866050f749bba--
