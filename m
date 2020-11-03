Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D4C2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 09:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A5B20719
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 09:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiB0QZ1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgKCJn6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbgKCJn6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 04:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604396637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LrduPtb2x8UMNN5qOXJh0L6mjlW0dgYy55sXPxMY3h4=;
        b=YiB0QZ1p4TDrJ4MVPJLGbF0XvwxrqUgCDCFY6Oe6SiQJvJV9fKfz/+mWTqbF+Xk0COcmNR
        fKgY4K4JSDNLi1g7oYlwWJUvAa6Y8S+849AAj9ErtWnS8ULJz7pVfXAUH+zJPR1lXblzjh
        7yOVrDNWSMKb7VH555tcaCHLbBE09cY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-TmGvVquCMZCMMjaR9Mv8Mg-1; Tue, 03 Nov 2020 04:43:43 -0500
X-MC-Unique: TmGvVquCMZCMMjaR9Mv8Mg-1
Received: by mail-lf1-f72.google.com with SMTP id s13so2511000lfo.6
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 01:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LrduPtb2x8UMNN5qOXJh0L6mjlW0dgYy55sXPxMY3h4=;
        b=K02TVogzwN/qsR8ap6q6TY59y6kvmJkjppBqhAVSnv9ATQjSRBSymhhvF4v9DM+J3R
         3dlTqEH4n1TIjVi1e1paLLN80PRGKqQuqINaf1b28LfozsH7GONNMUFy1WYtH3FvP05t
         SF5WMHbRVty9zXhXZY11bNmtv7n1Kv1GZl0CGRhccM+Dtv8HpKGQEp5Mi+dNgJa4eyo5
         AKMeovU3L4CTTo1yqETx+vF2GGEK4xOuJhSZ38Wofhjc3bc0h+TR44Sj//eAfxYEj8N9
         V7NbHuK2JC4uc0rHNuzBA73pwuYshja1CImjF2NWCvOcwgy5EWf5BY+ENIjNeVYIXUel
         dJng==
X-Gm-Message-State: AOAM532V3SKno+Lei9Dxj27j49xry7JBYO0qzaXID4n/QF91mSvuALCG
        29315yfKn91M3QnPfV9UUl8gy+ImokAlNDQEtGvsguPqg9GQSSlmYZeiHd3OD54k8lZ//U2zfxA
        aO1YIYg9hi29efcr9Op6qjqdiyenQeFZfJQ==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr7827275ljk.372.1604396621679;
        Tue, 03 Nov 2020 01:43:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+9FbfiD48GTsQzM7YwZqLSY1hVTNvGI3Pw3tNQnNUPowRSlIRycyyg9ibqWa9og/wpZ2okb6KnHeF+Od0JpM=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr7827265ljk.372.1604396621510;
 Tue, 03 Nov 2020 01:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20201031133251.186982-1-omosnace@redhat.com>
In-Reply-To: <20201031133251.186982-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 3 Nov 2020 10:43:30 +0100
Message-ID: <CAFqZXNtO-GytiLeA__dS4ek=tYqGCxcaAT8eMDwzh3PWd0N89w@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: bump stable fedora version to 33
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 2:32 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The kernel that comes with the F32 image has a bug in XFS quota
> handling, which will be exposed once we start testing all filesystems.
> Since Fedora 33 has been released recently and has a much newer kernel
> in its stock VM image, let's switch to it.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index dcac54d..cba7462 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -4,7 +4,7 @@ dist: bionic
>
>  env:
>    matrix:
> -    - FEDORA_KIND="releases" FEDORA_MAJOR="32"
> +    - FEDORA_KIND="releases" FEDORA_MAJOR="33"
>      - FEDORA_KIND="development" FEDORA_MAJOR="rawhide"
>
>  addons:
> --
> 2.26.2

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/8c6713af9132f5303909b427dfade064fe40b55c

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

