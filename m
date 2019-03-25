Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31952C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F3220896
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NdS7PK5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfCYPp5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:45:57 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:45454
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfCYPp5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 11:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553528755; bh=+6zC2frGvC5iGstReb6rnX2m3eDNPJ2uGy8EQZhujVA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NdS7PK5Co/gRxwwEoS1dibMzjhsud943q71XfkT1Ci5VIn84oUinzKiLWouKp+JpY3MxuFooc7Izst8ICGUnzcxU7AyXCtFUGRKiCekE7TWYA9k0b1McQUI8AUaR0vis9WfNQi6YbVFxxh10kbVyIoRKH1McmjbQjdC150hFCu3IPWZwpyghDQQmj/hTPp+AC6wlCA/pcH4+v0qTDIX87+T1QL9QksAreNbZ+84vPZEhMLQs41j0N0N9TbZU1gNQ4oDvz/y562Y/k3RTDsgr78uabhqZpZXRG7a58paOD97/xJHyqLigM19mGcISXkq5U0zuEq7/rBb3lxP5p2OZkA==
X-YMail-OSG: xK4phTsVM1lp5mhskNSjiIrfejHMvpIcnxh5MViz2CtoDRcutWAybyAD6N4o03I
 vWOrvaaRfrROptgBVi4XFge64118OQnSz63qXNZE3oy.iFqGjbXVpYR8LnROVP1p0Ab545IqeFfD
 7gSeYSfTfH2QonX3FeqEej5krJI9i8AITVrpRHQWLAykk4e7msb46L6FGR9Rqdien7eXAD06UORB
 z8wnDjLP_A26O_2kDoelIXMMjliw0p3MmNSmFNk4m7SxTQTt_5kTPLYpzt9w45XUiXUwr.5DXtsR
 V43hNBjwRjhUYyFyHzht6IR9lyFCnY3Xa7OgRHF0ydw2veH5X3lHP755_TIQ1JKtjzLav4qZIYdG
 VdJguFLK8_bHYkKMcULKDVQrzGHIJSspDYTo6.CYGkOef3RnWU0agvTNSnI1Z5qI1qXwvbtWTZ5X
 R.wqePbAYyIetiXEU.v9n8hxfi2BD0lPESfdfoDsekcagI2cUxEoOdMmPjgEI3N1eEaeh1MWLu73
 tpPOljcu5I2KZURAWE8dYU.cGTIWTCn0K_v.7sc0MZdpjazD9YtH4UPQfJMvkl_5CZG3hmNT6n8j
 y0XwCAuGBQWQlQtnrGAQXkKN4cWKJM9kyLjrOeqL9QeIgt2c8UhsRG2XzBwZVdmncUbp_vaq8Ler
 nhl_sMvJYHuIrTj.GhoN3cVJaBom_R3GnyUmLNSSYU5j_l_lgNT0QcAPAeHZBazwxFxNbcnTMHct
 c4OGGVY1dVYkua2UOSLKK4GFxyO23q.y65ar.HSn.RDnB6J_Fjdp6YkliXRO8ExLnXPfNTI6Axls
 X6CYDW1k04v1vxpRM6xoyWZv6HPLnp4DIFEoIrQJ.06Ba3zEEik_m5XRRwxROAt6foq5XjrWUQxW
 PmjTqoJEeCMEPwaXl9pKIx71UPG8z7_8hgKmBTMHe.7A5xrETq0Fj7vdSyxBELYcMRpnukU3MQPg
 4mFiOfgpDTnmoeugz1k5B8boHcczaywSUrVVBm9Mm021KhQfUN32pU9uPdDOhNrrW7GqTAfzTg5Z
 RFiM3hdHQUt.7IrQUHmZm0DpvmH2zOTXhf7AfSFtjq6PeOgWvpFxUnDCtLF3cUk4MWm6GVYzZF5A
 wOH.KxSgO6ihxlo6OsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Mar 2019 15:45:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f17181cde7856c563782a9c6621de0b4;
          Mon, 25 Mar 2019 15:45:50 +0000 (UTC)
Subject: Re: [PATCH] selinux: remove useless assignments
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
References: <20190325081115.19874-1-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b356acd5-74eb-5a90-18ab-7a8df62a95a5@schaufler-ca.com>
Date:   Mon, 25 Mar 2019 08:45:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325081115.19874-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/25/2019 1:11 AM, Ondrej Mosnacek wrote:
> The code incorrectly assigned directly to the variables instead of the
> values they point to. Since the values are already set to NULL/0 at the
> beginning of the function, we can simply remove these useless
> assignments.
>
> Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Fixes: fede148324c3 ("selinux: log invalid contexts in AVCs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/ss/services.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ec62918521b1..b18a8d7c1b5e 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1318,14 +1318,11 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
> -	if (only_invalid && !context->len) {
> -		scontext = NULL;
> -		scontext_len = 0;
> -		rc = 0;
> -	} else {
> +	if (only_invalid && !context->len)
> +		rc = 0; /* *scontext/*scontext_len are already set to NULL/0 */

I know that modern compilers won't be fooled, but please don't nest comments.


> +	else
>   		rc = context_struct_to_string(policydb, context, scontext,
>   					      scontext_len);
> -	}
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
>   out:
