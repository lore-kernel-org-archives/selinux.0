Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAHLJlRb008606
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 16:19:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAHLJkqY014952
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 21:19:46 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAHLJj0o014947 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 21:19:46 GMT
Date: Mon, 17 Nov 2003 21:19:25 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new PAM and policy to match
Message-ID: <20031117211924.GA4838@vnl.com>
References: <200311100849.52026.russell@coker.com.au> <200311121338.13459.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311121338.13459.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russ: We're getting there but I've finally got an
selinux system using your packages that I can log into.
That's the good news.

The problem areas are:

	* I had to delete later.te.
	* redhat-config-users.te had no matching tc
	  file. I didn't need it anyway so I deleted
	  it

With those mods I was able to build the policy file.
After rolling in my image with rsync, I logged into
the non-initrd choice and:

	tune2fs -j /dev/hda2	# set up ext2->ext3
	make load
	make relabel

which works. I can see the file contexts with ls. Then
I reboot through the initrd version. This time, for the
first time since I switched package repositories, I
was able to login to the selinux enabled kernel. 

Problem though... it is not giving a context or asking
for a choice of initial contexts; and newrole doesn't
recognize sysadm_r. 

I'd guess there is/are still incorrect package version(s)
being loaded out of 
	coker
	walters
	sid
but I'll be damned if I can figure out what and why.

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
