Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQNFYRb022443
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 18:15:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAQNFSqY029214
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 23:15:28 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAQNFR0o029211 for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 23:15:27 GMT
Date: Wed, 26 Nov 2003 23:15:23 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: mkinitrd setup script problem
Message-ID: <20031126231523.GX2718@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I seem to be having a little problem:

edbe    policycoreutils/policycoreutils_1.2-0.2_i386.deb *

Installs
	/sbin/load_policy 
and a link 
	/usr/sbin/load_policy -> /sbin/load_policy


edbe    selinux-policy-default_1.2.real-10_all.deb

Installs
	/etc/mkinitrd/scripts/selinux
which contains the line:
	cp -a /usr/sbin/load_policy "$INITRDDIR/bin/load_policy

When you do mkinitrd, you end up with

/initrd/bin/load_policy linked to /initrd/sbin/load_policy

but there is no /initrd/sbin/load_policy.

Did this just happen in the last day or two???

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
