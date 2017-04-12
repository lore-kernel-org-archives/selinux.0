Message-ID: <1492005519.3881.8.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>, Paul Moore <pmoore@redhat.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, william.c.roberts@intel.com, serge@hallyn.com,
 james.l.morris@oracle.com, Eric Paris <eparis@parisplace.org>, Paul Moore
 <paul@paul-moore.com>, Sebastien Buisson <sbuisson@ddn.com>
Date: Wed, 12 Apr 2017 09:58:39 -0400
In-Reply-To: <CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
 <CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-12 at 15:30 +0200, Sebastien Buisson wrote:
> 2017-04-12 13:55 GMT+02:00 Paul Moore <pmoore@redhat.com>:
> > As currently written this code isn't something we would want to
> > merge
> > upstream for two important reasons:
> > 
> > * No abstraction layer at the LSM interface.  The core kernel code
> > should not call directly into any specific LSM, all interaction
> > should
> > go through the LSM hooks.
> 
> The idea behind this patch and the other one was to replicate what is
> done with selinux_is_enabled(). As I understand it now,
> selinux_is_enabled() should remain the only exception to the LSM
> hooks.
> So do you agree if I propose a new security_is_enforced() function at
> the LSM abstraction layer, which will be hooked to a
> selinux_is_enforced() function defined inside the SELinux LSM?

Even your usage of selinux_is_enabled() looks suspect; that should
probably go away.  Only other user of it seems to be some cred validity
checking that could be dropped as well.  The include/linux/selinux.h
interfaces were originally for use by audit and secmark when there were
no other LSMs and have gradually been removed.
