Message-ID: <1492014798.3881.16.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: Paul Moore <pmoore@redhat.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
 william.c.roberts@intel.com, serge@hallyn.com,
 james.l.morris@oracle.com, Eric Paris <eparis@parisplace.org>,
 Paul Moore <paul@paul-moore.com>, Sebastien Buisson <sbuisson@ddn.com>
Date: Wed, 12 Apr 2017 12:33:18 -0400
In-Reply-To: <CAPkE-bUCK2kFpi6Ls2VYPRDH624xgiu3GGnw5LyeFAfswiaeSA@mail.gmail.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
 <CAPkE-bUsY8qD5xHU4VD-dxtAGxCGUhuQQmcS4kN0FyAozPRzhw@mail.gmail.com>
 <1492005519.3881.8.camel@tycho.nsa.gov>
 <CAPkE-bUCK2kFpi6Ls2VYPRDH624xgiu3GGnw5LyeFAfswiaeSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-12 at 17:19 +0200, Sebastien Buisson wrote:
> 2017-04-12 15:58 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> > Even your usage of selinux_is_enabled() looks suspect; that should
> > probably go away.  Only other user of it seems to be some cred
> > validity
> > checking that could be dropped as well.
> 
> Well the main reason for calling selinux_is_enabled() is performance
> optimization.
> Should I propose a patch to add a new security_is_enabled() function
> at the LSM abstraction layer? Or do you consider we should not test
> security enabled at all?

It isn't clear what "is enabled" means in general, particularly with
stacking. I would either drop it or replace it with a LSM hook that is
more precise.  For example, NFSv4 introduced a security_ismaclabel()
hook so that it could test whether a given security.* xattr is a MAC
label.
