Date: Tue, 23 Apr 2002 09:42:01 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version
Message-ID: <20020423084201.GB15694@vnl.com>
References: <72222DC86846D411ABD300A0C9EB08A101524354@csoc-mail-box.csoconline.com> <20020422213755.3317C1862@lyta.coker.com.au> <20020422200307.E2192@gricklegrass.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020422200307.E2192@gricklegrass.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 22, 2002 at 08:03:07PM -0400, Howard Holm wrote:

> I guess the one thought to take away is that there are these different
> models, and unless we can all agree on one, perhaps the best thing is
> to allow divergence until use in practice demonstrates some convincing
> advantages of one model or another.  I wish I had definitive answers,
> but I think we're in largely uncharted waters - SELinux is a set of
> distribution neutral changes that nevertheless make pervasive changes
> in a distribution.  It's hard to know the best way to package it.

They may not be as disparate as you fear. Many products will start from
Debian or a package (binary or source) set too make updates easy; it's
really hell and rather costly to diverge too far from the upstream
maintainer's code base, so the economics are driven by that unless
you've a really big operation behind you.

Perhaps the way to think of it is this:

upstream   package              product
main.      main.                maint.
Smalley -> ----      (TGZ) ->   ----             -> end user
           Coker     (DEB)      specialist dists
           Westerman (RPM)      pkg solutions



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
