Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8CNrkJf002097
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 19:53:46 -0400
Received: by mail-yb1-f193.google.com with SMTP id y20-v6so2515460ybi.13
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 16:53:36 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com.
 [209.85.219.181])
 by smtp.gmail.com with ESMTPSA id j70-v6sm762978ywb.69.2018.09.12.16.53.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Sep 2018 16:53:33 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id c4-v6so2538669ybl.6
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 16:53:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d92f5457-c7b0-a768-2411-5a5528f88fc8@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <d92f5457-c7b0-a768-2411-5a5528f88fc8@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Sep 2018 16:53:31 -0700
Message-ID: <CAGXu5jLxnmyNzWV2VV0tq-ikAnMAPfebfqxSWvHPUVDZ_xYsyg@mail.gmail.com>
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
Subject: Re: [PATCH 04/10] LSM: Infrastructure management of the
 cred security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the cred security blob out of the
> security modules and into the security infrastructure.
> Instead of allocating and freeing space the security
> modules tell the infrastructure how much space they
> require.

There's a lot of changes here that I think deserve some longer
discussion in the changelog. Notably, now we run _two_ cycles of init
calls? That seems... odd. Notes below...

> Some SELinux memory management debug code has been removed.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  14 ++++
>  kernel/cred.c                     |  13 ----
>  security/Kconfig                  |  11 ++++
>  security/apparmor/domain.c        |   2 +-
>  security/apparmor/include/cred.h  |  16 ++++-
>  security/apparmor/lsm.c           |  28 ++++++--
>  security/apparmor/task.c          |   6 +-
>  security/security.c               | 106 +++++++++++++++++++++++++++++-
>  security/selinux/hooks.c          |  63 +++++-------------
>  security/selinux/include/objsec.h |   4 ++
>  security/selinux/selinuxfs.c      |   1 +
>  security/smack/smack.h            |   1 +
>  security/smack/smack_lsm.c        |  85 +++++++++---------------
>  security/tomoyo/common.h          |  21 +++++-
>  security/tomoyo/domain.c          |   4 +-
>  security/tomoyo/securityfs_if.c   |  15 +++--
>  security/tomoyo/tomoyo.c          |  56 +++++++++++++---
>  17 files changed, 303 insertions(+), 143 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 97a020c616ad..0bef312efd45 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2024,6 +2024,13 @@ struct security_hook_list {
>         char                            *lsm;
>  } __randomize_layout;
>
> +/*
> + * Security blob size or offset data.
> + */
> +struct lsm_blob_sizes {
> +       int     lbs_cred;
> +};
> +
>  /*
>   * Initializing a security_hook_list structure takes
>   * up a lot of space in a source file. This macro takes
> @@ -2036,6 +2043,7 @@ struct security_hook_list {
>  extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>
> +extern void security_add_blobs(struct lsm_blob_sizes *needed);
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>                                 char *lsm);
>
> @@ -2082,4 +2090,10 @@ void __init loadpin_add_hooks(void);
>  static inline void loadpin_add_hooks(void) { };
>  #endif
>
> +extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
> +
> +#ifdef CONFIG_SECURITY
> +void lsm_early_cred(struct cred *cred);
> +#endif
> +
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf03657e71c..fa2061ee4955 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
>  {
>         if (cred->magic != CRED_MAGIC)
>                 return true;
> -#ifdef CONFIG_SECURITY_SELINUX
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       if (selinux_is_enabled() && cred->security) {
> -               if ((unsigned long) cred->security < PAGE_SIZE)
> -                       return true;
> -               if ((*(u32 *)cred->security & 0xffffff00) ==
> -                   (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
> -                       return true;

These aren't unreasonable checks -- can we add them back in later?
(They don't need to be selinux specific, in fact: the LSM could do the
poison...)

> [...]
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 08c88de0ffda..726910bba84b 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -975,7 +975,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>         }
>         aa_put_label(cred_label(bprm->cred));
>         /* transfer reference, released when cred is freed */
> -       cred_label(bprm->cred) = new;
> +       set_cred_label(bprm->cred, new);
>
>  done:
>         aa_put_label(label);
> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
> index e287b7d0d4be..a90eae76d7c1 100644
> --- a/security/apparmor/include/cred.h
> +++ b/security/apparmor/include/cred.h
> @@ -23,8 +23,22 @@
>  #include "policy_ns.h"
>  #include "task.h"
>
> -#define cred_label(X) ((X)->security)
> +static inline struct aa_label *cred_label(const struct cred *cred)
> +{
> +       struct aa_label **blob = cred->security;
> +
> +       AA_BUG(!blob);
> +       return *blob;
> +}
>
> +static inline void set_cred_label(const struct cred *cred,
> +                                 struct aa_label *label)
> +{
> +       struct aa_label **blob = cred->security;
> +
> +       AA_BUG(!blob);
> +       *blob = label;
> +}

This feels like it should be a separate patch? Shouldn't AA not be
playing with cred->security directly before we get to this "sizing and
allocation" patch?

> [...]
> diff --git a/security/security.c b/security/security.c
> index 3dfe75d0d373..ff7df14f6db1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -41,6 +41,8 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>
>  char *lsm_names;
> +static struct lsm_blob_sizes blob_sizes;

This needs to be __lsm_ro_after_init.

> +
>  /* Boot-time LSM user choice */
>  static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
>         CONFIG_DEFAULT_SECURITY;
> @@ -85,10 +87,22 @@ int __init security_init(void)
>         loadpin_add_hooks();
>
>         /*
> -        * Load all the remaining security modules.
> +        * The first call to a module specific init function
> +        * updates the blob size requirements.
> +        */
> +       do_security_initcalls();
> +
> +       /*
> +        * The second call to a module specific init function
> +        * adds hooks to the hook lists and does any other early
> +        * initializations required.
>          */
>         do_security_initcalls();

Tracking init state internally to each LSM seems not great. What about
having the state be a global the LSMs can query?

enum security_initcall_state_t {
    LSM_PRE_INIT,
    LSM_INIT,
};

static __initdata enum security_initcall_state_t security_initcall_state;

static void __init __do_security_initcalls(enum security_initcall_state state)
{
        int ret;
        initcall_t call;
        initcall_entry_t *ce;

        security_initcall_state = state;

        ce = __security_initcall_start;
        trace_initcall_level("security");
        while (ce < __security_initcall_end) {
                call = initcall_from_entry(ce);
                trace_initcall_start(call);
                ret = call();
                trace_initcall_finish(call, ret);
                ce++;
        }
}

static void __init do_security_initcalls(void)
{
       __do_security_initcalls(LSM_PRE_INIT);
       __do_security_initcalls(LSM_INIT);
}

>
> +#ifdef CONFIG_SECURITY_LSM_DEBUG
> +       pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
> +#endif
> +
>         return 0;
>  }
>
> @@ -198,6 +212,73 @@ int unregister_lsm_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL(unregister_lsm_notifier);
>
> +/**
> + * lsm_cred_alloc - allocate a composite cred blob
> + * @cred: the cred that needs a blob
> + * @gfp: allocation type
> + *
> + * Allocate the cred blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
> +{
> +       if (blob_sizes.lbs_cred == 0) {
> +               cred->security = NULL;
> +               return 0;
> +       }
> +
> +       cred->security = kzalloc(blob_sizes.lbs_cred, gfp);
> +       if (cred->security == NULL)
> +               return -ENOMEM;
> +       return 0;
> +}
> +
> +/**
> + * lsm_early_cred - during initialization allocate a composite cred blob
> + * @cred: the cred that needs a blob
> + *
> + * Allocate the cred blob for all the modules if it's not already there

Perhaps mention this is mainly for retroactively attaching a cred blob
to "init"?

> + */
> +void lsm_early_cred(struct cred *cred)
> +{
> +       int rc;
> +
> +       if (cred == NULL)
> +               panic("%s: NULL cred.\n", __func__);

I have been given strongly worded advice to never BUG nor panic. I would:

if (WARN_ON(!cred || !cred->security))
       return;

> +       if (cred->security != NULL)
> +               return;
> +       rc = lsm_cred_alloc(cred, GFP_KERNEL);
> +       if (rc)
> +               panic("%s: Early cred alloc failed.\n", __func__);

And:

WARN_ON(lsm_cred_alloc(cred, GFP_KERNEL));

> +}
> +
> +static void __init lsm_set_size(int *need, int *lbs)
> +{
> +       int offset;
> +
> +       if (*need > 0) {
> +               offset = *lbs;
> +               *lbs += *need;
> +               *need = offset;
> +       }
> +}
> +
> +/**
> + * security_add_blobs - Report blob sizes
> + * @needed: the size of blobs needed by the module
> + *
> + * Each LSM has to register its blobs with the infrastructure.
> + * The "needed" data tells the infrastructure how much memory
> + * the module requires for each of its blobs. On return the
> + * structure is filled with the offset that module should use
> + * from the blob pointer.
> + */
> +void __init security_add_blobs(struct lsm_blob_sizes *needed)
> +{
> +       lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> +}
> +
>  /*
>   * Hook list operation macros.
>   *
> @@ -998,17 +1079,36 @@ void security_task_free(struct task_struct *task)
>
>  int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>  {
> -       return call_int_hook(cred_alloc_blank, 0, cred, gfp);
> +       int rc = lsm_cred_alloc(cred, gfp);
> +
> +       if (rc)
> +               return rc;
> +
> +       rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
> +       if (rc)
> +               security_cred_free(cred);
> +       return rc;

I spent some time looking at this, but I think this is fine. I thought
it might be a double-free via the put_cred_rcu() path, but
cred->security gets set to NULL below, and we really don't want
allocated memory hanging around in the call_int_hook fails, so ...
yes. All good.

>  }
>
>  void security_cred_free(struct cred *cred)
>  {
>         call_void_hook(cred_free, cred);
> +
> +       kfree(cred->security);
> +       cred->security = NULL;
>  }
>
>  int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
>  {
> -       return call_int_hook(cred_prepare, 0, new, old, gfp);
> +       int rc = lsm_cred_alloc(new, gfp);
> +
> +       if (rc)
> +               return rc;
> +
> +       rc = call_int_hook(cred_prepare, 0, new, old, gfp);
> +       if (rc)
> +               security_cred_free(new);
> +       return rc;
>  }
>
>  void security_transfer_creds(struct cred *new, const struct cred *old)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9d6cdd21acb6..9b49698754a7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -213,12 +213,9 @@ static void cred_init_security(void)
>         struct cred *cred = (struct cred *) current->real_cred;
>         struct task_security_struct *tsec;
>
> -       tsec = kzalloc(sizeof(struct task_security_struct), GFP_KERNEL);
> -       if (!tsec)
> -               panic("SELinux:  Failed to initialize initial task.\n");
> -
> +       lsm_early_cred(cred);
> +       tsec = selinux_cred(cred);

Perhaps leave the existing panic() as-is?

>         tsec->osid = tsec->sid = SECINITSID_KERNEL;
> -       cred->security = tsec;
>  }
>
>  /*
> @@ -3898,53 +3895,17 @@ static int selinux_task_alloc(struct task_struct *task,
>                             sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
>  }
>
> -/*
> - * allocate the SELinux part of blank credentials
> - */
> -static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
> -{
> -       struct task_security_struct *tsec;
> -
> -       tsec = kzalloc(sizeof(struct task_security_struct), gfp);
> -       if (!tsec)
> -               return -ENOMEM;
> -
> -       cred->security = tsec;
> -       return 0;
> -}
> -
> -/*
> - * detach and free the LSM part of a set of credentials
> - */
> -static void selinux_cred_free(struct cred *cred)
> -{
> -       struct task_security_struct *tsec = selinux_cred(cred);
> -
> -       /*
> -        * cred->security == NULL if security_cred_alloc_blank() or
> -        * security_prepare_creds() returned an error.
> -        */
> -       BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
> -       cred->security = (void *) 0x7UL;

What is the world was this? Is this a "< PAGE_SIZE" poison of 0x7?

> -       kfree(tsec);
> -}
> -
>  /*
>   * prepare a new set of credentials for modification
>   */
>  static int selinux_cred_prepare(struct cred *new, const struct cred *old,
>                                 gfp_t gfp)
>  {
> -       const struct task_security_struct *old_tsec;
> -       struct task_security_struct *tsec;
> -
> -       old_tsec = selinux_cred(old);
> +       const struct task_security_struct *old_tsec = selinux_cred(old);
> +       struct task_security_struct *tsec = selinux_cred(new);
>
> -       tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
> -       if (!tsec)
> -               return -ENOMEM;
> +       *tsec = *old_tsec;
>
> -       new->security = tsec;
>         return 0;
>  }
>
> @@ -6894,6 +6855,10 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  }
>  #endif
>
> +struct lsm_blob_sizes selinux_blob_sizes = {
> +       .lbs_cred = sizeof(struct task_security_struct),
> +};
> +
>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>         LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -6976,8 +6941,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(file_open, selinux_file_open),
>
>         LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
> -       LSM_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
> -       LSM_HOOK_INIT(cred_free, selinux_cred_free),
>         LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
>         LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
>         LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
> @@ -7133,11 +7096,19 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>
>  static __init int selinux_init(void)
>  {
> +       static int finish;
> +
>         if (!security_module_enable("selinux")) {
>                 selinux_enabled = 0;
>                 return 0;
>         }
>
> +       if (!finish) {
> +               security_add_blobs(&selinux_blob_sizes);
> +               finish = 1;
> +               return 0;
> +       }
> +
>         if (!selinux_enabled) {
>                 pr_info("SELinux:  Disabled at boot.\n");
>                 return 0;
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 734b6833bdff..db1c7000ada3 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -25,6 +25,9 @@
>  #include <linux/binfmts.h>
>  #include <linux/in.h>
>  #include <linux/spinlock.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/msg.h>
> +#include <net/sock.h>

That's a surprising number of new headers?

>  #include <net/net_namespace.h>
>  #include "flask.h"
>  #include "avc.h"
> @@ -158,6 +161,7 @@ struct bpf_security_struct {
>         u32 sid;  /*SID of bpf obj creater*/
>  };
>
> +extern struct lsm_blob_sizes selinux_blob_sizes;
>  static inline struct task_security_struct *selinux_cred(const struct cred *cred)
>  {
>         return cred->security;
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f3a5a138a096..b5665bdc29fc 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -31,6 +31,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/kobject.h>
>  #include <linux/ctype.h>
> +#include <linux/lsm_hooks.h>
>
>  /* selinuxfs pseudo filesystem for exporting the security policy API.
>     Based on the proc code and the fs/nfsd/nfsctl.c code. */
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 0b55d6a55b26..0c6dce446825 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -24,6 +24,7 @@
>  #include <linux/list.h>
>  #include <linux/rculist.h>
>  #include <linux/lsm_audit.h>
> +#include <linux/msg.h>
>
>  /*
>   * Use IPv6 port labeling if IPv6 is enabled and secmarks
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 68ee3ae8f25c..a06ea8aa89c4 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -309,29 +309,20 @@ static struct inode_smack *new_inode_smack(struct smack_known *skp)
>  }
>
>  /**
> - * new_task_smack - allocate a task security blob
> + * init_task_smack - initialize a task security blob
> + * @tsp: blob to initialize
>   * @task: a pointer to the Smack label for the running task
>   * @forked: a pointer to the Smack label for the forked task
> - * @gfp: type of the memory for the allocation
>   *
> - * Returns the new blob or NULL if there's no memory available
>   */
> -static struct task_smack *new_task_smack(struct smack_known *task,
> -                                       struct smack_known *forked, gfp_t gfp)
> +static void init_task_smack(struct task_smack *tsp, struct smack_known *task,
> +                                       struct smack_known *forked)
>  {
> -       struct task_smack *tsp;
> -
> -       tsp = kzalloc(sizeof(struct task_smack), gfp);
> -       if (tsp == NULL)
> -               return NULL;
> -
>         tsp->smk_task = task;
>         tsp->smk_forked = forked;
>         INIT_LIST_HEAD(&tsp->smk_rules);
>         INIT_LIST_HEAD(&tsp->smk_relabel);
>         mutex_init(&tsp->smk_rules_lock);
> -
> -       return tsp;
>  }
>
>  /**
> @@ -1958,14 +1949,7 @@ static int smack_file_open(struct file *file)
>   */
>  static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>  {
> -       struct task_smack *tsp;
> -
> -       tsp = new_task_smack(NULL, NULL, gfp);
> -       if (tsp == NULL)
> -               return -ENOMEM;
> -
> -       cred->security = tsp;
> -
> +       init_task_smack(smack_cred(cred), NULL, NULL);
>         return 0;
>  }
>
> @@ -1982,10 +1966,6 @@ static void smack_cred_free(struct cred *cred)
>         struct list_head *l;
>         struct list_head *n;
>
> -       if (tsp == NULL)
> -               return;
> -       cred->security = NULL;
> -
>         smk_destroy_label_list(&tsp->smk_relabel);
>
>         list_for_each_safe(l, n, &tsp->smk_rules) {
> @@ -1993,7 +1973,6 @@ static void smack_cred_free(struct cred *cred)
>                 list_del(&rp->list);
>                 kfree(rp);
>         }
> -       kfree(tsp);
>  }
>
>  /**
> @@ -2008,14 +1987,10 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
>                               gfp_t gfp)
>  {
>         struct task_smack *old_tsp = smack_cred(old);
> -       struct task_smack *new_tsp;
> +       struct task_smack *new_tsp = smack_cred(new);
>         int rc;
>
> -       new_tsp = new_task_smack(old_tsp->smk_task, old_tsp->smk_task, gfp);
> -       if (new_tsp == NULL)
> -               return -ENOMEM;
> -
> -       new->security = new_tsp;
> +       init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
>
>         rc = smk_copy_rules(&new_tsp->smk_rules, &old_tsp->smk_rules, gfp);
>         if (rc != 0)
> @@ -2023,10 +1998,7 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
>
>         rc = smk_copy_relabel(&new_tsp->smk_relabel, &old_tsp->smk_relabel,
>                                 gfp);
> -       if (rc != 0)
> -               return rc;
> -
> -       return 0;
> +       return rc;
>  }
>
>  /**
> @@ -4652,6 +4624,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
>         return 0;
>  }
>
> +struct lsm_blob_sizes smack_blob_sizes = {
> +       .lbs_cred = sizeof(struct task_smack),
> +};
> +
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>         LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
> @@ -4830,23 +4806,35 @@ static __init void init_smack_known_list(void)
>   */
>  static __init int smack_init(void)
>  {
> -       struct cred *cred;
> +       static int finish;
> +       struct cred *cred = (struct cred *) current->cred;
>         struct task_smack *tsp;
>
>         if (!security_module_enable("smack"))
>                 return 0;
>
> +       if (!finish) {
> +               security_add_blobs(&smack_blob_sizes);
> +               finish = 1;
> +               return 0;
> +       }
> +
>         smack_inode_cache = KMEM_CACHE(inode_smack, 0);
>         if (!smack_inode_cache)
>                 return -ENOMEM;
>
> -       tsp = new_task_smack(&smack_known_floor, &smack_known_floor,
> -                               GFP_KERNEL);
> -       if (tsp == NULL) {
> -               kmem_cache_destroy(smack_inode_cache);
> -               return -ENOMEM;
> -       }
> +       lsm_early_cred(cred);
>
> +       /*
> +        * Set the security state for the initial task.
> +        */
> +       tsp = smack_cred(cred);
> +       init_task_smack(tsp, &smack_known_floor, &smack_known_floor);
> +
> +       /*
> +        * Register with LSM
> +        */
> +       security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
>         smack_enabled = 1;
>
>         pr_info("Smack:  Initializing.\n");
> @@ -4860,20 +4848,9 @@ static __init int smack_init(void)
>         pr_info("Smack:  IPv6 Netfilter enabled.\n");
>  #endif
>
> -       /*
> -        * Set the security state for the initial task.
> -        */
> -       cred = (struct cred *) current->cred;
> -       cred->security = tsp;
> -
>         /* initialize the smack_known_list */
>         init_smack_known_list();
>
> -       /*
> -        * Register with LSM
> -        */
> -       security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> -
>         return 0;
>  }

I feel like some of this Smack refactoring could be split out to ease review...

>
> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 539bcdd30bb8..0110bebe86e2 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -29,6 +29,7 @@
>  #include <linux/in.h>
>  #include <linux/in6.h>
>  #include <linux/un.h>
> +#include <linux/lsm_hooks.h>
>  #include <net/sock.h>
>  #include <net/af_unix.h>
>  #include <net/ip.h>
> @@ -1062,6 +1063,7 @@ void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *fmt,
>  /********** External variable definitions. **********/
>
>  extern bool tomoyo_policy_loaded;
> +extern bool tomoyo_enabled;
>  extern const char * const tomoyo_condition_keyword
>  [TOMOYO_MAX_CONDITION_KEYWORD];
>  extern const char * const tomoyo_dif[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
> @@ -1196,6 +1198,17 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
>                 atomic_dec(&group->head.users);
>  }
>
> +/**
> + * tomoyo_cred - Get a pointer to the tomoyo cred security blob
> + * @cred - the relevant cred
> + *
> + * Returns pointer to the tomoyo cred blob.
> + */
> +static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
> +{
> +       return cred->security;
> +}
> +
>  /**
>   * tomoyo_domain - Get "struct tomoyo_domain_info" for current thread.
>   *
> @@ -1203,7 +1216,9 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
>   */
>  static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  {
> -       return current_cred()->security;
> +       struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
> +
> +       return *blob;
>  }
>
>  /**
> @@ -1216,7 +1231,9 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
>                                                             *task)
>  {
> -       return task_cred_xxx(task, security);
> +       struct tomoyo_domain_info **blob = tomoyo_cred(get_task_cred(task));
> +
> +       return *blob;
>  }
>
>  /**

Shouldn't this Tomoyo cred handling get split out?

> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index f6758dad981f..b7469fdbff01 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -678,6 +678,7 @@ static int tomoyo_environ(struct tomoyo_execve *ee)
>   */
>  int tomoyo_find_next_domain(struct linux_binprm *bprm)
>  {
> +       struct tomoyo_domain_info **blob;
>         struct tomoyo_domain_info *old_domain = tomoyo_domain();
>         struct tomoyo_domain_info *domain = NULL;
>         const char *original_name = bprm->filename;
> @@ -843,7 +844,8 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>                 domain = old_domain;
>         /* Update reference count on "struct tomoyo_domain_info". */
>         atomic_inc(&domain->users);
> -       bprm->cred->security = domain;
> +       blob = tomoyo_cred(bprm->cred);
> +       *blob = domain;
>         kfree(exename.name);
>         if (!retval) {
>                 ee->r.domain = domain;
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
> index 1d3d7e7a1f05..768dff9608b1 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -71,9 +71,12 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
>                                 if (!cred) {
>                                         error = -ENOMEM;
>                                 } else {
> -                                       struct tomoyo_domain_info *old_domain =
> -                                               cred->security;
> -                                       cred->security = new_domain;
> +                                       struct tomoyo_domain_info **blob;
> +                                       struct tomoyo_domain_info *old_domain;
> +
> +                                       blob = tomoyo_cred(cred);
> +                                       old_domain = *blob;
> +                                       *blob = new_domain;
>                                         atomic_inc(&new_domain->users);
>                                         atomic_dec(&old_domain->users);
>                                         commit_creds(cred);
> @@ -234,10 +237,14 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
>   */
>  static int __init tomoyo_initerface_init(void)
>  {
> +       struct tomoyo_domain_info *domain;
>         struct dentry *tomoyo_dir;
>
> +       if (!tomoyo_enabled)
> +               return 0;
> +       domain = tomoyo_domain();
>         /* Don't create securityfs entries unless registered. */
> -       if (current_cred()->security != &tomoyo_kernel_domain)
> +       if (domain != &tomoyo_kernel_domain)
>                 return 0;
>
>         tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 9f932e2d6852..bb84e6ec3886 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -18,7 +18,9 @@
>   */
>  static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
>  {
> -       new->security = NULL;
> +       struct tomoyo_domain_info **blob = tomoyo_cred(new);
> +
> +       *blob = NULL;
>         return 0;
>  }
>
> @@ -34,8 +36,13 @@ static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
>  static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
>                                gfp_t gfp)
>  {
> -       struct tomoyo_domain_info *domain = old->security;
> -       new->security = domain;
> +       struct tomoyo_domain_info **old_blob = tomoyo_cred(old);
> +       struct tomoyo_domain_info **new_blob = tomoyo_cred(new);
> +       struct tomoyo_domain_info *domain;
> +
> +       domain = *old_blob;
> +       *new_blob = domain;
> +
>         if (domain)
>                 atomic_inc(&domain->users);
>         return 0;
> @@ -59,7 +66,9 @@ static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
>   */
>  static void tomoyo_cred_free(struct cred *cred)
>  {
> -       struct tomoyo_domain_info *domain = cred->security;
> +       struct tomoyo_domain_info **blob = tomoyo_cred(cred);
> +       struct tomoyo_domain_info *domain = *blob;
> +
>         if (domain)
>                 atomic_dec(&domain->users);
>  }
> @@ -73,6 +82,9 @@ static void tomoyo_cred_free(struct cred *cred)
>   */
>  static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>  {
> +       struct tomoyo_domain_info **blob;
> +       struct tomoyo_domain_info *domain;
> +
>         /*
>          * Do only if this function is called for the first time of an execve
>          * operation.
> @@ -93,13 +105,14 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>          * stored inside "bprm->cred->security" will be acquired later inside
>          * tomoyo_find_next_domain().
>          */
> -       atomic_dec(&((struct tomoyo_domain_info *)
> -                    bprm->cred->security)->users);
> +       blob = tomoyo_cred(bprm->cred);
> +       domain = *blob;
> +       atomic_dec(&domain->users);
>         /*
>          * Tell tomoyo_bprm_check_security() is called for the first time of an
>          * execve operation.
>          */
> -       bprm->cred->security = NULL;
> +       *blob = NULL;
>         return 0;
>  }
>
> @@ -112,8 +125,11 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>   */
>  static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>  {
> -       struct tomoyo_domain_info *domain = bprm->cred->security;
> +       struct tomoyo_domain_info **blob;
> +       struct tomoyo_domain_info *domain;
>
> +       blob = tomoyo_cred(bprm->cred);
> +       domain = *blob;
>         /*
>          * Execute permission is checked against pathname passed to do_execve()
>          * using current domain.
> @@ -493,6 +509,10 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>         return tomoyo_socket_sendmsg_permission(sock, msg, size);
>  }
>
> +struct lsm_blob_sizes tomoyo_blob_sizes = {
> +       .lbs_cred = sizeof(struct tomoyo_domain_info *),
> +};
> +
>  /*
>   * tomoyo_security_ops is a "struct security_operations" which is used for
>   * registering TOMOYO.
> @@ -531,6 +551,8 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
>  /* Lock for GC. */
>  DEFINE_SRCU(tomoyo_ss);
>
> +bool tomoyo_enabled;
> +
>  /**
>   * tomoyo_init - Register TOMOYO Linux as a LSM module.
>   *
> @@ -538,14 +560,28 @@ DEFINE_SRCU(tomoyo_ss);
>   */
>  static int __init tomoyo_init(void)
>  {
> +       static int finish;
>         struct cred *cred = (struct cred *) current_cred();
> +       struct tomoyo_domain_info **blob;
> +
> +       if (!security_module_enable("tomoyo")) {
> +               tomoyo_enabled = false;
> +               return 0;
> +       }
> +       tomoyo_enabled = true;
>
> -       if (!security_module_enable("tomoyo"))
> +       if (!finish) {
> +               security_add_blobs(&tomoyo_blob_sizes);
> +               finish = 1;
>                 return 0;
> +       }
> +
>         /* register ourselves with the security framework */
>         security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>         printk(KERN_INFO "TOMOYO Linux initialized\n");
> -       cred->security = &tomoyo_kernel_domain;
> +       lsm_early_cred(cred);
> +       blob = tomoyo_cred(cred);
> +       *blob = &tomoyo_kernel_domain;
>         tomoyo_mm_init();
>         return 0;
>  }
> --
> 2.17.1
>
>

-Kees

-- 
Kees Cook
Pixel Security
