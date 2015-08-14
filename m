Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7E6j6hO017867
 for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2015 02:45:06 -0400
Message-ID: <BLU436-SMTP8926E1E94C430CC9C28B0F9D7C0@phx.gbl>
From: rowan <rowanPang_selinux@hotmail.com>
To: <selinux@tycho.nsa.gov>
References: 
In-Reply-To: 
Subject: selinux mls/mcs rang modify
Date: Fri, 14 Aug 2015 14:45:05 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0121_01D0D69F.D1CC36B0"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

------=_NextPart_000_0121_01D0D69F.D1CC36B0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear all,

         When do test, I use semanage change the mls/mcs range of selinux
user 'system_u' from 's0-s0:c0.c1023' to 's0-s0:c0.c1020',cmd as bleow

                   'semanage user -m -r s0-s0:c0.c1020 system_u'

 

How do I change it back?

 

Thanks

rowan


------=_NextPart_000_0121_01D0D69F.D1CC36B0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN =
link=3D"#0563C1" vlink=3D"#954F72" =
style=3D'text-justify-trim:punctuation'><div class=3DWordSection1><p =
class=3DMsoNormal><span lang=3DEN-US>Dear all,<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When do =
test, I use semanage change the mls/mcs range of selinux user =
&#8216;system_u&#8217; from &#8216;s0-s0:c0.c1023&#8217; to =
&#8216;s0-s0:c0.c1020&#8217;,cmd as bleow<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#8216;semanage user -m =
-r s0-s0:c0.c1020 system_u&#8217;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-indent:21.0pt'><span lang=3DEN-US>How do =
I change it back?<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Thanks<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>rowan<o:p></o:p></span></p></div></body></html>
------=_NextPart_000_0121_01D0D69F.D1CC36B0--
