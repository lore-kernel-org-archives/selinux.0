Date: Mon, 22 Apr 2002 20:03:07 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version
Message-ID: <20020422200307.E2192@gricklegrass.epoch.ncsc.mil>
References: <72222DC86846D411ABD300A0C9EB08A101524354@csoc-mail-box.csoconline.com> <20020422213755.3317C1862@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020422213755.3317C1862@lyta.coker.com.au>; from russell@coker.com.au on Mon, Apr 22, 2002 at 11:37:54PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 22, 2002 at 11:37:54PM +0200, Russell Coker wrote:
> On Mon, 22 Apr 2002 14:40, Westerman, Mark wrote:
> > If future releases of selinux I think we should sub-divided into
> > more packages
> > 	selinux-kernel-<kernel version>-<NSA Release number>
> > 	selinux-policy-<version number>-<release>
> > 	selinxu-utils-<version number>-<release>
> > 		To include newrole, run_init and ......
> > 		Or a separate rpm for utility ?
> 
> Why split the sample policy from the utilities?  Why would you use one 
> without the other?
> 
> > Currently there is a question if any package should rebuild the
> > policy. The current rpm I am building will only build a policy
> > if /etc/selinux/policy does not exist. It created it and installs
> > the example policy. Other wise if /etc/selinux/policy exist the
> > install will not touch the policy.
> 
> Same here.
 
There seem to be a couple of different "mental models" of how SELinux
will work in the future.  I have some thoughts on which I like better,
but am in no better position to predict the future than anyone else.

One model seems to be that SELinux will always be an "add-on" that highly
security aware administrators tune and use based on NSA releases.
Another model has SELinux "distributions" that are out-of-the-box SELinux
and allow security tuning, but are configured "adequately" by default.
Yet another model has SELinux "distributions" with "drop-in" policies
depending on the intended use.

I think if you look at what packagers are proposing you will often see
that they have some specific assumptions from one or more of these models
built in to what they're doing.  The model I've been advocating (which
may or may not be what everyone else wants) is to have SELinux
"distributions" which out-of-the-box understand a small number of policies.
If you don't like those you can build your own policy.  The packaging
implications of that model are that SELinux is not "add-on" packages, but
rather incorporated into all "appropriate" packages for the distribution.
Remember here that a goal of SELinux was that it be transparent to most
applications, only visible when the application would otherwise break a
policy.  Thus, most packages shouldn't require changes.  A second
implication is that adding packages which will require policy changes
should change the system policy unless that policy is not one of the
"standard" policies.

So, clearly there is a reason to separate the policy from the utilities
if you envision different policies being available.  My current thinking
is that each package should contain the policy language necessary for
that package for at least a "default" policy, and probably a few others
(e.g, firewall, server, workstation.)  Frankly, I lean toward putting
the bulk of the non-package specific policy in the filesystem RPM for
Red Hat based distributions, but I suspect that's a radical position
to take.  Equally radical, I advocate some analysis of the "current"
policy (either by system configuration parameter - anyone for
/etc/sysconfig/policy?) or pointer or diff/patch that determines if
"interesting" (i.e., non "users") parts of the policy are default
or not, and installs appropriate changes.  Lastly, if successful, I
expect that SELinux will evolve directly in the mainline kernel and
mainline packages.  So, while new enhancements based on research are
likely to come from NSA from time to time, I expect version X and X+1
of SELinux to differ more based on kernel changes than NSA releases
(in the distant future.)  Thus, I don't expect NSA version numbers
to be interesting over the long term.  This doesn't alter the fact that
in the short term, NSA version numbers are how you "know what you've
got."  Although the kernel usually cycles up at least a release between
NSA versions, we aren't promising that.  It's entirely likely that
if development releases occur (as expected) much faster than stable
releases, that multiple NSA releases with slightly different operation
are built for the same stable kernel version.

I guess the one thought to take away is that there are these different
models, and unless we can all agree on one, perhaps the best thing is
to allow divergence until use in practice demonstrates some convincing
advantages of one model or another.  I wish I had definitive answers,
but I think we're in largely uncharted waters - SELinux is a set of
distribution neutral changes that nevertheless make pervasive changes
in a distribution.  It's hard to know the best way to package it.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
