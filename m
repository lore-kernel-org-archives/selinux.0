Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBIHJGZY030984
 for <selinux@tycho.nsa.gov>; Wed, 18 Dec 2013 12:19:18 -0500
References: 
Message-ID: <1387381759.80678.YahooMailNeo@web163404.mail.gq1.yahoo.com>
Date: Wed, 18 Dec 2013 07:49:19 -0800 (PST)
From: Andy Ruch <adruch2002@yahoo.com>
Subject: selinux control for network interface using SOCK_RAW
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="-2090553061-133738636-1387381759=:80678"
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---2090553061-133738636-1387381759=:80678
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,=0A=0AI'm trying to restrict an application to only have access to so=
me network interfaces. I'm running a custom policy on a RHEL 6.3 system. Th=
e application is opening the socket as AF_PACKET and SOCK_RAW. However, sel=
inux doesn't seem to be controlling any raw access to the interfaces.=0A=0A=
I've confirmed using apol that there are no rules for the interface type th=
at would allow access. I've also confirmed that the only attribute on the i=
nterface is netif_type and that the only access to netif_type is from kerne=
l_t. =0A=0A=0AI've granted the application:=0A=A0=A0=A0 allow my_app_t self=
:packet_socket { connected_socket_perms };=0A=A0=A0=A0 allow my_app_t  self=
:capability { net_raw };=0A=0AI was expecting to have to do something like:=
=0A=A0=A0=A0 allow my_app_t my_iface_t:netif { some_permission };=0A=0A=0AI=
s there any way for me to enforce network interface separation? Or does pac=
ket_socket always allow access to all interfaces?=0A=0A=0AThanks,=0AAndy Ru=
ch=0A
---2090553061-133738636-1387381759=:80678
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;fo=
nt-size:12pt"><div id=3D"yiv7598234917"><div><div style=3D"color:#000;backg=
round-color:#fff;font-family:HelveticaNeue, Helvetica Neue, Helvetica, Aria=
l, Lucida Grande, sans-serif;font-size:12pt;"><div id=3D"yiv7598234917"><di=
v id=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_6042"><div style=3D"col=
or:#000;background-color:#fff;font-family:HelveticaNeue, Helvetica Neue, He=
lvetica, Arial, Lucida Grande, sans-serif;font-size:12pt;" class=3D"yiv7598=
234917yui_3_13_0_ym1_1_1387377091205_5906" id=3D"yiv7598234917yui_3_13_0_ym=
1_1_1387377091205_6041"><div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956=
835_51">Hello,</div><div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_=
53"><br></div><div style=3D"color:rgb(0, 0, 0);font-size:16px;font-family:H=
elveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande,
 sans-serif;background-color:transparent;font-style:normal;" id=3D"yiv75982=
34917yui_3_13_0_ym1_7_1387296956835_55" class=3D"yiv7598234917yui_3_13_0_ym=
1_1_1387377091205_5907">I'm trying to restrict an=0A application to only ha=
ve access to some network interfaces. I'm running a custom policy on a RHEL=
 6.3 system. The application is opening the socket as AF_PACKET and SOCK_RA=
W. However, selinux doesn't seem to be controlling any raw access to the in=
terfaces.</div><div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_66" s=
tyle=3D"color:rgb(0, 0, 0);font-size:16px;font-family:HelveticaNeue, Helvet=
ica Neue, Helvetica, Arial, Lucida Grande, sans-serif;background-color:tran=
sparent;font-style:normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_13873770=
91205_5908"><br id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_71"></div=
><div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_68" style=3D"color:=
rgb(0, 0, 0);font-size:16px;font-family:HelveticaNeue, Helvetica Neue, Helv=
etica, Arial, Lucida Grande, sans-serif;background-color:transparent;font-s=
tyle:normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_5909">I'=
ve confirmed using apol that there are no rules for the
 interface type that would allow access. I've also=0A confirmed that the on=
ly attribute on the interface is netif_type and that the only access to net=
if_type is from kernel_t. <br id=3D"yiv7598234917yui_3_13_0_ym1_7_138729695=
6835_76"></div><div id=3D"yiv7598234917yui_3_13_0_ym1_1_1387296956835_26730=
" style=3D"color:rgb(0, 0, 0);font-size:16px;font-family:HelveticaNeue, Hel=
vetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;background-color:t=
ransparent;font-style:normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_13873=
77091205_5910"><br id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_80"></=
div><div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_77" style=3D"col=
or:rgb(0, 0, 0);font-size:16px;font-family:HelveticaNeue, Helvetica Neue, H=
elvetica, Arial, Lucida Grande, sans-serif;background-color:transparent;fon=
t-style:normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_5911"=
>I've granted the application:</div><div id=3D"yiv7598234917yui_3_13_0_ym1_=
7_1387296956835_84" style=3D"color:rgb(0, 0,
 0);font-size:16px;font-family:HelveticaNeue, Helvetica Neue, Helvetica, Ar=
ial, Lucida Grande, sans-serif;background-color:transparent;font-style:norm=
al;" class=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_5912">&nbsp;&nbsp=
;&nbsp; allow my_app_t self:packet_socket { connected_socket_perms };</div>=
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_88" style=3D"color:r=
gb(0, 0, 0);font-size:16px;font-family:HelveticaNeue, Helvetica Neue, Helve=
tica, Arial, Lucida Grande, sans-serif;background-color:transparent;font-st=
yle:normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_5913">&nb=
sp;&nbsp;&nbsp; allow my_app_t  self:capability { net_raw };<br><br>I was e=
xpecting to have to do something like:<br>&nbsp;&nbsp;&nbsp; allow my_app_t=
 my_iface_t:netif { some_permission };<br></div><div id=3D"yiv7598234917yui=
_3_13_0_ym1_7_1387296956835_91" style=3D"color:rgb(0, 0, 0);font-size:16px;=
font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande,
 sans-serif;background-color:transparent;font-style:normal;" class=3D"yiv75=
98234917yui_3_13_0_ym1_1_1387377091205_5914"><br id=3D"yiv7598234917yui_3_1=
3_0_ym1_7_1387296956835_95"></div><div id=3D"yiv7598234917yui_3_13_0_ym1_1_=
1387296956835_26927" style=3D"color:rgb(0, 0, 0);font-size:16px;font-family=
:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif=
;background-color:transparent;font-style:normal;" class=3D"yiv7598234917yui=
_3_13_0_ym1_1_1387377091205_5915">Is there any way for me to enforce networ=
k interface separation? Or does packet_socket always allow access to all in=
terfaces?<br></div><div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_9=
7" style=3D"color:rgb(0, 0, 0);font-size:16px;font-family:HelveticaNeue, He=
lvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;background-color:=
transparent;font-style:normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_1387=
377091205_5916"><br id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_102">=
</div><div
 id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_99" style=3D"color:rgb(0=
, 0, 0);font-size:16px;font-family:HelveticaNeue, Helvetica Neue, Helvetica=
, Arial, Lucida Grande, sans-serif;background-color:transparent;font-style:=
normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_5917">Thanks,=
</div><div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_104" style=3D"=
color:rgb(0, 0, 0);font-size:16px;font-family:HelveticaNeue, Helvetica Neue=
, Helvetica, Arial, Lucida Grande, sans-serif;background-color:transparent;=
font-style:normal;" class=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_59=
18">Andy Ruch<br></div></div></div></div></div></div></div></div></body></h=
tml>
---2090553061-133738636-1387381759=:80678--
