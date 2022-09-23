Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF7BECAAD8
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 15:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiIWPZR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWPZQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Sep 2022 11:25:16 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93FFF5944
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663946715; bh=D11walAOExIpo9/NKEcPj2pxnwmflqr/K2tpWmHjvMI=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=p2Ve+Y0xpMYDxuc6/ZJ5BeD4YaUlrroBQC/nIvqfj3iYkdoy+KsNK041fNA0NEvCcex79DAC+5ZlOAPWcx89wg6K52csQLeZXjnSJR+dSQP7yBvpzWcLs6l5t6je5JjNIFQncoPTW64DPPUWsESNU48Aioi8zPs9a0HDNO2e8jmPu1Z+n20ML9ZnCjGvM5tmZ2dqABr/J4e+rcQiV4zD7zy7PeOP/KVN0O6EkpwarwJZdklJjO1Ckk0tocvOdWKqeaFXAiyqdKlT0Ej6EKdIniPds6n8PTRU2YTEi0greaMJt/mTJKY2v+zZP6hCoS15koV5FMwA1V538Ql2dYq9aQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663946715; bh=QNqjulPCYWfznyKfzwNnoffZ+x4GgLAVX4lXQJH2+Yo=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=C2+VLEFLj449tcIhRlAGRRueHCisyACVASY0UGO5S/N5KlXUOA3tYPEyAdGyPo/Cy0BIdG29GUO59XY8KBB8zeFoC3cHf2e9VGHemr+I553VpGmaQ04xuLyzkee3OMgQfVokf8HQEGNW/dFSN+F3l1uWW+lznl65SNyCfyi0aZDXvBwGbN7vStkAUDwFE6wIkRwtAA6DATOkww+QoyMoDosPRxShIyQsBlgg1tG3ubSiF3YIzhmPZsEac9IyXx1hxxxIaDTUdNOsK0Rk1exsqNWMW32TFJfCoPfTo+z7y1ScwCDMvZ4ed0nBufJWj0+EDeoi7Vhct36+h/xYN3+1/A==
X-YMail-OSG: EvsK8X0VM1muk5UCSFlJKapf.SCp.WgljIwPQVUf5WJLzhBSo7LnRQrrHkOIXOx
 d.zzNgVYqJ292uNZ0G7l1On.uwlq5UW5rWCKbKjOZWsKl4001_o4wszJWgaGovD1f01FPwHqZitn
 GV.2s0JSU1iZnta1RuQa3V0bx8nR27VIi3M0v1nHYsWiIixbsHM2u9HeqgiiVnpbvLiEONlWYigb
 8eEuv8oexAm37rJU3ezx.YrLpYtjxA1eUoqFLSwJZz3GWKowre3Kwi6q8eAUEDv3Two855JLikx9
 c.GocG.hLgGBCwOoy37MdvPg.dkPwj3l2iLHQ7Zh5ipNHWYxkgXxBFQSohX1TUjUmkRIWfAsXAkp
 Jq9rtm_D0QZvXhgwz.GlpGtGyhbdVUrWguGtvtwopd1M0opuwAQJhnioArafVGSv.whT.V1TZisk
 kazqa2r6Qe20yeepFQoPEiMDaeRgdplUX2hjc_rS2CkXDP6fP77d2OKbtrGASDWF4OyYa8xUbXvN
 7Ti9o3cBCpGf4CzL21HhdIiFUeHFlFor8.xR6Vj.opxhc8LSYkHWPu_EUW_8BewmajqcAonThoRU
 32I3JiwPOihL3WTUyavOmDZtbyugwpCO5dOvRsLt63tjcW24WefHfn1H8iCSoBEu0teIXjfBrhbH
 LI1FboD5yn0Gf8V7ypHCGL.bZd9wCX8NuRqF89MCd.4SvkUZlqpDb_8ZKAlyYy2j_sJwU068sZa8
 .hWfis1v7mzJfrTG9LuL4ckJ5Rm1lrcYqiGz_IfuxgCWU4Eyx_FJlFritytUoK97yfk_j.xNxsU3
 fmoQltzn5zLyz1hcrvwosewGRe.gsSCZpurh7Kl7D2AvYuVn4iH1gaKzO1QfrLbPF4lOZ4PNzOI5
 HFDTiKFVkz8TzAxjUHrLKUMV8d5HaMKX.5ZzEkljNG88t31cEo6dcKBw3MuxNUTYdp7D5YIZQQ7Q
 1Uo790gjdQ8t9d1uCnLTVWz0FyUVA0glnh1S.dDZShHH4qvJYSgNI6b897HeudUWBOyql3bevC9P
 ojDkD_d99WSDyWZibforMhEhNCA3bPZUCc6gnBhw6umj2NGAVNGrcSZ9zOcp6ZaOEBc_1wk1EOY5
 WFn_kPK1gWU_EQalczdtf.oTiVl2XMwVXfVW6tlYeqe.6FHI3vWwLLyxS3HJb.t81cWr2Rpee6TD
 qLPBQLJlNEnxoWfh6LZL2CMbSN7DvrhSzCj2Y6TthgE_AD6UqnIL.tUiaPASMnKhkQhotbGLjKdm
 jXJ03OaIL7vHRMGSckOmFXHY6NYCjBE7LQuxPI3I.vXA7zZXIFBc2MuBlCWv1HbsOoyHDAHoCrNO
 .lEDvy.yJPk5inwPAHT2IwMB84OsPqcdsAj.0YBomgtMuxJgkGBnwH5VBRcAPRd7S.MT937.Noci
 9Fp83h0PjuqYj6pt_XLOmWGCk8tDWdogFSEoaALpx9Vr0Dw5mWHn3RJUp_SOrr7IT1okuxih5xi7
 fvbYwPcUbInk_Er4hJjNI0ACSdYnI9xSHVXm6G84rkTG4uRhYr99u3NiKlTcWwgo1SY.IRKClx9J
 55Ygsqpynb5KYTKddUVzpb8yAjXkiH30OeZ.VQNtgbacqsuKMJ_vKOHzQmgbX4jk0E7A16tQa_WB
 23.jfFBkciRNyRKgANh8mwdq9BIznT8adSV_j_5z38t0J4g7QMm5AorVTtwGshuEfzKz0CR6kWoD
 7XvzzLNQjS.6HQlrNOpVeYpmv0G65I5AOH_v4w56uqXSkG2vF7BPkn0rRvOs1Ut8zUgbO6EebOUN
 AbqML4hYjmaUkXMtJzIHm7dSuUcG6_Mepa4Cha0vbjCpa9jia.r1QRFEly5j3KKKdBR0Nub1fzm6
 SqaCvVHq7oRMRw1ZeZEUCPMcmoGLCltWnMY44Y7Wp_Wpe_Yip42Z.exj5XchuTJEfRo9EhKxPCUs
 eWe1k2sQWjNYW_pdwUKuSQV6Utb2qsG0A7w0VaLINUSBSNZSAu8RM9.Owhu1TlkoiBx8xY6wfxY.
 NVe6llNb0KyiYGoAn_dUSbU91bgdPFUCCYFjdRLsMVCjCNyPMUJtW6q4aKOPPO0qaHIP2pjVXb4Q
 W7McdayI48faZvl3sxqCgudHqkyqptSB_x7ixEpXJXlZusiMxR.ho9xJYKzwCPdmTaiqg2TIqqOP
 jZr5aQCerYUoTqATBCf4kiLYNJ6Bqkh7cUEbeea0iq7dTn0.zFmHK_t963Jq6RXokBS_hAHcN9Ka
 _VM9ciKY_fTIg0XtBoFFlIjCJowY509dkG2NewJLC_H0Mfr6eg333198JPvOAcK.VARqXrmrxH.z
 xfofBaFes8airCDOq8XdEMK.umg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 23 Sep 2022 15:25:15 +0000
Received: by hermes--production-bf1-759bcdd488-v8j49 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2a07f99e67a79452a03d786c5e666b04;
          Fri, 23 Sep 2022 15:25:09 +0000 (UTC)
Message-ID: <ae395206-b54d-ac82-5072-ee2fbc4f2dbc@schaufler-ca.com>
Date:   Fri, 23 Sep 2022 08:25:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH] selinux: increase the deprecation sleep for
 checkreqprot and runtime disable
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <166389782245.2164705.1324707815130435654.stgit@olly>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <166389782245.2164705.1324707815130435654.stgit@olly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20663 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/22/2022 6:50 PM, Paul Moore wrote:
> Further the checkreqprot and runtime disable deprecation efforts by
> increasing the sleep time from 5 to 15 seconds to help make this more
> noticeable for any users who are still using these knobs.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

To the extent it matters,

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/selinux/selinuxfs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index a00d191394365..0a6894cdc54d9 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -294,7 +294,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>  	 */
>  	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
>  	pr_err("SELinux:  https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
> -	ssleep(5);
> +	ssleep(15);
>  
>  	if (count >= PAGE_SIZE)
>  		return -ENOMEM;
> @@ -763,7 +763,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>  
>  	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
>  	if (new_value)
> -		ssleep(5);
> +		ssleep(15);
>  	length = count;
>  
>  	selinux_ima_measure_state(fsi->state);
>
