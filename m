Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01249
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 10:35:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h23FZiI21630
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 15:35:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h23FZgf21626 for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 15:35:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: Core policy, third pass
Date: Mon, 3 Mar 2003 16:35:33 +0100
References: <Pine.LNX.4.33.0303030916220.14620-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0303030916220.14620-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303031635.33938.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 3 Mar 2003 15:25, Wayne Salamon wrote:
>   I've built another policy based on the feedback to the list (thanks to
> all who commented).

Why portmap?  It doesn't seem much use on it's own.  If you don't use NFS or 
NIS then you don't have much need for it.

Also while re-tagging it I suggest that we merge pump.te and dhcpc.te into a 
single policy file.  I don't think that we have a need to protect pump and 
dhclient from each other as they both have essentially the same access.

I plan to re-write the dhcpc.te file soon in such a way that it'll do all you 
need for pump.  This re-tagging will be a good opportunity to remove pump.te

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
