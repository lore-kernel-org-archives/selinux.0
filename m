Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBEI0NUn011953
 for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2016 13:00:26 -0500
From: "Parker, Michael D." <Michael.D.Parker@ga.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: -EXT-Re: Possible SELinux problem on Fedora 25 Install
Date: Wed, 14 Dec 2016 18:00:04 +0000
Message-ID: <3407351bee4745a5a3c4a54525317e92@ASGEXCPWP01.ga.com>
References: <fc9b755857cd4bffa582fcac7ea2e574@ASGEXCPWP01.ga.com>
 <fc879540-0a81-573e-4def-085079ad9528@redhat.com>
In-Reply-To: <fc879540-0a81-573e-4def-085079ad9528@redhat.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=SHA1; boundary="----=_NextPart_000_0006_01D255F0.CD6D4C90"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

------=_NextPart_000_0006_01D255F0.CD6D4C90
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0007_01D255F0.CD6D4C90"


------=_NextPart_001_0007_01D255F0.CD6D4C90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks..ok, the package has not been currently released in the standard
repos, so where should I obtain it?

 

I also note that I seem to have docker-selinux installed..remove ok?
Probably due to the residual F24-->F25 upgrade process.

 

***** ***** *****

Michael D. Parker

General Atomics - ElectroMagnetics Systems Division (EMS)

Michael.d.parker@ga.com <mailto:Michael.d.parker@ga.com>   <<<<< NOTE:
Remember to include my middle initial >>>>>

+1 858 964 6675 / Office 86-1319 / Cell +1 858 376 7474

16969 Mesamint Street / San Diego / CA / 92127

 

From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
Sent: Wednesday, December 14, 2016 5:13 AM
To: Parker, Michael D. <Michael.D.Parker@ga.com>; selinux@tycho.nsa.gov
Subject: -EXT-Re: Possible SELinux problem on Fedora 25 Install

 

This should be fixed by updating to the latest container-selinux package.

container-selinux-1.12.4-5.git1b5971a.fc25.noarch.rpm

Then  you can 

dnf reinstall selinux-policy

 

ls 

On 12/13/2016 02:55 PM, Parker, Michael D. wrote:

I am getting the following messages during the last update concerning
SELinux packages...I do a pretty much vanilla install here and have not
modified any SELinux functionality...should I be concerned?

 

  Upgrading   : selinux-policy-3.13.1-225.3.fc25.noarch
1/38

Re-declaration of boolean virt_sandbox_use_fusefs

Failed to create node

Bad boolean declaration at
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152

semodule:  Failed!

  Upgrading   : samba-common-2:4.5.2-0.fc25.noarch
2/38

  Upgrading   : libwbclient-2:4.5.2-0.fc25.x86_64
3/38

  Upgrading   : samba-client-libs-2:4.5.2-0.fc25.x86_64
4/38

  Installing  : kernel-core-4.8.13-300.fc25.x86_64
5/38

  Installing  : kernel-modules-4.8.13-300.fc25.x86_64
6/38

  Upgrading   : selinux-policy-targeted-3.13.1-225.3.fc25.noarch
7/38

Re-declaration of boolean virt_sandbox_use_fusefs

Failed to create node

Bad boolean declaration at
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152

/usr/sbin/semodule:  Failed!

  Upgrading   : pcsc-lite-libs-1.8.19-1.fc25.x86_64
8/38

  Upgrading   : pcsc-lite-1.8.19-1.fc25.x86_64
9/38

  Upgrading   : selinux-policy-sandbox-3.13.1-225.3.fc25.noarch
10/38

Re-declaration of boolean virt_sandbox_use_fusefs

Failed to create node

Bad boolean declaration at
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152

semodule:  Failed!

  Installing  : kernel-4.8.13-300.fc25.x86_64
11/38

  Upgrading   : libsmbclient-2:4.5.2-0.fc25.x86_64
12/38

  Upgrading   : selinux-policy-mls-3.13.1-225.3.fc25.noarch
13/38

  Upgrading   : selinux-policy-minimum-3.13.1-225.3.fc25.noarch
14/38

Failed to resolve typeattributeset statement at
/var/lib/selinux/minimum/tmp/modules/100/xserver/cil:472

/usr/sbin/semodule:  Failed!

 

***** ***** *****

Michael D. Parker

General Atomics - ElectroMagnetics Systems Division (EMS)

Michael.d.parker@ga.com <mailto:Michael.d.parker@ga.com>   <<<<< NOTE:
Remember to include my middle initial >>>>>

+1 858 964 6675 / Office 86-1319 / Cell +1 858 376 7474

16969 Mesamint Street / San Diego / CA / 92127

 






_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov> 
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
<mailto:Selinux-leave@tycho.nsa.gov> .
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov> .

 


------=_NextPart_001_0007_01D255F0.CD6D4C90
Content-Type: text/html;
	charset="us-ascii"
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
@font-face
	{font-family:"Courier New \;color\:red";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New",serif;
	color:black;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
</o:shapelayout></xml><![endif]--></head><body bgcolor=3Dwhite =
lang=3DEN-US link=3D"#0563C1" vlink=3D"#954F72"><div =
class=3DWordSection1><p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Thanks&#8230;.ok, the package has not been =
currently released in the standard repos, so where should I obtain =
it?<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span style=3D'color:#1F497D'>I also note that I seem =
to have docker-selinux installed&#8230;.remove ok? Probably due to the =
residual F24</span><span =
style=3D'font-family:Wingdings;color:#1F497D'>&agrave;</span><span =
style=3D'color:#1F497D'>F25 upgrade process.<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><div><p =
class=3DMsoNormal><span style=3D'font-family:"Comic Sans =
MS",serif;color:#1F497D'>***** ***** *****<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-family:"Comic Sans =
MS",serif;color:#1F497D'>Michael D. Parker<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-family:"Comic Sans =
MS",serif;color:#1F497D'>General Atomics &#8211; ElectroMagnetics =
Systems Division (EMS)<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS",serif;color:#1F497D'><a =
href=3D"mailto:Michael.d.parker@ga.com">Michael.d.parker@ga.com</a>&nbsp;=
 <b>&lt;&lt;&lt;&lt;&lt; NOTE: Remember to include my middle initial =
&gt;&gt;&gt;&gt;&gt;<o:p></o:p></b></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS",serif;color:#1F497D'>+1 858 964 =
6675 / Office 86-1319 / Cell +1 858 376 7474<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-family:"Comic Sans =
MS",serif;color:#1F497D'>16969 Mesamint Street / San Diego / CA / =
92127<o:p></o:p></span></p></div><p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><div><div =
style=3D'border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in'><p class=3DMsoNormal><b><span =
style=3D'color:windowtext'>From:</span></b><span =
style=3D'color:windowtext'> Daniel J Walsh [mailto:dwalsh@redhat.com] =
<br><b>Sent:</b> Wednesday, December 14, 2016 5:13 AM<br><b>To:</b> =
Parker, Michael D. &lt;Michael.D.Parker@ga.com&gt;; =
selinux@tycho.nsa.gov<br><b>Subject:</b> -EXT-Re: Possible SELinux =
problem on Fedora 25 Install<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p>This should be fixed by =
updating to the latest container-selinux package.<span =
style=3D'font-size:12.0pt'><o:p></o:p></span></p><p>container-selinux-1.1=
2.4-5.git1b5971a.fc25.noarch.rpm<o:p></o:p></p><p>Then&nbsp; you can =
<o:p></o:p></p><p>dnf reinstall =
selinux-policy<o:p></o:p></p><p><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>ls <o:p></o:p></p><div><p class=3DMsoNormal>On =
12/13/2016 02:55 PM, Parker, Michael D. =
wrote:<o:p></o:p></p></div><blockquote =
style=3D'margin-top:5.0pt;margin-bottom:5.0pt'><p class=3DMsoNormal>I am =
getting the following messages during the last update concerning SELinux =
packages&#8230;..I do a pretty much vanilla install here and have not =
modified any SELinux functionality&#8230;..should I be =
concerned?<o:p></o:p></p><p class=3DMsoNormal>&nbsp;<o:p></o:p></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>&nbsp; Upgrading&nbsp;&nbsp; : =
selinux-policy-3.13.1-225.3.fc25.noarch&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1/38</span></b><o:=
p></o:p></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New ;color:red",serif'>Re-declaration of boolean =
virt_sandbox_use_fusefs</span></b><o:p></o:p></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>Failed to create node</span></b><o:p></o:p></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>Bad boolean declaration at =
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152</span></b><o:p></o=
:p></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>semodule:&nbsp; Failed!</span></b><o:p></o:p></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New",serif'>&nbsp; =
Upgrading&nbsp;&nbsp; : =
samba-common-2:4.5.2-0.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2/38</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; Upgrading&nbsp;&nbsp; : =
libwbclient-2:4.5.2-0.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3/38</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; Upgrading&nbsp;&nbsp; : =
samba-client-libs-2:4.5.2-0.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4/38</span><o:p></o:p></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New",serif'>&nbsp; =
Installing&nbsp; : =
kernel-core-4.8.13-300.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;5/38</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; Installing&nbsp; : =
kernel-modules-4.8.13-300.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6/38</span><o:p></o:p></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New",serif'>&nbsp; =
</span><b><span style=3D'font-family:"Courier =
New",serif;color:red'>Upgrading&nbsp;&nbsp; : =
selinux-policy-targeted-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7/38</s=
pan></b><o:p></o:p></p><p class=3DMsoNormal><b><span =
style=3D'font-family:"Courier New ;color:red",serif'>Re-declaration of =
boolean virt_sandbox_use_fusefs</span></b><o:p></o:p></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>Failed to create node</span></b><o:p></o:p></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>Bad boolean declaration at =
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152</span></b><o:p></o=
:p></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>/usr/sbin/semodule:&nbsp; =
Failed!</span></b><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; Upgrading&nbsp;&nbsp; : =
pcsc-lite-libs-1.8.19-1.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8/38</span><o:p></=
o:p></p><p class=3DMsoNormal><span style=3D'font-family:"Courier =
New",serif'>&nbsp; Upgrading&nbsp;&nbsp; : =
pcsc-lite-1.8.19-1.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9/38</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; </span><b><span =
style=3D'font-family:"Courier =
New",serif;color:red'>Upgrading&nbsp;&nbsp; : =
selinux-policy-sandbox-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10/38</span></b><o:p></o:p></p><p class=3DMsoNormal><b><span =
style=3D'font-family:"Courier New ;color:red",serif'>Re-declaration of =
boolean virt_sandbox_use_fusefs</span></b><o:p></o:p></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>Failed to create node</span></b><o:p></o:p></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>Bad boolean declaration at =
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152</span></b><o:p></o=
:p></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>semodule:&nbsp; Failed!</span></b><o:p></o:p></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New",serif'>&nbsp; =
Installing&nbsp; : =
kernel-4.8.13-300.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11/38</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; Upgrading&nbsp;&nbsp; : =
libsmbclient-2:4.5.2-0.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;12/38</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; Upgrading&nbsp;&nbsp; : =
selinux-policy-mls-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 13/38</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New",serif'>&nbsp; </span><b><span =
style=3D'font-family:"Courier =
New",serif;color:red'>Upgrading&nbsp;&nbsp; : =
selinux-policy-minimum-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;14/38</span><=
/b><o:p></o:p></p><p class=3DMsoNormal><b><span =
style=3D'font-family:"Courier New ;color:red",serif'>Failed to resolve =
typeattributeset statement at =
/var/lib/selinux/minimum/tmp/modules/100/xserver/cil:472</span></b><o:p><=
/o:p></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier New =
;color:red",serif'>/usr/sbin/semodule:&nbsp; =
Failed!</span></b><o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;<o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS",serif'>***** ***** =
*****</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS",serif'>Michael D. =
Parker</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS",serif'>General Atomics &#8211; =
ElectroMagnetics Systems Division (EMS)</span><o:p></o:p></p><p =
class=3DMsoNormal><span style=3D'font-family:"Comic Sans MS",serif'><a =
href=3D"mailto:Michael.d.parker@ga.com">Michael.d.parker@ga.com</a>&nbsp;=
 <b>&lt;&lt;&lt;&lt;&lt; NOTE: Remember to include my middle initial =
&gt;&gt;&gt;&gt;&gt;</b></span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS",serif'>+1 858 964 6675 / Office =
86-1319 / Cell +1 858 376 7474</span><o:p></o:p></p><p =
class=3DMsoNormal><span style=3D'font-family:"Comic Sans =
MS",serif'>16969 Mesamint Street / San Diego / CA / =
92127</span><o:p></o:p></p><p class=3DMsoNormal>&nbsp;<o:p></o:p></p><p =
class=3DMsoNormal><span style=3D'font-size:12.0pt;font-family:"Times New =
Roman",serif'><br><br><br><o:p></o:p></span></p><pre>____________________=
___________________________<o:p></o:p></pre><pre>Selinux mailing =
list<o:p></o:p></pre><pre><a =
href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><o:p></o:p=
></pre><pre>To unsubscribe, send email to <a =
href=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</=
a>.<o:p></o:p></pre><pre>To get help, send an email containing =
&quot;help&quot; to <a =
href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.g=
ov</a>.<o:p></o:p></pre></blockquote><p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Times New =
Roman",serif'><o:p>&nbsp;</o:p></span></p></div></body></html>
------=_NextPart_001_0007_01D255F0.CD6D4C90--

------=_NextPart_000_0006_01D255F0.CD6D4C90
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
BgNVHQ8BAf8EBAMCAYYwMwYDVR0gBCwwKjAMBgpghkgBZQMCAQwBMAwGCmCGSAFlAwIBDAIwDAYK
YIZIAWUDAgEMAzA3BgNVHR8EMDAuMCygKqAohiZodHRwOi8vY3JsLmRpc2EubWlsL2NybC9FQ0FS
T09UQ0EyLmNybDBKBggrBgEFBQcBAQQ+MDwwOgYIKwYBBQUHMAKGLmh0dHA6Ly9jcmwuZGlzYS5t
aWwvaXNzdWVkdG8vRUNBUk9PVENBMl9JVC5wN2MwDQYJKoZIhvcNAQEFBQADggEBAI9Ho4myU/iZ
8M5D1SSTqT6L5q6E82psbYq7sXkaJ8pUFsknMMyD2kKM/95AUd7OsnKdy3d0MwpHzlfalsg0Epl+
b6TiS5wo0TzFrzme4ykM0Ar4l05YhFTPqYlQh8Wqjo8pj+B4P/N1er/P30jLvEoSTpy3MGC1jH+H
2mcVxanP5ELYYjvA1uNC3SGOFQlTSH0muW+siKRiUCD6CPs5SuSOtnb7CzC/0Y1KLMvIVzg6ZFwM
mq+frelswrB5HeMD56S+uXj7geBJZqLRL+GvNQK5i1SJxzbWyIxkMJ34vq1eVJe8b43XXaBc9i7K
D0YDgZZCTyE4MsgM2SHv+6DgeNUwggWTMIIEe6ADAgECAhAWIsbEzwDpQl5YvBPjUdY2MA0GCSqG
SIb3DQEBBQUAMIGZMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYD
VQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxPjA8BgNVBAMTNVN5
bWFudGVjIENsaWVudCBFeHRlcm5hbCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEc0MB4XDTE2
MDgxOTAwMDAwMFoXDTE3MDgxOTIzNTk1OVowgZwxCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMu
IEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEXMBUGA1UECxMOVmVyaVNpZ24sIEluYy4xMzAxBgNV
BAsMKkdlbmVyYWwgQXRvbWljcyBBZXJvbmF1dGljYWwgU3lzdGVtcywgSW5jLjEXMBUGA1UEAxMO
TWljaGFlbCBQYXJrZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDb3P2KxIhjh6BY
1mRqBAdQ+89fvi1S9W6DZfJMm21ResbQj4w6R62yQHjnECqEczPsKPRnD/I03ZGcty7gV2p+ocrq
vDp02xoB9maLMuee4bVRXRY8pKBQzfZgoHP4B0bxyUHiMVoYVP3cBln9Tshawj7TvKbZLCHJpL4P
uhm36Gdeg0YTpeyhqo86bgJbYRl34JgYEhZnFIn7SmnytHz2Av5W82jdWXPYdtr9s1oWD7Hjk0ru
QEBgIMAU2rZs0qPk2UHda51OPSB74m09spmD1dyfG4LgaebbgRsf+Vikhq6TJLk3tv7MkYdG3XUt
AXqQEvd4Qdqi+pbp1RUA0RZ7AgMBAAGjggHQMIIBzDBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8v
ZWNhLWNsaWVudC1jcmwucGtpLnN5bWFudGVjLmNvbS9WZXJpU2lnbkVDQTIwNDgvTGF0ZXN0Q1JM
LUczLmNybDAOBgNVHQ8BAf8EBAMCBSAwHQYDVR0OBBYEFC07Rciu63Q/P0GRmc0/o7tqtj9tMB8G
A1UdIwQYMBaAFABH8CX1LA3ckyaqAJi/9JU0hVDbMCIGA1UdEQQbMBmBF21pY2hhZWwuZC5wYXJr
ZXJAZ2EuY29tMIGKBggrBgEFBQcBAQR+MHwwRQYIKwYBBQUHMAKGOWh0dHA6Ly9lY2EyMDQ4LnBr
aS5zeW1hbnRlYy5jb20vQ0EvU3ltYW50ZWNFQ0EyMDQ4LUc0LmNlcjAzBggrBgEFBQcwAYYnaHR0
cDovL2VjYS1jbGllbnQtb2NzcC5wa2kuc3ltYW50ZWMuY29tMFIGA1UdIARLMEkwRwYKYIZIAWUD
AgEMATA5MDcGCCsGAQUFBwIBFitodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcmVwb3NpdG9yeS9l
Y2EvY3BzMBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEFBQADggEBAHwz
62X738/ANcSum3JpMOcBq3ftAsRUvBmq/+QtbDkdof3IHJXra8/zYOoPa4phWb++dnFRy5+ddm33
nywEiU7ZY4TsHelyCW4m3eBOCqrcJaW5VHEM7TKRXrL3sK+wZ5GgQgl3z3tbkwcasduYW1PiYn89
nx0QeWDORNCrYXnfjGVXirp3Su84Rm3s7UbUkvtlmtKnhS/JcbhDXz1LdlSfaQJVuYypuToLoMZ0
OFFxKa04tRaVsE7n2h/S+kIxPKjQBqKlfva32zORfoXFur9GadckdI08R3PpYA8tJGty9JZ43qMQ
vaOVS8tjk/XYQw4hn1eeS28AlWTRAeYDzgMwggWTMIIEe6ADAgECAhB/HzlbWCgEOoRwielIn/vP
MA0GCSqGSIb3DQEBBQUAMIGZMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50
MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxPjA8BgNV
BAMTNVN5bWFudGVjIENsaWVudCBFeHRlcm5hbCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEc0
MB4XDTE2MDgxOTAwMDAwMFoXDTE3MDgxOTIzNTk1OVowgZwxCzAJBgNVBAYTAlVTMRgwFgYDVQQK
Ew9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEXMBUGA1UECxMOVmVyaVNpZ24sIEluYy4x
MzAxBgNVBAsMKkdlbmVyYWwgQXRvbWljcyBBZXJvbmF1dGljYWwgU3lzdGVtcywgSW5jLjEXMBUG
A1UEAxMOTWljaGFlbCBQYXJrZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCE3uLF
4ip/uQ6Px9UHxF1ibHLrNGeNCrJBvclSxOyU0b3zxx7OlhbmNERNlqOhQOpAJSnIwy6Pk3N3EO2D
6H71R1UKSPzcWPpQZ2rhKvDT8QqRVAXNyKlua0t1GxGFqMzGSEGV/9FqX6LVvva3UccLt88KM4jr
Vpfjo7mRJDVEhmdYEMF5ZSDcbmbAntwJphCEJVmLf/HyvkTYq5kXWHqhZmOcchk5OBg14Jk9kCmm
a+TebY5p2/Xba3w9y4sTES/+LsuAVfdZnGe018Vf2riBSMzf3JFmVrQYY1Nh/oFjcg1LPUpk6vB8
jtbEErlwA+OJbVrxF8qSh2vVI8ysuG2jAgMBAAGjggHQMIIBzDBYBgNVHR8EUTBPME2gS6BJhkdo
dHRwOi8vZWNhLWNsaWVudC1jcmwucGtpLnN5bWFudGVjLmNvbS9WZXJpU2lnbkVDQTIwNDgvTGF0
ZXN0Q1JMLUczLmNybDAOBgNVHQ8BAf8EBAMCBsAwHQYDVR0OBBYEFCZ16reGweqwgJmrZYD3pa7D
E8EyMB8GA1UdIwQYMBaAFABH8CX1LA3ckyaqAJi/9JU0hVDbMCIGA1UdEQQbMBmBF21pY2hhZWwu
ZC5wYXJrZXJAZ2EuY29tMIGKBggrBgEFBQcBAQR+MHwwRQYIKwYBBQUHMAKGOWh0dHA6Ly9lY2Ey
MDQ4LnBraS5zeW1hbnRlYy5jb20vQ0EvU3ltYW50ZWNFQ0EyMDQ4LUc0LmNlcjAzBggrBgEFBQcw
AYYnaHR0cDovL2VjYS1jbGllbnQtb2NzcC5wa2kuc3ltYW50ZWMuY29tMFIGA1UdIARLMEkwRwYK
YIZIAWUDAgEMATA5MDcGCCsGAQUFBwIBFitodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcmVwb3Np
dG9yeS9lY2EvY3BzMBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEFBQAD
ggEBAHemt/RL67yBv1cg3TFkWkP7cC/A2CUwn6FYKYe00QPb83g52PBZIrZg/x21de+Q7GloKscH
TimmJr7ztduw2a5WBWCU7w+w04fdi5C1Hv5tY/dLxuaPPuwDnrhVDNbMjlj5ie5guFnOavu67jpH
3QpMta79pZva9q6sy8GJXRacNgdWwSovbqrFI6eqQilbMUrm04u8f+9ELGINw8SToCboymEHh2CP
MOAUk5gh7ChbXARRBAhwXFQul9zTkELN2o236FxsnSCOb1rAGOjX4v2o8JOSHnUkk9yZ/FdSDls+
kwBsttYjPdh3FEaaK3ZbKqJR+NJ5maprjmBj9C9EiusxggRTMIIETwIBATCBrjCBmTELMAkGA1UE
BhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRUNBMSIwIAYDVQQLExlD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0aWVzMT4wPAYDVQQDEzVTeW1hbnRlYyBDbGllbnQgRXh0ZXJu
YWwgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHNAIQfx85W1goBDqEcInpSJ/7zzAJBgUrDgMC
GgUAoIICeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjEyMTQx
NzU5NDdaMCMGCSqGSIb3DQEJBDEWBBR7XwC28ZnmaVTsrAm0004SQqu21DCBkwYJKoZIhvcNAQkP
MYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATCBvwYJKwYBBAGCNxAEMYGxMIGuMIGZMQswCQYDVQQGEwJV
UzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRp
ZmljYXRpb24gQXV0aG9yaXRpZXMxPjA8BgNVBAMTNVN5bWFudGVjIENsaWVudCBFeHRlcm5hbCBD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEc0AhAWIsbEzwDpQl5YvBPjUdY2MIHBBgsqhkiG9w0B
CRACCzGBsaCBrjCBmTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoG
A1UECxMDRUNBMSIwIAYDVQQLExlDZXJ0aWZpY2F0aW9uIEF1dGhvcml0aWVzMT4wPAYDVQQDEzVT
eW1hbnRlYyBDbGllbnQgRXh0ZXJuYWwgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHNAIQFiLG
xM8A6UJeWLwT41HWNjANBgkqhkiG9w0BAQEFAASCAQAfeQC9N/DkMVPJOUSSRh80WSgEVd5rS53t
FRwIo42SjtRIw5J5IOwZ0mKH/UQjbpTbeYQhH+2oQFkB57husFNQW6g4mzQ5aEuy0WfBG2+I/kqg
c5X5k8ciPBniu8BX4bXS2BzFWdBwSKVIUnUf5vZ/mTfaUpq97fNIsHIus/I6RO58NA0PE0Y4ic2P
HbzyT4SdGO0WzFL9McWJGfy4J0GgSd4NtyHBLgZLt41wqmBsztUPEylQ/3LL7dvJIXfgU5Td8gcE
XcfPnNHB/NIFk27xqmCHiiEovr8gq1RbEhMigpIe1c5NGsiWrOTh25nLRHCrC3BSBtZwidyDC2R1
+/ZZAAAAAAAA

------=_NextPart_000_0006_01D255F0.CD6D4C90--
