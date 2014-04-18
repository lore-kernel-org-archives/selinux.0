Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3I9x6RE023568
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 05:59:06 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so2465113veb.2
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 02:59:07 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 18 Apr 2014 16:59:07 +0700
Message-ID: <CANh19KA2NX8RNt4u757_SY05Z84z9BsTfKhu3k+-rVzqfSAsMg@mail.gmail.com>
Subject: Transition domain in SELinux
From: =?UTF-8?B?dG9hzIluIGN1zIA=?= <xuantoanbkfet@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e0122f332500c2004f74e333c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0122f332500c2004f74e333c
Content-Type: text/plain; charset=UTF-8

Hi all !
I just researching policy in selinux, and I am facing an issue when
transition domain. I want change domain from unconfined_t to staff_t
domain.(when process of type unconfined_t execute file of type
xuantoan_t : *type_transition
unconfined_t xuantoan_t : process staff_t;*). since process of type
unconfined_t can access file of type toanxt_t through staff_t domain.

*policy_module(toanxt, 1.0.0);*
*require{*
*type unconfined_t;*
*type starr_t;*
*class process transition;*
*}*
*type toanxt_t;*
*type xuantoan_t;*
*type toanxt_exec_t;*

*allow staff_t  toanxt_exec_t : file { excute_no_trans   excute  open
 write getattr read}; *

*allow staff_t  toanxt_t : file { excute_no_trans   excute  open  write
getattr read};*

*type_transition unconfined_t xuantoan_t : process staff_t;*
*allow unconfined_t xuantoan_t : file { execute };*
*allow staff_t xuantoan_t : file entrypoint;*
*allow unconfined_t staff_t : process transition;*

but after compile and insert, process of type unconfined_t not access file
of type toanxt_t. I don't know why, look forward your help!

Thanks !


-- 
Mr.Toan-Cu Xuan

School of Electronics and Telecommunications

Hanoi University of Science and Technology

1 Dai Co Viet, Ha noi, Viet nam.

Phone: 01656228762

Email:xuantoanbkfet@gmail.com

--089e0122f332500c2004f74e333c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all !</div><div>I just researching policy in selin=
ux, and I am facing an issue when transition domain. I want change domain f=
rom unconfined_t to staff_t domain.(when process of type unconfined_t execu=
te file of type xuantoan_t :<font color=3D"#0000ff"> <i>type_transition unc=
onfined_t xuantoan_t : process staff_t;</i></font>). since process of type =
unconfined_t can access file of type toanxt_t through staff_t domain.</div>
<div><br></div><div><i><font color=3D"#0000ff">policy_module(toanxt, 1.0.0)=
;</font></i></div><div><i><font color=3D"#0000ff">require{</font></i></div>=
<div><i><font color=3D"#0000ff">type unconfined_t;</font></i></div><div><i>=
<font color=3D"#0000ff">type starr_t;</font></i></div>
<div><i><font color=3D"#0000ff">class process transition;</font></i></div><=
div><i><font color=3D"#0000ff">}</font></i></div><div><i><font color=3D"#00=
00ff">type toanxt_t;</font></i></div><div><i><font color=3D"#0000ff">type x=
uantoan_t;</font></i></div>
<div><i><font color=3D"#0000ff">type toanxt_exec_t;</font></i></div><div><i=
><font color=3D"#0000ff"><br></font></i></div><div><i><font color=3D"#0000f=
f">allow staff_t =C2=A0toanxt_exec_t : file { excute_no_trans =C2=A0 excute=
 =C2=A0open =C2=A0write getattr read};=C2=A0</font></i></div>
<div><i><font color=3D"#0000ff">allow staff_t =C2=A0toanxt_t : file { excut=
e_no_trans =C2=A0 excute =C2=A0open =C2=A0write getattr read};<br></font></=
i></div><div><i><font color=3D"#0000ff"><br></font></i></div><div><i><font =
color=3D"#0000ff">type_transition unconfined_t xuantoan_t : process staff_t=
;</font></i></div>
<div><i><font color=3D"#0000ff">allow unconfined_t xuantoan_t : file { exec=
ute };</font></i></div><div><i><font color=3D"#0000ff">allow staff_t xuanto=
an_t : file entrypoint;</font></i></div><div><i><font color=3D"#0000ff">all=
ow unconfined_t staff_t : process transition;</font></i></div>
<div><i><font color=3D"#0000ff"><br></font></i></div><div>but=C2=A0after co=
mpile and=C2=A0insert, process of type unconfined_t not access file of type=
 toanxt_t. I don&#39;t know why,=C2=A0look forward your help!</div><div><br=
></div><div>Thanks !=C2=A0</div>
<div><br></div><div><br></div>-- <br>Mr.Toan-Cu Xuan<div><p style=3D"font-f=
amily:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)">Sc=
hool of Electronics and Telecommunications</p><p style=3D"font-family:arial=
,sans-serif;font-size:13px;background-color:rgb(255,255,255)">
Hanoi University of Science and Technology</p><p style=3D"font-family:arial=
,sans-serif;font-size:13px;background-color:rgb(255,255,255)">1 Dai Co Viet=
, Ha noi, Viet nam.</p><p style=3D"font-family:arial,sans-serif;font-size:1=
3px;background-color:rgb(255,255,255)">
Phone: 01656228762</p><p style=3D"font-family:arial,sans-serif;font-size:13=
px;background-color:rgb(255,255,255)"><a href=3D"mailto:Email%3Axuantoanbkf=
et@gmail.com" target=3D"_blank">Email:xuantoanbkfet@gmail.com</a></p></div>
</div>

--089e0122f332500c2004f74e333c--
