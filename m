Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA02998
	for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2003 19:27:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0A0RfI05318
	for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 00:27:41 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h0A0RZf05314 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2003 00:27:36 GMT
Date: Fri, 10 Jan 2003 11:27:18 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: 2.4.20 stability issues
Message-ID: <20030110002718.GA922@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Has anybody else here used my kernel 2.4.20 source code or binary code?

I had no problems with 2.4.19, but as of 2.4.20 I seem to have
encountered some weird stability issues that I cannot put my finger on.

It only happens after an uptime of several hours (if not days; it
also depends if you count time in suspend mode or not), on my laptop
computer.

This time I noticed that ssh connections would hang; I tried restarting
ssh, but the previous process wouldn't die (for each parant sshd process,
there is a child zombie process). Typing in "killall -9 sshd" does
nothing. Pushing ctrl+alt+del does nothing. However, ironically, local
logins still work fine.

hmmm... now logouts hang. Oh well... Time to push that power switch.

So far this has only ever happened with 2.4.19, not 2.4.20. Weird.

I have compiled 2.4.20 (not my kernel binary online) with the same
configuration as 2.4.19 (evms and acl disabled, FreeSWAN and
SE-LINUX enabled).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
