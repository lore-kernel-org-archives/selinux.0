Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Wed, 9 Jul 2014 17:36:58 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: pcre compiled context files invalid with pcre updates?
Message-ID: <20140709153657.GA8570@siphos.be>
References: <20140709151216.GA8142@siphos.be> <53BD5F61.1040405@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53BD5F61.1040405@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 09, 2014 at 11:27:29AM -0400, Stephen Smalley wrote:
> > Do you think the above analysis makes sense? The bug linked earlier on has a
> > gdb backtrace for those interested. Any other pointers that might help us
> > troubleshoot this would be appreciated.
> 
> When this came up in:
> http://marc.info/?t=137192124100002&r=1&w=2
> the solution was to add a trigger to the selinux-policy package to
> always rebuild the policy (which includes regenerating the .bin file) on
> pcre upgrades.
> 
> Are you not doing that in Gentoo?

Not yet, we're exploring our options.

I was hoping the previous time was a one-off, but apparently it's not.

> The issue came up again in the context of cross-compiling in:
> http://marc.info/?t=139275881100002&r=1&w=2
> and there was a willingness to add a version but I don't think anyone
> proposed a patch to do so.  But even with the version, using the PCRE
> version effectively just means that you'll need to regenerate on each
> new library version anyway, right?  So what do we gain versus the
> current approach of regenerating on pcre updates?

There's a small period between the pcre upgrade and the selinux-policy
update in which we'll get these failures again (and in Gentoo, the
installation of selinux-policy will fail because a relabeling operation on
the files would occur which will segfault - but that's something we need to
tackle in Gentoo).

Wkr,
	Sven Vermeulen
