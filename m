Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s753fYQE025517
 for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2014 23:41:34 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.14.5/8.14.5) with SMTP id s753fdcF009404
 for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2014 20:41:39 -0700
Received: from sc-owa01.marvell.com ([199.233.58.136])
 by mx0b-0016f401.pphosted.com with ESMTP id 1njg2h186k-1
 (version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
 for <selinux@tycho.nsa.gov>; Mon, 04 Aug 2014 20:41:39 -0700
From: Zhi Xin <xinzhi@marvell.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Mon, 4 Aug 2014 20:41:36 -0700
Subject: confusing policy in unconfineddomain.te SEAndroid kk4.4
Message-ID: <F766E4F80769BD478052FB6533FA745D5944BD49F8@SC-VEXCH4.marvell.com>
Content-Type: multipart/alternative;
 boundary="_000_F766E4F80769BD478052FB6533FA745D5944BD49F8SCVEXCH4marve_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_F766E4F80769BD478052FB6533FA745D5944BD49F8SCVEXCH4marve_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Recently, I'm working on SEAndroid for kk4.4.  I found that some policy are=
 confused in sepolicy/unconfineddomain.te.

allow unconfineddomain domain:fd *;

allow unconfineddomain domain:dir r_dir_perms;

allow unconfineddomain domain:lnk_file r_file_perms;

allow unconfineddomain domain:{ fifo_file file } rw_file_perms;



I know sometimes object can be a domain. But when object is domain, should =
class be process ? In the examples above, the class are dir, lnk_file and f=
ile. How can this happen ? Does anyone know any scenario fit these situatio=
ns ?

Thanks.
Sincerely
Alan Xin



--_000_F766E4F80769BD478052FB6533FA745D5944BD49F8SCVEXCH4marve_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
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
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:SimSun;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN link=3Dblue vli=
nk=3Dpurple style=3D'text-justify-trim:punctuation'><div class=3DWordSectio=
n1><p><span lang=3DEN-US>Hi, <o:p></o:p></span></p><p><span lang=3DEN-US st=
yle=3D'font-family:"Times New Roman","serif"'>Recently, I&#8217;m working o=
n SEAndroid for kk4.4. &nbsp;I found that some policy are confused in sepol=
icy/unconfineddomain.te. <o:p></o:p></span></p><p><span lang=3DEN-US style=
=3D'font-family:"Times New Roman","serif"'>allow unconfineddomain <b>domain=
</b>:fd *;<o:p></o:p></span></p><p><span lang=3DEN-US style=3D'font-family:=
"Times New Roman","serif"'>allow unconfineddomain <b>domain</b>:dir r_dir_p=
erms;<o:p></o:p></span></p><p><span lang=3DEN-US style=3D'font-family:"Time=
s New Roman","serif"'>allow unconfineddomain <b>domain</b>:lnk_file r_file_=
perms;<o:p></o:p></span></p><p><span lang=3DEN-US style=3D'font-family:"Tim=
es New Roman","serif"'>allow unconfineddomain <b>domain</b>:{ fifo_file fil=
e } rw_file_perms;<o:p></o:p></span></p><p><span lang=3DEN-US style=3D'font=
-family:"Times New Roman","serif"'>&nbsp;<o:p></o:p></span></p><p><span lan=
g=3DEN-US style=3D'font-family:"Times New Roman","serif"'>I know sometimes =
<b>object</b> can be a <b>domain</b>. But when <b>object</b> is <b>domain</=
b>, should<b> class</b> be <b>process</b> ? In the examples above, the clas=
s are <b>dir</b>, <b>lnk_file</b> and<b> file. How can this happen ? Does a=
nyone know any scenario fit these situations ? </b><o:p></o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>Thanks.<o:p></o:p></span></p><p class=3DMso=
Normal><span lang=3DEN-US>Sincerely<o:p></o:p></span></p><p class=3DMsoNorm=
al><span lang=3DEN-US>Alan Xin<o:p></o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lan=
g=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_000_F766E4F80769BD478052FB6533FA745D5944BD49F8SCVEXCH4marve_--
