Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8063C47082
	for <selinux@archiver.kernel.org>; Mon,  7 Jun 2021 23:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C283F61182
	for <selinux@archiver.kernel.org>; Mon,  7 Jun 2021 23:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGXST (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Jun 2021 19:18:19 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:45873 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFGXSS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Jun 2021 19:18:18 -0400
Received: by mail-ej1-f41.google.com with SMTP id k7so29319868ejv.12
        for <selinux@vger.kernel.org>; Mon, 07 Jun 2021 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVcvHZxl4JqB10edFM0rP0Xu4QSj7UArIpCEg3v5Ei8=;
        b=U7TfcbAM3zxrbqLIzDoEUv43hEGINXWMWhYClak8CfaaNFxcUhS/u8mLrcy4H1f/lL
         8Dv7Y0aXJzyPOgKgY1zRrNzyIhlGulAI+YN3MCJrf3gVmss94O+O82qMJfO/bLwWaU7K
         Ryc5eFkS0Oj1u3a6R7AvzqIVUGTS+E9WDcB/ZiJfGKXucs31Fa4hdrgUJYDdQapNOCLY
         8bXmuY/xVLkCKvbj/Rccpk63vbHR1DMPdYTLV2MM5bTfRDrB8T9ShsdDzfYu6nNfV3vI
         xduQ4zw+eJF/FWzKjySwuoij9H8dUNzRMPX0Gi7L0edr2pQBxPQVYlk04xQPRevi3Srl
         iPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVcvHZxl4JqB10edFM0rP0Xu4QSj7UArIpCEg3v5Ei8=;
        b=nvF2ErCgODypAfG++6cIaNxWFF5hcwSBWYn5ukfxkVn+6raIeQcdNpg7ny6ZKMusik
         T9lILxUw6mQhwwAVmxSaIqIISKPNxAQdUPDTEBDGIYD8Xvtl5LzmEdNktIRwTbru3Esp
         CVo6xD/88mO/ZTxtFHCrzEv52xvzfLk1nURtV/UD46jWwDcLzoEnP1wVYwRVIvc8b8qN
         Y4P3vzd+ujc5eDn6GdCt4yTOQg7TkydWYkJVcXJPKsINVIP+2iVxVS0MWSPO04cUmUMf
         Eq8cXwEHH4X4dsqLJGSd73o+hxo095mHEWuEbJpN1NPH6JTWdU+Y5D72o9liHtouXIe6
         ydKw==
X-Gm-Message-State: AOAM531lDluDn/ulXrELvYanJ4hUpTgwDDmrC63uc3rrLgXMKVTjkU5s
        5mzS2pyQ215jDUe/OdCN2K3KOghVr/xl2jTYxjMEt/Q5ZA==
X-Google-Smtp-Source: ABdhPJwQmKKFjCUccixQJ2loM5vdZurrcHLgZFSdBmxemrGWy9aCkt/1ll1v8r13AIWiK1ynSFD9QO7MXzHvxVJN8wk=
X-Received: by 2002:a17:906:518b:: with SMTP id y11mr20728839ejk.178.1623107712097;
 Mon, 07 Jun 2021 16:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTr_hw_RBPf5yGD16j-qV2tbjjPJkimMNNQZBHtrJDbuQ@mail.gmail.com>
 <3a2903574a4d03f73230047866112b2dad9b4a9e.1622467740.git.rgb@redhat.com>
In-Reply-To: <3a2903574a4d03f73230047866112b2dad9b4a9e.1622467740.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Jun 2021 19:15:01 -0400
Message-ID: <CAHC9VhRa9dvCfPf5WHKYofrvQrGff7Lh+H4HMAhi_z3nK_rtoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: add filtering for io_uring records, addendum
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 31, 2021 at 9:45 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The commit ("audit: add filtering for io_uring records") added support for
> filtering io_uring operations.
>
> Add checks to the audit io_uring filtering code for directory and path watches,
> and to keep the list counts consistent.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit_tree.c  | 3 ++-
>  kernel/audit_watch.c | 3 ++-
>  kernel/auditfilter.c | 7 +++++--
>  3 files changed, 9 insertions(+), 4 deletions(-)

Thanks for pointing these omissions out in the original patch.  When a
patch has obvious problems generally people just provide feedback and
the patch author incorporates the fixes; this helps ensure we don't
merge known broken patches, helping preserve `git bisect`.

Do you mind if I incorporate these suggestions, and the one in patch
2/2, into the filtering patch in the original RFC patchset?  I'll add
a 'thank you' comment in the commit description as I did to the other
patch where you provided feedback.  I feel that is the proper way to
handle this.

> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 6c91902f4f45..2be285c2f069 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -727,7 +727,8 @@ int audit_make_tree(struct audit_krule *rule, char *pathname, u32 op)
>  {
>
>         if (pathname[0] != '/' ||
> -           rule->listnr != AUDIT_FILTER_EXIT ||
> +           (rule->listnr != AUDIT_FILTER_EXIT &&
> +            rule->listnr != AUDIT_FILTER_URING_EXIT) ||
>             op != Audit_equal ||
>             rule->inode_f || rule->watch || rule->tree)
>                 return -EINVAL;
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 2acf7ca49154..698b62b4a2ec 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -183,7 +183,8 @@ int audit_to_watch(struct audit_krule *krule, char *path, int len, u32 op)
>                 return -EOPNOTSUPP;
>
>         if (path[0] != '/' || path[len-1] == '/' ||
> -           krule->listnr != AUDIT_FILTER_EXIT ||
> +           (krule->listnr != AUDIT_FILTER_EXIT &&
> +            krule->listnr != AUDIT_FILTER_URING_EXIT) ||
>             op != Audit_equal ||
>             krule->inode_f || krule->watch || krule->tree)
>                 return -EINVAL;
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index c21119c00504..bcdedfd1088c 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -153,7 +153,8 @@ char *audit_unpack_string(void **bufp, size_t *remain, size_t len)
>  static inline int audit_to_inode(struct audit_krule *krule,
>                                  struct audit_field *f)
>  {
> -       if (krule->listnr != AUDIT_FILTER_EXIT ||
> +       if ((krule->listnr != AUDIT_FILTER_EXIT &&
> +            krule->listnr != AUDIT_FILTER_URING_EXIT) ||
>             krule->inode_f || krule->watch || krule->tree ||
>             (f->op != Audit_equal && f->op != Audit_not_equal))
>                 return -EINVAL;
> @@ -250,6 +251,7 @@ static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *
>                 pr_err("AUDIT_FILTER_ENTRY is deprecated\n");
>                 goto exit_err;
>         case AUDIT_FILTER_EXIT:
> +       case AUDIT_FILTER_URING_EXIT:
>         case AUDIT_FILTER_TASK:
>  #endif
>         case AUDIT_FILTER_USER:
> @@ -982,7 +984,8 @@ static inline int audit_add_rule(struct audit_entry *entry)
>         }
>
>         entry->rule.prio = ~0ULL;
> -       if (entry->rule.listnr == AUDIT_FILTER_EXIT) {
> +       if (entry->rule.listnr == AUDIT_FILTER_EXIT ||
> +           entry->rule.listnr == AUDIT_FILTER_URING_EXIT) {
>                 if (entry->rule.flags & AUDIT_FILTER_PREPEND)
>                         entry->rule.prio = ++prio_high;
>                 else
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
