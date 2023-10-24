Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052FC25B47
	for <selinux@archiver.kernel.org>; Tue, 24 Oct 2023 22:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjJXWX5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Oct 2023 18:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJXWX4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Oct 2023 18:23:56 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E89B10C9
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698186234; bh=j6P2QnBXU7U94C9mZqYpbbTJGrTfW2I/mQOU4PqyEmc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=A9+aIhCmifeuCyeNIlxyuH6CMq6nKufaogEFMMxr0uo/QVs1cukbx88Lw/TQJFSSQ5qPi+FxRv8soLrrnI0ATR+guQdXfcPAVcNnQs9tHsUJ63Sz4gx884Lu1FAVJEN6bBNvFjBlVKelUppXjUhhg/lE8j5+KC1Jy8m4doz5VSFVlkCytaos2eufPGeim9dj1oqZS8AgSXn7YtvZfbpdODAEcsGbm1nZsMKq8J0l2+l/pnqrtyLgUqu8tXoJkaSgHuU98sQmXz6SUTOQjblGaHTGfZGJ+GCJGog0XFqwwmNAjataye9fyIdJOkuiOP/sy4raMesqCle12Yaanfo8/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698186234; bh=VWdvfEaMX1uwaO9t8KfUIwjiiQ4VIb4WbdLjE5h0fPp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TZLF1DkhxZIzlKxajvoo+XJkxUQMWP2hfXGtB0LywtsKe461lgd5Ih8pJSvmlG+jMieTixD62D0Tw8SHUbl6QVe9DtbKHphzM791KR25GUsO4egTVYMONq+QaFLJOA1Sn0LGW3BQjIgJriI/0ygeUy8bcVSW18/8lWg1BRJO5W0wk/G+/o1yS4sJMNOCaAdhNxKopqnnJwy51EBidCJ1SuixieqHMYCMqeHomWHeIB77YThjmMRaaCE6Dr345Nw4ceWh0JWEWLw1wXkNT5xoIMUfqrFFPjmKbJygxmSTU4xY7NlJgZrmPGqe9zt1wcZUG1cRShDUrKxU60gDWX0Vag==
X-YMail-OSG: hVI9BRgVM1nT5yNL58D2AsxlL8akjhxMPCUWMqcncGRRuTkkO.d8_mAadjoJtnk
 NlL3Kulk9znjzqbbz46HDsOLP2JXEi984aV1rg9DRG1lFyQYRPpwMsBr7vTySP_XuhLKsBF.DyOl
 xM32cKULYGu266sXmGZrAbYJoaH183txfKtdR31fcs8nnlScUbmrv7SHBYoRioWJ5AG.FVsQVCaJ
 vFHbaWqCQYcqvmW7LeR21wh8rFhWcUtjx353p_uDfzjNr.PmJlUddW8YwhOZX7c8O6VI9Uo5HFpp
 zJNt9wbijWDSpnzqIweEIxGKfFwRy8tNmSPr8377rUBb89TklkilGLHITIxttpIyNMFqpX82q.dj
 2BE5oDAQMMIXGoRU1Y2GutDsAslS5ShpUU05a3YSHFefvm683qcNUdyfqxlnRaLGm9N4d1CtWmnN
 3uLIJKhm.rQ80za1oIyiKe3TUWOH1XsQkWZMdmsOlKmHqXXS2QK8gKUBp0QpoLyRddeu4ny9xeR3
 JyPKEUeRnkpzQMmhDf1.N52czvvRw6a95i6HNODq2A.jcmkcJkIwpc8yDaSLWJ8d74spFPyj6u8r
 Cq1vMZILRhnzZdnRLrSWU7d7XtO2ZxzmNLsEzfFY2tjY7a_vg56l7tJsLXGGBMnBI8yhuJGwNLdW
 6dXfUvhcE.KxNTj.69YsAwp2X9tjO.gMin19rN479arlEz_l.H0bo5X0rCjrZM2FYU26jrlsPNrv
 Q0WaB00s2Ki6TYmIyEAuhDuyuvXErvLV2d7UPEBbBdJ9rRbsPdGNkVUQNoBMtCeeOZPDOMaiRO2L
 nKa7gI4vCxhZPjinlsTDxlbteSQ28FbRx_i4kxG6GUk3FCcqc_pdcjk0YqMJ4jisKa6HVj1JUAd7
 jzyLu6FUAxfeIgJp96JTLBZ706mUKKHTiYV7fpUlphqJLsNlE5uTQrhq1omneEH2OpnvexaSBip_
 r3eKUxb7COMM4MyRiPCI4OZ1wyrmTABOkdPn0R4WR7ycAoTdP9P1TXDkamlcc5UOJW1xbCodztgO
 Ie1aIKvnPjrzpKvk.BnIVC8bHnptn3TMXp408pgjNxEnjosccTdvEQ7XUozEb8mGKToBm85TRTuY
 4dhNFI1WfVvUskb6jKu47XnGCc2EpAXH0FhOTmihiecQ_BIHb6jpFvwMy7JWuOtcCuExCiH378TI
 QYyFggld1KMth4hpNiDzodCzdgA2FNUR4L.Ko8y7aVSPf_EOFl55t06HpPLjYiflpNTSMbB1sGFC
 dnxOcitmz1j.nsiRTEPhRIB3bcWlQQpbD1ncG2p5tuZCv94I6Vqx_HbRot1caGbFg3dhLaoDtGdV
 pOfhlWIr1NZ2MTCTlxLPtrk8F3qYnt4dS__lkkXVHbr.Pxj8TYkEpAHjAQji3H.c5OFF6YpKUYgs
 0ldxKd6aU77d4sWmAaLckrh8Xwlj1yMmoi9xzfcsD3nF6Tqz1ePuN_0lQUEydCbcK6X3UG24wejj
 .s0AlMoa__XmhyICI8kil5LsFTI3lKFtRPuOjuv5jlrF7Cq9UzUa31SD1q4QK0BmIIakDY7KEDJw
 UZ8lZaoq2DHwPkoqKX81e66aHqQ18zkp1QF.ljwsHXrZCmJBtsa.rfg48ZzV_NS5I2Gf1yZBwgSn
 3ZnZF7ryMUi5.YRfxxh3cEyoXvGkOn8vqOxHSlZ5yADSbpDFJr8ZC6D64h40EZHtCXIIEkt5ztpk
 OFC_KUSnn9wYOOPQd3_TAEg4xXtoDVq3mpHixRJw3pIEW48tUFH5coLMjOrVeD41Gw6VqjDkTwFr
 OsirtkhYm5.6gyJd2hqfdl1A9K9SY8jxKrSDkz8JgckIYHysRNXN5gfocup0p95DOg8jv.UDt6Mf
 8R926EhJr8rvblfFEHqmDeeJ_EpvFFPYjwflcJfEjtajGQkq4FNfPco75SZdSX8pXaFSYzTlDY2n
 HcNXQ97BfOJ370kautkhMIp.zM_jpUy7ESBZp3uEemoCPyKZ.PAQMV48iuQlv9BufuSzzxF3b4UU
 s5BhTZWVOA1wrtuZrDLd8lngj8Z_KjdNBLDZknD3yAFhz1CI7tWzUVIggz3NVdtx.crTS8klnX0F
 ebk4D.TDk7m68XWLdfCoqe6run7AVpww0sSP9i5mrxV7dzpiRegBov92MAJQVjJXUWP4.jHzuRQ3
 _BcjPUY4UC3vYHhSnR.uWJXHCGzVqRzOFYcUsq3RzHSQqaQbfEK4Ds6IBL87rFtDQu8LoQ3pOz8e
 hRv5Pto5.1ZcG_xnPvWFHykd1cuFSyx1XHjmy0TdA6dl203z7zUnIz95SMp7ZAl_3Jza_bwE8T4m
 Gg7lXCdXgVqY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 88c5968a-f603-49f7-879d-7598d1c19fff
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Oct 2023 22:23:54 +0000
Received: by hermes--production-ne1-68668bc7f7-bm5xs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 61ba1c8306496e5d1c740d09f51cd615;
          Tue, 24 Oct 2023 22:23:53 +0000 (UTC)
Message-ID: <063873e7-fdf7-4053-8e29-8dbc9e98f6d8@schaufler-ca.com>
Date:   Tue, 24 Oct 2023 15:23:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] lsm: correct error codes in
 security_getselfattr()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-6-paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231024213525.361332-6-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/24/2023 2:35 PM, Paul Moore wrote:
> We should return -EINVAL if the user specifies LSM_FLAG_SINGLE without
> supplying a valid lsm_ctx struct buffer.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

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
