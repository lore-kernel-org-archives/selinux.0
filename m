Return-Path: <SRS0=stgd=CP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2125EC43461
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE10D2075A
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="i24VfLQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIFQcd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgIFQcZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Sep 2020 12:32:25 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1FC061573
        for <selinux@vger.kernel.org>; Sun,  6 Sep 2020 09:32:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so10224933edv.2
        for <selinux@vger.kernel.org>; Sun, 06 Sep 2020 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8tC2QXpOtOzE45Xjl3tUVikGMUOC2Eduj5EJAiJGFs=;
        b=i24VfLQ06hw0VDQf1ep/EZvafCeqBfFkXD+dz5B9N3V2rq5niU4zgtYZayrwLlF0UO
         FV2udODAghE0uLJNMq/RMBETY4gEIGxeMk1raY7CULmO50GIBMSTPq9+SbYqWYN6vlVs
         6Cg42/uc/C5BaRozeGFdHKWRsdjB3dPUYOpB88nzP63awJHbS8HqkCickiS5XUbb6KL+
         9KcKu7/hpKiUxYqtgrxRE9yumFMoB54m7/l4K1mFFUK9Dbon/WHSXEZmW5qC2BAXOrng
         WD+sKeK7fqUrbBBsW+Wq0NKzXkq/krjvMcb2qWmiY8ceLiI7DHUUCZTGnIesTqMkCI3t
         kd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8tC2QXpOtOzE45Xjl3tUVikGMUOC2Eduj5EJAiJGFs=;
        b=tFDCIYZWn7MjnbuU9/t4lzr4Fw98FHtb3cYxO7iMmBWjnTou3RI3ADp5C66pl+JdX1
         Sw+4Xstd1FWjDRn5aYqWxfWXpffmuppw9jQI6eyXIXbv9WPzcjioDzURDj6JbSzJkL4x
         tE7YtWxjjqiGBq+CpFrSuf6CkFow/LCxF8IJ/M9gHoLGk45dPQpPkbGUViSGOBL+cTOz
         tYRYbuNb8Yo5KIOf1AEPDmOPXzbdlpLW3O4l0AaOM4akDPHfT8jXs22KL0wRUIvp12m5
         XgGF0BpSHfh4OpcJp5KKi26ZKFYGJx3jS5X5KIBEXpWU9tBd4JG9L0krZnh7B9U9uZvU
         MdJg==
X-Gm-Message-State: AOAM532Ja9yFCIlFnPMuODFF3nseF09F/iwB+McWZYLqtIneRtGirrlb
        pWW1KUlYJLp2sPnjUAxpY6VksQ4h5gR0oN9wS+SB
X-Google-Smtp-Source: ABdhPJxA2P0MiIO4fTvXotn6GhscbUi8Qbr5zuEbipYxjJsWhM1nbn7UTn7R01spZPsVUiNmW6RUjNXznAyv95ea3/c=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr17517368edv.135.1599409940338;
 Sun, 06 Sep 2020 09:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-21-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-21-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 6 Sep 2020 12:32:09 -0400
Message-ID: <CAHC9VhThrFdTuy=+LWxBtUgtOsst6UpxK49V6DO6VSTh8zu9wA@mail.gmail.com>
Subject: Re: [PATCH v20 20/23] Audit: Add new record for multiple process LSM attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:23 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record type to contain the subject information
> when there are multiple security modules that require such data.
> This record is linked with the same timestamp and serial number.
> The record is produced only in cases where there is more than one
> security module with a process "context".
>
> Before this change the only audit events that required multiple
> records were syscall events. Several non-syscall events include
> subject contexts, so the use of audit_context data has been expanded
> as necessary.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> ---
>  drivers/android/binder.c                |  2 +-
>  include/linux/audit.h                   | 13 +++-
>  include/linux/security.h                | 18 ++++-
>  include/net/netlabel.h                  |  2 +-
>  include/net/scm.h                       |  3 +-
>  include/net/xfrm.h                      |  4 +-
>  include/uapi/linux/audit.h              |  1 +
>  kernel/audit.c                          | 89 ++++++++++++++++++-------
>  kernel/auditfilter.c                    |  2 +-
>  kernel/auditsc.c                        | 87 ++++++++++++++++++++++--
>  net/ipv4/ip_sockglue.c                  |  2 +-
>  net/netfilter/nf_conntrack_netlink.c    |  4 +-
>  net/netfilter/nf_conntrack_standalone.c |  2 +-
>  net/netfilter/nfnetlink_queue.c         |  2 +-
>  net/netlabel/netlabel_unlabeled.c       | 16 ++---
>  net/netlabel/netlabel_user.c            | 12 ++--
>  net/netlabel/netlabel_user.h            |  6 +-
>  security/integrity/integrity_audit.c    |  2 +-
>  security/security.c                     | 73 +++++++++++++++-----
>  security/smack/smackfs.c                |  3 +-
>  20 files changed, 259 insertions(+), 84 deletions(-)

Regardless of the code, the audit folks generally ask for an example
of the new audit record in the commit description; it make it easier
for the people not familiar with the kernel to review the record
format/information.

I've also been requiring that a test is added to the audit test suite
for new features added to the kernel.  I recognize this is a big ask
for something like this, but it is something we have been doing for
several years now and I think the benefits far outweigh the costs.

* https://github.com/linux-audit/audit-testsuite

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index ba1cd38d601b..fe027df0d9a8 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -186,7 +186,9 @@ extern void             audit_log_path_denied(int type,
>                                                   const char *operation);
>  extern void                audit_log_lost(const char *message);
>
> -extern int audit_log_task_context(struct audit_buffer *ab);
> +extern void audit_log_lsm(struct lsmblob *blob, bool exiting);
> +extern int audit_log_task_context(struct audit_buffer *ab,
> +                                 struct lsmblob *blob);

The audit functions tend to get abused, and this is mostly due to a
rather poor design, so I'd prefer to see audit_log_task_context()
remain with just a single argument: the audit buffer.  I believe this
covers the vast majority of the cases and should remain the preferred
option for callers.  This should help shrink the patch and focus it a
bit more.

For the handful of callers that do need to specify a separate task
context, you can create a __audit_log_task_context(ab, blob) that
allows the caller to specify the blob (and obviously you can write
audit_log_task_context() as a one line wrapper around this function).

> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 2737d24ec244..9e8cac6228b4 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -675,11 +675,13 @@ static inline struct audit_buffer *xfrm_audit_start(const char *op)
>
>         if (audit_enabled == AUDIT_OFF)
>                 return NULL;
> +       audit_stamp_context(audit_context());
>         audit_buf = audit_log_start(audit_context(), GFP_ATOMIC,
>                                     AUDIT_MAC_IPSEC_EVENT);

Is audit_stamp_context() necessary here?  Generally if the first
argument to audit_log_start() is not NULL then you shouldn't need to
create a "local" audit context.

I wonder if you might be getting mixed up in testing by not having
audit properly enabled (see link below)?  Make sure you don't have any
audit disable rules loaded into the kernel, and you can even add
"audit=1" to the kernel command line.

https://github.com/linux-audit/audit-documentation/wiki/HOWTO-Fedora-Enable-Auditing

>         if (audit_buf == NULL)
>                 return NULL;
>         audit_log_format(audit_buf, "op=%s", op);
> +       audit_log_lsm(NULL, false);
>         return audit_buf;
>  }

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 594b42fc88ff..0e7831c9f321 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1070,13 +1071,31 @@ static void audit_log_common_recv_msg(struct audit_context *context,
>                 return;
>         audit_log_format(*ab, "pid=%d uid=%u ", pid, uid);
>         audit_log_session_info(*ab);
> -       audit_log_task_context(*ab);
> +       audit_log_task_context(*ab, NULL);
>  }
>
>  static inline void audit_log_user_recv_msg(struct audit_buffer **ab,
>                                            u16 msg_type)
>  {
> -       audit_log_common_recv_msg(NULL, ab, msg_type);
> +       struct audit_context *context;
> +
> +       if (!lsm_multiple_contexts()) {
> +               audit_log_common_recv_msg(NULL, ab, msg_type);
> +               return;
> +       }
> +
> +       context = audit_context();
> +       if (context) {
> +               if (!context->in_syscall)
> +                       audit_stamp_context(context);
> +               audit_log_common_recv_msg(context, ab, msg_type);
> +               return;
> +       }
> +
> +       audit_alloc(current);
> +       context = audit_context();
> +
> +       audit_log_common_recv_msg(context, ab, msg_type);
>  }

Hmm.  Take a look at Richard's patch for adding the audit container ID
record to audit user records, it should give you a better idea of how
to approach this.  The above changes in audit_log_user_recv_msg() are
not really what we want.

https://lore.kernel.org/linux-audit/4a5019ed3cfab416aeb6549b791ac6d8cc9fb8b7.1593198710.git.rgb@redhat.com

> @@ -1869,6 +1889,10 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>         }
>
>         audit_get_stamp(ab->ctx, &t, &serial);
> +       if (type == AUDIT_MAC_TASK_CONTEXTS && ab->ctx->serial == 0) {
> +               audit_stamp_context(ab->ctx);
> +               audit_get_stamp(ab->ctx, &t, &serial);
> +       }
>         audit_log_format(ab, "audit(%llu.%03lu:%u): ",
>                          (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);

Can you walk me through what you are trying to do here?  This doesn't
seem right to me, but I'm sure you put it here for a reason.

> @@ -2126,30 +2150,47 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>                 audit_log_format(ab, "(null)");
>  }
>
> -int audit_log_task_context(struct audit_buffer *ab)
> +int audit_log_task_context(struct audit_buffer *ab, struct lsmblob *blob)
>  {
> +       int i;
>         int error;
> -       struct lsmblob blob;
> -       struct lsmcontext context;
> +       struct lsmblob localblob;
> +       struct lsmcontext lsmdata;
>
> -       security_task_getsecid(current, &blob);
> -       if (!lsmblob_is_set(&blob))
> +       /*
> +        * If there is more than one security module that has a
> +        * subject "context" it's necessary to put the subject data
> +        * into a separate record to maintain compatibility.
> +        */
> +       if (lsm_multiple_contexts()) {
> +               audit_log_format(ab, " subj=?");
>                 return 0;
> +       }
>
> -       error = security_secid_to_secctx(&blob, &context);
> -       if (error) {
> -               if (error != -EINVAL)
> -                       goto error_path;
> -               return 0;
> +       if (blob == NULL) {
> +               security_task_getsecid(current, &localblob);

Why is localblob necessary?  You know blob is NULL here, just use it
directly and skip the assignment later in this code block.

> +               if (!lsmblob_is_set(&localblob)) {
> +                       audit_log_format(ab, " subj=?");
> +                       return 0;
> +               }
> +               blob = &localblob;
>         }
>
> -       audit_log_format(ab, " subj=%s", context.context);
> -       security_release_secctx(&context);
> -       return 0;
> +       for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +               if (blob->secid[i] == 0)
> +                       continue;
> +               error = security_secid_to_secctx(blob, &lsmdata, i);
> +               if (error && error != -EINVAL) {
> +                       audit_panic("error in audit_log_task_context");
> +                       return error;
> +               }
>
> -error_path:
> -       audit_panic("error in audit_log_task_context");
> -       return error;
> +               audit_log_format(ab, " subj=%s", lsmdata.context);
> +               security_release_secctx(&lsmdata);
> +               break;
> +       }
> +
> +       return 0;
>  }
>  EXPORT_SYMBOL(audit_log_task_context);

...

> @@ -2279,6 +2320,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
>         if (!audit_enabled)
>                 return;
>
> +       audit_stamp_context(audit_context());
>         ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_LOGIN);
>         if (!ab)
>                 return;

Similar to above, I'm not sure audit_stamp_context() is what we want here.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4af5861bcb9a..cf5dbd0e3a3d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -962,10 +962,12 @@ int audit_alloc(struct task_struct *tsk)
>                 return 0; /* Return if not auditing. */
>
>         state = audit_filter_task(tsk, &key);
> -       if (state == AUDIT_DISABLED) {
> +       if (!lsm_multiple_contexts() && state == AUDIT_DISABLED) {
>                 clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
>                 return 0;
>         }
> +       if (state == AUDIT_DISABLED)
> +               clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);

Hmmm.  I think we've hit critical mass on the amount of hacks in the
audit subsystem for this code ... Let's back up a bit and start with
some basic requirements (correct me if I'm wrong on any of these):

1. This patch only deals with LSM process/task/subject contexts.
2. Multiple LSMs may, or may not exist; audit logs and behavior should
remain unchanged in the single LSM case.
3. If multiple LSMs are present, the subject field in existing records
should take the form of "subj=?" and a new audit record is created
containing fields of the format "subj_<LSM>=<context>".

Assuming all of that is true, why not simply keep the basic logic in
audit_log_task_context(), but also stash a lsmblob struct in the
audit_context for later use by audit_log_exit()?  Stashing of the
lsmblob would really only be necessary to handle the few cases where
the current task is not the proper subject.

> @@ -1483,6 +1486,52 @@ static void audit_log_proctitle(void)
>         audit_log_end(ab);
>  }
>
> +void audit_log_lsm(struct lsmblob *blob, bool exiting)
> +{
> +       struct audit_context *context = audit_context();
> +       struct lsmcontext lsmdata;
> +       struct audit_buffer *ab;
> +       struct lsmblob localblob;
> +       bool sep = false;
> +       int error;
> +       int i;
> +
> +       if (!lsm_multiple_contexts())
> +               return;
> +
> +       if (context && context->in_syscall && !exiting)
> +               return;

I think the "!lsm_multiple_contexts()" and "!exiting" checks fit well
with my comments about generating the AUDIT_MAC_TASK_CONTEXT record in
audit_log_exit.  This code needs a rethink.

> +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_MAC_TASK_CONTEXTS);
> +       if (!ab)
> +               return; /* audit_panic or being filtered */
> +
> +       if (blob == NULL) {
> +               security_task_getsecid(current, &localblob);
> +               if (!lsmblob_is_set(&localblob))
> +                       return;
> +               blob = &localblob;
> +       }
> +
> +       for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +               if (blob->secid[i] == 0)
> +                       continue;
> +               error = security_secid_to_secctx(blob, &lsmdata, i);
> +               if (error && error != -EINVAL) {
> +                       audit_panic("error in audit_log_lsm");
> +                       return; fits well with a
> +               }
> +
> +               audit_log_format(ab, "%ssubj_%s=%s", sep ? " " : "",
> +                                security_lsm_slot_name(i), lsmdata.context);
> +               sep = true;
> +
> +               security_release_secctx(&lsmdata);
> +       }
> +
> +       audit_log_end(ab);
> +}

...

> @@ -2217,6 +2267,21 @@ void __audit_inode_child(struct inode *parent,
>  }
>  EXPORT_SYMBOL_GPL(__audit_inode_child);
>
> +/**
> + * audit_stamp_context - set the timestamp+serial in an audit context
> + * @ctx: audit_context to set
> + */
> +void audit_stamp_context(struct audit_context *ctx)
> +{
> +       /* ctx will be NULL unless lsm_multiple_contexts() is true */
> +       if (!ctx)
> +               return;
> +
> +       ktime_get_coarse_real_ts64(&ctx->ctime);
> +       ctx->serial = audit_serial();
> +       ctx->current_state = AUDIT_BUILD_CONTEXT;
> +}

Based on previous discussions and what I *think* you are trying to do
in this patchset, I believe Richard's audit_alloc_local()
implementation (link below) is a better and cleaner solution.  His
latest revisions needs some minor tweaks (see my feeback), but I think
you could probably work with him to pull that single patch into your
patchset.

To be clear, I'm talking about just that one patch; I'm a firm
believer that tying the LSM stacking and audit container ID patches
beyond this would be a disaster.  I can deal with any merge conflicts
that arise whenever the different patchsets land.

* Richard's audit_alloc_local() patch (07/13 of the latest audit
container ID patchset)
https://lore.kernel.org/linux-audit/21e6c4e1ac179c8dcf35803e603899ccfc69300a.1593198710.git.rgb@redhat.com

> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 951ba0639d20..4e9064754b5f 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -84,12 +84,12 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>                                                struct netlbl_audit *audit_info)
>  {
>         struct audit_buffer *audit_buf;
> -       struct lsmcontext context;
> -       struct lsmblob blob;
>
>         if (audit_enabled == AUDIT_OFF)
>                 return NULL;
>
> +       audit_stamp_context(audit_context());

Another one.

>         audit_buf = audit_log_start(audit_context(), GFP_ATOMIC, type);
>         if (audit_buf == NULL)
>                 return NULL;

-- 
paul moore
www.paul-moore.com
