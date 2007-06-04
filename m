Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l55CZHha020180
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 08:35:17 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l55CZFN4029867
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 12:35:15 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l55CXibc012987
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 08:33:44 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l55CXi6j012986
	for selinux@tycho.nsa.gov; Tue, 5 Jun 2007 08:33:44 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A6EF.DF3A347C"
Subject: Help with semanage...
Date: Mon, 4 Jun 2007 17:30:33 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0399F027@de01exm68.ds.mot.com>
In-Reply-To: <20070531204502.3a667419@maya>
References: <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com><1180633622.3534.78.camel@localhost.localdomain><6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com> <20070531204502.3a667419@maya>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7A6EF.DF3A347C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I have a Linux machine (Machine_A) running a collection of  *strict*
SELinux policies. On Machine_A, I am able to further modify policies by
using semanage, and also add/delete policy modules using semodule. I can
make changes at will successfully as many times as I want.

I tarred up the entire  /etc/selinux/* directory from Machine_A, and I
untarred the tar-ball on another Linux machine, Machine_B. On Machine_B,
I also created and mounted the /selinux/ directory.=20

With all selinux files/dirs in place, AFTER rebooting Machine_B, SELinux
policies seem to be working as expected !

At this point, I am able to execute  "semanage"  ONLY ONE time
successfully !  Any attempts to make any further changes after the first
time fails with the error below...

So for example, If I create a new user-mapping with:  "semanage login -a
-s staff_u Admin", this first command is successful !

But every semanage command run afterwards has this same error:

semanage login -d Admin
Libsemanage.semanage_make_sandbox: Could not copy files to sandbox
/etc/selinux/strict/modules/tmp
/usr/sbin/semanage: Could not start semanage transaction

The error message in the /var/log/messages file is:
Jun  4 21:10:11 unknown python: Failed:  delete SELinux user mapping
name=3DAdmin

Any ideas on why I can execute semanage only ONCE ?  I have tried
rebooting the machine several times, to see if it helps, but it doesn't
!

Also, whats the significance of the
/etc/selinux/strict/module/semanage.read.LOCK  &  semanage.trans.LOCK
files ?

Thanks in advance,

- Rezaul.

------_=_NextPart_001_01C7A6EF.DF3A347C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.14">
<TITLE>Help with semanage...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hi =
All,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I have a Linux =
machine (Machine_A) running a collection of&nbsp; *strict*&nbsp; SELinux =
policies. On Machine_A, I am able to further modify policies by using =
semanage, and also add/delete policy modules using semodule.</FONT><FONT =
SIZE=3D2 FACE=3D"Arial"> I can make changes at will successfully as many =
times as I want.</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I tarred up the =
entire&nbsp; /etc/selinux/* directory from Machine_A, and I untarred =
the</FONT> <FONT SIZE=3D2 FACE=3D"Arial">tar-ball</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> on another Linux machine, Machine_B. On =
Machine_B,</FONT> <FONT SIZE=3D2 FACE=3D"Arial">I also</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">created and mounted the /selinux/ directory. =
</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">With all selinux =
files/dirs in place, AFTER</FONT><FONT SIZE=3D2 FACE=3D"Arial"> =
rebooting Machine_B, SELinux policies seem to be working as expected =
!</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">At this point, I =
am able to execute&nbsp;</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">&quot;</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">semanage</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">&quot;</FONT><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;<U><B> =
ONLY</B></U></FONT><U><B><FONT SIZE=3D2 FACE=3D"Arial"> =
ONE</FONT></B></U><B><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">time</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">successfully</FONT></B> <FONT SIZE=3D2 =
FACE=3D"Arial">!&nbsp;</FONT> <FONT SIZE=3D2 FACE=3D"Arial">Any attempts =
to make any further changes after the first time fails with the error =
below...</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">So</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">for example,</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">If I create a new user-mapping</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> with:</FONT><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; =
&quot;</FONT><B><FONT SIZE=3D2 FACE=3D"Arial">semanage login -a -s =
staff_u Admin</FONT></B><FONT SIZE=3D2 FACE=3D"Arial">&quot;, this first =
command is successful !</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">But every semanage =
command run afterwards has this same error:</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 FACE=3D"Arial">semanage login =
-d Admin</FONT></B></SPAN>

<BR><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Arial">Libsemanage.semanage_make_sandbox: Could not copy files =
to sandbox /etc/selinux/strict/modules/tmp</FONT></I></SPAN>

<BR><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 =
FACE=3D"Arial">/usr/sbin/semanage: Could not start semanage =
transaction</FONT></I></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">The error message =
in the /var/log/messages file is:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><I><FONT SIZE=3D2 FACE=3D"Arial">Jun&nbsp; 4 =
21:10:11 unknown</FONT></I><I><B> <FONT SIZE=3D2 =
FACE=3D"Arial">python</FONT></B><FONT SIZE=3D2 FACE=3D"Arial">: =
Failed:&nbsp; delete SELinux user mapping name=3DAdmin</FONT></I></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Any ideas on why I =
can execute semanage only ONCE ?&nbsp; I have tried rebooting the =
machine several times, to see if it helps, but it doesn't =
!</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Also, whats the =
significance of the&nbsp; /etc/selinux/strict/module/</FONT><B><FONT =
SIZE=3D2 FACE=3D"Arial">semanage.read.LOCK&nbsp;</FONT></B> <FONT =
SIZE=3D2 FACE=3D"Arial">&amp;&nbsp;</FONT><B> <FONT SIZE=3D2 =
FACE=3D"Arial">semanage.trans.LOCK&nbsp;&nbsp;</FONT></B> <FONT SIZE=3D2 =
FACE=3D"Arial">files ?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Thanks in =
advance,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">- =
Rezaul.</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7A6EF.DF3A347C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
