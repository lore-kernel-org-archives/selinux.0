Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D70DC00A89
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 08:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA36F2087D
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1MMFpEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgKEIzy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 03:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgKEIzy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 03:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604566553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fRTwiRvopsj5tiTTM/rDKCPU1MCBEBTiPw9U/+UKWY8=;
        b=D1MMFpEyskJmSvGAxceq1nNGheCRP4kjWeOsAALUCYtbIPpHca9TpARXgW4HdheSp/ZoBY
        d3lXb2KPO8e42r3henyY2u/9EWl5iB6eWxTfP4SWj+jpuNfqZVyXO2j69RGzVbMadBnK36
        xolcsig6vsjRCEjd36GahcFIkYaEC78=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-xLEcHBzSOMGHJ9GeWdtE-Q-1; Thu, 05 Nov 2020 03:55:51 -0500
X-MC-Unique: xLEcHBzSOMGHJ9GeWdtE-Q-1
Received: by mail-lf1-f69.google.com with SMTP id f28so371545lfq.16
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 00:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRTwiRvopsj5tiTTM/rDKCPU1MCBEBTiPw9U/+UKWY8=;
        b=pEUZTpXBzfawXrBWNDL2wWN3V4chh8p4NDFDfH3K0ofrwxDdbvbaoxGdYiT7ihqpUp
         sME/0AeD9c8vyfy1CB+jlsuYwqnfHRDFMejwnAxf1bIDXEayqeQlhpV2JqxNpRvocieR
         EXTpjL5R/7RL9mS8D/zRvASaZI0fgx+QO190ILkBw2Jl6+ukhYq/bt7rCrutVOLfjZ5G
         6ktTaz3c900bajxGn/GyAPAde1WyT3qD8ftpkvz7O41UIj/g5Q6kB3O7q1JDss7Y6KMe
         xKDksilRQ35s3a1RaqQd5ZxE5zbbR5UtSnQbpvbRGLoxOoJnhYA8jBIXJpho0ipWU0qR
         tBGQ==
X-Gm-Message-State: AOAM530DJj/UD9Le+BAg6m4CxKBczJ/XwG2QIIjbC0wS6Sp72tHhDysu
        cLRvK62ku1D0IzR+mdJQyk7TLo/8PsAMG/rMMdzSIzMGsvPn9sfUMKrWf/nBaHshfB5392OnPT1
        ivhBd3tCPYyYwWRacRbaPmHW9E+skxbs9Kw==
X-Received: by 2002:ac2:4d12:: with SMTP id r18mr619978lfi.354.1604566550032;
        Thu, 05 Nov 2020 00:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcFuLJdirSGqJIMlp96uIcX7o/HguxvFQE6GKSEIWOUM/dCFmQhLZETGQFzbYXLn3+hAF2SH1uu9il2wqIMSI=
X-Received: by 2002:ac2:4d12:: with SMTP id r18mr619971lfi.354.1604566549838;
 Thu, 05 Nov 2020 00:55:49 -0800 (PST)
MIME-Version: 1.0
References: <160453882404.5064.13236738388118581389.stgit@sifl>
In-Reply-To: <160453882404.5064.13236738388118581389.stgit@sifl>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 09:55:38 +0100
Message-ID: <CAFqZXNuM_Cv6jrxibEMZpzJA2jUiU8jif9_LrnN8oS2LU8Q_oA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix inode_doinit_with_dentry() LABEL_INVALID
 error handling
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 2:13 AM Paul Moore <paul@paul-moore.com> wrote:
> A previous fix, commit 83370b31a915 ("selinux: fix error initialization
> in inode_doinit_with_dentry()"), changed how failures were handled
> before a SELinux policy was loaded.  Unfortunately that patch was
> potentially problematic for two reasons: it set the isec->initialized
> state without holding a lock, and it didn't set the inode's SELinux
> label to the "default" for the particular filesystem.  The later can
> be a problem if/when a later attempt to revalidate the inode fails
> and SELinux reverts to the existing inode label.
>
> This patch should restore the default inode labeling that existed
> before the original fix, without affecting the LABEL_INVALID marking
> such that revalidation will still be attempted in the future.
>
> Fixes: 83370b31a915 ("selinux: fix error initialization in inode_doinit_with_dentry()")
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |   31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)

FWIW, the patch looks good to me.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

