Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5IIbm0D004479
 for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2014 14:37:49 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so1177175qcr.2
 for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2014 11:37:50 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov, russell@coker.com.au
Subject: Re: Deprecating policy capabilities
Date: Wed, 18 Jun 2014 14:37:47 -0400
Message-ID: <8580649.HKzoOIrl2x@sifl>
In-Reply-To: <1583671.gXuL95A5XS@xev>
References: <5219244.VNyImXJjQb@sifl> <51BB7C50.6000601@tycho.nsa.gov>
 <1583671.gXuL95A5XS@xev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, June 10, 2014 10:54:21 AM Russell Coker wrote:
> On Fri, 14 Jun 2013 16:25:52 Stephen Smalley wrote:
> > > Oh right, I forgot that there are people that boot new kernels on
> > > ancient distros. How far back does the backward support have to go?
> > 
> > I think the view of the kernel developers was forever; new kernel is
> > never supposed to break old userspace.  Of course there have been a few
> > examples of that being broken by others in other subsystems, but that is
> > frowned upon.
> > 
> > Even if we were to limit it to currently-supported enterprise
> > distributions, I think we'd have to wait until RHEL-5 (policy.20?) is
> > EOL'd.  Don't know about Debian or Ubuntu LTS.   Might as well be
> > forever as we likely won't remember this conversation then.
> 
> Sorry for the late reply, but this is an important an ongoing issue.
> 
> In Debian we don't aim to have any support for a kernel that is more than
> one version of Debian before or after the current version.
> 
> Debian/Wheezy works with a Squeeze kernel and I'll include an update to
> Wheezy to make it work better with a Jessie kernel when Jessie is released.
> 
> I will not accept bug reports about problems mixing Jessie and Squeeze
> parts. So the current userspace can entirely drop support for kernel 2.6.32
> and the current kernel code can drop support for policy 20100524 and
> libselinux 2.0.96 without doing anything that I'll accept as a Debian bug
> report.
> 
> What amount of mixing and matching kernel and userspace versions does Red
> Hat support?

What an individual distribution supports isn't the critical point here as far 
as I'm concerned, the issue is that dropping support for older policies, 
regardless of use, is frowned upon and will likely cause a lot of shouting 
that I'd just assume avoid.

The only real exception to this that I can see is that if we prove that a 
older policies no longer work correctly and fixing it in the kernel is non-
trivial.  Also, when I say "older policies", I'm thinking that the policy has 
to be out of use from any major distribution for quite some time; anything new 
we just need to fix.

-- 
paul moore
www.paul-moore.com
