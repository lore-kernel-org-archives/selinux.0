Return-Path: <SRS0=sd8A=UG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D76C468BC
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBA72133D
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 14:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfFGOEJ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Fri, 7 Jun 2019 10:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbfFGOEJ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 7 Jun 2019 10:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57A4CA7DD;
        Fri,  7 Jun 2019 14:04:09 +0000 (UTC)
Received: from workstation (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 596E088EE;
        Fri,  7 Jun 2019 14:04:07 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Jokke =?utf-8?B?SMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] trivial: remove unneeded int
References: <alpine.LFD.2.21.1905242306150.9521@34-41-5D-CA-59-C7>
Date:   Fri, 07 Jun 2019 16:04:05 +0200
In-Reply-To: <alpine.LFD.2.21.1905242306150.9521@34-41-5D-CA-59-C7> ("Jokke
        \=\?utf-8\?B\?SMOkbcOkbMOkaW5lbiIncw\=\=\?\= message of "Fri, 24 May 2019 23:07:38
 +0300 (EEST)")
Message-ID: <pjd5zphv6ei.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 07 Jun 2019 14:04:09 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jokke Hämäläinen <jokke.hamalainen@kolttonen.fi> writes:

> diff --git a/libsepol/src/context.c b/libsepol/src/context.c
> index a88937fc..e81b28c6 100644
> --- a/libsepol/src/context.c
> +++ b/libsepol/src/context.c
> @@ -38,7 +38,6 @@ int context_is_valid(const policydb_t * p, const context_struct_t * c)
>  	role_datum_t *role;
>  	user_datum_t *usrdatum;
>  	ebitmap_t types, roles;
> -	int ret = 1;
>  
>  	ebitmap_init(&types);
>  	ebitmap_init(&roles);
> @@ -75,7 +74,7 @@ int context_is_valid(const policydb_t * p, const context_struct_t * c)
>  	if (!mls_context_isvalid(p, c))
>  		return 0;
>  
> -	return ret;
> +	return 1;
>  }
>  
>  /*

ack

Would you please add Signed-off line (git commit -s ...) to the description, see
`git log` and https://developercertificate.org/

Also, if the patch applies only to one subdirectory it's a common practice
to use prefix in the subject of the patch, e.g.:

libsepol: trivial: remove unneeded int

Petr
