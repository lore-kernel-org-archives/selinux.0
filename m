Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7R80js8026560
	for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2011 04:00:45 -0400
Received: from snt0-omc3-s48.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7R80jiw023908
	for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2011 08:00:45 GMT
Message-ID: <SNT139-W28B6707A5C8557A0CA887EAB120@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a402e2de-889c-43a1-8d61-2551096c0c90_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: Toolchain is broken?
Date: Sat, 27 Aug 2011 08:00:44 +0000
In-Reply-To: <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl>
References: <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_a402e2de-889c-43a1-8d61-2551096c0c90_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


BTW, on my box this problem could temporarily worked around by specifying "disable-genhomedircon = true". 

From: harrytaurus2002@hotmail.com
To: selinux@tycho.nsa.gov
Subject: Toolchain is broken?
Date: Sat, 27 Aug 2011 07:45:11 +0000








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


 		 	   		   		 	   		  
--_a402e2de-889c-43a1-8d61-2551096c0c90_
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
BTW, on my box this problem could temporarily worked around by specifying "disable-genhomedircon = true". <br><br><div><hr id="stopSpelling">From: harrytaurus2002@hotmail.com<br>To: selinux@tycho.nsa.gov<br>Subject: Toolchain is broken?<br>Date: Sat, 27 Aug 2011 07:45:11 +0000<br><br>

<meta http-equiv="Content-Type" content="text/html; charset=unicode">
<meta name="Generator" content="Microsoft SafeHTML">
<style>
.ExternalClass .ecxhmmessage P
{padding:0px;}
.ExternalClass body.ecxhmmessage
{font-size:10pt;font-family:Î¢ÈíÑÅºÚ;}

</style>

<div dir="ltr">
Hi,<br><br>When I am improving my patchset to discard unused branches of tunable conditionals these days, I run into a new segfault issue that seems has nothing to do with my patchset. After I checked back to the master branch for both toolchain and refpolicy and pulled the latest codes, the segfault still exist.<br><br>Turns out the problem lies in genhomedircon.c, the level argument passed to set_fallback_user is NULL, and strdup(NULL) would segfault in the end. Below is the debug message I've seen:<br><br>genhomedircon.c Entered set_fallback_user, user = user_u, prefix = user, level = (null)<br>Passing NULL to strdup would segfault<br>make: *** [load] Segmentation fault<br><br>Has anyone else also run into the same problem? I didn't run into it before Aug 23rd, if this is a real problem, then it must have been introduced after that date.<br><br>So far I am pretty new to the semanage code, any idea to fix this issue?<br><br>Thanks,<br>Harry<br><br><br> 		 	   		  </div></d!
 iv> 		 	   		  </div></body>
</html>
--_a402e2de-889c-43a1-8d61-2551096c0c90_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
