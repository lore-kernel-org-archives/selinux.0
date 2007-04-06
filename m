Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l36E5GNg019112
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2007 10:05:16 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l36E5D6u009647
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2007 14:05:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 222EC620ED
	for <selinux@tycho.nsa.gov>; Sat,  7 Apr 2007 00:04:37 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNKF-JxThiXt for <selinux@tycho.nsa.gov>;
	Sat,  7 Apr 2007 00:04:37 +1000 (EST)
Received: from nospam.sws.net.au (nospam.sws.net.au [61.95.69.195])
	by smtp.sws.net.au (Postfix) with ESMTP id EA24E620EA
	for <selinux@tycho.nsa.gov>; Sat,  7 Apr 2007 00:04:36 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id ADD7818714
	for <selinux@tycho.nsa.gov>; Sat,  7 Apr 2007 00:04:36 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (nospam.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id citjcbgx52JK for <selinux@tycho.nsa.gov>;
	Sat,  7 Apr 2007 00:04:36 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 6D01F1870F
	for <selinux@tycho.nsa.gov>; Sat,  7 Apr 2007 00:04:36 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 80D3A201C2
	for <selinux@tycho.nsa.gov>; Sat,  7 Apr 2007 00:04:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: syscall-proxy
Date: Sat, 7 Apr 2007 01:04:47 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704070004.50617.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does anyone have sample code for a syscall proxy that they can send me?

In discussions of SE Linux and other technologies we keep coming up against 
the issue of people thinking that the only necessary thing is to control 
execution of programs not the actions that programs may perform.  The 
examples of Perl and other interpreters don't seem adequate to convince them 
(why not just prevent executing Perl?).

I know that there is code to demonstrate taking over an application by a 
stack-smashing attack and then making it perform arbitrary syscalls under 
instruction of a program over the net.  Does anyone have a sample of such 
code?

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
