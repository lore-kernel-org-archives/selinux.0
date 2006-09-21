Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8L8n8Wx004788
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 04:49:08 -0400
Received: from mga03.intel.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8L8mAJJ020506
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 08:48:10 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DD5A.8632F1E0"
Subject: How to modify and reload policy file
Date: Thu, 21 Sep 2006 16:47:09 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A40176C464@pdsmsx404.ccr.corp.intel.com>
From: "Jin, Yihua" <yihua.jin@intel.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DD5A.8632F1E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I used targeted policy 1.17 in RHEL4U4=20

Modify the domain/unconfined_t, added:

Bool allow_execmem false;

If ( allow_execmem ) {

         Allow domain self :process execmem;

}

Than I type make reload to load this modified policy, but I find exec
memory is still allowed by system.

That is, I check avc_has_perm and it allowed this operation.

=20

I want to know if there is some trick in reconfigure and reload selinux
policy, how it can works.

It's highly appreciated that someone can give an configure and reload
example.

=20

Thanks a lot=20

Best Regards

Jin, Yihua

Tel: 8821 6173

=20


------_=_NextPart_001_01C6DD5A.8632F1E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:&#23435;&#20307;;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@&#23435;&#20307;";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>I used targeted policy 1.17 in RHEL4U4 =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Modify the domain/unconfined_t, =
added:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><b><i><font size=3D1 face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;font-weight:bold;font-style:it=
alic'>Bool
allow_execmem false;<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D1 face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;font-weight:bold;font-style:it=
alic'>If
( allow_execmem ) {<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D1 face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;font-weight:bold;font-style:it=
alic'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Allow
domain self :process execmem;<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><b><i><font size=3D1 face=3DArial><span =
lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Arial;font-weight:bold;font-style:it=
alic'>}<o:p></o:p></span></font></i></b></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Than I type make reload to load this modified =
policy,
but I find exec memory is still allowed by =
system.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>That is, I check avc_has_perm and it allowed =
this
operation.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>I want to know if there is some trick in =
reconfigure and
reload selinux policy, how it can works.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>It&#8217;s highly appreciated that someone can =
give an
configure and reload example.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
9.0pt;font-family:Arial'>Thanks a lot <o:p></o:p></span></font></p>

<p class=3DMsoNormal><em><b><i><font size=3D2 face=3D"Times New =
Roman"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-weight:bold'>Best =
Regards</span></font></i></b></em><span
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><em><b><i><font size=3D2 face=3D"Times New =
Roman"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-weight:bold'>Jin, =
Yihua</span></font></i></b></em><span
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><em><b><i><font size=3D2 face=3D"Times New =
Roman"><span
lang=3DEN-US style=3D'font-size:10.0pt;font-weight:bold'>Tel:&nbsp;8821 =
6173</span></font></i></b></em><span
lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6DD5A.8632F1E0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
