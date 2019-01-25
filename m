Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3396C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AE72184B
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bW/+lB2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfAYW0f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:26:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36029 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAYW0f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 17:26:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so9669576ljk.3
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 14:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GDv3/l7b0Xv0MNwt77eE/2nfQ8bWUEVXH+H15x8XdE=;
        b=bW/+lB2wf0JRjzf3oLUs2rAcqyj//WbqZvpN1rrITkNfMgbW/RQEs8rzCv55R2R0U2
         le+1kwMLXFpvusKg8JeMltG/zefFIABsZ0UOTg/9rPKBJkj//TdAUPskuxNYCzgpO/Rt
         gFFLPFQFlNeNXLmExNqH9DZpOggkLJ+ly6XmjlXR+34p2PKQSmPT7aTrHCtjvYOVjDUY
         OyH0u4KNprZ1b3bwnGiNU5hRK+s6g/lJUTuaq4i/HyqqplmRVFiCffbvQp1Slyd1y4gR
         S8JPYjHxr/9y1ZqMF8fKQUt7E6s0qLTlmvMFlLTL2CJouJl+8UbqX+gwViPfVzds2Jbd
         WF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GDv3/l7b0Xv0MNwt77eE/2nfQ8bWUEVXH+H15x8XdE=;
        b=QAJ2xrsAnuRId8buxVbXID05SGWh/3SY6cmcCDwPVW8e+59/qTM74TJKaRxCVUN6On
         mZoxzBZx5cC2SnIk9Fu6+VIwLdto8EqSeHbBWqLqwh7aQXm0eEnZK39phm+yjjXKgnZY
         XvXC3CLmHhxXjksvoSkH/cCi42l74dJC6zZJTBFJHfhKHyIJm0f+teEXtQn7yYOq/e4o
         V9Jwdy4T8FNJ/FKgfLxH0D4mH38HqHkme7b6F/LVfJN4dQVxqoWJZTQqCX4lY9V055gw
         fqOtbMtUn4Hgyoiq4MMY4X/0F2NAyXG2GIHBEpqU9jn0JC8i8y6p8A+QHe4tdF7cDK6r
         bGMA==
X-Gm-Message-State: AHQUAuZhYHSaZ5MGnj8J5WD+oJGJqkyyYC2JvFh4ezMLJH92uYnSsrva
        bGtX8iLEUdG/wD+CK0VVlKU27keCYLuD36pwYhPY
X-Google-Smtp-Source: AHgI3IbU70HqPRA+3Af6QluPGOA1rXejTLLc8HYIpW1g1pEA5B9NFlwb2JUOf/LzLOGcl7V9OT3rOEXcwK/6LthTXG8=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr2255443ljj.95.1548455192815;
 Fri, 25 Jan 2019 14:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20190125100651.21753-1-omosnace@redhat.com> <20190125100651.21753-3-omosnace@redhat.com>
In-Reply-To: <20190125100651.21753-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 17:26:21 -0500
Message-ID: <CAHC9VhQh5xTbL3j3vfbfkPTyfydAHOP8F9sZ2ruqab0XcKUnVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] selinux: replace some BUG_ON()s with a WARN_ON()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 25, 2019 at 5:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> We don't need to crash the machine in these cases. Let's just detect the
> buggy state early and error out with a warning.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

It's always good to remove BUG_ON()s.  Merged, thanks.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 502162eeb3a0..5ebad47391c9 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -678,7 +678,6 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>                 return;
>         }
>
> -       BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
>         perms = secclass_map[sad->tclass-1].perms;
>
>         audit_log_string(ab, " {");
> @@ -731,7 +730,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>                 kfree(scontext);
>         }
>
> -       BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
>         audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
>
>         if (sad->denied)
> @@ -748,6 +746,9 @@ noinline int slow_avc_audit(struct selinux_state *state,
>         struct common_audit_data stack_data;
>         struct selinux_audit_data sad;
>
> +       if (WARN_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map)))
> +               return -EINVAL;
> +
>         if (!a) {
>                 a = &stack_data;
>                 a->type = LSM_AUDIT_DATA_NONE;
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
