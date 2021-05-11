Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52C9C433ED
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51996147D
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEKB5o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 21:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEKB5o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 21:57:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086FC061574
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:56:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s6so20927187edu.10
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDtzTdMSjcCqYcT5nK6EFkvKRXtIDXqaS339sOlu//0=;
        b=goM8csypbR2xlddwybHibrVkVZ8BUvaLsQbWcSyDqReWQli4Dpdl5+6XDnHyed5Od3
         GtirXBkJHXlunkCaxk6pq+ytw6KDnFf9imkrkXdU7pfgxepLMyhq+UNQqvdd/aY7Paol
         uE7oMtDLW0YeAkEByiVEDPPPcND/TFIKsm2Mc6WrjPGK67PSDJNaY9a95kYC/4tCl4vt
         Ls5GYWjkZCtiw/iIVgM/aB9h7IP5297yA1+hFE9KPABzipUCYxNj5Ks2I2Efb9bCnFt2
         tzRrzbKfX34SunzQJw6D0jXU7jZqclwu35EeI+V/ESbQgVgMujJmSOoyL1liYBDH8kIV
         6Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDtzTdMSjcCqYcT5nK6EFkvKRXtIDXqaS339sOlu//0=;
        b=CJs+nXQEXkBCnWIOcRzL5xJSduOHnOO61HTrQhD4MbDiJY1pGibS0pU+VW7UtLbT75
         pQq9cbblFvI/a/IWrtNVQRsBfQQNd+eDNYSBmWpdDokHmtOCTjEke8Ns9J9upi0z+r2s
         KaTg8szMzEH16o3/enY9Yk1NxZDFqo+9i5806ZBcq1f+sZ+Q7vtVv+7ubWdjXyNbuUQP
         6YOONbPgMcDnKX9By2pvEc56VxuSjkvuVScwACiozf30hbD/7vk0DwspYGn3k1XVk75X
         DwCfJj8lWk4egfU1gEY/PS/2K75DR1j+w4uD77KFWfkz5984g+BdqvqRV3aV1Mj5mSrJ
         d2pw==
X-Gm-Message-State: AOAM530oo0Un+AXGgcTPxSFF67tO3QRZeCV4DpGil9Ze0Bzn2EyTvTzE
        z72AzyTtDP+QsRyVxsuDk3g1eIhIYZF43dQoIsLg
X-Google-Smtp-Source: ABdhPJxBfHu8z/ZiSgV/j3o5jS7B+Kumf+ru+Z6HH3l2edXqgoWbzp1aZ4GL0VzEmuOB8wvgEDE9g248+SPIiDyvR9U=
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr32824463edv.128.1620698195684;
 Mon, 10 May 2021 18:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210507130445.145457-1-omosnace@redhat.com>
In-Reply-To: <20210507130445.145457-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:56:25 -0400
Message-ID: <CAHC9VhRFT=CVTq=wCxE=Wn8VHP+g1Cyw4zc0oAtsk7Jaa5EMzQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: use strlcpy() when copying IB device name
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 7, 2021 at 9:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> While the buffer should be large enough (IB_DEVICE_NAME_MAX) for all
> InfiniBand device names, it's better to be defensive and ensure the
> string will be null-terminated even if the hook happens to receive a
> longer name.
>
> Found by a Coverity scan (BUFFER_SIZE warning).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 92f909a2e8f7..ec14ed56f508 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6864,7 +6864,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
>                 return err;
>
>         ad.type = LSM_AUDIT_DATA_IBENDPORT;
> -       strncpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
> +       strlcpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));

The kernel preference these days appears to be to use strscpy()
instead of strlcpy(); if we are going to change it, let's change it to
strscpy().

-- 
paul moore
www.paul-moore.com
