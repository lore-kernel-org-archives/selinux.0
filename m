Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6U9D9F4021923
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 05:13:09 -0400
Received: from smtpq3.gn.mail.iss.as9143.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6U9E2Gr019261
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 09:14:02 GMT
From: "Remmolt G. Zwartsenberg" <remmolt@zwartsenberg.eu>
To: "'mina elnino'" <potushka@gmail.com>
Cc: <selinux@tycho.nsa.gov>
References: <f7d5075c0907290405x4d851cbnaf30980f8fadb308@mail.gmail.com> <CIEOKAFOMGPNJIPMMMAHMELCCBAA.remmolt@zwartsenberg.eu> <f7d5075c0907290626t1c772fd3l9f60c7a710c6152@mail.gmail.com> <f7d5075c0907290704x9b2b426sb6c3bb928a11a98b@mail.gmail.com> <1248882850.11627.64.camel@moss-pluto.epoch.ncsc.mil> <f7d5075c0907292221m3f04a942xd6216033e923cab6@mail.gmail.com>
Subject: {Spam?} C Code Compilation Errors
Date: Thu, 30 Jul 2009 11:31:37 +0200
Message-ID: <E18F0C249236489BA7FD480F151B2458@CIMSLAB.NL>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0015_01CA1109.4D4B7890"
In-Reply-To: <f7d5075c0907292221m3f04a942xd6216033e923cab6@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01CA1109.4D4B7890
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

RE: compiling errors!

 

Bokertov Mina,

 

Linux is OpenSource, but setting logical names 4 input datasets (especially
ODBC live connections with MySQL or ORACLE instances executing OLTP) can
create extreme confusion. Especially now that we are replacing big Harddisks
by Flash Memory Caches.

I hate to ask you, but do you have a pre- and postcondition matrix of the
constants and variables used in the Alghoritm? If yes, then we could apply a
regression testing procedure. We had considerable problems integrating C++
and C# (Microsoft C) runlibs,.Because SQL Server 2000 would always run out
of Tablespace we needed to migrate the POSTFIX header database to SQLServer
2005. 

 

I hope this helps,

 

Yours sincerely,

 

~remmolt  

 

  _____  

From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of mina elnino
Sent: donderdag 30 juli 2009 7:22
To: selinux@tycho.nsa.gov
Subject: Re: compiling errors!

 

well, i have to say that i went through the steps in:

http://danwalsh.livejournal.com/26428.html

and at last i realized that this page is for the ones who want to make
policies from the source. now i have packages:

$ ls ~/rpmbuild/RPMS/noarch/
selinux-policy-3.6.12-62.fc11.noarch.rpm
selinux-policy-doc-3.6.12-62.fc11.noarch.rpm
selinux-policy-minimum-3.6.12-62.fc11.noarch.rpm
selinux-policy-mls-3.6.12-62.fc11.noarch.rpm
selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm

none of them is the source policy package. i mean i need that old m4 macros,
"*.te" files and "policy.conf" which could be installed by
"selinux-policy-targeted-source" or "selinux-policy-strict-source" in fc4.

best regards.

On Wed, Jul 29, 2009 at 8:24 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

On Wed, 2009-07-29 at 18:34 +0430, mina elnino wrote:
> thank you. it got solved by installing "ustr-devel".
> now i should have my source policy files. so according to what you
> said, i used:
>
> $ yumdownloader --source selinux-policy
>
> then i had my "src.rpm" package. but i dont know how to install it.
> the reason is that i am not so familiar with fedora. i have used
> ubuntu and never worked with rpm packages.
>
> i used "Package Installer" but it didn't work! "Backend will not
> install a src rpm file" was the message. i am not sure if i should
> have my "policy.conf" file in /etc/selinux/targeted/src/. and what's
> more, where is the strict type of selinux??

Stay on list, please.

You can just rpm -i the .src.rpm file, and that will expand it under
~/rpmbuild, where you can follow the instructions in Dan Walsh's blog
that I pointed you to earlier.

targeted and strict policies have been merged together; you can map
users to confined roles via semanage login or system-config-selinux.


--
Stephen Smalley
National Security Agency

 


------=_NextPart_000_0015_01CA1109.4D4B7890
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>RE: compiling =
errors!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Bokertov =
Mina,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Linux is OpenSource, but setting =
logical
names 4 input datasets (especially ODBC live connections with MySQL or =
ORACLE
instances executing OLTP) can create extreme confusion. Especially now =
that we
are replacing big Harddisks by Flash Memory =
Caches.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I hate to ask you, but do you have =
a pre-
and postcondition matrix of the constants and variables used in the =
Alghoritm?
If yes, then we could apply a regression testing procedure. We had =
considerable
problems integrating C++ and C# (Microsoft C) runlibs,.Because SQL =
Server 2000
would always run out of Tablespace we needed to migrate the POSTFIX =
header
database to SQLServer 2005. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>I hope this =
helps,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Yours =
sincerely,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>~remmolt =
&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>mina elnino<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> donderdag 30 juli =
2009 7:22<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
selinux@tycho.nsa.gov<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: compiling =
errors!</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>well, i have =
to say that
i went through the steps in:<br>
<br>
<a =
href=3D"http://danwalsh.livejournal.com/26428.html">http://danwalsh.livej=
ournal.com/26428.html</a><br>
<br>
and at last i realized that this page is for the ones who want to make =
policies
from the source. now i have packages:<br>
<br>
$ ls ~/rpmbuild/RPMS/noarch/<br>
selinux-policy-3.6.12-62.fc11.noarch.rpm<br>
selinux-policy-doc-3.6.12-62.fc11.noarch.rpm<br>
selinux-policy-minimum-3.6.12-62.fc11.noarch.rpm<br>
selinux-policy-mls-3.6.12-62.fc11.noarch.rpm<br>
selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm<br>
<br>
none of them is the source policy package. i mean i need that old m4 =
macros,
&quot;*.te&quot; files and &quot;policy.conf&quot; which could be =
installed by
&quot;selinux-policy-targeted-source&quot; or
&quot;selinux-policy-strict-source&quot; in fc4.<br>
<br>
best regards.<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>On Wed, Jul 29, 2009 at 8:24 PM, Stephen Smalley &lt;<a
href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; =
wrote:<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>On Wed, =
2009-07-29 at
18:34 +0430, mina elnino wrote:<br>
&gt; thank you. it got solved by installing &quot;ustr-devel&quot;.<br>
&gt; now i should have my source policy files. so according to what =
you<br>
&gt; said, i used:<br>
&gt;<br>
&gt; $ yumdownloader --source selinux-policy<br>
&gt;<br>
&gt; then i had my &quot;src.rpm&quot; package. but i dont know how to =
install
it.<br>
&gt; the reason is that i am not so familiar with fedora. i have =
used<br>
&gt; ubuntu and never worked with rpm packages.<br>
&gt;<br>
&gt; i used &quot;Package Installer&quot; but it didn't work! =
&quot;Backend
will not<br>
&gt; install a src rpm file&quot; was the message. i am not sure if i =
should<br>
&gt; have my &quot;policy.conf&quot; file in /etc/selinux/targeted/src/. =
and
what's<br>
&gt; more, where is the strict type of =
selinux??<o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Stay on list, please.<br>
<br>
You can just rpm -i the .src.rpm file, and that will expand it under<br>
~/rpmbuild, where you can follow the instructions in Dan Walsh's =
blog<br>
that I pointed you to earlier.<br>
<br>
targeted and strict policies have been merged together; you can map<br>
users to confined roles via semanage login or =
system-config-selinux.<o:p></o:p></span></font></p>

<div>

<div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'><br>
--<br>
Stephen Smalley<br>
National Security Agency<o:p></o:p></span></font></p>

</div>

</div>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0015_01CA1109.4D4B7890--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
