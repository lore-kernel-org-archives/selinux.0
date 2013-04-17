Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3HEGR1m024547
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2013 10:16:27 -0400
Received: from iad-wprd-xchw02.corp.verio.net (iad-wprd-xchw02.corp.verio.net [198.87.7.165])
	by relay1-bcrtfl2.verio.net (Postfix) with ESMTP id 6D4D8B038688
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2013 10:16:24 -0400 (EDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CE3B76.24029BE9"
Subject: Not sending AVC denials to audit.log
Date: Wed, 17 Apr 2013 10:16:23 -0400
Message-ID: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09E0C@IAD-WPRD-XCHB03.corp.verio.net>
From: "Rodney Simioni" <rodney.simioni@verio.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CE3B76.24029BE9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I have a few development tests that are failing when I put the server in
'enforcing` mode; however, it's not sending AVC denials to the
audit.log.

I have also used 'semanage dontaudit' in both on and off position and
it's not generating denials. When I put the server in 'permissive mode`,
the tests do not fail.

Why isn't selinux sending the denials to the audit.log when the tests
fail? How do I go about finding the culprit(s) that is/are failing my
tests? Thanks in advance.

=20

Rodney



This email message is intended for the use of the person to whom it has =
been sent, and may contain information that is confidential or legally =
protected. If you are not the intended recipient or have received this =
message in error, you are not authorized to copy, distribute, or =
otherwise use this message or its attachments. Please notify the sender =
immediately by return e-mail and permanently delete this message and any =
attachments. Verio Inc. makes no warranty that this email is error or =
virus free.  Thank you.

------_=_NextPart_001_01CE3B76.24029BE9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I have a few =
development tests that are failing when I put the server in =
&#8216;enforcing` mode; however, it&#8217;s not sending AVC denials to =
the audit.log.<o:p></o:p></p><p class=3DMsoNormal>I have also used =
&#8216;semanage dontaudit&#8217; in both on and off position and =
it&#8217;s not generating denials. When I put the server in =
&#8216;permissive mode`, the tests do not fail.<o:p></o:p></p><p =
class=3DMsoNormal>Why isn&#8217;t selinux sending the denials to the =
audit.log when the tests fail? How do I go about finding the culprit(s) =
that is/are failing my tests? Thanks in advance.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Rodney<o:p></o:p></p></div><p></p><p><br>This email =
message is intended for the use of the person to whom it has been sent, =
and may contain information that is confidential or legally protected. =
If you are not the intended recipient or have received this message in =
error, you are not authorized to copy, distribute, or otherwise use this =
message or its attachments. Please notify the sender immediately by =
return e-mail and permanently delete this message and any attachments. =
Verio Inc. makes no warranty that this email is error or virus free.  =
Thank you.</p></body></html>
------_=_NextPart_001_01CE3B76.24029BE9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
