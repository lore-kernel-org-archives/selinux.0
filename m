Return-Path: <SRS0=bkjU=SM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA0C10F14
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D8A20818
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 12:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m48cvvhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfDJMno (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:43:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39565 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbfDJMnn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Apr 2019 08:43:43 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so3064041ita.4;
        Wed, 10 Apr 2019 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4dm31OsPI83QinYuRKcrJMwYdwKtMEfMGPaXAn2uv8=;
        b=m48cvvhWY//rvQctwtzAbRk/45iX4pwI1IpW+XSIpMSRF3RYk+R+LEhdZi4bQFl0/I
         88HHNOgYAbsmYDysB4K7Jt2epmEq9XWNhuCOPOTSs67xzgBrwwSK+6DI4tls72dduUv7
         cMdSrE3D8cJulv5Zz68nlErA9xaany1xKrMTZJm2kfQZgcQl0Qkd25Wn2eG8Y5pP36WN
         /3ZcovzbAHNEhkb1GZgywILdUteDCt/yP7BurDz9KWg0615rfXNJEeAJdqLUy1YGekRQ
         XhWArAI9ywwM0gwZMfrmzfEnjW+xOD5gKAG/Al7OoN+yI/RLPZ6BYjvjiZqCnCfx2Hwr
         ZRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4dm31OsPI83QinYuRKcrJMwYdwKtMEfMGPaXAn2uv8=;
        b=NUVBoOvxoZe0huMcDOV9NN3fTjeF92QPWSUC1YWLZ2e59lw7S2JnHZRNDhNmXBcDJk
         ATBXpWc2GOTrMQ7+nmB3ln3VTHEV0Q0Xi+XGX3qZzSK7FFhMlhX0ZCANhIKsTatvF/9Z
         xcOPnpkaFchELaZrttXLxNBinatAIEcBEZEqdf0cruAr02S2Q3wX8Tlrj9+R5uHYdSnj
         o/G6wgJ4YAvic2U9cfKbEzc8lwKsiQVxtj9yl1FX/4aRtMlFLJskCjDG/CsTzPUUX6vT
         BD5dV8coGh/9akRV8kvEFVCpRyP99LaEUwod0IDg9D2vUIGtIs+hmH+GSOYHneZnE5x2
         H08A==
X-Gm-Message-State: APjAAAVdw4wFhL0k4iflozUHxBV2hhEkYKbNorr0CVznTuu6ALnEGJ0r
        eXGKSy9IdbS0pkOwmeOx6Jmw88t7Gof4SwkAiVElPg==
X-Google-Smtp-Source: APXvYqyaQFEeJEVEfM7Hsbfk9Q18vckn7KftugRTdwazGEyUIzsu42F0QNtJhpw/duaDbWBpeGGW4AM5jMmcQnXgJHE=
X-Received: by 2002:a24:2e06:: with SMTP id i6mr3041467ita.18.1554900222474;
 Wed, 10 Apr 2019 05:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190409213946.1667-1-casey@schaufler-ca.com> <20190409213946.1667-59-casey@schaufler-ca.com>
In-Reply-To: <20190409213946.1667-59-casey@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Wed, 10 Apr 2019 08:43:35 -0400
Message-ID: <CAB9W1A0ZVUHAtAEhYw+HSyOnRdekg=6WQ2RP8PqNAirmDxBkZw@mail.gmail.com>
Subject: Re: [PATCH 58/59] LSM: Specify which LSM to display with /proc/self/attr/display
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 9, 2019 at 5:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new entry "display" in /proc/.../attr for controlling
> which LSM security information is displayed for a process.
> The name of an active LSM that supplies hooks for human readable
> data may be written to "display" to set the value. The name of
> the LSM currently in use can be read from "display".
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/proc/base.c      |   1 +
>  security/security.c | 123 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 121 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..7bf70e041315 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>         ATTR(NULL, "fscreate",          0666),
>         ATTR(NULL, "keycreate",         0666),
>         ATTR(NULL, "sockcreate",        0666),
> +       ATTR(NULL, "display",           0666),
>  #ifdef CONFIG_SECURITY_SMACK
>         DIR("smack",                    0555,
>             proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/security/security.c b/security/security.c
> index 29149db3f78a..6e304aa796f9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -47,9 +47,13 @@ static struct kmem_cache *lsm_inode_cache;
>
>  char *lsm_names;
>
> -/* Socket blobs include infrastructure managed data */
> +/*
> + *     Socket blobs include infrastructure managed data
> + *     Cred blobs include context display instructions
> + */
>  static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
>         .lbs_sock = sizeof(struct lsm_export),
> +       .lbs_cred = sizeof(struct lsm_one_hooks),
>  };
>
>  /**
> @@ -751,7 +755,10 @@ int lsm_superblock_alloc(struct super_block *sb)
>
>  #define call_one_int_hook(FUNC, IRC, ...) ({                   \
>         int RC = IRC;                                           \
> -       if (lsm_base_one.FUNC.FUNC)                             \
> +       struct lsm_one_hooks *LOH = current_cred()->security;   \
> +       if (LOH->FUNC.FUNC)                                     \
> +               RC = LOH->FUNC.FUNC(__VA_ARGS__);               \
> +       else if (LOH->lsm == NULL && lsm_base_one.FUNC.FUNC)    \
>                 RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);       \
>         RC;                                                     \
>  })
> @@ -1617,6 +1624,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>
>  void security_cred_free(struct cred *cred)
>  {
> +       struct lsm_one_hooks *loh;
>         /*
>          * There is a failure case in prepare_creds() that
>          * may result in a call here with ->security being NULL.
> @@ -1626,26 +1634,44 @@ void security_cred_free(struct cred *cred)
>
>         call_void_hook(cred_free, cred);
>
> +       loh = cred->security;
> +       kfree(loh->lsm);
>         kfree(cred->security);
>         cred->security = NULL;
>  }
>
> +static int copy_loh(struct lsm_one_hooks *new, struct lsm_one_hooks *old,
> +                   gfp_t gfp)
> +{
> +       *new = *old;
> +       if (old->lsm) {
> +               new->lsm = kstrdup(old->lsm, gfp);
> +               if (unlikely(new->lsm == NULL))
> +                       return -ENOMEM;
> +       }
> +       return 0;
> +}
> +
>  int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
>  {
>         int rc = lsm_cred_alloc(new, gfp);
>
> -       if (rc)
> +       if (unlikely(rc))
>                 return rc;
>
>         rc = call_int_hook(cred_prepare, 0, new, old, gfp);
>         if (unlikely(rc))
>                 security_cred_free(new);
> +       else
> +               rc = copy_loh(new->security, old->security, gfp);
> +
>         return rc;
>  }
>
>  void security_transfer_creds(struct cred *new, const struct cred *old)
>  {
>         call_void_hook(cred_transfer, new, old);
> +       WARN_ON(copy_loh(new->security, old->security, GFP_KERNEL));
>  }
>
>  void security_cred_getsecid(const struct cred *c, struct lsm_export *l)
> @@ -1960,10 +1986,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>                                 char **value)
>  {
>         struct security_hook_list *hp;
> +       struct lsm_one_hooks *loh = current_cred()->security;
> +       char *s;
> +
> +       if (!strcmp(name, "display")) {
> +               if (loh->lsm)
> +                       s = loh->lsm;
> +               else if (lsm_base_one.lsm)
> +                       s = lsm_base_one.lsm;
> +               else
> +                       return -EINVAL;
> +
> +               *value = kstrdup(s, GFP_KERNEL);
> +               if (*value)
> +                       return strlen(s);
> +               return -ENOMEM;
> +       }
>
>         hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>                 if (lsm != NULL && strcmp(lsm, hp->lsm))
>                         continue;
> +               if (lsm == NULL && loh->lsm && strcmp(loh->lsm, hp->lsm))
> +                       continue;
>                 return hp->hook.getprocattr(p, name, value);
>         }
>         return -EINVAL;
> @@ -1973,10 +2017,83 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>                          size_t size)
>  {
>         struct security_hook_list *hp;
> +       struct lsm_one_hooks *loh = current_cred()->security;
> +       bool found = false;
> +       char *s;
> +
> +       /*
> +        * End the passed name at a newline.
> +        */
> +       s = strnchr(value, size, '\n');
> +       if (s)
> +               *s = '\0';
> +
> +       if (!strcmp(name, "display")) {
> +               union security_list_options secid_to_secctx;
> +               union security_list_options secctx_to_secid;
> +               union security_list_options socket_getpeersec_stream;
> +
> +               if (size == 0 || size >= 100)
> +                       return -EINVAL;
> +
> +               secid_to_secctx.secid_to_secctx = NULL;
> +               hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
> +                                    list) {
> +                       if (size >= strlen(hp->lsm) &&
> +                           !strncmp(value, hp->lsm, size)) {
> +                               secid_to_secctx = hp->hook;
> +                               found = true;
> +                               break;
> +                       }
> +               }
> +               secctx_to_secid.secctx_to_secid = NULL;
> +               hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid,
> +                                    list) {
> +                       if (size >= strlen(hp->lsm) &&
> +                           !strncmp(value, hp->lsm, size)) {
> +                               secctx_to_secid = hp->hook;
> +                               found = true;
> +                               break;
> +                       }
> +               }
> +               socket_getpeersec_stream.socket_getpeersec_stream = NULL;
> +               hlist_for_each_entry(hp,
> +                               &security_hook_heads.socket_getpeersec_stream,
> +                                    list) {
> +                       if (size >= strlen(hp->lsm) &&
> +                           !strncmp(value, hp->lsm, size)) {
> +                               socket_getpeersec_stream = hp->hook;
> +                               found = true;
> +                               break;
> +                       }
> +               }
> +               if (!found)
> +                       return -EINVAL;
> +
> +               /*
> +                * The named lsm is active and supplies one or more
> +                * of the relevant hooks. Switch to it.
> +                */
> +               s = kmemdup(value, size + 1, GFP_KERNEL);
> +               if (s == NULL)
> +                       return -ENOMEM;
> +               s[size] = '\0';
> +
> +               if (loh->lsm)
> +                       kfree(loh->lsm);
> +               loh->lsm = s;
> +               loh->secid_to_secctx = secid_to_secctx;
> +               loh->secctx_to_secid = secctx_to_secid;
> +               loh->socket_getpeersec_stream = socket_getpeersec_stream;

You can't just write to the cred security blob like this; it is a
shared data structure, not per-task.

> +
> +               return size;
> +       }
>
>         hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>                 if (lsm != NULL && strcmp(lsm, hp->lsm))
>                         continue;
> +               if (lsm == NULL && loh->lsm && strcmp(loh->lsm, hp->lsm))
> +                       continue;
>                 return hp->hook.setprocattr(name, value, size);
>         }
>         return -EINVAL;
> --
> 2.19.1
>
