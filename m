Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8D4JZ89008842
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 00:19:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id 14-v6so643388ywe.2
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 21:19:26 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com.
 [209.85.161.53])
 by smtp.gmail.com with ESMTPSA id j8-v6sm990677ywj.6.2018.09.12.21.19.22
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Sep 2018 21:19:23 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id n21-v6so642300ywh.5
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 21:19:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Sep 2018 21:19:21 -0700
Message-ID: <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKLM <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Two proposed security modules require the ability to
> share security blobs with existing "major" security modules.
> These modules, S.A.R.A and LandLock, provide significantly
> different services than SELinux, Smack or AppArmor. Using
> either in conjunction with the existing modules is quite
> reasonable. S.A.R.A requires access to the cred blob, while
> LandLock uses the cred, file and inode blobs.
>
> The use of the cred, file and inode blobs has been
> abstracted in preceding patches in the series. This
> patch teaches the affected security modules how to access
> the part of the blob set aside for their use in the case
> where blobs are shared. The configuration option
> CONFIG_SECURITY_STACKING identifies systems where the
> blobs may be shared.
>
> The mechanism for selecting which security modules are
> active has been changed to allow non-conflicting "major"
> security modules to be used together. At this time the
> TOMOYO module can safely be used with any of the others.
> The two new modules would be non-conflicting as well.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/admin-guide/LSM/index.rst | 14 +++--
>  include/linux/lsm_hooks.h               |  2 +-
>  security/Kconfig                        | 81 +++++++++++++++++++++++++
>  security/apparmor/include/cred.h        |  8 +++
>  security/apparmor/include/file.h        |  9 ++-
>  security/apparmor/include/lib.h         |  4 ++
>  security/apparmor/lsm.c                 |  8 ++-
>  security/security.c                     | 30 ++++++++-
>  security/selinux/hooks.c                |  3 +-
>  security/selinux/include/objsec.h       | 18 +++++-
>  security/smack/smack.h                  | 19 +++++-
>  security/smack/smack_lsm.c              | 17 +++---
>  security/tomoyo/common.h                | 12 +++-
>  security/tomoyo/tomoyo.c                |  3 +-
>  14 files changed, 200 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
> index 9842e21afd4a..d3d8af174042 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -17,10 +17,16 @@ MAC extensions, other extensions can be built using the LSM to provide
>  specific changes to system operation when these tweaks are not available
>  in the core functionality of Linux itself.
>
> -The Linux capabilities modules will always be included. This may be
> -followed by any number of "minor" modules and at most one "major" module.
> -For more details on capabilities, see ``capabilities(7)`` in the Linux
> -man-pages project.
> +The Linux capabilities modules will always be included. For more details
> +on capabilities, see ``capabilities(7)`` in the Linux man-pages project.
> +
> +Security modules that do not use the security data blobs maintained
> +by the LSM infrastructure are considered "minor" modules. These may be
> +included at compile time and stacked explicitly. Security modules that
> +use the LSM maintained security blobs are considered "major" modules.
> +These may only be stacked if the CONFIG_LSM_STACKED configuration
> +option is used. If this is chosen all of the security modules selected
> +will be used.
>
>  A list of the active security modules can be found by reading
>  ``/sys/kernel/security/lsm``. This is a comma separated list, and
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 416b20c3795b..dddcced54fea 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2079,7 +2079,7 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  #define __lsm_ro_after_init    __ro_after_init
>  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>
> -extern int __init security_module_enable(const char *module);
> +extern bool __init security_module_enable(const char *lsm, const bool stacked);
>  extern void __init capability_add_hooks(void);
>  #ifdef CONFIG_SECURITY_YAMA
>  extern void __init yama_add_hooks(void);
> diff --git a/security/Kconfig b/security/Kconfig
> index 22f7664c4977..ed48025ae9e0 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -36,6 +36,28 @@ config SECURITY_WRITABLE_HOOKS
>         bool
>         default n
>
> +config SECURITY_STACKING
> +       bool "Security module stacking"
> +       depends on SECURITY
> +       help
> +         Allows multiple major security modules to be stacked.
> +         Modules are invoked in the order registered with a
> +         "bail on fail" policy, in which the infrastructure
> +         will stop processing once a denial is detected. Not
> +         all modules can be stacked. SELinux, Smack and AppArmor are
> +         known to be incompatible. User space components may
> +         have trouble identifying the security module providing
> +         data in some cases.
> +
> +         If you select this option you will have to select which
> +         of the stackable modules you wish to be active. The
> +         "Default security module" will be ignored. The boot line
> +         "security=" option can be used to specify that one of
> +         the modules identifed for stacking should be used instead
> +         of the entire stack.
> +
> +         If you are unsure how to answer this question, answer N.

I don't see a good reason to make this a config. Why shouldn't this
always be enabled?

> +
>  config SECURITY_LSM_DEBUG
>         bool "Enable debugging of the LSM infrastructure"
>         depends on SECURITY
> @@ -250,6 +272,9 @@ source security/yama/Kconfig
>
>  source security/integrity/Kconfig
>
> +menu "Security Module Selection"
> +       visible if !SECURITY_STACKING
> +
>  choice
>         prompt "Default security module"
>         default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
> @@ -289,3 +314,59 @@ config DEFAULT_SECURITY
>
>  endmenu
>
> +menu "Security Module Stack"
> +       visible if SECURITY_STACKING
> +
> +choice
> +       prompt "Stacked 'extreme' security module"
> +       default SECURITY_SELINUX_STACKED if SECURITY_SELINUX
> +       default SECURITY_SMACK_STACKED if SECURITY_SMACK
> +       default SECURITY_APPARMOR_STACKED if SECURITY_APPARMOR

I don't think any of this is needed either: we already have the
CONFIG_DEFAULT_SECURITY_* choice.

> [...]
> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
> index a90eae76d7c1..be7575adf6f0 100644
> --- a/security/apparmor/include/cred.h
> +++ b/security/apparmor/include/cred.h
> @@ -25,7 +25,11 @@
>
>  static inline struct aa_label *cred_label(const struct cred *cred)
>  {
> +#ifdef CONFIG_SECURITY_STACKING
> +       struct aa_label **blob = cred->security + apparmor_blob_sizes.lbs_cred;
> +#else
>         struct aa_label **blob = cred->security;
> +#endif

Without the config, then there's no need for all these #ifdefs.

> -#define file_ctx(X) ((struct aa_file_ctx *)(X)->f_security)
> +static inline struct aa_file_ctx *file_ctx(struct file *file)
> +{
> +#ifdef CONFIG_SECURITY_STACKING
> +       return file->f_security + apparmor_blob_sizes.lbs_file;
> +#else
> +       return file->f_security;
> +#endif
> +}

This define->inline should have been part of an earlier patch.

>  /* struct aa_file_ctx - the AppArmor context the file was opened in
>   * @lock: lock to update the ctx
> diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
> index 6505e1ad9e23..bbe9b384d71d 100644
> --- a/security/apparmor/include/lib.h
> +++ b/security/apparmor/include/lib.h
> @@ -16,6 +16,7 @@
>
>  #include <linux/slab.h>
>  #include <linux/fs.h>
> +#include <linux/lsm_hooks.h>
>
>  #include "match.h"
>
> @@ -55,6 +56,9 @@ const char *aa_splitn_fqname(const char *fqname, size_t n, const char **ns_name,
>                              size_t *ns_len);
>  void aa_info_message(const char *str);
>
> +/* Security blob offsets */
> +extern struct lsm_blob_sizes apparmor_blob_sizes;
> +
>  /**
>   * aa_strneq - compare null terminated @str to a non null terminated substring
>   * @str: a null terminated string
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 15716b6ff860..36d8386170e8 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1553,7 +1553,9 @@ static int __init apparmor_init(void)
>         int error;
>
>         if (!finish) {
> -               if (apparmor_enabled && security_module_enable("apparmor"))
> +               if (apparmor_enabled &&
> +                   security_module_enable("apparmor",
> +                               IS_ENABLED(CONFIG_SECURITY_APPARMOR_STACKED)))
>                         security_add_blobs(&apparmor_blob_sizes);
>                 else
>                         apparmor_enabled = false;
> @@ -1561,7 +1563,9 @@ static int __init apparmor_init(void)
>                 return 0;
>         }
>
> -       if (!apparmor_enabled || !security_module_enable("apparmor")) {
> +       if (!apparmor_enabled ||
> +           !security_module_enable("apparmor",
> +                               IS_ENABLED(CONFIG_SECURITY_APPARMOR_STACKED))) {
>                 aa_info_message("AppArmor disabled by boot time parameter");
>                 apparmor_enabled = false;
>                 return 0;

I don't think any of these changes are needed either with the loss of
the config.

> diff --git a/security/security.c b/security/security.c
> index 2501cdcbebff..06bed74d1ed0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -36,6 +36,7 @@
>
>  /* Maximum number of letters for an LSM name string */
>  #define SECURITY_NAME_MAX      10
> +#define MODULE_STACK           "(stacking)"
>
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> @@ -48,7 +49,11 @@ static struct lsm_blob_sizes blob_sizes;
>
>  /* Boot-time LSM user choice */
>  static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
> +#ifdef CONFIG_SECURITY_STACKING
> +       MODULE_STACK;
> +#else
>         CONFIG_DEFAULT_SECURITY;
> +#endif
>
>  static void __init do_security_initcalls(void)
>  {
> @@ -169,6 +174,7 @@ static int lsm_append(char *new, char **result)
>  /**
>   * security_module_enable - Load given security module on boot ?
>   * @module: the name of the module
> + * @stacked: indicates that the module wants to be stacked
>   *
>   * Each LSM must pass this method before registering its own operations
>   * to avoid security registration races. This method may also be used
> @@ -184,9 +190,29 @@ static int lsm_append(char *new, char **result)
>   *
>   * Otherwise, return false.
>   */
> -int __init security_module_enable(const char *module)
> +bool __init security_module_enable(const char *lsm, const bool stacked)
>  {
> -       return !strcmp(module, chosen_lsm);
> +#ifdef CONFIG_SECURITY_STACKING
> +       /*
> +        * Module defined on the command line security=XXXX
> +        */
> +       if (strcmp(chosen_lsm, MODULE_STACK)) {
> +               if (!strcmp(lsm, chosen_lsm)) {
> +                       pr_info("Command line sets the %s security module.\n",
> +                               lsm);
> +                       return true;
> +               }
> +               return false;
> +       }
> +       /*
> +        * Module configured as stacked.
> +        */
> +       return stacked;
> +#else
> +       if (strcmp(lsm, chosen_lsm) == 0)
> +               return true;
> +       return false;
> +#endif
>  }

I don't see the need for this? security_module_enable() will already
specify if it's been selected as the "primary" LSM.

The only change I think is needed here is to treat tomoyo differently.
It can now operate independently, like the "minor" LSMs. So we have
three types of LSMs now: "conflicting", "non-conflicting", and
"minor".

The only differences are how they get initialized. Major use
security_initcall() and minor use explicit calls to $lsm_add_hooks().
Yama is always enabled if built in. Loadpin uses a module parameter
("loadpin.enabled") and checks it when loadpin_add_hooks() is called.

To split tomoyo away from the other security modules, we need to track
its enablement _separately_ from the conflicting LSMs.

i.e. choose_lsm() needs to change, or tomoyo needs to use a module
parameter ("tomoyo.enabled"), or a __setup() call like apparmor and
selinux do for enablement. (Note that apparmor and selinux check
_both_ their __setup() and security_module_enable() values...)

For example (untested, likely whitespace damaged):

diff --git a/security/tomoyo/Kconfig b/security/tomoyo/Kconfig
index 404dce66952a..4edc8e733245 100644
--- a/security/tomoyo/Kconfig
+++ b/security/tomoyo/Kconfig
@@ -14,6 +14,14 @@ config SECURITY_TOMOYO
          found at <http://tomoyo.sourceforge.jp/>.
          If you are unsure how to answer this question, answer N.

+config SECURITY_TOMOYO_ENABLED
+       bool "Enable TOMOYO at boot"
+       depends on SECURITY_TOMOYO
+       default SECURITY_TOMOYO
+       help
+         If selected, TOMOYO will be enabled at boot. If not selected, it
+         can be enabled at boot with the kernel parameter "tomoyo.enabled=1".
+
 config SECURITY_TOMOYO_MAX_ACCEPT_ENTRY
        int "Default maximal count for learning mode"
        default 2048
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9f932e2d6852..8dc9ef2096ab 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -531,6 +531,8 @@ static struct security_hook_list tomoyo_hooks[]
__lsm_ro_after_init = {
 /* Lock for GC. */
 DEFINE_SRCU(tomoyo_ss);

+static int enabled = IS_ENABLED(CONFIG_SECURITY_TOMOYO_ENABLED);
+
 /**
  * tomoyo_init - Register TOMOYO Linux as a LSM module.
  *
@@ -540,7 +542,7 @@ static int __init tomoyo_init(void)
 {
        struct cred *cred = (struct cred *) current_cred();

-       if (!security_module_enable("tomoyo"))
+       if (!enabled)
                return 0;
        /* register ourselves with the security framework */
        security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
@@ -550,4 +552,8 @@ static int __init tomoyo_init(void)
        return 0;
 }

+/* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
+module_param(enabled, int, 0);
+MODULE_PARM_DESC(enabled, "Tomoyo enabled at boot");
+
 security_initcall(tomoyo_init);


(I prefer LSMs do enablement with module params so that they leave
their namespace open for other runtime configuration. I think
"apparmor=" and "selinux=" for enable/disable isn't good to
replicate.)

We will quickly encounter "LSM ordering" as an issue, but not in this
case yet: there's no new LSM. Ordering is preserved even with my
suggestion: major order is controlled by Makefile link ordering, and
minor is controlled by explicit ordering in security/security.c's
add_hooks() calls.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 6617abb51732..be14540ce09c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3493,18 +3493,16 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  {
>         struct smack_known *skp = smk_of_task_struct(p);
>         char *cp;
> -       int slen;
>
> -       if (strcmp(name, "current") != 0)
> +       if (strcmp(name, "current") == 0) {
> +               cp = kstrdup(skp->smk_known, GFP_KERNEL);
> +               if (cp == NULL)
> +                       return -ENOMEM;
> +       } else
>                 return -EINVAL;
>
> -       cp = kstrdup(skp->smk_known, GFP_KERNEL);
> -       if (cp == NULL)
> -               return -ENOMEM;
> -
> -       slen = strlen(cp);
>         *value = cp;
> -       return slen;
> +       return strlen(cp);
>  }

This refactoring seems out of place?

-Kees

-- 
Kees Cook
Pixel Security
