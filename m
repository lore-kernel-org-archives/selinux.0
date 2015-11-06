Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6HSKnN023798
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 12:28:20 -0500
From: Paul Moore <pmoore@redhat.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: New SELinux userspace release supporting extended ioctl
 permissions?
Date: Fri, 06 Nov 2015 12:28 -0500
Message-ID: <15905901.1XIAY3c11E@sifl>
In-Reply-To: <563CD60D.9090605@quarksecurity.com>
References: <1852496.Nbh2u1K4Uk@sifl> <20151106162635.GA10239@x250>
 <563CD60D.9090605@quarksecurity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 06, 2015 11:32:13 AM Joshua Brindle wrote:
> Dominick Grift wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA512
> > 
> > On Fri, Nov 06, 2015 at 10:37:35AM -0500, Paul Moore wrote:
> >> Now that Linux 4.3 has been released with the extended ioctl permissions,
> >> are we planning to make a new userspace release so that we can take
> >> advantage of this new functionality?  I believe all the necessary
> >> patches have been merged, no?
> > 
> > Are you referring to anything in particular?
> > 
> > There is already some support:
> > https://github.com/SELinuxProject/selinux/commit/ef93dfe0393c4a60483c3f77
> > 29dd98a2f886606a
>
> I think he means actually making a release...

Yes, exactly.  I'm old fashioned that way.

-- 
paul moore
security @ redhat
