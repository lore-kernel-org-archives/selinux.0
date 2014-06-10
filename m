From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Deprecating policy capabilities
Date: Tue, 10 Jun 2014 10:54:21 +1000
Message-ID: <1583671.gXuL95A5XS@xev>
In-Reply-To: <51BB7C50.6000601@tycho.nsa.gov>
References: <5219244.VNyImXJjQb@sifl>
 <CADjGSjjz0TX_H7LyLmR1WS_2kpVP8Xau3eRZkAkO4h0yna5Y=Q@mail.gmail.com>
 <51BB7C50.6000601@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SELinux <selinux@tycho.nsa.gov>
Reply-To: russell@coker.com.au
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 14 Jun 2013 16:25:52 Stephen Smalley wrote:
> > Oh right, I forgot that there are people that boot new kernels on
> > ancient distros. How far back does the backward support have to go?
> 
> I think the view of the kernel developers was forever; new kernel is 
> never supposed to break old userspace.  Of course there have been a few 
> examples of that being broken by others in other subsystems, but that is 
> frowned upon.
> 
> Even if we were to limit it to currently-supported enterprise 
> distributions, I think we'd have to wait until RHEL-5 (policy.20?) is 
> EOL'd.  Don't know about Debian or Ubuntu LTS.   Might as well be 
> forever as we likely won't remember this conversation then.

Sorry for the late reply, but this is an important an ongoing issue.

In Debian we don't aim to have any support for a kernel that is more than one 
version of Debian before or after the current version.

Debian/Wheezy works with a Squeeze kernel and I'll include an update to Wheezy 
to make it work better with a Jessie kernel when Jessie is released.

I will not accept bug reports about problems mixing Jessie and Squeeze parts.  
So the current userspace can entirely drop support for kernel 2.6.32 and the 
current kernel code can drop support for policy 20100524 and libselinux 2.0.96 
without doing anything that I'll accept as a Debian bug report.

What amount of mixing and matching kernel and userspace versions does Red Hat 
support?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
