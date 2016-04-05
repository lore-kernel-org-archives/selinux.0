Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u35KKNN4029673
 for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2016 16:20:23 -0400
Received: by mail-io0-f196.google.com with SMTP id z133so4149059iod.1
 for <selinux@tycho.nsa.gov>; Tue, 05 Apr 2016 13:20:21 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH v3] selinux: restrict kernel module loading
Date: Tue, 05 Apr 2016 16:20:19 -0400
Message-ID: <8908738.EEDhGzQ6mK@sifl>
In-Reply-To: <1459886787-19858-1-git-send-email-jeffv@google.com>
References: <1459886787-19858-1-git-send-email-jeffv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, April 05, 2016 01:06:27 PM Jeff Vander Stoep wrote:
> Utilize existing kernel_read_file hook on kernel module load.
> Add module_load permission to the system class.
> 
> Enforces restrictions on kernel module origin when calling the
> finit_module syscall. The hook checks that source type has
> permission module_load for the target type.
> Example for finit_module:
> 
> allow foo bar_file:system module_load;
> 
> Similarly restrictions are enforced on kernel module loading when
> calling the init_module syscall. The hook checks that source
> type has permission module_load with itself as the target object
> because the kernel module is sourced from the calling process.
> Example for init_module:
> 
> allow foo foo:system module_load;
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
> v2: The target type for init_module changed from SECINITSID_KERNEL
> to the same type as the source.
> v3: Use inode_security() to ensure inode's label is revalidated.

Merged, thanks for your patience.  I had to do one minor fixup to resolve a 
problem at compile time, see below.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3fa3ca5..231c897 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

...

> +static selinux_kernel_read_file(struct file *file, enum kernel_read_file_id
> id)

You're missing the return type :)  No need to resend, I fixed it when merging 
your patch, see the selinux#next branch.

-- 
paul moore
www.paul-moore.com
