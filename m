Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3NLEEnj010547
 for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2015 17:14:14 -0400
From: "Spector, Aaron" <Aaron_Spector@mcafee.com>
To: "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Switching to enforcing mode introduces new policy issues?
Date: Thu, 23 Apr 2015 21:14:07 +0000
Message-ID: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
Content-Type: multipart/alternative;
 boundary="_000_363d72e72db54ed2a93f39f76d1811fdMIVEXUSR1N01corpzoneint_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_363d72e72db54ed2a93f39f76d1811fdMIVEXUSR1N01corpzoneint_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I've been working on writing my first policy for SELinux and I've hit a bit=
 of a snag. I've gotten the policy clean in permissive mode, but when I swa=
p the system over to enforcing, a whole new set of policy issues crop up. E=
verything I've read says this isn't to be expected so I'm a bit confused as=
 to what's happening. Output from sestatus when in permissive mode is:

SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             default
Current mode:                   permissive
Mode from config file:          permissive
Policy MLS status:              enabled
Policy deny_unknown status:     denied
Max kernel policy version:      29

I'm running a version 26 policy and a 3.16.7 kernel.

It seems like the majority of the new deny audits are about the need for se=
arch permissions on directories between types that already have what I beli=
eve are the necessary file permissions.

So far what I've had to do to get around it is to add to my policy, but tha=
t doesn't seem like that should be necessary. If the audit is clean in perm=
issive mode, why isn't it clean in enforcing?

Is it possible that I'm missing policy deny audits when it's in permissive =
mode?


Thanks,

-Aaron


--_000_363d72e72db54ed2a93f39f76d1811fdMIVEXUSR1N01corpzoneint_
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve been working on writing my first policy f=
or SELinux and I&#8217;ve hit a bit of a snag. I&#8217;ve gotten the policy=
 clean in permissive mode, but when I swap the system over to enforcing, a =
whole new set of policy issues crop up. Everything I&#8217;ve
 read says this isn&#8217;t to be expected so I&#8217;m a bit confused as t=
o what&#8217;s happening. Output from sestatus when in permissive mode is:<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">SELinux status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabled<o:p></o=
:p></p>
<p class=3D"MsoNormal">SELinuxfs mount:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sys/fs/selinux<o:p>=
</o:p></p>
<p class=3D"MsoNormal">SELinux root directory:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /etc/selinux<o:p></o:p></p>
<p class=3D"MsoNormal">Loaded policy name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default<o:p></o:p></p>
<p class=3D"MsoNormal">Current mode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; permi=
ssive<o:p></o:p></p>
<p class=3D"MsoNormal">Mode from config file:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; permissive<o:p></o:p></p>
<p class=3D"MsoNormal">Policy MLS status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabled<o:p></o:p></p>
<p class=3D"MsoNormal">Policy deny_unknown status:&nbsp;&nbsp;&nbsp;&nbsp; =
denied<o:p></o:p></p>
<p class=3D"MsoNormal">Max kernel policy version:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 29<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m running a version 26 policy and a 3.16.7 k=
ernel.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It seems like the majority of the new deny audits ar=
e about the need for search permissions on directories between types that a=
lready have what I believe are the necessary file permissions.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So far what I&#8217;ve had to do to get around it is=
 to add to my policy, but that doesn&#8217;t seem like that should be neces=
sary. If the audit is clean in permissive mode, why isn&#8217;t it clean in=
 enforcing?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is it possible that I&#8217;m missing policy deny au=
dits when it&#8217;s in permissive mode?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Aaron<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_363d72e72db54ed2a93f39f76d1811fdMIVEXUSR1N01corpzoneint_--
