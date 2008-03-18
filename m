Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IIvGSV003389
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 14:57:16 -0400
Received: from az25ege01.gdc4s.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2IIvFB4026768
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 18:57:15 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88926.5A8944C4"
Subject: unconfined_t Domain with MLS Policy
Date: Tue, 18 Mar 2008 11:31:59 -0700
Message-ID: <EC684739C863494FB46F604CEDEC3E241BBA2F@AZ25EXM01.gddsi.com>
From: "Henley, Tim-P64420" <Timothy.Henley@gdc4s.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C88926.5A8944C4
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Is the unconfined_t Domain available when running with the MLS Policy? I
was attempting to assign a Perl script to the domain using chcon (with
the -t switch). The result is that I get an "Invalid argument" error
message. I'm doing this on a development box (the Perl script is for dev
use only) as a means of trying to avoid having to stop and write a
policy for every script/executable I create during development. Is this
how I should be handling this or is there a more appropriate way to do
this? Thanks in advance.
=20
Regards,
Tim Henley

------_=_NextPart_001_01C88926.5A8944C4
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>unconfined_t Domain with MLS Policy</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Is the unconfined_t Domain available =
when running with the MLS Policy? I was attempting to assign a Perl =
script to the domain using chcon (with the -t switch). The result is =
that I get an &quot;Invalid argument&quot; error message. I'm doing this =
on a development box (the Perl script is for dev use only) as a means of =
trying to avoid having to stop and write a policy for every =
script/executable I create during development. Is this how I should be =
handling this or is there a more appropriate way to do this? Thanks in =
advance.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Tim Henley</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C88926.5A8944C4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
