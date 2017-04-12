Message-ID: <1492014294.3881.14.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov,
 william.c.roberts@intel.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Sebastien Buisson
 <sbuisson@ddn.com>, james.l.morris@oracle.com
Date: Wed, 12 Apr 2017 12:24:54 -0400
In-Reply-To: <CAPkE-bWQLfSq0+J0uoMRKAPbSdO0giuGZzfRXA7VXL+xo3fNgg@mail.gmail.com>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
 <CAPkE-bX5-Mo9AMPwf6dwBNT9FeWgAShWwKbkiJg3ZZVpt9itLA@mail.gmail.com>
 <1492007701.3881.10.camel@tycho.nsa.gov>
 <CAPkE-bWQLfSq0+J0uoMRKAPbSdO0giuGZzfRXA7VXL+xo3fNgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-12 at 17:11 +0200, Sebastien Buisson wrote:
> 2017-04-12 16:35 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> > How are you using this SELinux information in the kernel and/or in
> > userspace?  What's the purpose of it?  What are you comparing it
> > against?  Why do you care if it changes?
> 
> Enforcement status and policy version are compared to their
> previously
> stored value. If they differ, then it means we need to call a
> userland
> helper from Lustre client kernelspace to read the currently loaded
> policy (reading it will let us know if the Lustre client node is
> conforming to the Lustre-wide security policy).
> As calling the userland helper is costly, we do it only when it is
> necessary by retrieving some SELinux key information directly from
> kernelspace.

Maybe you want to register a notifier callback on policy reload? See
the archives for the SELinux support for Infiniband RDMA patches (which
seem to have stalled), which included LSM hooks and SELinux
implementation to support notifications on policy reloads.

> 
> > Note btw that the notion of a policy name/type and the policy file
> > path
> > is purely a userspace construct and shouldn't be embedded in your
> > kernel code.  Android for example doesn't follow that convention at
> > all; their SELinux policy file is simply /sepolicy.  On modern
> > kernels,
> > you can always read the currently loaded policy from the kernel
> > itself
> > via /sys/fs/selinux/policy (formerly just /selinux/policy).
> 
> As I understand it, a userspace program can directly read the policy
> info exposed by the kernel by reading this file. But how about
> reading
> it from kernelspace?

In SELinux, the underlying kernel function is security_read_policy();
you'd have to wrap it with a LSM hook interface, and generalize it a
bit wrt whether to use vmalloc_user() or not.

This seems very inefficient though for your purposes.  Wouldn't it be
better to just extend SELinux to compute the checksum from the original
image when the policy is loaded, save that checksum in the policydb,
and provide you with a way to fetch the already computed checksum?  The
computation would be done in security_load_policy() and saved in the
policydb.  Then you could introduce a function and a LSM hook to export
it to your code. We would probably want to also expose it via a
selinuxfs node to userspace.

This however only works for checking that you have a completely
identical policy built in exactly the same way.  You could have
semantically identical policies that still differ in the binary policy
file, or policies with minor local customizations that aren't
significant.  But perhaps that isn't an issue for Lustre environments.
