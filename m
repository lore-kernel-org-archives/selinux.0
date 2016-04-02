Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u32JmLMU008482
 for <selinux@tycho.nsa.gov>; Sat, 2 Apr 2016 15:48:21 -0400
Received: by mail-ob0-f178.google.com with SMTP id bg3so7080806obb.1
 for <selinux@tycho.nsa.gov>; Sat, 02 Apr 2016 12:48:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459550439-29408-1-git-send-email-jeffv@google.com>
References: <1459550439-29408-1-git-send-email-jeffv@google.com>
Date: Sat, 2 Apr 2016 11:31:31 -0400
Message-ID: <CAHC9VhTQUTAUByVGrrFLxm_w8xzx8cvvrKYscnkRzs7b4fVDsg@mail.gmail.com>
Subject: Re: [PATCH] selinux: restrict kernel module loading
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>, nnk@google.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Apr 1, 2016 at 6:40 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
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
> type has permission module_load for the kernel target type.
> Example for init_module:
>
> allow foo kernel:system module_load;
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  security/selinux/hooks.c            | 52 +++++++++++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  2 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3fa3ca5..5bc4875 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3719,6 +3719,57 @@ static int selinux_kernel_module_request(char *kmod_name)
>                             SYSTEM__MODULE_REQUEST, &ad);
>  }
>
> +static int selinux_kernel_module_from_file(struct file *file)
> +{
> +       struct common_audit_data ad;
> +       struct inode_security_struct *isec;
> +       struct file_security_struct *fsec;
> +       struct inode *inode;
> +       u32 sid = current_sid();
> +       int rc;
> +
> +       /* init_module */
> +       if (file == NULL) {
> +               rc = avc_has_perm(sid, SECINITSID_KERNEL, SECCLASS_SYSTEM,
> +                                       SYSTEM__MODULE_LOAD, NULL);
> +               goto out;
> +       }

I don't think the object type is correct here; in this case, the
object is the kernel module being loaded, and with init_module() that
kernel module is coming from the calling process, not the kernel.  It
seems like the following would be more appropriate:

  avc_has_perm(sid, sid, SECCLASS_SYSTEM, SYSTEM__MODULE_LOAD, NULL);

-- 
paul moore
www.paul-moore.com
