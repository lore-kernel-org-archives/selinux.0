Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAC1XYSf010976
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2003 20:33:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAC1VsBd024263
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 01:33:08 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAC1Cj4o023142
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 01:14:11 GMT
Date: Wed, 12 Nov 2003 01:09:30 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Authentication failure
Message-ID: <20031112010929.GY23277@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm getting 'Authentication Failure' when I go to login.
This is a freshly installed system (disk image built 
elsewhere and rolled in). I can log in if I boot
single user; that way I was able to label the file
system and then reboot via the initrd... but the
full selinux boot also gives 'Authentication failure'.

Could it be there is still some conflict in packages
between Coker, Walters and sid? 

Any suggestions on what to try next?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
