Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82DR9rT028867
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 09:27:09 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82DQH3w000695
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 13:26:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Latest Patches
Date: Thu, 2 Sep 2004 23:27:04 +1000
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <200408241818.40064.russell@coker.com.au> <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil> <41371628.2020408@redhat.com>
In-Reply-To: <41371628.2020408@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409022327.04337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Sep 2004 22:46, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Include some stuff from Russell,
> Critical patch for tmpfs to get udev on tmpfs working
>
> You sent me a note saying some patches conflict with other changes,
> please point those out so I can remove them.

The initrc patch removes my change to clean up the initrc_t definition.  
Having two definitions leads to bugs when people update only one of them (as 
was done with the unrestricted attribute change).

There should never be a printer_device_t:fifo_file entry, I removed it because 
there is no way for such a node to be created in enforcing mode.

The dovecot patch reverts my change to put the capabilities in numerical 
order.  I put them in order to improve readability.

In xserver_macros.te there's a ifdef(`redhat' when distro_redhat should be 
used.

We should probably avoid putting distro.tun into patch files that are 
distributed outside a distribution.  Leave all options commented for the CVS 
version.

Also the patch for tunable.tun is not something we want in the CVS.  I think 
that we want the CVS policy to have fairly restrictive settings for tunables.  
Apart from use_games I think that all the tunable changes in your patch 
should not be in the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
