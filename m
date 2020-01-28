Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B45C33CB3
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C47824686
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 09:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLGuZzzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgA1Jy0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:54:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38708 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725853AbgA1Jy0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 04:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580205265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+qT/SYn9CBlwS06VJNVbjd/6JyYXgkIv7Bhz+ukung=;
        b=HLGuZzzPZzQ8RGIEHAXdsL2gfaBBxly4+a99gDC+5p6L3rN7S4BfH61cRR4FYRNt8vNR21
        XoqKY2kiyoEc3Z4cj5PT0h5wN5k0DhS6VowS6yWWWTFkUYlLI7FbFNfxF/Uz5zp9eVQ9uW
        D1ICKGmtCVsTzr+dqRFfEzArIdwoftc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-DvRJkB7PN_GDBFJhIRo1Ug-1; Tue, 28 Jan 2020 04:54:24 -0500
X-MC-Unique: DvRJkB7PN_GDBFJhIRo1Ug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E7D13EB
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2020 09:54:23 +0000 (UTC)
Received: from localhost (unknown [10.34.245.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B43919C58;
        Tue, 28 Jan 2020 09:54:22 +0000 (UTC)
References: <20200123125716.12662-1-omosnace@redhat.com> <20200123125716.12662-5-omosnace@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH userspace v2 4/4] Makefile: always build with -fno-common
In-reply-to: <20200123125716.12662-5-omosnace@redhat.com>
Date:   Tue, 28 Jan 2020 10:54:20 +0100
Message-ID: <pjdblqnzz1v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Ondrej Mosnacek <omosnace@redhat.com> writes:

> GCC 10 has it enabled by default and everything now builds OK with it,
> so add it to CFLAGS to avoid breaking the build in the future.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c238dbc8..298cd2b7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -16,7 +16,8 @@ else
>  		-Wstrict-prototypes \
>  		-Wundef \
>  		-Wunused \
> -		-Wwrite-strings
> +		-Wwrite-strings \
> +		-fno-common
>  endif
>  
>  ifneq ($(DESTDIR),)


This change applies only when you run a build from root directory.
Would it make sense to propagate it also to libsepol/src/Makefile and
checkpolicy/Makefile so it's used when users builds components from
released tar balls?




