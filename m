Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA11150
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 17:31:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA21409
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 21:30:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA21405
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 21:30:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4556492466
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 07:31:23 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id CD4302F61
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 23:31:14 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ipsec access to { sysadm_tty_device_t sysadm_devpts_t }
Date: Tue, 27 Aug 2002 23:31:14 +0200
MIME-Version: 1.0
Message-Id: <20020827213114.CD4302F61@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been having some discussions with Steve about access to { 
sysadm_tty_device_t sysadm_devpts_t }.  We agree that giving all daemons 
access to the administrator terminal is a bad idea in concept.

However some programs seem to require it.  The PCMCIA cardmgr program does 
not seem to start correctly unless it has such access.

Now I'm working on ipsec which seems to require { read write ioctl getattr } 
access to those device types for correct functioning.  As I am just learning 
about IPSec I'm not in a good position to analyse this in detail, could 
someone who knows it better please have a look and see if there's something 
that can be done about it or whether it really needs such access.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
