Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Wed, 9 Jul 2014 19:23:21 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: pcre compiled context files invalid with pcre updates?
Message-ID: <20140709172321.GA10669@siphos.be>
References: <20140709151216.GA8142@siphos.be> <53BD5F61.1040405@tycho.nsa.gov>
 <20140709153657.GA8570@siphos.be> <53BD7645.8060407@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53BD7645.8060407@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 09, 2014 at 01:05:09PM -0400, Stephen Smalley wrote:
> >> The issue came up again in the context of cross-compiling in:
> >> http://marc.info/?t=139275881100002&r=1&w=2
> >> and there was a willingness to add a version but I don't think anyone
> >> proposed a patch to do so.  But even with the version, using the PCRE
> >> version effectively just means that you'll need to regenerate on each
> >> new library version anyway, right?  So what do we gain versus the
> >> current approach of regenerating on pcre updates?
> > 
> > There's a small period between the pcre upgrade and the selinux-policy
> > update in which we'll get these failures again (and in Gentoo, the
> > installation of selinux-policy will fail because a relabeling operation on
> > the files would occur which will segfault - but that's something we need to
> > tackle in Gentoo).
> 
> I see.  How about the attached patch then?

The patch works fine, thanks. Tested with libselinux-2.3, and pcre 8.33 / 8.35. I
timed the difference of setfiles commands to "acknowledge" that the .bin
files were ignored when they needed to (longer duration means regular
context files are used instead of .bin files).

Wkr,
	Sven Vermeulen
