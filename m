Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0QIGUZN024994
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 13:16:30 -0500
Received: from ams-iport-2.cisco.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0QIGNSr019514
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 18:16:23 GMT
Received: from xbh-ams-201.cisco.com (xbh-ams-201.cisco.com [144.254.75.7])
	by ams-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p0QIGMR0016620
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 18:16:22 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CBBD85.2266D0F5"
Subject: SeLinux Policy design question
Date: Wed, 26 Jan 2011 19:16:21 +0100
Message-ID: <0B31D28E10F4FA489A0261135B94A14804A4489F@XMB-AMS-109.cisco.com>
From: "Ger Lawlor (gelawlor)" <gelawlor@cisco.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CBBD85.2266D0F5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am pondering the best approach to design of appropriate filesystem
labeling that will reduce the long term complexity of managing contexts
and transitions in SeLinux.

If I have a suite of services that interface within a single product and
those services have the potential to share access to similar sub
directory structures, but they=20

currently only access files and execute within their own install
directories. It's obviously better to keep locked down any access
outside of each services domain.=20

However, what if all services within a product were permitted open
access to all known directories within a product - apart from the
obvious i.e. these services could

Interfere with each other, are there any reasons why this approach would
not be considered a suitable initial approach to seLinux development,
with continued=20

Evolution, adding contexts for further refinement of control over time?
Are there best practice guides to filesystem labeling that considers the
complexity that can

Come from excessive labeling?

=20

Thanks.

Ger.


------_=_NextPart_001_01CBBD85.2266D0F5
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
	{mso-style-type:export-only;}
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
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I am =
pondering the best approach to design of appropriate filesystem labeling =
that will reduce the long term complexity of managing contexts and =
transitions in SeLinux.<o:p></o:p></p><p class=3DMsoNormal>If I have a =
suite of services that interface within a single product and those =
services have the potential to share access to similar sub directory =
structures, but they <o:p></o:p></p><p class=3DMsoNormal>currently only =
access files and execute within their own install directories. =
It&#8217;s obviously better to keep locked down any access outside of =
each services domain. <o:p></o:p></p><p class=3DMsoNormal>However, what =
if all services within a product were permitted open access to all known =
directories within a product &#8211; apart from the obvious i.e. these =
services could<o:p></o:p></p><p class=3DMsoNormal>Interfere with each =
other, are there any reasons why this approach would not be considered a =
suitable initial approach to seLinux development, with continued =
<o:p></o:p></p><p class=3DMsoNormal>Evolution, adding contexts for =
further refinement of control over time? Are there best practice guides =
to filesystem labeling that considers the complexity that =
can<o:p></o:p></p><p class=3DMsoNormal>Come from excessive =
labeling?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks.<o:p></o:p></p><p =
class=3DMsoNormal>Ger.<o:p></o:p></p></div></body></html>
------_=_NextPart_001_01CBBD85.2266D0F5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
