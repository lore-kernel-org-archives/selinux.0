Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13953
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 09:06:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0NE6eI25615
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 14:06:40 GMT
Received: from wiprom2mx2.wipro.com (wiprom2mx2.wipro.com [203.197.164.42])
        by jazzband.ncsc.mil  with ESMTP id h0NE6af25602 for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 14:06:37 GMT
Received: from m2vwall2 (m2vwall2.wipro.com [164.164.29.236])
	by wiprom2mx2.wipro.com (8.11.3/8.11.3) with SMTP id h0NE6R903785
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 19:36:28 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-bdbbc938-b546-440f-ab30-c1708cfd3abe"
Subject: Information required
Date: Thu, 23 Jan 2003 19:36:26 +0530
Message-ID: <52C85426D39B314381D76DDD480EEE0C66D189@blr-m3-msg.wipro.com>
From: "Rashmi Agrawal" <rashmi.agrawal@wipro.com>
To: <selinux@tycho.nsa.gov>
Cc: "Rashmi Agrawal" <rashmi.agrawal@wipro.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPartTM-000-bdbbc938-b546-440f-ab30-c1708cfd3abe
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C2C2E8.9E4F53EF"

------_=_NextPart_001_01C2C2E8.9E4F53EF
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am developing a software which require very high performance for data =
store/retrieval. Taking that into consideration, I decided to go for =
kernel space system calls for read/write, open/close etc.=20

I directly calls the file operation from within the kernel. Since kernel =
has access to all system resources and low level hardware, could =
somebody point out if it is secure enough to read/write in kernel space.

If it is not advisable directly to use system calls in kernel, can we do =
something to make it secure?? or do we already have something which =
provides us security even if I do kernel space system call =
implementation.

Any information provided on this would be useful. Also problems faced =
with this kind of implementation will give me more clarity on what to =
do.

Regards
Rashmi

------_=_NextPart_001_01C2C2E8.9E4F53EF
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.5770.91">
<TITLE>Information required</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi All,<BR>
<BR>
I am developing a software which require very high performance for data =
store/retrieval. Taking that into consideration, I decided to go for =
kernel space system calls for read/write, open/close etc.<BR>
<BR>
I directly calls the file operation from within the kernel. Since kernel =
has access to all system resources and low level hardware, could =
somebody point out if it is secure enough to read/write in kernel =
space.<BR>
<BR>
If it is not advisable directly to use system calls in kernel, can we do =
something to make it secure?? or do we already have something which =
provides us security even if I do kernel space system call =
implementation.<BR>
<BR>
Any information provided on this would be useful. Also problems faced =
with this kind of implementation will give me more clarity on what to =
do.<BR>
<BR>
Regards<BR>
Rashmi</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C2C2E8.9E4F53EF--


------=_NextPartTM-000-bdbbc938-b546-440f-ab30-c1708cfd3abe
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-bdbbc938-b546-440f-ab30-c1708cfd3abe--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
