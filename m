Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDFFC54E4A
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BE520714
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 08:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVAt+yDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgELI7n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 04:59:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729027AbgELI7m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 04:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589273981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bbz4soxRB+ZE+/VGLKjEUAtNvqfrPFAg3DPxSAgv9BM=;
        b=UVAt+yDlZ6OWnciTBgy/AJvYPstFSPZeFIsxBaQi0AMZj0fUbhD53CMZYu2LJn3nbBO1GT
        I8gURiWLc4u8YfFMUW67aGmID4PltPG0vjPAM0nJDWDr2oLhfYALxMND9g6ruke615tztn
        QUkMZLkwaeuoUlxkWovFi9x9O7JnKoo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-c1XCNKz3MKe1-NtvbGQcDg-1; Tue, 12 May 2020 04:59:37 -0400
X-MC-Unique: c1XCNKz3MKe1-NtvbGQcDg-1
Received: by mail-oi1-f199.google.com with SMTP id v185so13962524oie.5
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 01:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbz4soxRB+ZE+/VGLKjEUAtNvqfrPFAg3DPxSAgv9BM=;
        b=mOykHSBqIHPNVDuOXtr87VtkvzkXuE+FC85ksTzwm0IJB5AKgfMY+prjn/jJUpEQ8h
         IH6UhNWhzwoQG6CewCpo+C9ab9rtJ2Fjl5uY6oaosO7N/dycqxgdb3r3jukjS7/71o66
         X6be5GRk6n+mJl2q5I+GY78I3hN7YyCpPWOFb3qoxNmIBr3b6fdDA58kfBmge9lqtvhN
         vVrmHtl+17a3/cp1Km1J6RpJb6absXf4WNtIHBQqHnMqTWCSqzmjCQf49NPkMOl/LAJB
         cEpRWSnVwCGQq/1n5mxhLh+A6PAnJOxx+DtxYm7a+xxPUOU+Cxmfgs95MkJ8b31nkRkI
         J0hQ==
X-Gm-Message-State: AGi0PuYjLWT7PP3J3EgPBb23wo27YoEFGe+Y/MZ7llCGcvBmgpcu+0v1
        lZ5V2q7YOOFQDB+7Ota4VBCDKGl3u3gEMWK/SncdXwe+LY9q/MNmyLSYCZnLkW4mw6YpL0K+o9e
        0kBDDU0QO/dREJnHEocwDVqiZVtWL9hfqQQ==
X-Received: by 2002:aca:488c:: with SMTP id v134mr10059096oia.103.1589273976615;
        Tue, 12 May 2020 01:59:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypJDUokmrU+bKhwNB275SoRriLd3Nu+kUoz92uvucU1O28jyIvtLh27OmPnGy9JX0wxsr0AWr7FwIdJgXMIU5Cc=
X-Received: by 2002:aca:488c:: with SMTP id v134mr10059093oia.103.1589273976406;
 Tue, 12 May 2020 01:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com> <20200508154138.24217-8-stephen.smalley.work@gmail.com>
In-Reply-To: <20200508154138.24217-8-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 12 May 2020 10:59:25 +0200
Message-ID: <CAFqZXNvcLxVN7XTNog7nkNT8n5Ds5CTiW-=U9ALWBv3jLbYg0Q@mail.gmail.com>
Subject: Re: [PATCH v4 testsuite 07/15] test_policy.if: use ptynode instead of unconfined_devpts_t
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 8, 2020 at 5:42 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> refpolicy does not define an unconfined_devpts_t type instead
> assigning user_devpts_t to unconfined ptys. Switch to using ptynode
> in the test policy to provide compatibility across both refpolicy and
> Fedora.  ptynode is an attribute that includes all pty types.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  policy/test_policy.if | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index cefc8fb..f0400f5 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -29,7 +29,7 @@
>  interface(`unconfined_runs_test',`
>         gen_require(`
>                 type unconfined_t;
> -               type unconfined_devpts_t;
> +               attribute ptynode;
>                 role unconfined_r;
>         ')
>
> @@ -38,7 +38,7 @@ interface(`unconfined_runs_test',`
>         role unconfined_r types $1;
>        # Report back from the test domain to the caller.
>        allow $1 unconfined_t:fd use;
> -      allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
> +      allow $1 ptynode:chr_file { read write ioctl getattr };

How about using term_use_all_ptys($1) instead? It allows a few extra
permissions (open, append, lock), but it doesn't seem to influence the
tests. It would allow us to remove the 'attribute ptynode' from the
gen_require block.

>        allow $1 unconfined_t:fifo_file { read write ioctl getattr };
>        allow $1 unconfined_t:process { sigchld };
>
> --
> 2.23.1
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

