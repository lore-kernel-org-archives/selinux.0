Message-ID: <1492007701.3881.10.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>, Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov, william.c.roberts@intel.com,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Sebastien Buisson <sbuisson@ddn.com>, james.l.morris@oracle.com
Date: Wed, 12 Apr 2017 10:35:01 -0400
In-Reply-To: <CAPkE-bX5-Mo9AMPwf6dwBNT9FeWgAShWwKbkiJg3ZZVpt9itLA@mail.gmail.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
 <CAPkE-bX5-Mo9AMPwf6dwBNT9FeWgAShWwKbkiJg3ZZVpt9itLA@mail.gmail.com>
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
> > * No clear user of this functionality.  There needs to be a well
> > defined user of this functionality in the kernel.
> 
> The use case for this new functionality (and the other one) is
> getting
> SELinux information from the Lustre client code in kernel space.
> Latest patch can be accessed at:
> https://review.whamcloud.com/24421
> Actual user is sptlrpc_get_sepol() function in
> lustre/lustre/ptlrpc/sec.c file.
> This code will be pushed to the upstream kernel as soon as it is
> landed into Lustre master branch.

How are you using this SELinux information in the kernel and/or in
userspace?  What's the purpose of it?  What are you comparing it
against?  Why do you care if it changes?

Note btw that the notion of a policy name/type and the policy file path
is purely a userspace construct and shouldn't be embedded in your
kernel code.  Android for example doesn't follow that convention at
all; their SELinux policy file is simply /sepolicy.  On modern kernels,
you can always read the currently loaded policy from the kernel itself
via /sys/fs/selinux/policy (formerly just /selinux/policy).
