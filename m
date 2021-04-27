Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C329EC433B4
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 08:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783AC61159
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 08:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhD0IeP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Apr 2021 04:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235140AbhD0IeO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Apr 2021 04:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619512411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZWJlXPdkwZ88ZJkc8vnPKUwNq6t1RUPtdauIBnXGqQ=;
        b=RheNo8nn//n0WrYFv/kHpZvyXqW9ZEFSHMScQm7jJhy5laP3BV/j6sWcOagk1l7NfSPD0C
        dt2NhczxJnPMaSvWObfHEJgoZwMtJIPR3+0jN3g8L5G/e9j4GN2cUAot3xlgf+YCqUVH4R
        FTbZWeB/YVnJhG9yRqH/M2zzK0rcqtk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-MdbVXkHNP32MWjI5gXkXMw-1; Tue, 27 Apr 2021 04:33:29 -0400
X-MC-Unique: MdbVXkHNP32MWjI5gXkXMw-1
Received: by mail-yb1-f198.google.com with SMTP id z8-20020a2566480000b02904e0f6f67f42so37169413ybm.15
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 01:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZWJlXPdkwZ88ZJkc8vnPKUwNq6t1RUPtdauIBnXGqQ=;
        b=BvYvrEV6brS5GSotKMwl3KN1QVfF6ea70DPCPLVg6U3IehDL3qAGqmo/WHzVqKp1Me
         IXl1vH2XZ/gZIn5bQk0e8wyUAAPHjTCcikkmvr4T2rAyf9FKzr7HmLCO8RdCJjU00ogM
         mvvQfnT5dbdnS++rvCPL7s0KTcI4IHrvsLn6bQnwMJcCqmkoP4gJPo4yq2NyNueyHZ5k
         8si+rx+sV7UmHCabCjENVeeRKpTXAjTUtAiRh8rv5WQ27U6NRTkXCop/CMmlqT1cAvO3
         UyBso9bCI+ID22aOMAYLDdTBuImGPfqDXHn57wI+Ft1W/paG9HVZ9sdjqu1FJQVKlrLo
         Ghhg==
X-Gm-Message-State: AOAM531Ic+BwqfXsfhR+qjshu4U9THNHLKHL912leVn8qq66zt0FL0qj
        Nr7A0p5MyH9NhTh+0Hq7cacGS2itkP3WbcdVhqBO4U4rrDN3ouaWzt5Z9F7c4e2C7e5Vs4xiKsh
        0ICgn/wnI/0Y2yWOvCwspJDz8Ye/kmchVKA==
X-Received: by 2002:a25:5d8:: with SMTP id 207mr14356550ybf.436.1619512408681;
        Tue, 27 Apr 2021 01:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHRq0ShF5oqVQUgU21NKz4EX11pPN62qeRjrr631jF5PlCEJsOtpZv/QpOYK5u/Nrh8NnpE8jscgUidLzzuUw=
X-Received: by 2002:a25:5d8:: with SMTP id 207mr14356524ybf.436.1619512408447;
 Tue, 27 Apr 2021 01:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <161947648054.55076.7300753011213416749.stgit@olly>
In-Reply-To: <161947648054.55076.7300753011213416749.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 27 Apr 2021 10:33:17 +0200
Message-ID: <CAFqZXNvHe094zpnfM0eBA8Y=HjwgzVpCkuA9SNfLPdJ4Th-LTQ@mail.gmail.com>
Subject: Re: [PATCH] testsuite: fix cap_userns for kernels >= v5.12
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 27, 2021 at 12:34 AM Paul Moore <paul@paul-moore.com> wrote:
> Starting with Linux v5.12 CAP_SETFCAP is required to map UID 0/root.
> This is due to kernel commit db2e718a4798 ("capabilities: require
> CAP_SETFCAP to map uid 0").  In order to resolve this in the test
> suite allow the test_cap_userns_t domain to exercise the setfcap
> capability.

Thanks! We hit this in our mainline kernel CI as well and I was going
to send a patch for this, but I didn't have the right kernel build at
hand to test, so I deferred it. One comment below.

>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  policy/test_cap_userns.te |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> index ab74325..052afea 100644
> --- a/policy/test_cap_userns.te
> +++ b/policy/test_cap_userns.te
> @@ -14,6 +14,7 @@ typeattribute test_cap_userns_t capusernsdomain;
>
>  # This domain is allowed sys_admin on non-init userns for mount.
>  allow test_cap_userns_t self:cap_userns sys_admin;
> +allow test_cap_userns_t self:capability setfcap;

I think we should allow the capability to both domains (i.e. to
capusernsdomain). We are testing cap_userns::sys_admin here and if the
tested operation is not denied for a domain that has only
capability::setfcap, we want the test to fail.

Also, a comment with a sentence explaining why CAP_SETFCAP is needed
would be nice :)

>
>  # Domain for process that is not allowed non-init userns capabilities
>  type test_no_cap_userns_t;
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

