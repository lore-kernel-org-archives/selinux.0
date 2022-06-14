Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E4C43334
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 12:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbiFNM5p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbiFNM5n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 08:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C818D114
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655211462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIwWxn9c1j1uI+Rss/iv6mmeQ1IDi7gRZIWjSpwU2dc=;
        b=eIF1n0E6B4Od0C7OvYDn8AIzCOToRmBHQ9Ks56WplFuAh8NFxY5j/7c2G6KG8dMSOtNKXm
        Y2PV57Eff5m16P3WJA2YU8dof6BABZK89c9UTF6cGyKDZbP9flt73tU9xEZokdM+5rCgF0
        PLv38B2XrIB5g5IYvktqHDEoXCVIVFc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-qCcKPu5HPMyFWVNo6SH-ng-1; Tue, 14 Jun 2022 08:57:41 -0400
X-MC-Unique: qCcKPu5HPMyFWVNo6SH-ng-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-313cfb0c181so24277497b3.20
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 05:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIwWxn9c1j1uI+Rss/iv6mmeQ1IDi7gRZIWjSpwU2dc=;
        b=e0iZXCqVTyJpx6I/WQaLBmEVdjbhKtXgDAiN4P1/D8NZ20JEg6x1Xrr+zk7PzJuYrZ
         iCfwpn+jjJnhKakBlREd+avKVQlJorII90kd6Br9HMaXsdw2pnruuXD0BbhYDrZWH3/Y
         jWIHFrIxVGDEHOkEPxYiX4eoH40A0se7Px2j2WPcBg2FXB0gTcIBNRgKP/Lno+3NaVel
         KmMMkwO/48ubwEoUZS6gS+ShOkWHyvePPQdKC10lAHxvz+5XUsKh1ID8WEwgcvNCdsy7
         QKP71I15gCopm1lDhZ4fzoy/CMySOmz1hPXjvMBIiLgHDKl/W70DkydvVBBHK+u4WDGf
         jhjw==
X-Gm-Message-State: AJIora+/97udVir4st+hLI1V0rCTHHgAmvZjWVPk55ZyZ+9aZaqmV+uV
        R3IcMy/+jqPA5kobH4J3nF7+J3UI1iRwSX/oOtIpMzel77xi4IYaS+0QFY/BANKGE5OegUKyaCx
        z77/QKcXByCgG+dKIeiPvdlDU8FjCI4mFlQ==
X-Received: by 2002:a25:3810:0:b0:664:4424:e9f9 with SMTP id f16-20020a253810000000b006644424e9f9mr4804916yba.21.1655211460487;
        Tue, 14 Jun 2022 05:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPvLbRTYXWqgIa2Tz6k6x8jx9ptBnvxvFdsvNaAGrQ4/l9gFj0PDk+q10gx8UiE4uxh3jOdI5zZNxrbl3vt84=
X-Received: by 2002:a25:3810:0:b0:664:4424:e9f9 with SMTP id
 f16-20020a253810000000b006644424e9f9mr4804897yba.21.1655211460246; Tue, 14
 Jun 2022 05:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220613135953.135998-1-xiujianfeng@huawei.com>
In-Reply-To: <20220613135953.135998-1-xiujianfeng@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jun 2022 14:57:29 +0200
Message-ID: <CAFqZXNvHB0cftgbK+mScbZbcO71OLpXrBMxWAx1z1eB27mm8Cw@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_state_kernel
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        michalorzel.eng@gmail.com, Austin Kim <austin.kim@lge.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 13, 2022 at 4:02 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> In this function, it directly returns the result of __security_read_policy
> without freeing the allocated memory in *data, cause memory leak issue,
> so free the memory if __security_read_policy failed.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/services.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 69b2734311a6..fe5fcf571c56 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -4048,6 +4048,7 @@ int security_read_policy(struct selinux_state *state,
>  int security_read_state_kernel(struct selinux_state *state,
>                                void **data, size_t *len)
>  {
> +       int err;
>         struct selinux_policy *policy;
>
>         policy = rcu_dereference_protected(
> @@ -4060,5 +4061,11 @@ int security_read_state_kernel(struct selinux_state *state,
>         if (!*data)
>                 return -ENOMEM;
>
> -       return __security_read_policy(policy, *data, len);
> +       err = __security_read_policy(policy, *data, len);
> +       if (err) {
> +               vfree(*data);
> +               *data = NULL;
> +               *len = 0;
> +       }
> +       return err;
>  }
> --
> 2.17.1
>

security_read_policy() defined a few lines above has the same pattern
(just with vmalloc_user() in place of vmalloc()). Would you like to
send another patch to fix that function as well?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

