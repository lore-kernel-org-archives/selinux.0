Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B521C5517A
	for <selinux@archiver.kernel.org>; Mon,  9 Nov 2020 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B02420897
	for <selinux@archiver.kernel.org>; Mon,  9 Nov 2020 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eoh2qVq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgKIPF7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Nov 2020 10:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730701AbgKIPFf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Nov 2020 10:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604934334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uo/TP63Q7ZAvpWERYhzc/Iyew5R/nylCpFD5EYh4pHw=;
        b=Eoh2qVq7FYSCh17IiisejlAZrak3/lE41KZO5NS/R7+gJXiq5E+OlVpE1eBPn5E+fIVyqw
        jQ+aSu+nXK1Jm7VaXD5DPHOi/fWM1WAX8WVILXVVw8JmMd2ZewipYRAkJigq7Maxp/Du6a
        dmkW4HWI6hUeNmNGcrgaesNFFXe4jkk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-ti8D9gkMOXay2xMs7lUipw-1; Mon, 09 Nov 2020 10:05:31 -0500
X-MC-Unique: ti8D9gkMOXay2xMs7lUipw-1
Received: by mail-lf1-f72.google.com with SMTP id c17so674397lfh.20
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2020 07:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uo/TP63Q7ZAvpWERYhzc/Iyew5R/nylCpFD5EYh4pHw=;
        b=edItb+PARn4F3xZ6ui3H1MgJaA6wHdAIPFHsEPzH/0X4ik6ftroZRf2/bCgpbm3Hsr
         WtFRSSyZ5z7UzHCNeC85eLg/BGEmKC6woFGKmN8Fcgc3GrqNfpqM36Xx1KbZvAQ5stRA
         yIP7DQRv7Oe1suLnuJxblMZhhu5oS0uURUJWlwI3ohKQyy806YPo+NhmZJwB6QLJpxvP
         9LEmjnxs/troUZGdrwal4wlVGtUlq0XIUKVs8m22A054o3X7z6WK5owLEj84l54egMqG
         xGiCG+ukxlQf+cfqzVRo4fKMSIzTDA183NlyB+bbb7ElkIw+MrPPNuADegeN7D2bTv28
         gWmA==
X-Gm-Message-State: AOAM530x1zZFU+0M2cW4lWvD+9bKeReO7m7Qitju7xcBv6U+6nxmrBN7
        oZ0MRp15ppth80aEZxV64RzlTCm9GeBGrzcciCUKj5DxVch5Nq1byqQNRCBYCGd401O+TJvjRwK
        xmP2tcU0dOjRT1vUIyfLoolV4cibph2fHEA==
X-Received: by 2002:a2e:3314:: with SMTP id d20mr5836207ljc.372.1604934329599;
        Mon, 09 Nov 2020 07:05:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0NXK4q67TuIrlfVhRMm26zHsJB6kflQC+9SQRsHq+CDKWI36sXBQalgiEcRIiqeugKLw+bJznq2+x2WHmb4A=
X-Received: by 2002:a2e:3314:: with SMTP id d20mr5836178ljc.372.1604934328656;
 Mon, 09 Nov 2020 07:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20201104073140.819579-1-omosnace@redhat.com>
In-Reply-To: <20201104073140.819579-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 9 Nov 2020 16:05:17 +0100
Message-ID: <CAFqZXNtMO2ARMfucG6KG-A=COz1qjenGqEjeaPqzaBzk63dYbg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/Makefile: silence modprobe output
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 4, 2020 at 8:31 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Avoid obtrusive error messages when the kernel doesn't support some of
> the filesystems.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index b441031..4c00b5f 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -19,7 +19,7 @@ MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
>  POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
>
>  # Filter out unavailable filesystems
> -FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) && echo $(fs)))
> +FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) &>/dev/null && echo $(fs)))
>
>  SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
>         fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
> --
> 2.26.2

Applied"
https://github.com/SELinuxProject/selinux-testsuite/commit/bfa5a13114e4871b93cf87112b075f2d23698e6f

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

