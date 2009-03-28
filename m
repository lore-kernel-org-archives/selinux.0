Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2SC3Emt000648
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 08:03:14 -0400
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2SBxFRe003773
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 11:59:15 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 0/6] Labeled networking patches for 2.6.30
Date: Sat, 28 Mar 2009 08:01:47 -0400
Cc: David Miller <davem@davemloft.net>, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, netdev@vger.kernel.org, casey@schaufler-ca.com,
        etienne.basset@numericable.fr
References: <20090327205520.17777.32557.stgit@flek.lan> <20090327.145840.218658417.davem@davemloft.net> <alpine.LRH.2.00.0903281158010.21619@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.0903281158010.21619@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903280801.48329.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 27 March 2009 08:58:52 pm James Morris wrote:
> On Fri, 27 Mar 2009, David Miller wrote:
> > From: Paul Moore <paul.moore@hp.com>
> > Date: Fri, 27 Mar 2009 17:10:20 -0400
> >
> > > This patchset wraps up all the new labeled networking bits for 2.6.30. 
> > > This is mostly a fixup/cleanup release with the main focus being to
> > > correct the TCP labeling of both SELinux and Smack; expect some of this
> > > to get backported to the -stable trees but there will need to be a bit
> > > of rework first so it may take a few weeks for that to happen.  Other
> > > than the TCP issue there is a new Smack feature to configure CIPSO
> > > aware hosts in "/smack/netlabel" which should make the host/network
> > > label configuration much more flexible.  The last change is to get rid
> > > of the security_socket_post_accept() hook which isn't currently being
> > > used by anything in-tree and seems to act as a magnet for bad ideas; if
> > > things change we can always add it back later.
> >
> > Is James Morris going to take this stuff?  Just curious...
>
> I will unless you specifically want it.

Since James had pulled the labeled networking patches the past few times I 
figured he would do the same this time around.  I was posting these to netdev 
more as an FYI since there were some core networking changes, although they 
were pretty minor and previously ACKd.

> Paul: it's probably a good idea to have this in my tree before the merge
> window opens.

Okay, I'll make sure you have the lblnet-2.6_next stuff before the merge 
window opens in the future.  Regardless, thanks for pulling in the patches.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
