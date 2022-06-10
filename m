Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C14C43334
	for <selinux@archiver.kernel.org>; Fri, 10 Jun 2022 21:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348020AbiFJVE5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350760AbiFJVEw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jun 2022 17:04:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894A24BDB
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 14:04:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g186so284918pgc.1
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiLCrAL53VdiLKOXfLPLunTsPwo2FINx12xxld+VcU4=;
        b=bFQVTO6kUj6C9eZqt3ASwH3yDJCd8h4+qHqP1I+aPVsKQAS8QoEkX82JRGy9ooQDC2
         MR8htAsandvUIN3h90FZvL04oRvRshPFFbdKJ1A29ojwxreeu/mqSzweWjeNRGmGx7xK
         Vs/O8fPBaQaYpevC/OBloET2GC9ejXJDZpiNRsmSGIxlYWF9RIQEu1Gf6dmrhl7I17o0
         RB5a0RHCLeFhu3WcZSBQtNm0A6dj5SnN2ZdpmFi2FYl4qCF/bRV7JG8Su4HSu+8+sCZH
         2eeIIsuAeOG5yJwagorVIKfbV+8tCYLs/V4UtEdtzjxCBKK+8VbpEUb2vw187EbIm1YC
         t1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiLCrAL53VdiLKOXfLPLunTsPwo2FINx12xxld+VcU4=;
        b=aGpgXinxfw65MrEQLgwGn6jC9cjR00QJnH/9pOGJNIiFDnA+q14IuwG7Qk3iNENCWg
         aGJxkBFo7IYluAowWA5Qwij2gTBhm5qSmdbx0RO7TOZ90IfrB78/G82mrKRCv7GRNNfQ
         uy8sh15l0+tE8b0P3y/sO2WCU4oWh/lL/k5QzQLdzq9izjAKncxXMkzyz7WzwnM3BTAr
         vCFiqXvnb90qh3o4vAN3cphzwf+vAxOD38P7INPBKo1ndiUuJiLF8ML2rOGLcXYlpTgs
         XWb5BzdRtrPGuannc/kI9PQTY0u9L7HX9dF2t0LWMJSxkFMxYji0IayEJNKy/9egB/+o
         7hWQ==
X-Gm-Message-State: AOAM533IE1wojwDou+y9XIcYbAL3FGkY1TzzZYxQP+t0PKzZ5ZOJMCk3
        fCBRavvWzItmu2jp/O6peiI3n6xL1Aug8eZZyjH5
X-Google-Smtp-Source: ABdhPJwNdRdVzr3QMEopSyl6AGpCfiZgxW6A683tU/g0pcw8EZpJjU6kRe3OUp1IJyJkmTxwo6rWP/C3gyWE88D/3OI=
X-Received: by 2002:a62:868c:0:b0:51b:bd62:4c87 with SMTP id
 x134-20020a62868c000000b0051bbd624c87mr47036124pfd.83.1654895089650; Fri, 10
 Jun 2022 14:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220609230146.319210-1-casey@schaufler-ca.com> <20220609230146.319210-27-casey@schaufler-ca.com>
In-Reply-To: <20220609230146.319210-27-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 17:04:38 -0400
Message-ID: <CAHC9VhT-qo=N4k7fWvZNELNLTGDWuE4kDXEOYwMBgZGRQu8f7w@mail.gmail.com>
Subject: Re: [PATCH v36 26/33] Audit: Allow multiple records in an audit_buffer
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

On Thu, Jun 9, 2022 at 7:15 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list. Functions are created to manage the skb list
> in the audit_buffer.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 113 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 90 insertions(+), 23 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6b6c089512f7..987740374dfa 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1784,8 +1789,12 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
>         ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
>         if (!ab->skb)
>                 goto err;
> +
> +       skb_queue_head_init(&ab->skb_list);
> +       skb_queue_tail(&ab->skb_list, ab->skb);
> +
>         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> -               goto err;
> +               kfree_skb(ab->skb);
>
>         ab->ctx = ctx;
>         ab->gfp_mask = gfp_mask;

I didn't notice this in v35, but if the nlmsg_put() fails I think you
need to preserve the 'goto err;' since the skb hasn't been properly
initialized.  The good news is that I don't think you need to worry
about the 'kfree_skb(ab->skb);' in the error handler as it's already
been placed on the audit_buffer:skb_list list and will be freed when
audit_buffer_alloc()'s error handling code calls audit_buffer_free().

-- 
paul-moore.com
