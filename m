Return-Path: <SRS0=L6MV=WW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E1C3A59F
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 21:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56244217F5
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 21:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JpmT5tAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfHZVum (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:50:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43542 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfHZVul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Aug 2019 17:50:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id h15so16481431ljg.10
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2019 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YvjBvk+7ijItCmV7c6yDFxn/7uUgavT8rZyfkQO+PrE=;
        b=JpmT5tAOwVQGkFO6WGf5xOYq/tqGPtkYWslPFq0fTxIQxiXMTyaOUEsNT/UHYRNp4N
         c3OK99ujwLy+GSq3vJYQLWzaLESho+E2ddD9ZOOEsO9cSczT3Yxp+GNGb+fAIuO7fONv
         6k7aOZR84nt2p1LUZcYVv6iJhPxuLQ2rAbr7BerwJbo0W5hyr38/un0dsYNbi4NP7J/H
         jhIdMD5n11lEU1Y67nv5AvONjeIFjDyjTtzGZy17M4xsgtlk8rSHxLcvHwWucgYFnbWi
         1S/K2rWDB686zE20i9p9h7V8lRu6NqnFjlcjKTkn8FFwuRauMKoM8+HmoHDdDJzuaLsR
         4dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YvjBvk+7ijItCmV7c6yDFxn/7uUgavT8rZyfkQO+PrE=;
        b=rLyWGdU7IF1qXjMCjg3f+KfdHVW1g9jQCVeiAWW1LYWNgvoUvsTVb7KDE5nCD0oB9D
         xe69efvPK7tlc6xr0+WCbcjElzgGlS07ktsQ4ipJZRe94mILP0TempzMShpf81gjcUJn
         UfDcrvBYngRX40OEaQDbdu+rFcPUxHJsXJ6CGUxEzjHZ9KKA7AoRVoVirrr/Nz3KX07M
         TlIbhdH/zQPG4w1z2cP+g/f/31IQPldYZvd/DC2gNUBcvjjdNUQHhwMjEBp3Ll2+KyHF
         T5IB4xFlS7yNmZFPfeNHIL+WjT94SVzSfkSNcdAezrGOmwRViqdoDKiE0oCuGNPzTbmK
         julQ==
X-Gm-Message-State: APjAAAX+QDm80v3grkOkBlaDDuICNcEcxmC4WP/HF2iwe5mHDQk4cqre
        oMA+Eq4Zwo8T1sk47kpkuAAcFEt5AWF26kGNqL5CjIIJcA==
X-Google-Smtp-Source: APXvYqzkLl+trReCPxLuxJcIkkYCjrlcZH6UoGQC7xcL+iI2kbntOiUC87FuaTKwyvgXZxwlspt/LSntpJwx9O4gknA=
X-Received: by 2002:a2e:9757:: with SMTP id f23mr10467868ljj.91.1566856239408;
 Mon, 26 Aug 2019 14:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <156685561015.29917.5393176418461343562.stgit@chester>
In-Reply-To: <156685561015.29917.5393176418461343562.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Aug 2019 17:50:28 -0400
Message-ID: <CAHC9VhTnzdqENrFyMgm2SnvekZ7MYOeabOowBcvjnGQ3cyxuxA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: ensure the cgroups_label tests works
 on old and new systems
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 26, 2019 at 5:40 PM Paul Moore <paul@paul-moore.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> Commit 697efc910393 ("selinux-testsuite: fix the cgroups_label test")
> fixed the cgroups_label test on new systems, but it broke old systems.
> Try to use /sys/fs/cgroup/unified first and if that doesn't exist go
> with the new approach introduced in the commit above.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/cgroupfs_label/test |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/cgroupfs_label/test b/tests/cgroupfs_label/test
> index 385b953..91517b4 100755
> --- a/tests/cgroupfs_label/test
> +++ b/tests/cgroupfs_label/test
> @@ -5,7 +5,11 @@ BEGIN { plan tests => 2 }
>
>  my $ret;
>
> -my $dir = "/sys/fs/cgroup/selinuxtest";
> +# Older systems use /sys/fs/cgroup/unified, newer use /sys/fs/cgroup.
> +my $dir = "/sys/fs/cgroup/unified";
> +if (! -d $dir) {
> +       $dir = "/sys/fs/cgroup/selinuxtest";
> +}

Merged with the requisite style fixes (sorry about that, my mistake).

>  # Create a new cgroupfs directory and relabel it.
>  mkdir("$dir");

-- 
paul moore
www.paul-moore.com
