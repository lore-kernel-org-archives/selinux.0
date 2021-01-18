Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31DBC433E6
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 13:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B25C22B4E
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 13:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404561AbhARNuJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jan 2021 08:50:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404867AbhARNqF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jan 2021 08:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610977478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbbaWzBEG+iQ0sCtJrnpzwQR68M/zA5qjs2VnbKebVk=;
        b=GbvRKpOBk02FtQQLfk67A5tyiakAHg628lftIp1vrH3PQBe2jmN6ZCazQpDx1n4fltrmEa
        BQWNrdFjKU2sNqrF7frnR5y4rz95wf0fUFNG2mA6GeGEpA/iZGLbJoPnlJY94rXEjgxJto
        DJKTKLC8yZnS3pPP+zgvRhgfa6UaHE4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-JOZHki0YNMeDiu1SWluPPw-1; Mon, 18 Jan 2021 08:44:35 -0500
X-MC-Unique: JOZHki0YNMeDiu1SWluPPw-1
Received: by mail-lj1-f197.google.com with SMTP id v22so4259995ljc.16
        for <selinux@vger.kernel.org>; Mon, 18 Jan 2021 05:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fbbaWzBEG+iQ0sCtJrnpzwQR68M/zA5qjs2VnbKebVk=;
        b=Y4UlCBLaISqImjNWcur74mAq8yj1gFAwbSQS2my4Xip7gMKVsTzMKedvrOUHScjblp
         XSX+aynXEVH419ho3/E2ivzBsREo6cAdw+LNjWwwThHabZDyu+O6xc6NiXWlkzbuOuXI
         scwElLEFTGHKlKvRP60k/38kifdDkAbMVqJXNg8t3DK5Qlz66kOP4P2GLP3kIYPN0h20
         oyzQSvT+ETdK+WAy4kBOHUtaWHlX9Nbxz+KUfrk0BV3k+XdVB6Jd8eOdeP6K7lukIz21
         ym7T1aBDHsGAAM7Yh3QHEZNIk1E+DNcl5HtzPznZUUCaXszGb1iBqlixfEhuF6VS28DR
         Ro+w==
X-Gm-Message-State: AOAM531bdXi5NArFSRyCPuHw2r5DZlLvUGlJ/kuHa85nIIUhg058FXl5
        k0Z5ule3ch3dy72H/HtaOQ7iap4FRfq4Z9CRMPm3e6TtybnPfMtN3W+s8joHUHOFKEwcbi84fwx
        9KsCge3If0e0GQs+Fz86YTQlrR+U/Z7LtYA==
X-Received: by 2002:a19:8213:: with SMTP id e19mr11488668lfd.600.1610977473788;
        Mon, 18 Jan 2021 05:44:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6mwnaEpveXPXaV8dM0oJqbZe6+VhodhS0RbaNAGfsidwX40ok5kuMnBHY+qU8mAFTDIJsQNwxsp93oPjvEf0=
X-Received: by 2002:a19:8213:: with SMTP id e19mr11488662lfd.600.1610977473631;
 Mon, 18 Jan 2021 05:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20210113122609.62703-1-omosnace@redhat.com>
In-Reply-To: <20210113122609.62703-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 18 Jan 2021 14:44:23 +0100
Message-ID: <CAFqZXNuGsHmHJCA1JdFAkVP_b=4KCndSvs25dKV1HDVSohwB_Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/sysctl: use vm.swappiness instead of kernel.modprobe
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 13, 2021 at 1:26 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> /proc/sys/kernel/modprobe is labeled as usermode_helper_t on Fedora and
> all domains are allowed to read that type now [1] so that crash handling
> can proceed without denials.
>
> While the underlying issue might be a kernel bug (I suspect these files
> should be read under kernel credentials, not the crashing process),
> let's use a different sysctl for testing for now.
>
> Since vm.swappiness will be more strict about what values can be set,
> rework the test a bit so that it works correctly regardless of the
> original value and restores the original setting at the end.
>
> [1] https://github.com/fedora-selinux/selinux-policy/pull/528
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/sysctl/test | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/24bb5c0090710767ff187f1682e5bf355166caa3

>
> diff --git a/tests/sysctl/test b/tests/sysctl/test
> index a726e96..d6f8c0f 100755
> --- a/tests/sysctl/test
> +++ b/tests/sysctl/test
> @@ -3,21 +3,30 @@
>  use Test;
>  BEGIN { plan tests => 4 }
>
> -$sysctl = "kernel.modprobe";
> +$sysctl = "vm.swappiness";
> +$val1   = "20";
> +$val2   = "21";
> +$val3   = "22";
>  $oldval = `/sbin/sysctl -n $sysctl`;
>
> +# set to a known value
> +system "/sbin/sysctl -w $sysctl=$val1";
> +
>  $result = system "runcon -t test_sysctl_t -- /sbin/sysctl -n $sysctl 2>&1";
>  ok( $result, 0 );
>
>  $result =
> -  system "runcon -t test_sysctl_t -- /sbin/sysctl -w $sysctl=$oldval 2>&1";
> +  system "runcon -t test_sysctl_t -- /sbin/sysctl -w $sysctl=$val2 2>&1";
>  ok( $result, 0 );
>
>  $result = system "runcon -t test_nosysctl_t -- /sbin/sysctl -n $sysctl 2>&1";
>  ok($result);
>
>  $result =
> -  system "runcon -t test_nosysctl_t -- /sbin/sysctl -w $sysctl=foobar 2>&1";
> +  system "runcon -t test_nosysctl_t -- /sbin/sysctl -w $sysctl=$val3 2>&1";
>  ok($result);
>
> +# restore original value
> +system "/sbin/sysctl -w $sysctl=$oldval";
> +
>  exit;
> --
> 2.29.2
>


-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

