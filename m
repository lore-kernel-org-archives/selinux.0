Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA21869
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2001 16:53:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA11191
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2001 21:53:39 GMT
Received: from mail.rdc2.tx.home.com (ha1.rdc2.tx.home.com [24.14.77.20])
	by jazzband.ncsc.mil  with ESMTP id VAA11187
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2001 21:53:38 GMT
Received: from c783838-b.croltn1.tx.home.com ([24.15.240.109])
          by mail.rdc2.tx.home.com (InterMail vM.4.01.03.00 201-229-121)
          with SMTP
          id <20010208215329.OGEY26394.mail.rdc2.tx.home.com@c783838-b.croltn1.tx.home.com>
          for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2001 13:53:29 -0800
Date: Thu, 8 Feb 2001 15:53:29 -0600
From: Dustin Reyes <crusader@linuxgames.com>
To: selinux@tycho.nsa.gov
Subject: Crypto FS
Message-ID: <20010208155329.A1383@linuxgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Re: Integrate existing publicly available file cryptography
with file mandatory controls 

Will the SE Linux team (NAI Labs, NSA, etc.) be conducting
an extensive security audit of current Linux disk encryption?

I'm asking this question from more of a legal viewpoint,
due to the Executive branch of the federal government's
traditional negative stance towards *effective* personal data
encryption without key escrow as it interferes with
law enforcement to some degree.

I know that the team hopes that the philosophy behind SE Linux's
architecture and SE Linux itself become a standard in
the industry, but will the strength of fs crypto be compromised,
or not examined with the same rigor, as the rest of the
distribution/system?

It may not be a legal problem per se, but I'm concerned that NSA
culture and tradition would prevent a thorough analysis (and the
release of solutions or enhancements to any problems)...

Finally, I'm not a professional coder or cryptologist, so this question
may be completely invalidated by encrypted filesystems are
already implemented... if so, I apologize in advance.

Thanks for your patience and time.

-Dustin

-- 
Dustin Reyes - crusader@linuxgames.com
LinuxGames - http://www.linuxgames.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
