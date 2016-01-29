Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0THbK6u013329
 for <selinux@tycho.nsa.gov>; Fri, 29 Jan 2016 12:37:20 -0500
Date: Fri, 29 Jan 2016 17:37:15 +0000 (UTC)
From: Joe Wulf <joe_wulf@yahoo.com>
Reply-To: Joe Wulf <joe_wulf@yahoo.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <2033239564.1859278.1454089035658.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <1464190.SZXTM0cE5o@juss>
References: <1464190.SZXTM0cE5o@juss>
Subject: Re: Newbie question on fixfiles
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_1859277_1217555035.1454089035652"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

------=_Part_1859277_1217555035.1454089035652
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

What filesystem is applied to your disk and its various partitions?For this=
 to work, that FS has to be one that supports SELinux labeling (seclabel).Y=
ou are right---if what you are using doesn't support that, you are dead in =
the water (currently).What options do you have to change to an SELinux-comp=
liant FS?
=20

      From: Thomas Downing <tdowning@bomgar.com>
 To: selinux@tycho.nsa.gov=20
 Sent: Friday, January 29, 2016 12:25 PM
 Subject: Newbie question on fixfiles
  =20
Hi,

I need to get SELinux running on an appliance we are building, not based on=
 a=20
distro that already supports SELinux.

I've got all the userspace stuff built, (including setools3) without any=20
warnings or errors. I followed instructions for installing and loading=20
refpolicy, no warnings or errors.=C2=A0 (Except the python tools, which all=
 import=20
selinux.py, which does not seem to be included in the source tree.)

I'm booting with kernel options "security=3Dselinux selinux=3D1", and dmesg=
 shows=20
SELinux initializing, and no errors or warnings.

sestatus output:

SELinux status:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 enabled
SELinuxfs mount:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /s=
ys/fs/selinux
SELinux root directory:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /etc/selinux
Loaded policy name:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 refpolicy
Current mode:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 permissive
Mode from config file:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 permissive
Policy MLS status:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
disabled
Policy deny_unknown status:=C2=A0=C2=A0=C2=A0 denied
Max kernel policy version:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 30

Problem is: fixfiles does not actually label anything, and the underlying r=
eason=20
is that none of the mounted disk filesystems (all ext4) have option 'seclab=
el'.

Any pointers?

Also, given the absence of the seclabel option, I question if the kernel pa=
rt=20
of SELinux is in fact really happy...and if it isn't, I'm dead in the water=
=20
anyway.

Thanks much,

Thomas Downing

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to Selinux-request@tycho.nsa.g=
ov.


  
------=_Part_1859277_1217555035.1454089035652
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, =
sans-serif;font-size:13px"><div id=3D"yui_3_16_0_1_1454085467530_23117"><sp=
an id=3D"yui_3_16_0_1_1454085467530_23142">What filesystem is applied to yo=
ur disk and its various partitions?</span></div><div dir=3D"ltr" id=3D"yui_=
3_16_0_1_1454085467530_23160"><span id=3D"yui_3_16_0_1_1454085467530_23142"=
>For this to work, that FS has to be one that supports SELinux labeling (se=
clabel).</span></div><div id=3D"yui_3_16_0_1_1454085467530_23199" dir=3D"lt=
r"><span id=3D"yui_3_16_0_1_1454085467530_23142">You are right---if what yo=
u are using doesn't support that, you are dead in the water (currently).</s=
pan></div><div id=3D"yui_3_16_0_1_1454085467530_23200" dir=3D"ltr"><span id=
=3D"yui_3_16_0_1_1454085467530_23142">What options do you have to change to=
 an SELinux-compliant FS?</span><br> </div><br><div id=3D"yui_3_16_0_1_1454=
085467530_23131" class=3D"qtdSeparateBR"><br></div><div style=3D"display: b=
lock;" id=3D"yui_3_16_0_1_1454085467530_23137" class=3D"yahoo_quoted">  <di=
v id=3D"yui_3_16_0_1_1454085467530_23136" style=3D"font-family: HelveticaNe=
ue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size:=
 13px;"> <div id=3D"yui_3_16_0_1_1454085467530_23135" style=3D"font-family:=
 HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif=
; font-size: 16px;"> <div id=3D"yui_3_16_0_1_1454085467530_23134" dir=3D"lt=
r"> <font id=3D"yui_3_16_0_1_1454085467530_23133" face=3D"Arial" size=3D"2"=
> <hr id=3D"yui_3_16_0_1_1454085467530_23132" size=3D"1"> <b><span style=3D=
"font-weight:bold;">From:</span></b> Thomas Downing &lt;tdowning@bomgar.com=
&gt;<br> <b><span style=3D"font-weight: bold;">To:</span></b> selinux@tycho=
.nsa.gov <br> <b><span style=3D"font-weight: bold;">Sent:</span></b> Friday=
, January 29, 2016 12:25 PM<br> <b><span style=3D"font-weight: bold;">Subje=
ct:</span></b> Newbie question on fixfiles<br> </font> </div> <div id=3D"yu=
i_3_16_0_1_1454085467530_23201" class=3D"y_msg_container"><br>Hi,<br><br>I =
need to get SELinux running on an appliance we are building, not based on a=
 <br>distro that already supports SELinux.<br><br>I've got all the userspac=
e stuff built, (including setools3) without any <br>warnings or errors. I f=
ollowed instructions for installing and loading <br>refpolicy, no warnings =
or errors.&nbsp; (Except the python tools, which all import <br>selinux.py,=
 which does not seem to be included in the source tree.)<br><br>I'm booting=
 with kernel options "security=3Dselinux selinux=3D1", and dmesg shows <br>=
SELinux initializing, and no errors or warnings.<br><br>sestatus output:<br=
><br>SELinux status:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; enabled<br>SELinuxfs mount:&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; /sys/fs/selinux<br>SELinux root directory:&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /etc/selinux<br>Loaded policy name:&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; refpolicy<br>Current mode:&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; permissive<br>M=
ode from config file:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; permissive<br>Po=
licy MLS status:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; di=
sabled<br>Policy deny_unknown status:&nbsp;&nbsp;&nbsp; denied<br>Max kerne=
l policy version:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 30<br><br>Problem is=
: fixfiles does not actually label anything, and the underlying reason <br>=
is that none of the mounted disk filesystems (all ext4) have option 'seclab=
el'.<br><br>Any pointers?<br><br>Also, given the absence of the seclabel op=
tion, I question if the kernel part <br>of SELinux is in fact really happy.=
..and if it isn't, I'm dead in the water <br>anyway.<br><br>Thanks much,<br=
><br>Thomas Downing<br><br>_______________________________________________<=
br>Selinux mailing list<br><a ymailto=3D"mailto:Selinux@tycho.nsa.gov" href=
=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>To unsubscri=
be, send email to <a ymailto=3D"mailto:Selinux-leave@tycho.nsa.gov." href=
=3D"mailto:Selinux-leave@tycho.nsa.gov.">Selinux-leave@tycho.nsa.gov.</a><b=
r>To get help, send an email containing "help" to <a ymailto=3D"mailto:Seli=
nux-request@tycho.nsa.gov." href=3D"mailto:Selinux-request@tycho.nsa.gov.">=
Selinux-request@tycho.nsa.gov.</a><br><br><br></div> </div> </div>  </div><=
/div></body></html>
------=_Part_1859277_1217555035.1454089035652--
