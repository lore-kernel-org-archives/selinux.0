Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA15506
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 08:37:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA05007
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 12:36:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA05003 for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 12:36:13 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7C41592452
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 22:37:19 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 465F819143
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 14:37:09 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: boot loader
Date: Sat, 20 Apr 2002 14:37:08 +0200
MIME-Version: 1.0
Message-Id: <20020420123709.465F819143@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am creating a policy for lilo.

I have defined it's type as follows:
type lilo_t, domain, privlog, privmem, boot_loader;

privmem is because lilo needs to read from /dev/mem to get BIOS data about 
boot devices.  I have defined "boot_loader" as a type attribute for anything 
that needs to write to raw hard drive devices to install a boot loader (grub 
etc would need that too).  Then I added boot_loader in assert.te as being 
allowed to write to fixed_disk_device_t.

What do you think?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
