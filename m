MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7C4B7.485D1348"
Subject: Libsemanage dependency on version of Linux...
Date: Thu, 12 Jul 2007 15:03:07 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D03C0A72F@de01exm68.ds.mot.com>
In-Reply-To: <1183638838.12218.334.camel@moss-spartans.epoch.ncsc.mil>
References: <20070521095414.832619201@tresys.com> <1180137749.10334.18.camel@localhost.localdomain> <4677F1BC.2000201@tresys.com> <1182443353.11527.50.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com> <1182449086.11527.80.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com> <1182449898.11527.83.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com> <1182450900.11527.88.camel@localhost.localdomain> <467AE59E.2050501@tycho.nsa.gov> <1182525734.3014.20.camel@localhost.localdomain> <467BFF99.9000404@tycho.nsa.gov> <1182540624.6599.5.camel@localhost.localdomain> <467C3728.6070803@tycho.nsa.gov>  <468904FA.7030102@tresys.com> <1183386217.16330.0.camel@localhost.locald! omain> <46896D88.7060504@tresys.com> <1183425133.32465.16.camel@code.and.org> <468A2FE2.5000903@aus-city.com> <1183464455.12218.243.camel@moss-spartans.epoch.ncs! c.mil> <468C2D9!
 5.2010801
	@aus-city.co
	m> <1183638838.12218.334.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7C4B7.485D1348
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I currently am running on Linux 2.6.14,  and I have
libsemanage-1.6.17-1

After discussing with Stephen Smalley, I learned that in order for
semanage to NOT create a "/previous" directory, I need to upgrade my
libsemanage library to version   1.9.2  or higher.

My question is:  is libsemanage version 1.9.2  dependent on a Linux
version newer than Linux 2.6.14 ???

What is the latest version of libsemanage that is supported in Linux
version 2.6.14 ?

Also, what are the latest versions of the following other libs supported
by Linux 2.6.14 : ?

checkpolicy
libsepol
libselinux
Policycoreutils

Thanks in advance,

- Rezaul.

------_=_NextPart_001_01C7C4B7.485D1348
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Libsemanage dependency on version of Linux...</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hi =
All,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I currently am =
running on Linux 2.6.14,&nbsp; and I have&nbsp;&nbsp; =
libsemanage-1.6.17-1</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">After discussing =
with Stephen Smalley, I learned that in order for semanage to NOT create =
a &quot;/previous&quot; directory, I need to upgrade my libsemanage =
library to version&nbsp;&nbsp;<B> 1.9.2&nbsp;</B> or =
higher.</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">My question =
is:&nbsp; is libsemanage version</FONT><B> <FONT SIZE=3D2 =
FACE=3D"Arial">1.9.2&nbsp;</FONT></B> <FONT SIZE=3D2 =
FACE=3D"Arial">dependent on a Linux version newer than Linux 2.6.14 =
???</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">What is the latest =
version of libsemanage that is supported in Linux version 2.6.14 =
?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Also, what are the =
latest versions of the following other libs supported by Linux 2.6.14 : =
?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">checkpolicy</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">libsepol</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">libselinux</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Policycoreutils</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Thanks in =
advance,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">- =
Rezaul.</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7C4B7.485D1348--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
