Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA27437
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2001 15:09:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA20384
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2001 19:08:48 GMT
Received: from dallas.jhuapl.edu (dallas.jhuapl.edu [128.244.197.22])
	by jazzswing.ncsc.mil  with ESMTP id TAA20380
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2001 19:08:47 GMT
Received: from CONVERSION-DAEMON by dallas.jhuapl.edu (PMDF V5.2-32 #40039)
 id <0GCQ00J012DU36@dallas.jhuapl.edu> for selinux@tycho.nsa.gov; Wed,
 2 May 2001 15:05:54 -0400 (EDT)
Received: from kouskya1.jhuapl.edu (kouskya1.jhuapl.edu [128.244.59.230])
 by dallas.jhuapl.edu (PMDF V5.2-32 #40039)
 with ESMTP id <0GCQ00H492DPXI@dallas.jhuapl.edu> for selinux@tycho.nsa.gov;
 Wed, 02 May 2001 15:05:54 -0400 (EDT)
Date: Wed, 02 May 2001 15:05:57 -0400 (EDT)
From: Yanni Kouskoulas <Yanni.Kouskoulas@jhuapl.edu>
Subject: installation problems with checkpolicy
To: selinux@tycho.nsa.gov
Message-id: <Pine.LNX.4.21.0105021025380.8009-100000@kouskya1.jhuapl.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yesterday, I tried to install selinux on the x86 box I have at work. This
machine normally runs linux with the 2.4.2 kernel.

I am new to selinux, so from the download page, I got "Everything in one
large file" I followed the documentation in the installation guide: the
kernel compiled with some warnings, build-apps and install-apps seemed to
work fine. When I type "make initinstall" (of if I try to use
./tools/build-kernel) make dies when it tries to execute checkpolicy with
the following errors:

---------------------------------------------------
../kernel/security/checkpolicy -o initpolicy initpolicy.conf
../kernel/security/checkpolicy:  loading policy configuration from 
initpolicy.conf

error in the statement ending on line 1686 (token ';'): unknown class 
capability used in rule

../kernel/security/checkpolicy:  error(s) encountered while parsing 
configuration
---------------------------------------------------

It doesn't like the keyword "capability". Line 1686 is part of the list of
atd_t domain rules:

allow atd_t atd_t:capability { setgid setuid };

However, I don't completely understand all the configuration files, and
have only begun to read through the document titled "A Security Policy
Configuration for the Security-Enhanced Linux."

Is there something else I need to install? Some other docs I should read?
Any helpful suggestions for getting this initially set up?
Thanks.

-Yanni









--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
