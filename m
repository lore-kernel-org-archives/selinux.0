Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051E3C25B48
	for <selinux@archiver.kernel.org>; Thu, 26 Oct 2023 15:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjJZPH0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Oct 2023 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjJZPHT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Oct 2023 11:07:19 -0400
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 08:06:54 PDT
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716910F5
        for <selinux@vger.kernel.org>; Thu, 26 Oct 2023 08:06:53 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SGTW21VgvzMrn4d;
        Thu, 26 Oct 2023 15:00:30 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SGTW12HHhzMpnPg;
        Thu, 26 Oct 2023 17:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698332430;
        bh=JSgWKn/7daqkUSbBNLDdLlaYRI2HPYBou+TajN6vNow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qg9cdymXBZhBFWXyBzxN6PUH0GEPTC5Uud88hJFSHpxyE71sS0l3MyDgEW2XJB1qI
         Xxg0Dt2sGazdDNsVKwRE8HFXJ+QdP0gcxI8Vce7BonZnUIdSigSftM1CO7Gov6V10H
         zwU7S7Ac1iEQAnlGTizJXtrg+yrRa9dCGISbXk/Q=
Date:   Thu, 26 Oct 2023 17:00:27 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [RFC PATCH 2/3] lsm: correct error codes in
 security_getselfattr()
Message-ID: <20231026.iFe3ieQuaegh@digikod.net>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-6-paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024213525.361332-6-paul@paul-moore.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 24, 2023 at 05:35:28PM -0400, Paul Moore wrote:
> We should return -EINVAL if the user specifies LSM_FLAG_SINGLE without
> supplying a valid lsm_ctx struct buffer.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

> ---
>  security/security.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 9c63acded4ee..67ded406a5ea 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3923,9 +3923,9 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  		/*
>  		 * Only flag supported is LSM_FLAG_SINGLE
>  		 */
> -		if (flags != LSM_FLAG_SINGLE)
> +		if (flags != LSM_FLAG_SINGLE || !uctx)
>  			return -EINVAL;
> -		if (uctx && copy_from_user(&lctx, uctx, sizeof(lctx)))
> +		if (copy_from_user(&lctx, uctx, sizeof(lctx)))
>  			return -EFAULT;
>  		/*
>  		 * If the LSM ID isn't specified it is an error.
> -- 
> 2.42.0
> 
