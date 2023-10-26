Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E42C25B6B
	for <selinux@archiver.kernel.org>; Thu, 26 Oct 2023 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjJZPHw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Oct 2023 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjJZPHl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Oct 2023 11:07:41 -0400
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 08:07:29 PDT
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86C1709
        for <selinux@vger.kernel.org>; Thu, 26 Oct 2023 08:07:29 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SGTTW5kPDzMq5Gr;
        Thu, 26 Oct 2023 14:59:11 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SGTTW15gyzMpnPn;
        Thu, 26 Oct 2023 16:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698332351;
        bh=Irv7E9j6HOTX47HuCekJ4tPHeXh76sWkhzBG5+BnvEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmvEpAPeJ+DCXNaIay67Qy8p+CWFMwPj6nXG0nsrWB1V+YPOnshFCVUoaSWd91jlE
         KeLPNrRehi//Qi4BtoFxfWrzi8KaPDWsEk5D77GZ/kOcsxoQY5Bx89vzllXUWWm0BX
         XR60KMz1xv/CjMkw+5jREIIvEXMesHaA+nTH+As4=
Date:   Thu, 26 Oct 2023 16:59:09 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [RFC PATCH 1/3] lsm: cleanup the size counters in
 security_getselfattr()
Message-ID: <20231026.dei6ooGhab3i@digikod.net>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-5-paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024213525.361332-5-paul@paul-moore.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 24, 2023 at 05:35:27PM -0400, Paul Moore wrote:
> Zero out all of the size counters in the -E2BIG case (buffer too
> small) to help make the current code a bit more robust in the face of
> future code changes.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

> ---
>  security/security.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 988483fcf153..9c63acded4ee 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3951,8 +3951,9 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  			continue;
>  		}
>  		if (rc == -E2BIG) {
> -			toobig = true;
> +			rc = 0;
>  			left = 0;
> +			toobig = true;
>  		} else if (rc < 0)
>  			return rc;
>  		else
> -- 
> 2.42.0
> 
