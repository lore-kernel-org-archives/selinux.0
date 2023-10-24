Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBFBC07545
	for <selinux@archiver.kernel.org>; Tue, 24 Oct 2023 22:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjJXWXR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Oct 2023 18:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjJXWXR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Oct 2023 18:23:17 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FF10C6
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698186194; bh=bfzOxzqXj8l8QozDEHqejY92xrxkUYQ/rJCqn78kaeM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uIY4lTDb9iPLZS26tbpZl5hNuVLLViAs6Jx+67ihKz802ftJWo/aORUzBRFzpk+5o/rvlM845JxCmqdhKCqDSIyQC1YY3+ipn/fZ0QMhZawmi22m9AFOHMOtebkwAnmMOJCJ+kHpZnz8UW+GEZgMVI0zIfxYEmU9D0Jpt9QQuMFDCB1R5qx8ZHgBU13XIVENabaKtLp6rTlqg4QzEkAO+cYXc16JDSZ1eQ10SChbY2XvnYThjPS4xsXonwxQuJmBoQrr2jEs2vGbxFbTyHxvZfV32m2n6JY2EQGxUcTdcwSXK48Q7iiUJOE5vEEvNlwWILLbM35q+po32wFkB/nRMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698186194; bh=sRIgVF3RzmB04/q73fpNCOER/HjMyww6tHxScvRdx3+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OV9Jlq+/FDGXYJXClkcQ4dDjeuhyHnO0Go48qf3gR4cdlf++75K7M47TLfmJL5YXDbpfDakeoGL73aK27oDXiiBBnqW8PRohgWGGqU1PbSB7B0O8hPIoc794zEzJqWLBgjLp4i10kBbHvpnHveXE1mcGEY+OAwuFLODpuUkTEbhb/CjCF49Q+Pzq2BR4it28nkFx7Q++VZoN3UKEnAXQqtyUUA3lgueMMc4n4d3l1FTUrxHoL7CDRqOwruMqAgvASaxhQMu0u7uZPfXKelBRFEFTmCEhsGp3vg++4lpmdFvMK4AeEIsoyymxC9GCWQxuEWh+m3t7CuBhOmj9UYwHhQ==
X-YMail-OSG: W9AyJd0VM1k1_aaluPVIsC2gzVi0qQhLV3_9GPbsgUtLlKB1HiaaJrpLYRtuYk3
 YJeVBGFK_e54IkflwWos5RjErNgv1EPkpjHdBoNp6hpa3V2XNW_Vy1BgxWxI8QmmWwNHKIIH25Bh
 AE.m3k3xmEGpxVVondJilbgd5jRrWxaMGF4NI5XonSjFJg.po.w0bFgfT9nzeg8NWVGHZAto7pB5
 TzARfwUqrUOXIWEUzprTQdPjywLWH3eqhAR2fmbFnwPnUwaW8Dgy8TJyeSNt9fzyBawBkYSOErnL
 XNS6FM4e7bhbYGNxELen6de4xKfTNxq1XU02GQAe0KabMS0tzS0BLN8KKiWnU.qpI.7IPSnhYjj3
 2NRTvS5jciQz7.8KxMcRCFqnzEejEbkp1hcyygVh9uOM69.xUSHd_XXm9wb0Fi.kr4N8fK0iIdfa
 RYE69AXXRVqJ8ld1cXFRkmv8aL5V4vzo3Sxck8KvxWe9rhmWq1fpXLaOBTqU8Fn_CH2d3xPMwpgP
 0vLdJiXXLx_wUSIZGHuA_GuKVF4Lf_G8..PyCGmrH1mkdfeOHOcdwGrRSGT9ojlKqkmjy6W5oDZL
 4PJdAjDFC4EevHkAis4wu43sxK0O_uH2ZycUnMaeB1.NRV.0K12YCulna0UqH7DxvxB6wNNc93M8
 Zxdvf5F0vzGWC2bkWpDRZD9eNrwWEYMmrA2dsYLl9At4JHn5LTCBqRnZwHhuaJV5tVxr_CnHLbkQ
 1zrXze8jIpC4SKN_dsPiCFncGl7klV1OHVpuSguku4QMEmpJ14YPa66xkwkeJXXWeU2bDIoJHmTK
 Gwolee1IsJFh4aQNgeQagZ7tHn4MKsl8kFzNq05pKUuf7TGvygBmxlo3UPkX3RarUdv6WyZojlJs
 FvkFjBKNW_t3AU4WjzV_6qOlof52CUbx9iMMe0hwwtwcqaafx8UC976S6wMP8e4JyNTKxz1ilV.k
 oR2KbcInHy4xgTio6koF1jMP4hlOrwInwg1Sao5PCRDFa1rEoF3BxifXGzwL4GCDnIaZNxjz3xR_
 p0NWXMaZkdDRZxlqChDDXgzCrEcbjaYryruo.2ZC4iGF.jHC1ku1zgLvjk3hs.kQG1Aepte5sUah
 z_LXk0Cx20HplyAjfSJtNXz.XUoH6d3coTSJhw2zT_2Z7ufa0CSboJNmy4E5O5xyQgMiwsGsVBA7
 .xmRhe2eeYXhcfnpXVuLQkSD_YHTG3XIMH9.yjiLrIBnn7Ad6Ka2S5FnZNwCPlvze9azAeSEHE9B
 gWD2SQr6Vhxb5LNMxK_RuVjtOF8Ugj2k51eqRMKfL4i6gZ7xalNsEv8MmzS6VwdCL5lbNIbcrirT
 2GixJZlxDDehxcxp9cUzGgwbLeJNvyQEqwGAOMUIgfxe9h6HaYbR9BYTLFjoLHiNlMExXRNBa0VJ
 Ctt_.wz8pt0rg6.VUVrLZPdg.kBlyz6qKvXiMhG3o8xFVCoFeEb61ziBeitS4gdc82iLoAnkMcxv
 kZVXXnHIh.cN1_uub9U39IWEclZ_xIUCJ5CrUfm8LQIn1_vtsk5moHrFGQJCqt0b1CryLZFQcn9a
 A7Jzdh7WJxPYNXFFAPX8F5Qfc86U77PApurSEAhM9uflnQw7afKBXNI.GPGG2ROMtMWgLj6LNSis
 n2d4bGjWKFhdPlfxYTrtLDEPDgixPLTawvKT86KZlGk85YWzBW.11wuSGmuSFGcY.kRQRPSg3eTc
 VGkeLo48zYw2Zdl1_SKqkcTZtVthe.V5QgYwsMFdUSv0OyzvWgWngoPvHOkCxXbCxabb..ZiBUw8
 Bxl567RScqGhHySjbF_5HOf54XHIQUi6E80laP640i2mWdkmHiN70C7p7OP5Qdc3hn1PIOuTxFx1
 3rZjx3iFn6pRgIC8rWCPVsKm4TZ03UZYB_Ma0BSb5HCEk3hCIsai.8JW67h1yD_MenP4GEw1OaHg
 q.0MeMGooHsOVokRL.1NeoYwe0WCwXNuXHag.gmk7a_5bzSomdEJRJRTwlBOjYVyILixeUMKfy3L
 mnw752vu4666Ow7VJ30iDUaLJ9x5Bx48dHB72ir8dp.ALxBXiw6dt32iA7LW38YLbcEaK8vS0br.
 0LzCHe7Np3SwJKkPNrLutSjRSNEQno3_1Po46waMhmjRfTDq5JnjolZfJawxF4XUESl6DSpggeJY
 hiIYJZNhuR0lgZWxD9W53cYZTs9paMQYuXXRONwVUXsfS0dmOJxqeqp8aUZvbopSPRUDAiq7hAXj
 8IA2RMSOOoW4LRaUjd5VoFOpL.jK_tzU0AoKSt1ymUbNJPcSBqQbuCw4GFqB.wYgiuvyqQnop9kM
 ZnoGBwAB8eCYj_GOX
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e6c38e10-a354-43eb-9a13-252793ebcf62
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Oct 2023 22:23:14 +0000
Received: by hermes--production-ne1-68668bc7f7-bhhrm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4cda45f06afe0ef13ddd6e99c03d7c6a;
          Tue, 24 Oct 2023 22:23:09 +0000 (UTC)
Message-ID: <8fcaab11-6340-4056-b9e0-4650be05b270@schaufler-ca.com>
Date:   Tue, 24 Oct 2023 15:23:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] lsm: cleanup the size counters in
 security_getselfattr()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-5-paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231024213525.361332-5-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/24/2023 2:35 PM, Paul Moore wrote:
> Zero out all of the size counters in the -E2BIG case (buffer too
> small) to help make the current code a bit more robust in the face of
> future code changes.

I don't see how this change would have the described effect.
What it looks like it would do is change the return from -E2BIG
to 0, which would not have the desired result.

>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
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
