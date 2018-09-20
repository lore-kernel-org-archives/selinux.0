Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KLZmuX008430
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 17:35:49 -0400
Received: by mail-wm1-f48.google.com with SMTP id y139-v6so972770wmc.2
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 14:35:44 -0700 (PDT)
MIME-Version: 1.0
From: Ted Toth <txtoth@gmail.com>
Date: Thu, 20 Sep 2018 16:35:33 -0500
Message-ID: <CAFPpqQG3_aUEJW8fbz8sRtTPRcw2KUsQ+wtr3+-awjcws+PD0w@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000229f060576544e2a"
Subject: file context not being set on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000229f060576544e2a
Content-Type: text/plain; charset="UTF-8"

I have something very much like the following in an fc file:
/usr/lib64/python2\.(6|7)/site-packages/xyz/paste     --
gen_context(system_u:object_r:jxyz_exec_t,s0)

and I use the same file on el6 and el7. On el6 the file is labeled as
specified in the python2.6 directory. However on el7 where the file gets
installed into python2.7 the file is not labeled correctly. On el7
`semanage fcontext -l | grep xyz` shows the file context expected but
`matchpathcon /usr/lib64/python2.7/site-packages/xyz/paste` does not return
the expected context and `restorecon -RFv
/usr/lib64/python2.7/site-packages/xyz` has no affect. The type xyz_exec_t
exists on both systems. It's probably something stupid I'm doing but I'm
just not seeing it. Has anyone else experienced similar issues?

Ted

--000000000000229f060576544e2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I have something very much like the =
following in an fc file:</div><div>/usr/lib64/python2\.(6|7)/site-packages/=
xyz/paste=C2=A0 =C2=A0 =C2=A0--=C2=A0 =C2=A0 =C2=A0 gen_context(system_u:ob=
ject_r:jxyz_exec_t,s0)</div><div><br></div><div>and I use the same file on =
el6 and el7. On el6 the file is labeled as specified in the python2.6 direc=
tory. However on el7 where the file gets installed into python2.7 the file =
is not labeled correctly. On el7 `semanage fcontext -l | grep xyz` shows th=
e file context expected but `matchpathcon /usr/lib64/python2.7/site-package=
s/xyz/paste` does not return the expected context and `restorecon -RFv /usr=
/lib64/python2.7/site-packages/xyz` has no affect. The type xyz_exec_t exis=
ts on both systems. It&#39;s probably something stupid I&#39;m doing but I&=
#39;m just not seeing it. Has anyone else experienced similar issues?</div>=
<div><br></div><div>Ted</div><div><br></div></div></div>

--000000000000229f060576544e2a--
