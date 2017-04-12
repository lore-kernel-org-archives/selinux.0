MIME-Version: 1.0
In-Reply-To: <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 12 Apr 2017 15:30:02 +0200
Message-ID: <CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
To: Paul Moore <pmoore@redhat.com>, sds@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, william.c.roberts@intel.com, serge@hallyn.com,
 james.l.morris@oracle.com, Eric Paris <eparis@parisplace.org>,
 Paul Moore <paul@paul-moore.com>, Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-04-12 13:55 GMT+02:00 Paul Moore <pmoore@redhat.com>:
> As currently written this code isn't something we would want to merge
> upstream for two important reasons:
>
> * No abstraction layer at the LSM interface.  The core kernel code
> should not call directly into any specific LSM, all interaction should
> go through the LSM hooks.

The idea behind this patch and the other one was to replicate what is
done with selinux_is_enabled(). As I understand it now,
selinux_is_enabled() should remain the only exception to the LSM
hooks.
So do you agree if I propose a new security_is_enforced() function at
the LSM abstraction layer, which will be hooked to a
selinux_is_enforced() function defined inside the SELinux LSM?
