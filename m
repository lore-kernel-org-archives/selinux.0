From: "Chengfei (Fixed Network R&D Mgmt Dept)" <chengfei999@huawei.com>
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
CC: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: Does selinuxfs support ACL?
Date: Thu, 11 Sep 2014 03:21:51 +0000
Message-ID: <C4B033C531077E4AA42DB0AE4AE06B581C5A3BEC@szxeml511-mbx.china.huawei.com>
Content-Type: multipart/alternative;
 boundary="_000_C4B033C531077E4AA42DB0AE4AE06B581C5A3BECszxeml511mbxchi_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_C4B033C531077E4AA42DB0AE4AE06B581C5A3BECszxeml511mbxchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone,
Recently, I want to make other user use some selinux commands( i.e. setenfo=
rce)without using sudo.But , I find the file that /selinux/enforce 's dac-l=
ist is -rw-r- -r- - root root which means only root(or set-user-id-root) ca=
n use "setenforce 0".So I started to think about apply acl on /selinux/**.
I used acl like this:
Mount -t selinuxfs -o remount,acl,rw none /selinux;
Cat /etc/mtab | grep selinux;//result:seccuss
So,then:
Setfacl -m u:newuser:rw /selinux/enforce;//result:failed
I want to figure out where failed, thanks!:)

--_000_C4B033C531077E4AA42DB0AE4AE06B581C5A3BECszxeml511mbxchi_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
/* Page Definitions */
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello everyone, <o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Re=
cently, I want to make other user use some selinux commands( i.e. setenforc=
e)without using sudo.But , I find the file that /selinux/enforce &#8216;s d=
ac-list is &#8211;rw-r- -r- - root root which means
 only root(or set-user-id-root) can use &#8220;setenforce 0&#8221;.So I sta=
rted to think about apply acl on /selinux/**.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">I =
used acl like this:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Mo=
unt &#8211;t selinuxfs &#8211;o remount,acl,rw none /selinux;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Ca=
t /etc/mtab | grep selinux;//result:seccuss<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">So=
,then:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Se=
tfacl &#8211;m u:newuser:rw /selinux/enforce;//result:failed<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">I =
want to figure out where failed, thanks!:)<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_C4B033C531077E4AA42DB0AE4AE06B581C5A3BECszxeml511mbxchi_--
