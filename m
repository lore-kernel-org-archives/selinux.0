Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA3DJ9MA014455
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 08:19:09 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA3DDphI014578
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 13:13:51 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id jA3DDHCM002950
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 08:13:17 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id jA3DDHoj002949
	for selinux@tycho.nsa.gov; Thu, 3 Nov 2005 08:13:17 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA2J1uMA008128
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2005 14:01:56 -0500 (EST)
Received: from wsncexc001.silkroadtech.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA2IujPq009402
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2005 18:56:46 GMT
From: "Remmolt Zwartsenberg" <remmolt.zwartsenberg@silkroadtech.com>
To: "'Wei Shen'" <cquark@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: A question on integrating IPSec to Selinux
Date: Wed, 2 Nov 2005 20:25:15 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0060_01C5DFEB.89BC8830"
In-Reply-To: <e12e59640511020830q18817c3dsb01d3051970baf9f@mail.gmail.com>
Message-ID: <WSNCEXC0010dSHpVyLr00001d77@wsncexc001.silkroadtech.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0060_01C5DFEB.89BC8830
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Dear Wei,

 

You need to backtrack to the bowels of the origin of the TCP/IP protocol!

A payload inside an IP packet can get as small as a datagram...

 

The datagram may be a very significant public or private key in a 2, 3 or 4
way constellation.

 

Of course the protocol is important, but equally so are the peers behind the
handshakes.

 

Good luck, Remmolt

 

'Communication is only achieved when 2 wise men are comitted to understand
each other' 

 ( Transcription from Tao Te Ching by Lao Tsu, about 350 BC )   

 

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Wei Shen
Sent: woensdag 2 november 2005 17:30
To: SELinux@tycho.nsa.gov
Subject: A question on integrating IPSec to Selinux

 

Greedings,

 

I read "Leveraging IPSec for Mandatory Access Control of Linux Network

Communication" by Mr. Trent Jaeger. I learned that when a security

association is built, the initiator is responsible for adding its MAC

label as an attribute of the SA, and the responder then use the label

received to decide the label of the SA in the responder endpoint.

 

To my understandings, in this implementation a remote client can only

act passively - it provide its authorization information, and can only

accept the label the server give it in the server side. Is it possible

for a remote process (assuming that it knows the policy configuration

in the peer side) to specify a label (e.g. a security level in MLS) it

expects to have in the peer side, and wait for a approval?

 

I think such a function is useful. For instance, if a user is allowed

to access remote service under different security levels, he can

specify a wanted level in one request, but not change authorization

information to meet the corresponding requirement every time. And we

then need not to change each application  level servers (such as

telnet, ftp) to realize similar features.

 

I also think by adding a optional wanted remote label together with a

local label to a proposal payload when negotiating a SA, it is not

hard to implement.

 

Is my comprehension any wrong?

 

Thanks!

Wei

 

 

--

This message was distributed to subscribers of the selinux mailing list.

If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with

the words "unsubscribe selinux" without quotes as the message.


------=_NextPart_000_0060_01C5DFEB.89BC8830
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 77.95pt 72.0pt 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Dear Wei,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>You need to backtrack to the bowels of the origin of the TCP/IP =
protocol!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>A payload inside an IP packet can get as small as a =
datagram...<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>The datagram may be a very significant public or private key in =
a 2, 3
or 4 way constellation.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Of course the protocol is important, but equally so are the =
peers
behind the handshakes.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Good luck, Remmolt<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><i><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-style:italic'>&#8216;Communication is =
only
achieved when 2 wise men are comitted to understand each other&#8217; =
<o:p></o:p></span></font></i></p>

<p class=3DMsoPlainText><i><font size=3D2 face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-style:italic'>&nbsp;( Transcription from =
Tao Te
Ching by Lao Tsu, about 350 BC ) =
&nbsp;</span></font></i>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-----Original Message-----<br>
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] =
On
Behalf Of Wei Shen<br>
Sent: woensdag 2 november 2005 17:30<br>
To: SELinux@tycho.nsa.gov<br>
Subject: A question on integrating IPSec to Selinux</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Greedings,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>I read &quot;Leveraging IPSec for Mandatory Access Control of =
Linux
Network<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Communication&quot; by Mr. Trent Jaeger. I learned that when a =
security<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>association is built, the initiator is responsible for adding =
its MAC<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>label as an attribute of the SA, and the responder then use the =
label<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>received to decide the label of the SA in the responder =
endpoint.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>To my understandings, in this implementation a remote client can =
only<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>act passively - it provide its authorization information, and =
can only<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>accept the label the server give it in the server side. Is it =
possible<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>for a remote process (assuming that it knows the policy =
configuration<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>in the peer side) to specify a label (e.g. a security level in =
MLS) it<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>expects to have in the peer side, and wait for a =
approval?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>I think such a function is useful. For instance, if a user is =
allowed<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>to access remote service under different security levels, he =
can<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>specify a wanted level in one request, but not change =
authorization<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>information to meet the corresponding requirement every time. =
And we<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>then need not to change each application&nbsp; level servers =
(such as<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>telnet, ftp) to realize similar =
features.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>I also think by adding a optional wanted remote label together =
with a<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>local label to a proposal payload when negotiating a SA, it is =
not<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>hard to implement.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Is my comprehension any wrong?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Thanks!<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Wei<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>--<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>This message was distributed to subscribers of the selinux =
mailing
list.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>the words &quot;unsubscribe selinux&quot; without quotes as the
message.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0060_01C5DFEB.89BC8830--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
