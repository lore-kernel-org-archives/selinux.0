Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t96MKt47010664
 for <selinux@tycho.nsa.gov>; Tue, 6 Oct 2015 18:20:55 -0400
From: Paul Moore <pmoore@redhat.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v2 5/5] selinux: introduce kdbus access controls
Date: Tue, 06 Oct 2015 18:20:51 -0400
Message-ID: <21245029.iIIe2WA6vd@sifl>
In-Reply-To: <56141925.5050004@m4x.org>
References: <20151005203358.32023.88592.stgit@localhost>
 <20151005204137.32023.7198.stgit@localhost> <56141925.5050004@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, October 06, 2015 08:55:33 PM Nicolas Iooss wrote:
> On 10/05/2015 10:41 PM, Paul Moore wrote:
> > Add the SELinux access control implementation for the new kdbus LSM
> 
> > hooks using the new kdbus object class and the following permissions:
> [[SNIP]]
> 
> > diff --git a/security/selinux/include/classmap.h
> > b/security/selinux/include/classmap.h index eccd61b..31e4435 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -153,5 +153,9 @@ struct security_class_mapping secclass_map[] = {
> > 
> >  	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
> >  	
> >  	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
> >  	
> >  		      NULL } },
> > 
> > +	{ "kdbus", { "impersonate", "fakecreds", "fakepids", "owner",
> > +		     "privileged", "activator", "monitor", "policy_holder",
> > +		     "connect", "own", "talk", "see", "see_name",
> > +		     "see_notification" } },
> > 
> >  	{ NULL }
> >  	
> >    };
> 
> Hello,
> Out of curiosity, why is the new list of permissions not
> NULL-terminated?

Honest answer: I forgot :)

These patches are still "RFC quality" which means I'm emphasizing getting the 
patches posted quickly (hardy har har) and not putting the code through as 
much testing and scrutiny as I usually do.  The idea right now is to get 
feedback about the hooks and the individual LSM implementations.

Regardless, thanks for catching the missing terminator, the fix will be in the 
next draft of the patches.

-- 
paul moore
security @ redhat
