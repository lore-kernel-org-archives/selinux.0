Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0VGUrgU014370
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 11:30:53 -0500
Received: from fw5540.nrl.navy.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0VGUqYA025037
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 16:30:52 GMT
Received: from chacs.nrl.navy.mil (sun1.fw5540.net [10.0.0.11])
	by fw5540.nrl.navy.mil (8.13.6/8.13.6) with ESMTP id m0VGUqax001913
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 11:30:52 -0500 (EST)
Received: from chacs.nrl.navy.mil (sun1 [10.0.0.11])
	by chacs.nrl.navy.mil (8.13.6/8.13.6) with SMTP id m0VGUq9w007911
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 11:30:52 -0500 (EST)
Received: (from PC05 [10.0.1.195])
 by chacs.nrl.navy.mil (SMSSMTP 4.1.16.48) with SMTP id M2008013111305104814
 for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 11:30:51 -0500
From: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
Subject: problems updating /etc/shadow using strict example policy on Fedora Core 3
Date: Thu, 31 Jan 2008 11:28:35 -0500
Message-ID: <002501c86426$538c0800$c301000a@PC05>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0026_01C863FC.6AB60000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0026_01C863FC.6AB60000
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi:

 

I'm updating a legacy system where due to the SELinux policy a user was not
permitted to replace an expired password.  I gradually added allow
statements to eliminate the AVC messages.

 

The final SELinux change which corrupts the shadow file is

 

allow system_chkpwd_t shadow_t:file { create setattr rename write unlink };

 

or more specifically including the write permission in the allow statement
corrupts the shadow file.  If the write permission is not included, an AVC
is generated indicating we need to add the write permission.  But when the
write permission is included the shadow file is corrupted - the shadow file
is updated without a hash of the new password and the user is allowed to log
in without a password.  So I'm wondering is there a SELinux patch I need for
chkpwd?  Or do I need to add/modify an allow statement for a process other
than chkpwd to have the shadow file updated correctly?

 

Here is the AVC message - 

 

Jan 10 19:00:24 nrl-xml-nkm kernel: audit(1200009624.533:0): avc:  denied  {
write } for  pid=16563 exe=/sbin/unix_chkpwd path=/etc/nshadow dev=dm-0
ino=5275736 scontext=system_u:system_r:system_chkpwd_t
tcontext=system_u:object_r:shadow_t tclass=file

 

This is a SELinux problem because when the system is in permissive instead
of enforcing mode, the user can replace the expired password and the shadow
file is updated correctly.

 

I know most people ignored this email as soon as they saw the words "Fedora
Core 3" in the subject heading.  Any feedback would be greatly appreciated.
Thanks in advance.

 

Kim

 


------=_NextPart_000_0026_01C863FC.6AB60000
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
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
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hi:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I&#8217;m updating a legacy system where due to the SELinux =
policy a
user was not permitted to replace an expired password.&nbsp; I gradually =
added
allow statements to eliminate the AVC =
messages.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>The final =
SELinux change
which corrupts the shadow file is<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>allow =
system_chkpwd_t
shadow_t:file { create setattr rename write unlink =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>or more =
specifically
including the write permission in the allow statement corrupts the =
shadow file.&nbsp;
If the write permission is not included, an AVC is generated indicating =
we need
to add the write permission.&nbsp; But when the write permission is =
included
the shadow file is corrupted &#8211; the shadow file is updated without =
a hash
of the new password and the user is allowed to log in without a =
password.&nbsp;
So I'm wondering is there a SELinux patch I need for chkpwd?&nbsp; Or do =
I need
to add/modify an allow statement for a process other than chkpwd to have =
the
shadow file updated correctly?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Here is the =
AVC message &#8211;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Jan 10 =
19:00:24
nrl-xml-nkm kernel: audit(1200009624.533:0): avc:&nbsp; denied&nbsp; { =
write }
for&nbsp; pid=3D16563 exe=3D/sbin/unix_chkpwd path=3D/etc/nshadow =
dev=3Ddm-0
ino=3D5275736 scontext=3Dsystem_u:system_r:system_chkpwd_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>This is a =
SELinux problem
because when the system is in permissive instead of enforcing mode, the =
user
can replace the expired password and the shadow file is updated =
correctly.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>I know most =
people
ignored this email as soon as they saw the words &#8220;Fedora Core =
3&#8221; in
the subject heading. &nbsp;Any feedback would be greatly =
appreciated.&nbsp;
Thanks in advance.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D3
face=3D"Times New Roman"><span =
style=3D'font-size:12.0pt'>Kim<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0026_01C863FC.6AB60000--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
