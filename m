Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0VMQ553011554
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 17:26:05 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0VMQ7Gm024678
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 22:26:07 GMT
Subject: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Mon, 31 Jan 2005 15:26:09 -0700
Message-Id: <1107210369.1928.5.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What are your thoughts on this bug?
It asks whether it would be reasonable to grant full getattr privileges
to all file browsing applications (like nautilus, mozilla, things with a
file open dialog..)

This has bothered me ever since I first tried selinux - I open up 
nautilus or any other app with a file browser, and soon I get a storm of
denials. There should be a way to fix this.

https://bugzilla.redhat.com/beta/show_bug.cgi?id=146557

The bug says dontaudit, but when dwalsh explained the difference
I see I mean allow instead. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
