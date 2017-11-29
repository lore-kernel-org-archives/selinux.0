Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vATBnttn030749
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 06:49:56 -0500
Received: by mail-it0-f43.google.com with SMTP id d137so3776938itc.2
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 03:49:52 -0800 (PST)
MIME-Version: 1.0
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 17:19:51 +0530
Message-ID: <CAPMH7--5mGMZ4UMLM9763ukX-CBOzfUD96_wnCea57+RM8uakw@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="94eb2c19dbf2bbebac055f1dbbe9"
Subject: Default User in Selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c19dbf2bbebac055f1dbbe9
Content-Type: text/plain; charset="UTF-8"

Hi All,

During System boot up, I am running some semanage commands to change the
User to sysadm_u.  But in Cent OS 7.3 , Below error message is coming
i.e.  *ValueError:
Login mapping for __default__ is not defined.*

/usr/sbin/semanage login -m -S targeted -s user_u -r s0 __default__
    ValueError: Login mapping for __default__ is not defined


But the same command is working fine in Cent OS 6.8.

Please let me know why this error message is coming for Cent OS 7.

-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--94eb2c19dbf2bbebac055f1dbbe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>During System boot up, I am run=
ning some semanage commands to change the User to sysadm_u.=C2=A0 But in Ce=
nt OS 7.3 , Below error message is coming i.e.=C2=A0=C2=A0<b><span style=3D=
"background-color:rgb(245,245,245);color:rgb(51,51,51);font-size:12px;white=
-space:pre-wrap">ValueError: Login mapping </span><span class=3D"gmail-code=
-keyword" style=3D"font-size:12px;white-space:pre-wrap;color:rgb(0,0,145)">=
for</span><span style=3D"background-color:rgb(245,245,245);color:rgb(51,51,=
51);font-size:12px;white-space:pre-wrap"> __default__ is not defined.</span=
></b></div><div><b><span style=3D"background-color:rgb(245,245,245);color:r=
gb(51,51,51);font-size:12px;white-space:pre-wrap"><br></span></b></div><div=
><pre class=3D"gmail-code-java" style=3D"margin-top:0px;margin-bottom:0px;p=
adding:0px;max-height:30em;overflow:auto;white-space:pre-wrap;word-wrap:nor=
mal;color:rgb(51,51,51);font-size:12px;background-color:rgb(245,245,245)">/=
usr/sbin/semanage login -m -S targeted -s user_u -r s0 __default__=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
    ValueError: Login mapping <span class=3D"gmail-code-keyword" style=3D"c=
olor:rgb(0,0,145)">for</span> __default__ is not defined</pre></div><div><b=
r></div><div>But the same command is working fine in Cent OS 6.8.=C2=A0</di=
v><div><br></div><div>Please let me know why this error message is coming f=
or Cent OS 7.<br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_si=
gnature"><div dir=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><d=
iv>Cell: +91 9990296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5=
@gmail.com" target=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div=
>
</div></div>

--94eb2c19dbf2bbebac055f1dbbe9--
