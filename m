Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h412OUI4008188
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 22:24:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h412OT7R018657
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 02:24:29 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h412ORKP018654 for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 02:24:28 GMT
Date: Thu, 1 May 2003 12:24:14 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: ssh/login
Message-ID: <20030501022414.GA13019@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

If I boot a computer with SE-Linux but without the SE-Linux policy
installed (in permissive mode obviously[1]), neither the SE-Linux
patched ssh or login will let me login. It means that the only option I
have is to reboot is single user mode, and downgrade these packages to
non-SE-Linux versions.

This is because there are no valid security contexts available for me to
log in with.

Is there anyway I can get ssh or login to completely disable SE-Linux
support if SE-Linux is loaded but no policy is?

Alternatively, it there anyway I can login even though none of the valid
security contexts I am allowed to use exist?

Notes:
[1] Interesting enough, in this setup, my computer no longer seems to
be crashing.... I have since loaded a policy and it still hasn't crashed
yet. Hmmm.. I think I will need to track try and isolate this further.
I wonder if it will survive a reboot...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
