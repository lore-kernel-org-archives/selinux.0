Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32888C4360F
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 17:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090EF206BA
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 17:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfCVRqM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:46:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39604 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfCVRqL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 13:46:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id f10so2661815otb.6
        for <selinux@vger.kernel.org>; Fri, 22 Mar 2019 10:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzc6LE9HVzd84KZHDBHVC0MPhSeqCkINOUAJe9Tde7M=;
        b=cIVVvtia/oJkM414R5jyczQ+EcJV5cR9fvdYKVtAptsg3PxeBAtL8Ulg/zCXVi11d5
         LqM9EClwn+6dKsjMYbknRhGu7v+x7uA1KZ6GlXhCOjP6bT689FynpGHd+H8LY1gHBMhz
         dy2J/rXxOFLaInNrcTPVBgNmWjYCDc5YJlx5QwEzJCkIOPq+GsagWNczuirbF9SVHBMq
         bmNJ6RzuGwKC8RuLqs3iXHnSkAl4Y+T7LLJ5ScU0xwGA81J6horQRSvsnhCT0BfaN/yO
         m4I+M2hN5XVRDtxGiQ9s1iS8NSjI05llDZ1ET6g6T74WALSmlBzrwhHJRVJJLObAiEzb
         hcOQ==
X-Gm-Message-State: APjAAAUfPfJYJHeDdJ6yaK+/XUrj3NJjboGdBR6vRpB4ztspg/mlO2Xy
        dCQQ92tK5ZvUgt8pNxLUUei4Etal6rQ8VuORkib5tg==
X-Google-Smtp-Source: APXvYqxb7TeO0B8j5M3e3xY/yMRqQWuLnyleKsOKlgyhTkldum8eXcoaJFBCQ7Xnuj+TXd9Tss4HT4NooscxL3MG7yw=
X-Received: by 2002:a9d:7591:: with SMTP id s17mr7478512otk.52.1553276770150;
 Fri, 22 Mar 2019 10:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140400.18892-1-yuehaibing@huawei.com>
In-Reply-To: <20190322140400.18892-1-yuehaibing@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Mar 2019 18:45:59 +0100
Message-ID: <CAFqZXNv-u+nAr2F+bYuovqMgvVJaS1LK9kCWXCZCtWGBYGj_cQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Make selinux_kernfs_init_security static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 22, 2019 at 3:04 PM Yue Haibing <yuehaibing@huawei.com> wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> security/selinux/hooks.c:3389:5: warning:
>  symbol 'selinux_kernfs_init_security' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Yup, another trivial mistake on my part...

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks for catching that!

> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ab4b049..b6e6152 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3386,8 +3386,8 @@ static int selinux_inode_copy_up_xattr(const char *name)
>
>  /* kernfs node operations */
>
> -int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
> -                                struct kernfs_node *kn)
> +static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
> +                                       struct kernfs_node *kn)
>  {
>         const struct task_security_struct *tsec = current_security();
>         u32 parent_sid, newsid, clen;
> --
> 2.7.0

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
