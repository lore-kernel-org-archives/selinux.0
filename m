Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1N2JodW027380
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 21:19:50 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1N2HRZE000034
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 02:17:28 GMT
Subject: Mplayer: PT_GNU_STACK RWE
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: mplayer-dev-eng@mplayerhq.hu
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 22 Feb 2005 21:20:12 -0500
Message-Id: <1109125212.26770.16.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(re-sending to correct mplayer list..)

Hi, I've subscribed to this list just to post this one question.

The mplayer/mencoder executables are marked with PT_GNU_STACK RWE.
This is true for the RPMS which I use from Livna.org (vs FC3), and also
for mplayer CVS, compiled with gcc 3.4.3 (default FC rawhide compiler). 

This creates problems for the SELinux strict policy, and requires that
special privileges be granted for mplayer as a "legacy domain".

The question is, does mplayer really require an executable stack?

I'm not a gcc expert of any kind, but from what I've read I understand
that asm code causes gcc to mark the binary as requiring executable
stack. I think it can be overriden with ld -z noexecstack.

It would be a lot easier to write the mplayer security policy
if it didn't require executable stack.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
