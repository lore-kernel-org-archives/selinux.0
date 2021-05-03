Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E10C43461
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 16:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19ED6054E
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhECQpv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 12:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231395AbhECQnM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 12:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620060137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jq5ddHiSniuDlUiihhTTyO4R5HXkorVrkLsWf3SylYA=;
        b=XDHx/inTg5Hp64kKR7aUYU3yiWNrMr/INrAt1l1B5aQooFYoq+pX7mlJVZHOA0HyXXrw5Y
        oxgFuGkjqh1HAbHVT84zQQf+rOPOHVQBDO3yRCxgccGd3Htge1F4x5wXh9Qy7JLZqi6k4R
        sSdgpCpECnMQB50aeBPnFyhzyz4mJeI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163--w4swtLXO4u-6PR4xH-nUg-1; Mon, 03 May 2021 12:42:14 -0400
X-MC-Unique: -w4swtLXO4u-6PR4xH-nUg-1
Received: by mail-yb1-f199.google.com with SMTP id 80-20020a2503530000b02904f7ea3c8e39so2006502ybd.9
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 09:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Jq5ddHiSniuDlUiihhTTyO4R5HXkorVrkLsWf3SylYA=;
        b=AlbelrC8xkYQuUJPRe0gko4NhGUC5PrRYIZL1cEQUVpFKJLn54fjbuP5dvMuR6ha3t
         7s47DzNtIT/ckfNHCzsk6T+pw0EkqqqLErPYwugilF0RsctNu8MKk+w2gEo5Hgt/TwGy
         jDXzWQLFe7eHyfGQzox2pjYQcGDOjFFZjSRkrzKH8oY21xmNpY8MWxCGy5oFoUXWBSXs
         XGmMidANo2cjckZf8mMH4jAQx5TchlvvBL9EFreNzjigo8+5CFEFIHW/JzFhScEDmxQO
         rfufpbr5UDtwAcpOfqZvkJn0U/oVm+1rIYm19W+0uKjOR0DpKZ4kIE9DSbmEaK+n5WBe
         qgyA==
X-Gm-Message-State: AOAM532LPHyEPYMM0q6gZmYuLiZ2Zz/uPT3KG7VAprkRInYRU6V13jqi
        7MGiGycsC3wE5no6wmvcLPITzFj7WGaUVa6MDBFCt8PHJP76pwMlBAuImvtwcc9HYJqa43Pf82Y
        +WitfVbesozhrXnIj//XrGOZ9e+cdlcCasg==
X-Received: by 2002:a25:6983:: with SMTP id e125mr19719853ybc.81.1620060134242;
        Mon, 03 May 2021 09:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNWQvw5aXaICXycqf0xhl55W6Yq33H3N36rOgubY/CfmGI1oILEDBCd7EVWOLOosH/f0plSy5k7dN1xVT/1yA=
X-Received: by 2002:a25:6983:: with SMTP id e125mr19719822ybc.81.1620060134012;
 Mon, 03 May 2021 09:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210501103936.19527-1-omosnace@redhat.com>
In-Reply-To: <20210501103936.19527-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 May 2021 18:42:02 +0200
Message-ID: <CAFqZXNv1p1qfZhCLhBWJOeCrjGZdZJCO_udo8XQdv8UzrPe0Xw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/lockdown: use /sys/kernel/debug/fault_around_bytes
 for integrity test
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 1, 2021 at 12:39 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> /sys/kernel/debug/sched_features has been moved/removed in kernel 5.13,
> so use /sys/kernel/debug/fault_around_bytes instead, which will
> hopefully be more stable.
>
> Fixes: de8246f5c853 ("lockdown: use debugfs/tracefs to test lockdown permissions")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/lockdown/test | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/lockdown/test b/tests/lockdown/test
> index 6694a4c..a86c988 100755
> --- a/tests/lockdown/test
> +++ b/tests/lockdown/test
> @@ -3,7 +3,7 @@
>  use Test;
>  BEGIN { plan tests => 8 }
>
> -$integrity_cmd       = "head -c 1 /sys/kernel/debug/sched_features";
> +$integrity_cmd       = "head -c 1 /sys/kernel/debug/fault_around_bytes";
>  $confidentiality_cmd = "head -c 1 /sys/kernel/debug/tracing/tracing_on";
>
>  # everything is allowed
> --
> 2.30.2

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/edf9da5d8f815d5408b46c4141eaeffd45e03ccc

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

