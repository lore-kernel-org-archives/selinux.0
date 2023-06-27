Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11390EB64D9
	for <selinux@archiver.kernel.org>; Tue, 27 Jun 2023 14:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjF0Oin (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjF0OiE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Jun 2023 10:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15830F1
        for <selinux@vger.kernel.org>; Tue, 27 Jun 2023 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ck6UTJGyxCCD9cLDhmIKEwHEbNWsOf5EyAHtj6Z9Jr8=;
        b=c1uyp6n+trYJRBjhdHtH09/pbsXE+jyDi1v8WHM0HUP6wU3K6ryIY5fpQCMiVEhn/GkzMA
        bT6+9N9xOGdAPqCHg5h/fZ8HHPrwjIV9WXMrr0UN8xB3eM6mvlXV2NE4eX9I4wcWTbEKtk
        TX7VmveJvUFuSMrucjCDuqlfOw2FfBI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-IQYOtLdhPmqlGKBPKxQy4w-1; Tue, 27 Jun 2023 10:36:47 -0400
X-MC-Unique: IQYOtLdhPmqlGKBPKxQy4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11BF82808E81;
        Tue, 27 Jun 2023 14:36:16 +0000 (UTC)
Received: from localhost (unknown [10.45.225.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C76B0111F3B0;
        Tue, 27 Jun 2023 14:36:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Huaxin Lu <luhuaxin1@huawei.com>, selinux@vger.kernel.org
Cc:     shenyining@huawei.com, fangxiuning@huawei.com,
        zhujianwei7@huawei.com
Subject: Re: [PATCH] libselinux: fix inconsistent indentation in
 selinux_check_access
In-Reply-To: <20230618234510.118204-1-luhuaxin1@huawei.com>
References: <20230618234510.118204-1-luhuaxin1@huawei.com>
Date:   Tue, 27 Jun 2023 16:36:15 +0200
Message-ID: <87v8f90y74.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Huaxin Lu <luhuaxin1@huawei.com> writes:

> Function selinux_check_access mixes up the TABs and spaces. Fix it
> to keep the consistent coding style.
>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>

Thanks, but I would rather avoid such "cosmetic" changes if they are not
connected to a functional change.

Petr


> ---
>  libselinux/src/checkAccess.c | 42 ++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index 022cd6b..7f0d68f 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -41,27 +41,27 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>  
>  	(void) selinux_status_updated();
>  
> -       sclass = string_to_security_class(class);
> -       if (sclass == 0) {
> -	       rc = errno;
> -	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
> -	       if (security_deny_unknown() == 0)
> -		       return 0;
> -	       errno = rc;
> -	       return -1;
> -       }
> -
> -       av = string_to_av_perm(sclass, perm);
> -       if (av == 0) {
> -	       rc = errno;
> -	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
> -	       if (security_deny_unknown() == 0)
> -		       return 0;
> -	       errno = rc;
> -	       return -1;
> -       }
> -
> -       return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
> +	sclass = string_to_security_class(class);
> +	if (sclass == 0) {
> +		rc = errno;
> +		avc_log(SELINUX_ERROR, "Unknown class %s", class);
> +		if (security_deny_unknown() == 0)
> +			return 0;
> +		errno = rc;
> +		return -1;
> +	}
> +
> +	av = string_to_av_perm(sclass, perm);
> +	if (av == 0) {
> +		rc = errno;
> +		avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
> +		if (security_deny_unknown() == 0)
> +			return 0;
> +		errno = rc;
> +		return -1;
> +	}
> +
> +	return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
>  }
>  
>  static int selinux_check_passwd_access_internal(access_vector_t requested)
> -- 
> 2.33.0

