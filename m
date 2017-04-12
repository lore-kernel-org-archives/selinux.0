MIME-Version: 1.0
In-Reply-To: <1492007701.3881.10.camel@tycho.nsa.gov>
References: <1491988018-4120-1-git-send-email-sbuisson@ddn.com>
 <CAGH-KgsymFfRqDnmn1kLpWiPtHFkLU3UMKVu=8=NOUwk+qWjmg@mail.gmail.com>
 <CAPkE-bX5-Mo9AMPwf6dwBNT9FeWgAShWwKbkiJg3ZZVpt9itLA@mail.gmail.com>
 <1492007701.3881.10.camel@tycho.nsa.gov>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 12 Apr 2017 17:11:43 +0200
Message-ID: <CAPkE-bWQLfSq0+J0uoMRKAPbSdO0giuGZzfRXA7VXL+xo3fNgg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add selinux_is_enforced() function
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov,
 william.c.roberts@intel.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Sebastien Buisson <sbuisson@ddn.com>, james.l.morris@oracle.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-04-12 16:35 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> How are you using this SELinux information in the kernel and/or in
> userspace?  What's the purpose of it?  What are you comparing it
> against?  Why do you care if it changes?

Enforcement status and policy version are compared to their previously
stored value. If they differ, then it means we need to call a userland
helper from Lustre client kernelspace to read the currently loaded
policy (reading it will let us know if the Lustre client node is
conforming to the Lustre-wide security policy).
As calling the userland helper is costly, we do it only when it is
necessary by retrieving some SELinux key information directly from
kernelspace.

> Note btw that the notion of a policy name/type and the policy file path
> is purely a userspace construct and shouldn't be embedded in your
> kernel code.  Android for example doesn't follow that convention at
> all; their SELinux policy file is simply /sepolicy.  On modern kernels,
> you can always read the currently loaded policy from the kernel itself
> via /sys/fs/selinux/policy (formerly just /selinux/policy).

As I understand it, a userspace program can directly read the policy
info exposed by the kernel by reading this file. But how about reading
it from kernelspace?
