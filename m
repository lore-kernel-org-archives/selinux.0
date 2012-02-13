Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1DF4ifS011903
	for <selinux@tycho.nsa.gov>; Mon, 13 Feb 2012 10:04:44 -0500
Received: from TX2EHSOBE002.bigfish.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q1DF4g1P011585
	for <selinux@tycho.nsa.gov>; Mon, 13 Feb 2012 15:04:43 GMT
Received: from mail98-tx2 (localhost [127.0.0.1])	by mail98-tx2-R.bigfish.com
 (Postfix) with ESMTP id 10DE6420152	for <selinux@tycho.nsa.gov>; Mon, 13 Feb
 2012 15:04:40 +0000 (UTC)
Received: from TX2EHSMHS036.bigfish.com (unknown [10.9.14.237])	by
 mail98-tx2.bigfish.com (Postfix) with ESMTP id 5E634200049	for
 <selinux@tycho.nsa.gov>; Mon, 13 Feb 2012 15:04:37 +0000 (UTC)
From: Julian Onions <Julian.Onions@nexor.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Building multiple custom modules
Date: Mon, 13 Feb 2012 15:04:27 +0000
Message-ID: <36039C79EF8CEC4EA97F96D6B85706420C76E3B1@AMSPRD0302MB107.eurprd03.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_36039C79EF8CEC4EA97F96D6B85706420C76E3B1AMSPRD0302MB107_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_36039C79EF8CEC4EA97F96D6B85706420C76E3B1AMSPRD0302MB107_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm working on a policy for an application made of several modules. I'd rea=
lly like the policy to use the other modules interface files.

The standard Makefile for policy building (/usr/share/selinux/devel/Makefil=
e) doesn't seem to let you include your own .if files, unless they are unde=
r /usr/share/selinux/devel/include or alternatively in the current director=
y (in which case it needs .te files too).

Is there any way to convince it I'd like files that I'm building in project=
/C/policy to reference the .if files in project/B/policy and project/A/poli=
cy without copying them all to project/C/policy?

Thanks,
Julian


--_000_36039C79EF8CEC4EA97F96D6B85706420C76E3B1AMSPRD0302MB107_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I&#8217;m working on a policy for an application mad=
e of several modules. I&#8217;d really like the policy to use the other mod=
ules interface files.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The standard Makefile for policy building (/usr/shar=
e/selinux/devel/Makefile) doesn&#8217;t seem to let you include your own .i=
f files, unless they are under /usr/share/selinux/devel/include or alternat=
ively in the current directory (in which
 case it needs .te files too). <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is there any way to convince it I&#8217;d like files=
 that I&#8217;m building in project/C/policy to reference the .if files in =
project/B/policy and project/A/policy without copying them all to project/C=
/policy?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Julian<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_36039C79EF8CEC4EA97F96D6B85706420C76E3B1AMSPRD0302MB107_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
