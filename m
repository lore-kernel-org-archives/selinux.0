Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3PEvKRb017028
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 10:57:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3PEvJdi019247
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 14:57:19 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
        by jazzband.ncsc.mil  with ESMTP id i3PEvFJP019244 for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 14:57:19 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: sshd, devpts, unix_chkpwd
Date: Sun, 25 Apr 2004 10:57:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <200404251359.10230.russell@coker.com.au>
Message-Id: <20040425145703.6C4ED3A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

How about some type of wrapper that would force passwd (and other programs)
to run in a specific domain instead of doing mods to the programs itself?

As for ssh 3.8 under debian I had to add the following line for user logins
to occur correctly.

#ssh 3.8 stuff
allow staff_t sshd_devpts_t:chr_file { read write ioctl };

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Russell Coker
Sent: Saturday, April 24, 2004 11:59 PM
To: mizu
Cc: selinux@tycho.nsa.gov
Subject: Re: sshd, devpts, unix_chkpwd

That is a bug in the pam package for Debian.  Fixing it is on my to-do list,

in the mean time putting in a dontaudit rule to stop that will be OK.


---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.662 / Virus Database: 425 - Release Date: 4/20/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
