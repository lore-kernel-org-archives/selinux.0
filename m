Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7R7jEOd026144
	for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2011 03:45:21 -0400
Received: from snt0-omc3-s19.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7R7jDiw022489
	for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2011 07:45:14 GMT
Message-ID: <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_e27ab9ef-a122-4314-bf4c-48b0092f3f39_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <selinux@tycho.nsa.gov>
Subject: Toolchain is broken?
Date: Sat, 27 Aug 2011 07:45:11 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_e27ab9ef-a122-4314-bf4c-48b0092f3f39_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi,

When I am improving my patchset to discard unused branches of tunable conditionals these days, I run into a new segfault issue that seems has nothing to do with my patchset. After I checked back to the master branch for both toolchain and refpolicy and pulled the latest codes, the segfault still exist.

Turns out the problem lies in genhomedircon.c, the level argument passed to set_fallback_user is NULL, and strdup(NULL) would segfault in the end. Below is the debug message I've seen:

genhomedircon.c Entered set_fallback_user, user = user_u, prefix = user, level = (null)
Passing NULL to strdup would segfault
make: *** [load] Segmentation fault

Has anyone else also run into the same problem? I didn't run into it before Aug 23rd, if this is a real problem, then it must have been introduced after that date.

So far I am pretty new to the semanage code, any idea to fix this issue?

Thanks,
Harry


 		 	   		  
--_e27ab9ef-a122-4314-bf4c-48b0092f3f39_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Hi,<br><br>When I am improving my patchset to discard unused branches of tunable conditionals these days, I run into a new segfault issue that seems has nothing to do with my patchset. After I checked back to the master branch for both toolchain and refpolicy and pulled the latest codes, the segfault still exist.<br><br>Turns out the problem lies in genhomedircon.c, the level argument passed to set_fallback_user is NULL, and strdup(NULL) would segfault in the end. Below is the debug message I've seen:<br><br>genhomedircon.c Entered set_fallback_user, user = user_u, prefix = user, level = (null)<br>Passing NULL to strdup would segfault<br>make: *** [load] Segmentation fault<br><br>Has anyone else also run into the same problem? I didn't run into it before Aug 23rd, if this is a real problem, then it must have been introduced after that date.<br><br>So far I am pretty new to the semanage code, any idea to fix this issue?<br><br>Thanks,<br>Harry<br><br><br> 		 	   		  </div></b!
 ody>
</html>
--_e27ab9ef-a122-4314-bf4c-48b0092f3f39_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
