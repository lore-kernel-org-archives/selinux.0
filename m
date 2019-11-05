Return-Path: <SRS0=kJrL=Y5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF710C5DF60
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7520578
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0m5ZsZmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfKEPBr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:01:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46725 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbfKEPBr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Nov 2019 10:01:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id 19so10211173lft.13
        for <selinux@vger.kernel.org>; Tue, 05 Nov 2019 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+6DDVvf/Sp/Pfb9RzGJnAMMN2GKMI8WwAA5ayfG3j8=;
        b=0m5ZsZmR1JXjKAVshnZxZTjfZ6CYvczkQ7eikf9RMch4ndWWJOvX3qtkAmG6T8wzX8
         68RyWaNjyd8O+F7idkFxYzQQZjS9oVtJYipXN0kwwH5APCEgsLNytn/m0uwcpaqOXYk+
         DyFJbpWQddXcMZwGbJSqaJZ8WnSjY21xjQzVujWky00E4gWl6Jt/n3rzTZgf4M8YORQk
         D9xOPZ9Jf0g03RQE5kY7pnmmUZT833QZpVRnN/iNjE4WqpOXr1oViPqFQ3KyhLi9LuXp
         Ucnr05P82xzzR+GIRnT64zbDYSMNQpqR6rLYtEQbdyTJSKiQpd0/TuXZQZqXd+j1Zuv1
         Ezng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+6DDVvf/Sp/Pfb9RzGJnAMMN2GKMI8WwAA5ayfG3j8=;
        b=Vs5eF5Hq9g4fLILjntyCb5NCy8jPdo8oDU4wvZ33ThB9Cu51lQHYqtybg8hlXEn3zI
         1uGmJGpEJEfV5kdMJBH7eQ4DxSZ20S0AKMOVOcI5IFyK/kEMYVqwH1AKGv0S2UMFMqzO
         XJtU9KO8zvBZDDoossGeIWjxtqhxwgfRynWqHBhqMjtR9VrkldnIfFKSqE6DFslnIrcM
         qDR60qgj1MBnpQ1TEYyehB+6RHOaMb/TFivYNv9XtQ4jYkHCwQYTip2sPYX0n0tyHRQS
         9eQQVxeJCboIOIa1mito3baQH5gpPkQtqCUVsOtdXbwNkoghDKkju42beTn92DugxjNs
         ujFg==
X-Gm-Message-State: APjAAAUGzzumw2CfIUXQJibFvepp8Jzch6OETh4kQjIbSUcecJuu86/Q
        t85Q/oy+etFAlbd8okSKJa/2zEL4vUJWp5muDnVIHVA=
X-Google-Smtp-Source: APXvYqzq3RGf11gHMwDfLbRAvtbcVqWk0cufwHUWp0Ow0bVRa6+ICsjAU57s1dUvr3pA5ir3JWKzJccDDOfle1hxido=
X-Received: by 2002:ac2:53ae:: with SMTP id j14mr1658760lfh.137.1572966104674;
 Tue, 05 Nov 2019 07:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20191031191520.2849-1-sds@tycho.nsa.gov>
In-Reply-To: <20191031191520.2849-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Nov 2019 10:01:33 -0500
Message-ID: <CAHC9VhTeZ_PS2UUqZ=6tGtGegsi2yFV7hFm701gjG0fGvt8sag@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: add tests for fsnotify
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Lukas Vrabec <lvrabec@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 31, 2019 at 3:15 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> From: Aaron Goidel <acgoide@tycho.nsa.gov>
>
> Added a suite to test permissions for setting inotify and fanotify watches
> on filesystem objects. Tests watch, watch_with_perm, and watch_reads
> permissions.
>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> [sds@tycho.nsa.gov: fix whitespace, check-syntax -f, policy cleanup]
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  policy/Makefile              |   4 ++
>  policy/test_notify.te        |  94 +++++++++++++++++++++++++
>  tests/Makefile               |   4 ++
>  tests/notify/Makefile        |   5 ++
>  tests/notify/test            | 133 +++++++++++++++++++++++++++++++++++
>  tests/notify/test_fanotify.c | 109 ++++++++++++++++++++++++++++
>  tests/notify/test_inotify.c  |  43 +++++++++++
>  7 files changed, 392 insertions(+)
>  create mode 100644 policy/test_notify.te
>  create mode 100644 tests/notify/Makefile
>  create mode 100755 tests/notify/test
>  create mode 100644 tests/notify/test_fanotify.c
>  create mode 100644 tests/notify/test_inotify.c

Merged, thanks Aaron and Stephen.

Lukas, do you know when you expect to merge the necessary policy
support into Fedora?

-- 
paul moore
www.paul-moore.com
