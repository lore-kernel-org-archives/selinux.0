Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AADC433FE
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 11:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiKDLCN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiKDLBl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 07:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101F2C127
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667559627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wb7lSUzOAVti1W8BTrpCnwnqLJOIeovD6WLxKXjgcck=;
        b=CRUlNeyws55G/OH4Y+YMd1VsYUS9rBGnaWcjtFRpLQiNQSRhIEDQqkD0B0jB8y6vtKyFbR
        Xp94MTUr7c6MsVG/Sl/GXwPECWj9ZLipx3+IEF5f0UJU7kruPDpkf5ZoEXYaV+NFFbSt2q
        iDx9yUSd3A0vx38IvHMdBq7X9DxTwJA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-EF-7pMn9Pj2oumiLK_9y2Q-1; Fri, 04 Nov 2022 07:00:25 -0400
X-MC-Unique: EF-7pMn9Pj2oumiLK_9y2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 756D5800B30;
        Fri,  4 Nov 2022 11:00:25 +0000 (UTC)
Received: from localhost (ovpn-194-20.brq.redhat.com [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B89C2038B82;
        Fri,  4 Nov 2022 11:00:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] docs: update the README.md with a basic SELinux
 description
In-Reply-To: <166480484056.9276.9459961157065300430.stgit@olly>
References: <166480484056.9276.9459961157065300430.stgit@olly>
Date:   Fri, 04 Nov 2022 12:00:24 +0100
Message-ID: <871qqjdlx3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> This is to help meet the OpenSSF Best Practices requirements.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>



> ---
>  README.md |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/README.md b/README.md
> index 74b0a0c3..f54e0555 100644
> --- a/README.md
> +++ b/README.md
> @@ -7,13 +7,18 @@ SELinux Userspace
>  [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
>  [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
>  
> -Please submit all bug reports and patches to <selinux@vger.kernel.org>.
> -
> -Subscribe by sending "subscribe selinux" in the body of an email
> -to <majordomo@vger.kernel.org>.
> -
> -Archive of this mailing list is available on https://lore.kernel.org/selinux/.
> -
> +SELinux is a flexible Mandatory Access Control (MAC) system built into the
> +Linux Kernel.  SELinux provides administrators with a comprehensive access

                ^^
                
I was wondering, is the double whitespace intended? Is it something
related to typography? 

> +control mechanism that enables greater access granularity over the existing
> +Linux Discretionary Access Controls (DAC) and is present in many major Linux
> +distributions.  This repository contains the sources for the SELinux utilities
> +and system libraries which allow for the configuration and management of an
> +SELinux-based system.
> +
> +Please submit all bug reports and patches to the <selinux@vger.kernel.org>
> +mailing list.  You can subscribe by sending "subscribe selinux" in the body of
> +an email to <majordomo@vger.kernel.org>.  Archives of the mailing list are
> +available at https://lore.kernel.org/selinux.
>  
>  Installation
>  ------------

