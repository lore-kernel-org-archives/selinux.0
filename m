From: Colin Powers <Colin.Powers@nexor.com>
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: RE: selinux control for network interface using SOCK_RAW
Date: Wed, 18 Dec 2013 17:31:06 +0000
Message-ID: <cede51375f174d7da793c4f9d95664ef@AMXPR03MB136.eurprd03.prod.outlook.com>
References: <1387381759.80678.YahooMailNeo@web163404.mail.gq1.yahoo.com>
In-Reply-To: <1387381759.80678.YahooMailNeo@web163404.mail.gq1.yahoo.com>
Content-Type: multipart/alternative;
 boundary="_000_cede51375f174d7da793c4f9d95664efAMXPR03MB136eurprd03pro_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_cede51375f174d7da793c4f9d95664efAMXPR03MB136eurprd03pro_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'd be interested to see what others have to say on this too.

You can achieve what you are doing using iptables and SECMARK, see the link=
s below:
http://selinuxproject.org/page/NB_Networking
http://james-morris.livejournal.com/11010.html
http://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-toge=
ther

The basic idea being that you:

*         Create a type, for example, eth0_packet_t

*         Use iptables to label all packets on eth0 as eth0_packet_t

*         Grant permissions on eth0_packet_t as necessary, e.g. allow my_ap=
p_t eht0_packet_t : packet {send recv}

I'd be very interested to hear others' opinions on whether this is best pra=
ctice!

Cheers
Colin

From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of Andy Ruch
Sent: 18 December 2013 15:49
To: SELinux ML
Subject: selinux control for network interface using SOCK_RAW

Hello,

I'm trying to restrict an application to only have access to some network i=
nterfaces. I'm running a custom policy on a RHEL 6.3 system. The applicatio=
n is opening the socket as AF_PACKET and SOCK_RAW. However, selinux doesn't=
 seem to be controlling any raw access to the interfaces.

I've confirmed using apol that there are no rules for the interface type th=
at would allow access. I've also confirmed that the only attribute on the i=
nterface is netif_type and that the only access to netif_type is from kerne=
l_t.

I've granted the application:
    allow my_app_t self:packet_socket { connected_socket_perms };
    allow my_app_t self:capability { net_raw };

I was expecting to have to do something like:
    allow my_app_t my_iface_t:netif { some_permission };

Is there any way for me to enforce network interface separation? Or does pa=
cket_socket always allow access to all interfaces?

Thanks,
Andy Ruch

--_000_cede51375f174d7da793c4f9d95664efAMXPR03MB136eurprd03pro_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:2031291950;
	mso-list-type:hybrid;
	mso-list-template-ids:1035790550 134807553 134807555 134807557 134807553 1=
34807555 134807557 134807553 134807555 134807557;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">I'd be interested to see wh=
at others have to say on this too.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">You can achieve what you ar=
e doing using iptables and SECMARK, see the links below:<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><a href=3D"http://selinuxproject.org/page/NB_Network=
ing">http://selinuxproject.org/page/NB_Networking</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"http://james-morris.livejournal.com/11010=
.html">http://james-morris.livejournal.com/11010.html</a><o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"http://www.linux.com/learn/tutorials/4211=
52-using-selinux-and-iptables-together">http://www.linux.com/learn/tutorial=
s/421152-using-selinux-and-iptables-together</a><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">The basic idea being that y=
ou:<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span style=3D"font-size:11.0pt;font-family:S=
ymbol;color:black"><span style=3D"mso-list:Ignore">&middot;<span style=3D"f=
ont:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Create a type, for =
example, eth0_packet_t<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span style=3D"font-size:11.0pt;font-family:S=
ymbol;color:black"><span style=3D"mso-list:Ignore">&middot;<span style=3D"f=
ont:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Use iptables to lab=
el all packets on eth0 as eth0_packet_t<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-18.0pt;mso-list:l0 leve=
l1 lfo1"><![if !supportLists]><span style=3D"font-size:11.0pt;font-family:S=
ymbol;color:black"><span style=3D"mso-list:Ignore">&middot;<span style=3D"f=
ont:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Grant permissions o=
n eth0_packet_t as necessary, e.g. allow my_app_t eht0_packet_t : packet {s=
end recv}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">I'd be very interested to h=
ear others' opinions on whether this is best practice!<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">Cheers<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">Colin<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&qu=
ot;sans-serif&quot;"> Selinux [mailto:selinux-bounces@tycho.nsa.gov]
<b>On Behalf Of </b>Andy Ruch<br>
<b>Sent:</b> 18 December 2013 15:49<br>
<b>To:</b> SELinux ML<br>
<b>Subject:</b> selinux control for network interface using SOCK_RAW<o:p></=
o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div id=3D"yiv7598234917">
<div>
<div>
<div id=3D"yiv7598234917">
<div id=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_6042">
<div id=3D"yiv7598234917yui_3_13_0_ym1_1_1387377091205_6041">
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_51">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Helvetica&quot;,&quot;sans-serif&quot;;color:black">Hello,<o:p></o:=
p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_53">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Helvetica&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:=
p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_55">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">I'm trying to restrict an application to o=
nly have access to some network interfaces. I'm running a custom policy on =
a RHEL 6.3 system. The application is opening the socket
 as AF_PACKET and SOCK_RAW. However, selinux doesn't seem to be controlling=
 any raw access to the interfaces.<o:p></o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_66">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_68">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">I've confirmed using apol that there are n=
o rules for the interface type that would allow access. I've also confirmed=
 that the only attribute on the interface is netif_type
 and that the only access to netif_type is from kernel_t. <o:p></o:p></span=
></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_1_1387296956835_26730">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_77">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">I've granted the application:<o:p></o:p></=
span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_84">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp;&nbsp;&nbsp; allow my_app_t self:pac=
ket_socket { connected_socket_perms };<o:p></o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_88">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">&nbsp;&nbsp;&nbsp; allow my_app_t self:cap=
ability { net_raw };<br>
<br>
I was expecting to have to do something like:<br>
&nbsp;&nbsp;&nbsp; allow my_app_t my_iface_t:netif { some_permission };<o:p=
></o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_91">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_1_1387296956835_26927">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">Is there any way for me to enforce network=
 interface separation? Or does packet_socket always allow access to all int=
erfaces?<o:p></o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_97">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_99">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">Thanks,<o:p></o:p></span></p>
</div>
<div id=3D"yiv7598234917yui_3_13_0_ym1_7_1387296956835_104">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Helvetica&quot;,&qu=
ot;sans-serif&quot;;color:black">Andy Ruch<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_cede51375f174d7da793c4f9d95664efAMXPR03MB136eurprd03pro_--
