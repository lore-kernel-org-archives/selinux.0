Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18113
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 15:00:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1OK0AI06818
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 20:00:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1OK05f06814 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 20:00:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Core policy
Date: Mon, 24 Feb 2003 20:59:51 +0100
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302242059.51557.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Feb 2003 19:55, Wayne Salamon wrote:
> Here is a list of policy files that may considered the core policy.
> However, this policy needs some work in order to build, but I'm trying to
> get a feel for what users typically run on their systems.

I think that you need to firstly define "core" more clearly.

In previous discussions about core policy I always thought it was the packages 
needed for booting and for base functionality.  I don't think that such 
criteria matches your list of packages.

> apache.te	Apache Web server; may need to be simplified to allow only
> 		serving Web pages without CGI, etc.

Most workstations do not need Apache.  The suggestion of separating out the 
CGI part is a good one.  I will investigate it.

> apmd.te		Automatic Power Management daemon
> cardmgr.te	PCMCIA control programs

Perhaps we should have different groupings of policy?  apmd.te and cardmgr.te 
go together.  It's quite rare to use one without the other.

> cups.te		Common Unix Printing System
> lpr.te		Print client

Do we need choices in the core policy?  Maybe we should make one the 
recommended option and the other the optional replacement.

> dhcpc.te	DHCP client
> pump.te		DHCP client

I think that whatever pump needs should be merged into dhcpc.te.  There isn't 
that much a DHCP client can do, so there isn't a need to have two policy 
files IMHO.  Maybe a bit of ifdef in the policy for some of the less used 
features, but that's all.

> gpm.te		General Purpose Mouse driver

GPM is not suitable for core IMHO.  I've never used it or seen anyone use it.

> portslave.te	Terminal server software (not sure about this one)

Portslave is not needed for core policy.  The vast majority of Linux machines 
are not running as terminal servers.

> procmail.te	Mail delivery agent for mail servers (may be removed)

It's a server-only thing, IMHO it's claim is exactly as good as that of 
Apache.

> rpcd.te		RPC daemon (not sure; how often do client workstations export
> 		RPC services)

Also using rpc without care is a huge security risk.  If you want a secure 
system then removing RPC is often a good thing to do.

> X Windows potential core domains
> ==================================================
> xdm.te		X Display Manager
> xfs.te		X font server

xfs is not required IMHO.  I think that the only need for XFS is for TrueType 
fonts, and I get the impression that anti-aliasing benefits from this too.  
But the core functionality is fine without it.

As for xdm, it currently doesn't work properly and has excessive permissions.  
I'm working on this now, I expect to have it sorted out in a couple of weeks 
along with a patch for kdm 3.1.

> the policy source files. Also, there are several instances of rules being
> duplicated in the generated policy due to macro usage.

Duplication of rules is a minor annoyance, and I've been fixing it wherever I 
notice it.  But is it a big problem?  The compiler removes that anyway...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
