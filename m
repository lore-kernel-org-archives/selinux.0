Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u083Ch68003357
 for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2016 22:12:44 -0500
Received: by mail-wm0-f50.google.com with SMTP id f206so119954062wmf.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Jan 2016 19:12:15 -0800 (PST)
MIME-Version: 1.0
From: Mark Steele <mark@control-alt-del.org>
Date: Thu, 7 Jan 2016 22:11:35 -0500
Message-ID: <CAB5=j_rdr6mEPctVLSrL06RG8Nj9hNO=4khcE0Aayn4HsK4UkA@mail.gmail.com>
Subject: Preventing packet sniffing
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114435e8364cd70528c9f42f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114435e8364cd70528c9f42f
Content-Type: text/plain; charset=UTF-8

Hi all,

I would like to know what a good approach might be to prevent packet
sniffing on a local node from being able to see the network traffic related
to an application.

Would iptables (secmark/connsecmark) do the trick to prevent tools like
tcpdump from being able to see these packets? Are there alternative
approaches that would be better for handling this?

Thanks in advance!


Mark Steele
CISSP, GPEN, GCIA, CSM
mark@control-alt-del.org

LinkedIn: https://ca.linkedin.com/in/markrsteele
Github: https://github.com/marksteele
Personal: http://www.control-alt-del.org

--001a114435e8364cd70528c9f42f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div><br></div><div>I would like to know=
 what a good approach might be to prevent packet sniffing on a local node f=
rom being able to see the network traffic related to an application.</div><=
div><br></div><div>Would iptables (secmark/connsecmark) do the trick to pre=
vent tools like tcpdump from being able to see these packets? Are there alt=
ernative approaches that would be better for handling this?</div><div><br><=
/div><div>Thanks in advance!<br></div><div><br></div><br clear=3D"all"><div=
><div class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div style=3D"font-size:small">Mark Steele</div><div style=3D"font=
-size:small">CISSP, GPEN, GCIA, CSM</div><div style=3D"font-size:small"><a =
href=3D"mailto:mark@control-alt-del.org" target=3D"_blank">mark@control-alt=
-del.org</a><br></div><div style=3D"font-size:small"><br></div><div><font s=
ize=3D"2">LinkedIn: <a href=3D"https://ca.linkedin.com/in/markrsteele" targ=
et=3D"_blank">https://ca.linkedin.com/in/markrsteele</a></font><br></div><d=
iv style=3D"font-size:small">Github: <a href=3D"https://github.com/markstee=
le" target=3D"_blank">https://github.com/marksteele</a></div><div><font siz=
e=3D"2">Personal: <a href=3D"http://www.control-alt-del.org" target=3D"_bla=
nk">http://www.control-alt-del.org</a></font></div><div style=3D"font-size:=
small"></div></div></div></div></div></div>
</div>

--001a114435e8364cd70528c9f42f--
