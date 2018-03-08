Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w28AtJUg004857
 for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2018 05:55:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID11.oob.disa.mil (Postfix) with SMTP id 3zxnTv2vWsz4QVYW
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 10:55:15 +0000 (UTC)
Received: from USFB3CPA05_EEMSG_MP27.eemsg.mil (unknown [192.168.16.22])
 by USFBF3ID11.oob.disa.mil (Postfix) with ESMTP id 3zxnTv2NDyz4QVYV
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 10:55:15 +0000 (UTC)
Received: by mail-ot0-f175.google.com with SMTP id r30so5024074otr.2
 for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2018 02:55:14 -0800 (PST)
MIME-Version: 1.0
From: Zvonko Kosic <zkosic@redhat.com>
Date: Thu, 08 Mar 2018 10:55:03 +0000
Message-ID: <CAFrfeQ5LmB6bCTT7rP8Afbmvfy8M0MpZwzunfixWA0t_wW4oBQ@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="089e082c7f849c0e360566e482bf"
Subject: SELinux Namespace on bind mounted files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e082c7f849c0e360566e482bf
Content-Type: text/plain; charset="UTF-8"

I've seen the presentation by James Morrison about  namespacing SELinux and
I have a question regarding a special case we have in our environment.

We have third party prestart runtime hooks for docker which bind mount
files from the host into the container image, which have the wrong label.

To change the SELinux labels on the host is not an option because
it breaks stuff on the host.

Wil the SELinux namespacing work on files that are bind mounted?


Thanks & Regards,
Zvonko Kosic

--089e082c7f849c0e360566e482bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"color:rgb(33,33,33);font-size:10.5625px">I&#=
39;ve seen the presentation by James Morrison about=C2=A0 namespacing=C2=A0=
<span class=3D"inbox-inbox-lG" style=3D"background-color:rgba(251,246,167,0=
.5);outline:transparent dashed 1px">SELinux</span>=C2=A0and I have a questi=
on regarding a special case we have in our environment.=C2=A0</div><div sty=
le=3D"color:rgb(33,33,33);font-size:10.5625px"><br></div><div style=3D"colo=
r:rgb(33,33,33);font-size:10.5625px">We have third party prestart runtime h=
ooks for docker which bind mount</div><div style=3D"color:rgb(33,33,33);fon=
t-size:10.5625px">files from the host into the container image, which have =
the wrong label.=C2=A0</div><div style=3D"color:rgb(33,33,33);font-size:10.=
5625px"><br></div><div style=3D"color:rgb(33,33,33);font-size:10.5625px">To=
 change the=C2=A0<span class=3D"inbox-inbox-lG" style=3D"background-color:r=
gba(251,246,167,0.5);outline:transparent dashed 1px">SELinux</span>=C2=A0la=
bels on the host is not an option because</div><div style=3D"color:rgb(33,3=
3,33);font-size:10.5625px">it breaks stuff on the host.=C2=A0</div><div sty=
le=3D"color:rgb(33,33,33);font-size:10.5625px"><br></div><div style=3D"colo=
r:rgb(33,33,33);font-size:10.5625px">Wil the=C2=A0<span class=3D"inbox-inbo=
x-lG" style=3D"background-color:rgba(251,246,167,0.5);outline:transparent d=
ashed 1px">SELinux</span>=C2=A0namespacing work on files that are bind moun=
ted?</div><div style=3D"color:rgb(33,33,33);font-size:10.5625px"><br></div>=
<div style=3D"color:rgb(33,33,33);font-size:10.5625px"><br></div>Thanks=C2=
=A0&amp; Regards,=C2=A0<div>Zvonko Kosic<br class=3D"inbox-inbox-Apple-inte=
rchange-newline"><div><br></div></div></div>

--089e082c7f849c0e360566e482bf--
