Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hASB5gRb026746
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 06:05:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hASB55p5007430
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:05:05 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hASB54t0007427
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:05:05 GMT
Date: Fri, 28 Nov 2003 11:05:36 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: More mkinitrd setup script problems
Message-ID: <20031128110536.GE12418@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You'll need to add these two lines, or something like them,
to /etc/mkinitrd/scripts/selinux

	cp -aL /lib/libselinux.so.1 "$INITRDDIR/lib/"
	cp -aL /lib/libattr.so.1 "$INITRDDIR/lib/"

to allow load_policy to run. I'm wondering if something
major happened to load_policy recently. It worked without
this until a few days ago.

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
