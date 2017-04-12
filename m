MIME-Version: 1.0
In-Reply-To: <1492005519.3881.8.camel@tycho.nsa.gov>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
 <CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
 <1492005519.3881.8.camel@tycho.nsa.gov>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 12 Apr 2017 17:19:14 +0200
Message-ID: <CAPkE-bUCK2kFpi6Ls2VYPRDH624xgiu3GGnw5LyeFAfswiaeSA@mail.gmail.com>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <pmoore@redhat.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
 william.c.roberts@intel.com, serge@hallyn.com,
 james.l.morris@oracle.com, Eric Paris <eparis@parisplace.org>,
 Paul Moore <paul@paul-moore.com>, Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-04-12 15:58 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> Even your usage of selinux_is_enabled() looks suspect; that should
> probably go away.  Only other user of it seems to be some cred validity
> checking that could be dropped as well.

Well the main reason for calling selinux_is_enabled() is performance
optimization.
Should I propose a patch to add a new security_is_enabled() function
at the LSM abstraction layer? Or do you consider we should not test
security enabled at all?
