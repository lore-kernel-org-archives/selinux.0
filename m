Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3AIOa5x010890
	for <selinux@tycho.nsa.gov>; Wed, 10 Apr 2013 14:24:37 -0400
Received: from iad-wprd-xchw02.corp.verio.net (iad-wprd-xchw02.corp.verio.net [198.87.7.165])
	by relay1-bcrtfl2.verio.net (Postfix) with ESMTP id 04A37B038884
	for <selinux@tycho.nsa.gov>; Wed, 10 Apr 2013 14:24:20 -0400 (EDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CE3618.9E5E6E4E"
Subject: appending to an existing policy
Date: Wed, 10 Apr 2013 14:24:18 -0400
Message-ID: <0971982CF6B9AB418FFD5FEF7F50CB9F05D71CDA@IAD-WPRD-XCHB03.corp.verio.net>
From: "Rodney Simioni" <rodney.simioni@verio.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CE3618.9E5E6E4E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I just created a custom policy and did the semodule -i test.te.

=20

I reran all my tests after a few days and I noticed there were
additional AVC denials in the audit.log.

=20

I want to add the new stuff to my existing test.te file so that I won't
have multiple policies. I just want to have one policy and just keep
adding to it, is that possible and how? Thanks in advance.



This email message is intended for the use of the person to whom it has =
been sent, and may contain information that is confidential or legally =
protected. If you are not the intended recipient or have received this =
message in error, you are not authorized to copy, distribute, or =
otherwise use this message or its attachments. Please notify the sender =
immediately by return e-mail and permanently delete this message and any =
attachments. Verio Inc. makes no warranty that this email is error or =
virus free.  Thank you.

------_=_NextPart_001_01CE3618.9E5E6E4E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>I just =
created a custom policy and did the semodule -i =
test.te.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I reran all my tests after a few days and I noticed =
there were additional AVC denials in the audit.log.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I want to =
add the new stuff to my existing test.te file so that I won't have =
multiple policies. I just want to have one policy and just keep adding =
to it, is that possible and how? Thanks in =
advance.<o:p></o:p></p></div><p></p><p><br>This email message is =
intended for the use of the person to whom it has been sent, and may =
contain information that is confidential or legally protected. If you =
are not the intended recipient or have received this message in error, =
you are not authorized to copy, distribute, or otherwise use this =
message or its attachments. Please notify the sender immediately by =
return e-mail and permanently delete this message and any attachments. =
Verio Inc. makes no warranty that this email is error or virus free.  =
Thank you.</p></body></html>
------_=_NextPart_001_01CE3618.9E5E6E4E--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
