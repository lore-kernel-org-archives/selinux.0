Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h986ApWt017095
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 02:10:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h986Ao7d009705
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 06:10:50 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h986AnRn009702 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 06:10:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: alexn@telia.com, selinux@tycho.nsa.gov
Subject: Re: Version mismatch in selinux-usr?
Date: Wed, 8 Oct 2003 16:10:34 +1000
References: <200310080216.03233.alexn@telia.com>
In-Reply-To: <200310080216.03233.alexn@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310081610.34337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 10:16, Alex wrote:
> The load_policy in Brian May's source is a version 12 match, but I needed
> to build a static binary for an initrd image, and the apt-get source
> selinux didn't appear to contain the load_policy files.

Brian's packages are all for the old SE Linux, which has policy version 12.  
If you use the new (xattr based) SE Linux then you need Colin's packages for 
version 15.

> Also, I think Russel Coker sent a message earlier about a mkinitrd script
> which I would gladly have a look at, I didn't receive it and the archives
> don't appear to updated every day, so if someone would send it to me I
> would appreciate it.

See the link in my .sig.  On that page there is a link to list archives that 
are updated immediately when new messages are posted.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
