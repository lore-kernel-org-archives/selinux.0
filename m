From: Andrew Perepechko <anserper@ya.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 andrew.perepechko@seagate.com
Subject: Re: [PATCH] selinux: export validatetrans decisions
Date: Tue, 27 Oct 2015 21:27:32 +0300
Message-ID: <3826370.MZ6nvm2ybe@panda-pc>
In-Reply-To: <562FBF50.2090700@tycho.nsa.gov>
References: <1445965643-30900-1-git-send-email-anserper@ya.ru>
 <562FBF50.2090700@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Stephen!

Thank you for your the response.

On Tuesday 27 Oct 2015 14:15:44 Stephen Smalley wrote:
> Follow the example of security_transition_sid(), i.e. introduce a _user
> interface() and re-factor the existing security_validate_transition()
> into a common helper that takes a bool argument.

OK.

> 
> Could be confusing since it is for validate_transition not transition_sid.
> Probably ought to put validate into the name in some form.
> 

OK.

> 
> Just define a new permission in include/classmap.h (and in your policy,
> of course) and use it.
> 

OK.

> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = -ENOMEM;
> > +	if (count >= PAGE_SIZE - 1)
> > +		goto out;
> 
> Why PAGE_SIZE-1?
> 

This is to avoid allocation of more than a single page.
kzalloc(count+1) will guarantee the string is zero-terminated.

The code below can be slightly optimized by modifying the
copied string in-place, but I tried to follow the style
used in neighbouring functions.

> 
> #next has security_context_str_to_sid() as a convenient helper for this.
> 

OK.

> 
> Hmm...in what situation don't you want it to reflect the kernel
> enforcing mode (i.e. when won't you just have your userspace file server
> end up checking security_getenforce() and ignore the error in that
> situation)?  Userspace AVC is different since it is caching decisions
> from the kernel but still ends up honoring the kernel's enforcing status
> (unless you explicitly set it to use its own private one).

We expected to have an option to be able to enforce the policy even
if the server itself is running in permissive, but this is not a critical
requirement, so I'll update this bit.

> 
> Beyond that, the things that you don't want to happen when called from
> userspace include not unmapping the class value and not printk'ing on an
> unrecognized class.  See security_transition_sid_user() ->
> security_compute_sid() for example.
> 

Sorry, you are right, indeed. :( This part somehow did not get in the final 
patch.

I'll update the patch according to your comments.

Andrew
