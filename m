Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4689EC54E4A
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2321B20730
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlYvJpyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgELOcN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 10:32:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27483 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgELOcN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 10:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589293931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4zKM4twygqPrK8++PIDtPIJ05IiM0hDUpngxKlN2rqU=;
        b=LlYvJpyjQEJzH0bFgiRjaBafzi1PCsFZegJZWxoksTpm0C1/T2ZZS3pMAmLGhf7aTiPsV/
        4+t+4XtshfGwPo86Ktt2WlqFaArctW4vP+T2orj3G000F3Z3eb5oevOfADGkePZoi4Uklk
        0LT4xy4YUMq5Sq/snHu1hj98k4y35JI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-dwf7Lc41PxCNLYM8m5BRKQ-1; Tue, 12 May 2020 10:32:10 -0400
X-MC-Unique: dwf7Lc41PxCNLYM8m5BRKQ-1
Received: by mail-ot1-f71.google.com with SMTP id f14so6137451otl.20
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 07:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zKM4twygqPrK8++PIDtPIJ05IiM0hDUpngxKlN2rqU=;
        b=H71dOKjX4BP6IQHbAGx4Te/ShHrxFiCWdaBY/ELHsu3rxFz/7SG/wq3Smelf7ivEEI
         936e4SliUEgu8m0BAfS527GA8MW2DDcXzczNsxroNPh+3k71UZBDLPNlAGN3EK+5Jsq3
         cLcCfvu/KNvWVBh11nJsZD850E6tW2gxEwlXws5FxuXR4ycOzsklz0KmFdDSeACjRKGH
         /zjh1tIc4Vw6LqLE4LAAg5aIlfgELI8w9KxoOPzOYD1D4AYGSIENuhL2kmSABpeNpOf0
         AGwKEb0qR5OpJ1Tj7K0hONhsTxefS+5gmwQfjsmfpzqjjM41lHB6jS0Vz2j581PZyB2z
         mIkg==
X-Gm-Message-State: AGi0PuY5PSL+KHdZ+JEFFj57FMZjcvwxvY35hZyrsbpteuwSXNLaacA6
        /pErlxK+0TqtIhMYzJJy+FR4OPrY0lHw0UuhSJNSXgEG4akYeIWX00wDcRvA9Hki4sppBh4WgEJ
        WauUzUBm/sCT/P9rvFJRAW0IlqxXgCGG4jQ==
X-Received: by 2002:aca:ed44:: with SMTP id l65mr23879922oih.127.1589293929161;
        Tue, 12 May 2020 07:32:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOh8iQwfMFiBC7oQWHpuuz+0i2e4wMwC26bYt3wCxrm93+wkl3xagA+BwMwfVHZM/zilGU3U3ZHjeHAWihcd4=
X-Received: by 2002:aca:ed44:: with SMTP id l65mr23879904oih.127.1589293928914;
 Tue, 12 May 2020 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200512135602.32110-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200512135602.32110-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 12 May 2020 16:31:57 +0200
Message-ID: <CAFqZXNv6RJKjKScGEvdGG07WmTTWG7Xiqr8pdHxCiJ93UHbdCQ@mail.gmail.com>
Subject: Re: [PATCH v5 testsuite 07/15] test_policy.if: use
 term_use_all_ptys() instead of unconfined_devpts_t
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 12, 2020 at 3:56 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> refpolicy does not define an unconfined_devpts_t type instead
> assigning user_devpts_t to unconfined ptys. Switch to using
> the refpolicy term_use_all_ptys() interface in the test policy
> to provide compatibility across both refpolicy and Fedora.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v5 switches from direct use of ptynode to term_use_all_ptys().
>
>  policy/test_policy.if | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index cefc8fb..e3c01c8 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -29,7 +29,6 @@
>  interface(`unconfined_runs_test',`
>         gen_require(`
>                 type unconfined_t;
> -               type unconfined_devpts_t;
>                 role unconfined_r;
>         ')
>
> @@ -38,7 +37,7 @@ interface(`unconfined_runs_test',`
>         role unconfined_r types $1;
>        # Report back from the test domain to the caller.
>        allow $1 unconfined_t:fd use;
> -      allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
> +      term_use_all_ptys($1)
>        allow $1 unconfined_t:fifo_file { read write ioctl getattr };
>        allow $1 unconfined_t:process { sigchld };
>
> --
> 2.23.3
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

