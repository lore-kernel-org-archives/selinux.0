Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA42sIU0018082
 for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2014 21:54:18 -0500
From: <Josh_Pennell@dell.com>
To: <selinux@tycho.nsa.gov>
Date: Mon, 3 Nov 2014 20:54:08 -0600
Subject: squashfs files showing as unlabeled_t
Message-ID: <83DE8B501DA82042847858927365655402BC59B7E7@AUSX7MCPC102.AMER.DELL.COM>
Content-Type: multipart/alternative;
 boundary="_000_83DE8B501DA82042847858927365655402BC59B7E7AUSX7MCPC102A_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_83DE8B501DA82042847858927365655402BC59B7E7AUSX7MCPC102A_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm working on a project using a selinux reference policy on an embedded sy=
stem.  The device uses a squashfs file system that is labeled during build =
time.  During the build, policy file labels are applied using Pseudo and se=
tfiles with an alternate root path specified.

Using a Fedora system it is possible to mount the squashfs file and confirm=
 the file labels are correct.  When checked on target system the squashfs f=
iles are incorrect, but ram disk files are correct.  All squashfs files are=
 system_u:object_r:unlabeled_t

The kernel .config values for squsahfs and selinux here here

CONFIG_SQUASHFS=3Dy
CONFIG_SQUASHFS_XATTR=3Dy
CONFIG_SQUASHFS_ZLIB=3Dy
CONFIG_SQUASHFS_LZO=3Dy
CONFIG_SQUASHFS_XZ=3Dy
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=3Dy
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D10

CONFIG_SECURITY_SELINUX=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=3D1
CONFIG_SECURITY_SELINUX_DISABLE=3Dy
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX=3Dn
# CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set

Has anyone else run into this problem?  Any suggestions on what may be wron=
g?

Regards,
josh


--_000_83DE8B501DA82042847858927365655402BC59B7E7AUSX7MCPC102A_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 15 (filtered medium)"><style><!--
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
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:105%;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3D"#0563C1=
" vlink=3D"#954F72"><div class=3DWordSection1><p class=3DMsoNormal style=3D=
'margin-bottom:0in;margin-bottom:.0001pt'>Hello,<o:p></o:p></p><p class=3DM=
soNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'><o:p>&nbsp;</o:p=
></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'=
>I&#8217;m working on a project using a selinux reference policy on an embe=
dded system.&nbsp; The device uses a squashfs file system that is labeled d=
uring build time.&nbsp; During the build, policy file labels are applied us=
ing Pseudo and setfiles with an alternate root path specified.&nbsp; <o:p><=
/o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.000=
1pt'><o:p>&nbsp;</o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;m=
argin-bottom:.0001pt'>Using a Fedora system it is possible to mount the squ=
ashfs file and confirm the file labels are correct.&nbsp; When checked on t=
arget system the squashfs files are incorrect, but ram disk files are corre=
ct.&nbsp; All squashfs files are system_u:object_r:unlabeled_t<o:p></o:p></=
p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'><o=
:p>&nbsp;</o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-b=
ottom:.0001pt'>The kernel .config values for squsahfs and selinux here here=
<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-botto=
m:.0001pt'><o:p>&nbsp;</o:p></p><p class=3DMsoNormal style=3D'margin-bottom=
:0in;margin-bottom:.0001pt'>CONFIG_SQUASHFS=3Dy<o:p></o:p></p><p class=3DMs=
oNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'>CONFIG_SQUASHFS_X=
ATTR=3Dy<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;marg=
in-bottom:.0001pt'>CONFIG_SQUASHFS_ZLIB=3Dy<o:p></o:p></p><p class=3DMsoNor=
mal style=3D'margin-bottom:0in;margin-bottom:.0001pt'>CONFIG_SQUASHFS_LZO=
=3Dy<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-b=
ottom:.0001pt'>CONFIG_SQUASHFS_XZ=3Dy<o:p></o:p></p><p class=3DMsoNormal st=
yle=3D'margin-bottom:0in;margin-bottom:.0001pt'># CONFIG_SQUASHFS_4K_DEVBLK=
_SIZE is not set<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:=
0in;margin-bottom:.0001pt'>CONFIG_SQUASHFS_EMBEDDED=3Dy<o:p></o:p></p><p cl=
ass=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'>CONFIG_SQ=
UASHFS_FRAGMENT_CACHE_SIZE=3D10 <o:p></o:p></p><p class=3DMsoNormal style=
=3D'margin-bottom:0in;margin-bottom:.0001pt'><o:p>&nbsp;</o:p></p><p class=
=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'>CONFIG_SECUR=
ITY_SELINUX=3Dy<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0=
in;margin-bottom:.0001pt'>CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy<o:p></o:p><=
/p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'>C=
ONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=3D1<o:p></o:p></p><p class=3DMsoNorm=
al style=3D'margin-bottom:0in;margin-bottom:.0001pt'>CONFIG_SECURITY_SELINU=
X_DISABLE=3Dy<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in=
;margin-bottom:.0001pt'>CONFIG_SECURITY_SELINUX_DEVELOP=3Dy<o:p></o:p></p><=
p class=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'>CONFI=
G_SECURITY_SELINUX_AVC_STATS=3Dy<o:p></o:p></p><p class=3DMsoNormal style=
=3D'margin-bottom:0in;margin-bottom:.0001pt'>CONFIG_SECURITY_SELINUX_CHECKR=
EQPROT_VALUE=3D1<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:=
0in;margin-bottom:.0001pt'>CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX=3Dn=
<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-botto=
m:.0001pt'># CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set<o:p></=
o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001=
pt'><o:p>&nbsp;</o:p></p><p class=3DMsoNormal style=3D'margin-bottom:0in;ma=
rgin-bottom:.0001pt'>Has anyone else run into this problem?&nbsp; Any sugge=
stions on what may be wrong? <o:p></o:p></p><p class=3DMsoNormal style=3D'm=
argin-bottom:0in;margin-bottom:.0001pt'><o:p>&nbsp;</o:p></p><p class=3DMso=
Normal style=3D'margin-bottom:0in;margin-bottom:.0001pt'>Regards,<o:p></o:p=
></p><p class=3DMsoNormal style=3D'margin-bottom:0in;margin-bottom:.0001pt'=
>josh<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body>=
</html>=

--_000_83DE8B501DA82042847858927365655402BC59B7E7AUSX7MCPC102A_--
