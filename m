Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4RHjH9m028858
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 13:45:17 -0400
Received: by mail-vc0-f177.google.com with SMTP id hq11so5156737vcb.8
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 10:45:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 28 May 2014 00:45:18 +0700
Message-ID: <CANh19KBDGC4PPBitWUeFov-=1Mc51wBmfGYf0c3Zuy5-rtJAjA@mail.gmail.com>
Subject: change selinux user's roles
From: =?UTF-8?B?dG9hzIluIGN1zIA=?= <xuantoanbkfet@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7bacb7705f34e404fa654294
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bacb7705f34e404fa654294
Content-Type: text/plain; charset=UTF-8

Hi all!

I want to change a selinux user's role
Examble:
   Linux account: ToanCu and relation with SELinux user staff_u (staff_u
can access a number of roles staff_r, system_r, unconfiled_r, sysadm_r)
when I checked context of user by command *# id,* i have context of selinux
user :
uid=502(ToanCu) gid=503(ToanCu) groups=503(ToanCu)
*context=staff_u:staff_r:staff_t:s0-s0:c0.c1023*

I want to change the context above to : *context:
staff_u:sysadm_r:staff_t:s0-s0:c0.c1023*

Look forward your help!

Thanks!

-- 
Mr.Toan-Cu Xuan

School of Electronics and Telecommunications

Hanoi University of Science and Technology

1 Dai Co Viet, Ha noi, Viet nam.

Phone: 01656228762

Email:xuantoanbkfet@gmail.com

--047d7bacb7705f34e404fa654294
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all!<div><br></div><div><div>I want to change a selinux=
 user&#39;s role=C2=A0</div><div>Examble:=C2=A0</div><div>=C2=A0 =C2=A0Linu=
x account: ToanCu and=C2=A0<span style=3D"color:rgb(0,0,0);font-family:sans=
-serif;font-size:13px;line-height:19.200000762939453px">relation</span>=C2=
=A0with SELinux user staff_u (staff_u can=C2=A0access a number of roles sta=
ff_r, system_r, unconfiled_r, <font color=3D"#ff0000">sysadm_r</font>)=C2=
=A0</div>
<div>when I checked context of user by command=C2=A0<b># id,</b> i have con=
text of selinux user :=C2=A0</div><div><div><span style=3D"background-color=
:rgb(255,255,255)"><font color=3D"#000000">uid=3D502(ToanCu) gid=3D503(Toan=
Cu) groups=3D503(ToanCu) </font><b><font color=3D"#000000">context=3Dstaff_=
u:</font><font color=3D"#ff0000">staff_r</font><font color=3D"#000000">:sta=
ff_t:s0-s0:c0.c1023</font></b></span></div>
</div><div><br></div><div>I want to change the context above to :=C2=A0<b>c=
ontext: staff_u:<font color=3D"#ff0000">sysadm_r</font>:staff_t:s0-s0:c0.c1=
023</b></div><div><br></div><div><div style=3D"font-family:arial,sans-serif=
;font-size:13px">
<font face=3D"arial, sans-serif">Look forward your help!</font></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px"><font face=3D"arial, s=
ans-serif"><br></font></div><div style=3D"font-family:arial,sans-serif;font=
-size:13px">
<font face=3D"arial, sans-serif">Thanks!</font></div><div><br></div>-- <br>=
Mr.Toan-Cu Xuan<div><p style=3D"font-family:arial,sans-serif;font-size:13px=
;background-color:rgb(255,255,255)">School of Electronics and Telecommunica=
tions</p>
<p style=3D"font-family:arial,sans-serif;font-size:13px;background-color:rg=
b(255,255,255)">Hanoi University of Science and Technology</p><p style=3D"f=
ont-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255=
)">
1 Dai Co Viet, Ha noi, Viet nam.</p><p style=3D"font-family:arial,sans-seri=
f;font-size:13px;background-color:rgb(255,255,255)">Phone: 01656228762</p><=
p style=3D"font-family:arial,sans-serif;font-size:13px;background-color:rgb=
(255,255,255)">
<a href=3D"mailto:Email%3Axuantoanbkfet@gmail.com" target=3D"_blank">Email:=
xuantoanbkfet@gmail.com</a></p></div>
</div></div></div>

--047d7bacb7705f34e404fa654294--
