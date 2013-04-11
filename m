Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3BE3Gm0019793
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 10:03:16 -0400
Received: from iad-wprd-xchw02.corp.verio.net (iad-wprd-xchw02.corp.verio.net [198.87.7.165])
	by relay1-bcrtfl2.verio.net (Postfix) with ESMTP id C485FB0388C5
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 10:03:14 -0400 (EDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CE36BD.4EED65FE"
Subject: I am new to selinux
Date: Thu, 11 Apr 2013 10:03:13 -0400
Message-ID: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09976@IAD-WPRD-XCHB03.corp.verio.net>
From: "Rodney Simioni" <rodney.simioni@verio.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CE36BD.4EED65FE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings,

I've been tasked to setup selinux on a web hosting server where users
will have accounts, able to ftp, able to shell, and able to store their
web content.

This server will have some of its services running unconventionally.
This is how I am approaching selinux and please comment if something
concerns you on my way of configuring selinux.

=20

I am the developer of this server but I'm also doing system
administration duties. All my code works as expected when the server is
in permissive mode; however, I do see the failed AVC denials in
audit.log.

=20

Here are my steps:

=20

1.       Run all my tests on the code I have written, which will write
to the audit.log.

2.       Do a audit2why -a, to see the errors and the recommended
solution.

3.       Run all the setsebool commands that was recommended.

4.       Then I'll grep the "Missing type enforcement (TE) allow rule"
AVC errors and pipe them to a file.

5.       I'll create a module from the file and then ' semodule -i'  the
module.

=20

Any comments will be greatly appreciated.

=20

Rod Simioni

Software Development Engineer II

Verio, Inc.



This email message is intended for the use of the person to whom it has =
been sent, and may contain information that is confidential or legally =
protected. If you are not the intended recipient or have received this =
message in error, you are not authorized to copy, distribute, or =
otherwise use this message or its attachments. Please notify the sender =
immediately by return e-mail and permanently delete this message and any =
attachments. Verio Inc. makes no warranty that this email is error or =
virus free.  Thank you.

------_=_NextPart_001_01CE36BD.4EED65FE
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
/* List Definitions */
@list l0
	{mso-list-id:1004941914;
	mso-list-type:hybrid;
	mso-list-template-ids:-2003648456 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Greetings,<o:p></o:p></p><p =
class=3DMsoNormal>I&#8217;ve been tasked to setup selinux on a web =
hosting server where users will have accounts, able to ftp, able to =
shell, and able to store their web content.<o:p></o:p></p><p =
class=3DMsoNormal>This server will have some of its services running =
unconventionally. This is how I am approaching selinux and please =
comment if something concerns you on my way of configuring =
selinux.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I am the developer of this server but I&#8217;m also =
doing system administration duties. All my code works as expected when =
the server is in permissive mode; however, I do see the failed AVC =
denials in audit.log.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Here are my =
steps:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span style=3D'mso-list:Ignore'>1.<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>Run =
all my tests on the code I have written, which will write to the =
audit.log.<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'mso-list:Ignore'>2.<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>Do =
a audit2why &#8211;a, to see the errors and the recommended =
solution.<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'mso-list:Ignore'>3.<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>Run =
all the setsebool commands that was recommended.<o:p></o:p></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span style=3D'mso-list:Ignore'>4.<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span><![endif]>Then I&#8217;ll grep the &#8220;Missing type =
enforcement (TE) allow rule&#8221; AVC errors and pipe them to a =
file.<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'mso-list:Ignore'>5.<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span><![endif]>I&#8217;ll create a module from the file and =
then &#8216; semodule &#8211;i&#8217; &nbsp;the module.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Any comments =
will be greatly appreciated.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Rod =
Simioni<o:p></o:p></p><p class=3DMsoNormal>Software Development Engineer =
II<o:p></o:p></p><p class=3DMsoNormal>Verio, =
Inc.<o:p></o:p></p></div><p></p><p><br>This email message is intended =
for the use of the person to whom it has been sent, and may contain =
information that is confidential or legally protected. If you are not =
the intended recipient or have received this message in error, you are =
not authorized to copy, distribute, or otherwise use this message or its =
attachments. Please notify the sender immediately by return e-mail and =
permanently delete this message and any attachments. Verio Inc. makes no =
warranty that this email is error or virus free.  Thank =
you.</p></body></html>
------_=_NextPart_001_01CE36BD.4EED65FE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
