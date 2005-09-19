Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8JKXQNs022311
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 16:33:26 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8JKTTeY001018
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 20:29:30 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2E0C261AF6
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 06:29:27 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15902-09 for <selinux@tycho.nsa.gov>;
	Tue, 20 Sep 2005 06:29:26 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B4B6A61AF5
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 06:29:26 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: misc policy patches
Date: Tue, 20 Sep 2005 06:29:17 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200509192101.04722.russell@coker.com.au> <432F1834.8080809@redhat.com>
In-Reply-To: <432F1834.8080809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509200629.25197.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 20 September 2005 05:57, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> >The attached patch has a bunch of small changes that are fairly obvious
> > (and the less obvious ones have comments).
>
> What is this for?
> +allow mount_t named_conf_t:dir mounton;

This is for a chroot environment for BIND where an init script mounts /proc 
inside the chroot.  The mount point gets labeled named_conf_t.

Another possible solution to this is to have the mount point labeled as 
<<none>> (although we would still have problems with machines that already 
have the mount point labeled).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
