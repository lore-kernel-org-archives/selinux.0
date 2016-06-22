MIME-Version: 1.0
From: Ravi Kumar <nxp.ravi@gmail.com>
Date: Wed, 22 Jun 2016 23:05:33 +0530
Message-ID: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
Subject: New rules on restrict kernel module loading
To: seandroid-list@tycho.nsa.gov
Cc: Selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e0122e9bc58fca60535e15d20
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0122e9bc58fca60535e15d20
Content-Type: text/plain; charset=UTF-8

Hi team ,

I see some new changes  both in kernel and sepolicy project on restricting
the load of kernel module  .

https://android-review.googlesource.com/#/c/213758/ -- kernel change  on
check for moudle_load request  by Jeff
https://android-review.googlesource.com/#/c/214021/-- sepolicy change
adding the neverallow  on module_load request  by Jeff .

As most of the  SoC /OEM has there own KO  which are loaded on run-time
detection an mostly running in system_app/system_server/platfrom_app  are
there any special guideline here .

As an good example  wlan.ko  .


Regard,
Ravi

--089e0122e9bc58fca60535e15d20
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi team ,=C2=A0</div><div><br></div>I see some new ch=
anges =C2=A0both in kernel and sepolicy project on restricting the load of =
kernel module =C2=A0.=C2=A0<div><br></div><div><a href=3D"https://android-r=
eview.googlesource.com/#/c/213758/">https://android-review.googlesource.com=
/#/c/213758/</a> -- kernel change =C2=A0on check for moudle_load request =
=C2=A0by Jeff=C2=A0<br></div><div><a href=3D"https://android-review.googles=
ource.com/#/c/214021/--">https://android-review.googlesource.com/#/c/214021=
/--</a> sepolicy change adding the neverallow =C2=A0on module_load request =
=C2=A0by Jeff .<br></div><div><br></div><div>As most of the =C2=A0SoC /OEM =
has there own KO =C2=A0which are loaded on run-time detection an mostly run=
ning in system_app/system_server/platfrom_app =C2=A0are there any special g=
uideline here .=C2=A0</div><div><br></div><div>As an good example =C2=A0wla=
n.ko =C2=A0.</div><div><br></div><div><br></div><div>Regard,</div><div>Ravi=
=C2=A0</div></div>

--089e0122e9bc58fca60535e15d20--
