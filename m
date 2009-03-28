Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2S0xCec022866
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 20:59:12 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2S0tDCM007104
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 00:55:13 GMT
Date: Sat, 28 Mar 2009 11:58:52 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: David Miller <davem@davemloft.net>
cc: paul.moore@hp.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, netdev@vger.kernel.org, casey@schaufler-ca.com,
        etienne.basset@numericable.fr
Subject: Re: [PATCH 0/6] Labeled networking patches for 2.6.30
In-Reply-To: <20090327.145840.218658417.davem@davemloft.net>
Message-ID: <alpine.LRH.2.00.0903281158010.21619@tundra.namei.org>
References: <20090327205520.17777.32557.stgit@flek.lan> <20090327.145840.218658417.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Mar 2009, David Miller wrote:

> From: Paul Moore <paul.moore@hp.com>
> Date: Fri, 27 Mar 2009 17:10:20 -0400
> 
> > This patchset wraps up all the new labeled networking bits for 2.6.30.  This
> > is mostly a fixup/cleanup release with the main focus being to correct the
> > TCP labeling of both SELinux and Smack; expect some of this to get backported
> > to the -stable trees but there will need to be a bit of rework first so it
> > may take a few weeks for that to happen.  Other than the TCP issue there is a
> > new Smack feature to configure CIPSO aware hosts in "/smack/netlabel" which
> > should make the host/network label configuration much more flexible.  The last
> > change is to get rid of the security_socket_post_accept() hook which isn't
> > currently being used by anything in-tree and seems to act as a magnet for
> > bad ideas; if things change we can always add it back later.
> 
> Is James Morris going to take this stuff?  Just curious...

I will unless you specifically want it.

Paul: it's probably a good idea to have this in my tree before the merge 
window opens.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
