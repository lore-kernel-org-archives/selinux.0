Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ENtBWt022429
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 19:55:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9ENtAmR007041
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 23:55:10 GMT
Received: from whms0073.cwshs.com (mailout.cgi.com [66.110.7.6])
        by jazzband.ncsc.mil  with ESMTP id h9ENt9jp007038 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 23:55:09 GMT
Received: from whml0344.cgi.com ([10.254.251.20]) by
          whms0073.cwshs.com (Netscape Messaging Server 4.15 whms0073 Jan
          17 2002 00:23:08) with SMTP id HMRUFX01.WWT for
          <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 19:55:09 -0400
Received: from RWANNER ([207.164.204.5]) by whms0335.cwshs.com
          (Netscape Messaging Server 4.15 whms0335 Jan 17 2002 00:23:08)
          with SMTP id HMRUFV00.H6K for <selinux@tycho.nsa.gov>; Tue, 14
          Oct 2003 19:55:07 -0400
From: "Richard Herbert Wanner" <richard.wanner@cgi.com>
To: <selinux@tycho.nsa.gov>
Subject: Compile/build problem in Red Hat 9.0
Date: Tue, 14 Oct 2003 19:53:23 -0400
Message-ID: <GMECJOINLDFDGEEPGINLAEGECKAA.richard.wanner@cgi.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0024_01C3928C.D3690DE0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C3928C.D3690DE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am trying to build the SE-Linux 2.4 kernel on Red Hat 9.0.  The make =
does not generate any obvious errors, (but there are .o files missing, =
and when we try to compile dummy.c by hand, it fails), but the make =
module_install fails.

Here is the tail end of the console for the make module_install (sorry, =
I didn't capture the make console)

make[2]: Entering  directory '/tmp/linux-2.4/drivers/net'
mkdir -p /lib/modules/2.4.21-selinux2/kernel/drivers/net/
cp dummy.o /lib/modules/2.4.21-selinux2/kernel/drivers/net/
cp: cannot stat 'dummy.o': No such file or directory
make[2]: *** [_modinst_] Error 1


Anybody have any idea what I can do to resolve this?




Richard (Rick) Wanner B.Sc. GCFW

Consultant

Security Engineering & Evaluation Group

InfoSec Centre of Expertise (COE)

CGI Information Systems & Management Consultants Inc.

Ottawa, Canada

http://www.infosec.cgi.com/

Email: richard.wanner@cgi.com

Tel:    (613) 234-2155

Cell:    (613) 220-2045

Fax:    (613) 234-6934

Confidentiality Notice: This e-mail message, including any attachments, =
is for the sole use of the intended recipient(s) and may contain =
confidential and privileged information. Any unauthorized review, use, =
disclosure or distribution is prohibited. If you are not the intended =
recipient, please contact the sender by reply e-mail and destroy all =
copies of the original message.

=20


------=_NextPart_000_0024_01C3928C.D3690DE0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1264" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial size=3D2>I am =
trying to build=20
the SE-Linux 2.4 kernel on Red Hat 9.0.&nbsp; The make does not generate =
any=20
obvious errors, (but there are .o files missing, and when we try to =
compile=20
dummy.c by hand, it fails), but the make module_install=20
fails.</FONT></SPAN></DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial size=3D2>Here =
is the tail end=20
of the console for the make module_install (sorry, I didn't capture the =
make=20
console)</FONT></SPAN></DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial =
size=3D2>make[2]:=20
Entering&nbsp; directory =
'/tmp/linux-2.4/drivers/net'</FONT></SPAN></DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial size=3D2>mkdir =
-p=20
/lib/modules/2.4.21-selinux2/kernel/drivers/net/</FONT></SPAN></DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial size=3D2>cp =
dummy.o=20
/lib/modules/2.4.21-selinux2/kernel/drivers/net/</FONT></SPAN></DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial size=3D2>cp: =
cannot stat=20
'dummy.o': No such file or directory</FONT></SPAN></DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial =
size=3D2>make[2]: ***=20
[_modinst_] Error 1</FONT></SPAN></DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D459203523-14102003><FONT face=3DArial =
size=3D2>Anybody have any=20
idea what I can do to resolve this?</FONT></SPAN></DIV>
<DIV class=3DSection1>
<P style=3D"MARGIN: 0in 0in 0pt">&nbsp;</P>
<P style=3D"MARGIN: 0in 0in 0pt">&nbsp;</P>
<P style=3D"MARGIN: 0in 0in 0pt"><B><SPAN=20
style=3D"FONT-FAMILY: Verdana; mso-bidi-font-size: 10.0pt; =
mso-bidi-font-family: 'Courier New'">Richard=20
(Rick) Wanner B.Sc. GCFW<?xml:namespace prefix =3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></B></P>
<P style=3D"MARGIN: 0in 0in 0pt"><I><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">Consultant<o:p></o:p></SPAN></I></P>
<P style=3D"MARGIN: 0in 0in 0pt"><I><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">Security=20
Engineering &amp; Evaluation Group<o:p></o:p></SPAN></I></P>
<P style=3D"MARGIN: 0in 0in 0pt"><I><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">InfoSec=20
Centre of Expertise (COE)<o:p></o:p></SPAN></I></P>
<P style=3D"MARGIN: 0in 0in 0pt"><I><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">CGI=20
Information Systems &amp; Management Consultants =
Inc.<o:p></o:p></SPAN></I></P>
<P style=3D"MARGIN: 0in 0in 0pt"><I><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">Ottawa,=20
Canada</SPAN></I><I><SPAN=20
style=3D"FONT-SIZE: 8pt; FONT-FAMILY: Verdana; mso-bidi-font-size: =
10.0pt; mso-bidi-font-family: 'Courier New'"><o:p></o:p></SPAN></I></P>
<P style=3D"MARGIN: 0in 0in 0pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'"><A=20
href=3D"http://www.infosec.cgi.com/">http://www.infosec.cgi.com/</A><o:p>=
</o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">Email:=20
richard.wanner@cgi.com<o:p></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">Tel:=20
<SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp; </SPAN>(613)=20
234-2155<o:p></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">Cell:=20
<SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp; </SPAN>(613)=20
220-2045<o:p></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">Fax:=20
<SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp; </SPAN>(613)=20
234-6934<o:p></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN-RIGHT: 0.5in; mso-margin-top-alt: auto; =
mso-margin-bottom-alt: auto"><B><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: #cc3300; FONT-FAMILY: Arial; =
mso-bidi-font-size: 10.5pt">Confidentiality=20
Notice:</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: black; FONT-FAMILY: Arial; =
mso-bidi-font-size: 7.5pt">=20
This e-mail message, including any attachments, is for the sole use of =
the=20
intended recipient(s) and may contain confidential and privileged =
information.=20
Any unauthorized review, use, disclosure or distribution is prohibited. =
If you=20
are not the intended recipient, please contact the sender by reply =
e-mail and=20
destroy all copies of the original message.</SPAN><SPAN=20
style=3D"FONT-SIZE: 7.5pt; COLOR: black; FONT-FAMILY: Verdana; =
mso-bidi-font-family: 'Arial Unicode MS'; mso-fareast-font-family: =
'Arial Unicode MS'"><o:p></o:p></SPAN></P>
<P style=3D"MARGIN: 0in 0in 0pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Verdana; mso-bidi-font-family: =
'Courier New'">&nbsp;<o:p></o:p></SPAN></P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0024_01C3928C.D3690DE0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
