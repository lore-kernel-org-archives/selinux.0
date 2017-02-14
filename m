Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1EMuK90031795
 for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2017 17:56:20 -0500
Date: Wed, 15 Feb 2017 09:55:25 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 kernel-hardening@lists.openwall.com
Subject: Re: [RFC v2 PATCH 1/2] security: introduce
 CONFIG_SECURITY_WRITABLE_HOOKS
In-Reply-To: <201702142324.IFB95862.MOSJLOVFQFtFHO@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.20.1702150952360.6813@namei.org>
References: <alpine.LRH.2.20.1702150016220.32759@namei.org>
 <201702142324.IFB95862.MOSJLOVFQFtFHO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 14 Feb 2017, Tetsuo Handa wrote:

> > diff --git a/security/Kconfig b/security/Kconfig
> > index 118f454..f6f90c4 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -31,6 +31,11 @@ config SECURITY
> >  
> >  	  If you are unsure how to answer this question, answer N.
> >  
> > +config SECURITY_WRITABLE_HOOKS
> > +	depends on SECURITY
> > +	bool
> > +	default n
> > +
> 
> This configuration option must not be set to N without big fat explanation
> about implications of setting this option to N.

It's not visible in the config menu, it's only there to support SELinux 
runtime disablement, otherwise it wouldn't even be an option.

> 
> Honestly, I still don't like this option, regardless of whether SELinux
> needs this option or not.
> 

I agree, it would be better to just enable RO hardening without an option 
to disable it.

-- 
James Morris
<jmorris@namei.org>
