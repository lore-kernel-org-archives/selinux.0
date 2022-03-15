Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B756BC4332F
	for <selinux@archiver.kernel.org>; Tue, 15 Mar 2022 23:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352619AbiCOXtJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Mar 2022 19:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348320AbiCOXtI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Mar 2022 19:49:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD217E05
        for <selinux@vger.kernel.org>; Tue, 15 Mar 2022 16:47:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a8so845264ejc.8
        for <selinux@vger.kernel.org>; Tue, 15 Mar 2022 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNpw6JDKnJaStDEQbMYrPng7QK8NBZw/YfwumvcctfY=;
        b=ZGYr0lbTpqSXCrncIFe6/Lj89SdYYP4TM4gHBHfTsuM22VWEhR90xBr0C1R99ME+8O
         WuUpt+J+HcscaS/VYB7OXORa+KyLrSmn/Mrcvvt6KYnZFVLFwUJpuQfAYUQCdWc2/YmC
         c1DEzYLOugHUd+So11xTXTUU6/fPgsdRWf1ZFyJbCI8x/PNOCDd1BI2H6xVrnBBl1OWi
         4DQNUnhE3cGOO4onK3IMkXzaOaQAnH/Av8MucrLgmSfb2zet0YzBCsp1FOF4E8p9MvfU
         iqlAsSWHXQXwpNCPne85eaW/uLZZjMV4Vl3cycxPg2a6wziEXORozYkE9cHbLLPZtLwW
         +aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNpw6JDKnJaStDEQbMYrPng7QK8NBZw/YfwumvcctfY=;
        b=r4wgGfzsUUG+Ai0VjSI3sUupGZpmrtXRXZnhPsvkRR1uGqN7/TtyqFiNfVEGW7BtFg
         Zjj1S7ecLYINumRqVd+ISWQU4qD0rjV03g1kDh53k/QFmcIo2/DPTp5GTAEZ16AP0oM8
         3PbUX8WRjwS+O/gUCPyOpazV0nfgaVYoAckp4CNc1OU+M8/zkuP+FUCoenrAZxTHYRha
         PD3TvGjBVHKafdk8Ph2BTtflW8hn++gLQoJM52g23z/lFjHzcCMbsgjNKLiHHiBUwuhr
         FiuN5RqmY2ZjqpxIOrTLWduWVCqXvKf/6d5ErBvXiLUF+7+8+iQ9TWYLJzPxeq48sqlr
         AAog==
X-Gm-Message-State: AOAM533mqUqdRDD4sjGJuoreIWDKJywGiPbv8abFsUV6R41dQpyv2vHH
        qD9qVCt2pCSLR6cor1JBl1v4zCQ1iUS6SHqEb21L
X-Google-Smtp-Source: ABdhPJwMDlgE3Rds0dK2V8kz4+cLHiA+xeH+Eh7vcPSUa6dPbkcRxZpueixswjtw6dKgS/n9D+D+3VIT66j4Gb3g0zU=
X-Received: by 2002:a17:907:97c1:b0:6da:bd15:cca0 with SMTP id
 js1-20020a17090797c100b006dabd15cca0mr24579091ejc.327.1647388073631; Tue, 15
 Mar 2022 16:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234632.16194-1-casey@schaufler-ca.com> <20220310234632.16194-27-casey@schaufler-ca.com>
In-Reply-To: <20220310234632.16194-27-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Mar 2022 19:47:42 -0400
Message-ID: <CAHC9VhSYr3nC87jk+cPzvVLgYZO9p9vaM7n+jvGEF60RaNJw7A@mail.gmail.com>
Subject: Re: [PATCH v33 26/29] Audit: Add record for multiple task security contexts
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 10, 2022 at 6:59 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS (1420) record is:
>
>     type=MAC_TASK_CONTEXTS[1420]
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
>
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
> the "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on a subject security context.
>
> Functions are created to manage the skb list in the audit_buffer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/uapi/linux/audit.h |   1 +
>  kernel/audit.c             | 104 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 93 insertions(+), 12 deletions(-)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 8eda133ca4c1..af0aaccfaf57 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -143,6 +143,7 @@
>  #define AUDIT_MAC_UNLBL_STCDEL 1417    /* NetLabel: del a static label */
>  #define AUDIT_MAC_CALIPSO_ADD  1418    /* NetLabel: add CALIPSO DOI entry */
>  #define AUDIT_MAC_CALIPSO_DEL  1419    /* NetLabel: del CALIPSO DOI entry */
> +#define AUDIT_MAC_TASK_CONTEXTS        1420    /* Multiple LSM task contexts */
>
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 4713e66a12af..ad825af203cf 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2147,8 +2147,65 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>                 audit_log_format(ab, "(null)");
>  }
>
> +/*
> + * A brief note on aux record management.
> + *
> + * Aux records are allocated and added to the skb list of
> + * the "main" record. The ab->skb is reset to point to the
> + * aux record on its creation. When the aux record in complete
                                                      ^^
                                                     "is"
> + * ab->skb has to be reset to point to the "main" record.
> + * This allows the audit_log_ functions to be ignorant of
> + * which kind of record it is logging to. It also avoids adding
> + * special data for aux records.
> + */

It might be good to move the above comment into the
audit_buffer_aux_new() comment header (below) so it does not get
misplaced.

> +/**
> + * audit_buffer_aux_new - Add an aux record buffer to the skb list
> + * @ab: audit_buffer
> + * @type: message type
> + *
> + * On success ab->skb will point to the new aux record.
> + * Returns 0 on success, -ENOMEM should allocation fail.
> + */
> +static int audit_buffer_aux_new(struct audit_buffer *ab, int type)

...

> @@ -2157,16 +2214,44 @@ int audit_log_task_context(struct audit_buffer *ab)
>         if (!lsmblob_is_set(&blob))
>                 return 0;
>
> -       error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
> +       if (!lsm_multiple_contexts()) {
> +               error = security_secid_to_secctx(&blob, &context,
> +                                                LSMBLOB_FIRST);
> +               if (error) {
> +                       if (error != -EINVAL)
> +                               goto error_path;
> +                       return 0;
> +               }
>
> -       if (error) {
> -               if (error != -EINVAL)
> +               audit_log_format(ab, " subj=%s", context.context);
> +               security_release_secctx(&context);
> +       } else {
> +               /* Multiple LSMs provide contexts. Include an aux record. */
> +               audit_log_format(ab, " subj=?");
> +               error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
> +               if (error)
>                         goto error_path;
> -               return 0;
> +               for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +                       if (blob.secid[i] == 0)
> +                               continue;
> +                       error = security_secid_to_secctx(&blob, &context, i);
> +                       if (error) {
> +                               if (error != -EINVAL)
> +                                       audit_panic("error in audit_log_task_context");
> +                               audit_log_format(ab, "%ssubj_%s=?",
> +                                                i ? " " : "",
> +                                                lsm_slot_to_name(i));

I wonder if it might be better to record the "subj_smack=?" field
before checking @error and potentially calling audit_panic().  In
practice it likely shouldn't matter, I feel better if we at least
record the subject information before we call the wildcard that is
audit_panic().

> +                       } else {
> +                               audit_log_format(ab, "%ssubj_%s=%s",
> +                                                i ? " " : "",
> +                                                lsm_slot_to_name(i),
> +                                                context.context);
> +                               security_release_secctx(&context);
> +                       }
> +               }
> +               audit_buffer_aux_end(ab);
>         }
>
> -       audit_log_format(ab, " subj=%s", context.context);
> -       security_release_secctx(&context);
>         return 0;
>
>  error_path:
> @@ -2382,13 +2467,8 @@ int audit_signal_info(int sig, struct task_struct *t)
>  }
>
>  /**
> - * __audit_log_end - end one audit record
> + * __audit_log_end - send one audit record

If we want to be very nit-picky here, "end" is more correct than
"send".  First, audit_log_end() doesn't actually send the record, it
just queues the record for the kauditd_thread which then attempts to
send it.  Second, there is no guarantee that the record will actually
be sent at this point, although it would be nice if that were true :)

>   * @skb: the buffer to send
> - *
> - * We can not do a netlink send inside an irq context because it blocks (last
> - * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> - * queue and a kthread is scheduled to remove them from the queue outside the
> - * irq context.  May be called in any context.
>   */

This should probably be moved to patch 25/29 as it has more to do with
the __audit_log_end() introduction than this patch.


--
paul-moore.com
