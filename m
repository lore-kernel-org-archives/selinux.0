Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7SHClLa020677
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 13:12:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7SHClet006829
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 17:12:47 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h7SHCklq006826 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 17:12:46 GMT
Date: Thu, 28 Aug 2003 18:12:42 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Package install probs
Message-ID: <20030828171242.GC6898@vnl.com>
References: <20030828144825.GA6898@vnl.com> <200308290149.15229.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308290149.15229.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since I've not played with this for at least a year (and a lot has
changed), please excuse me while I go through a dumb question period.

During boot up:

Security scaffold v1.1.0 initialized
SELinux: initializing
SELinux starting in permissive mode
There is already a security framework initialized, register_security
failed.
Failure registering capabilities with the kernel.
selinux_register_security: Registering secondary module capability
Capability LSM initialized.

Is this because I enabled Linux default capabilities and
that LSM is also providing that feature?

Next, what is a good test to see if everything is working
right? I've got one message in the log:

 (system_usetiathome) GETFILCON failed /etc/cron.d/setiathome

which seems to indicate selinux is at least doing something.

I've also not yet acquired a patch to handle xattr on
reiserfs and I haven't got a single system available that
is non-reiserfs.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
