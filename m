Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52CD1ACEBB
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318973; cv=none; b=XDdDMKZz4fkAanPqyeGMqttUm7JRjf6+maCiQhHhGbupSYEAjP8Vjtq4bThly+Oosg5S2Wig74QWGPW0BmMJOK/zUDDtEBr8IhkG81kvy3xA5+eR7v8zWkoI7eBqRCER4KKtRhZB4FkTaso5rcVsMDw+p+Glcg9+SAuEAskoDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318973; c=relaxed/simple;
	bh=Qlk5VaAoOiEd73K3JPSMOixqkbU0j1o/m4Z8v2Qkxa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ifqqickgzj6ywus25P5Uj2pENZvg4/VJsfYvZ8TedVt65EWaBVU0hJg/i+wqzTDzys/Q/MV4gGCNjExDfgHx3U1GWx2rOPdm7ZYMC5uD46jHoRPfFlf0fCELiaN8fHDv8hiLvOyhKLzL0Roy4W3tU4ASOMLRWLgwVW3Yhouj6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Xi7IOlpT; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Xi7IOlpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747318965; bh=xjAuixVWonEpzwuCZGyw6f4NBRx+wjK5AHGNBjxgnOE=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=Xi7IOlpTLYpHsEHZlmsZdVP2/N3tbFk0EJaBCEosOR+DJi1V3DpAvAg4Lp1ylhS1bNYurm5/RdD1kiSFGo6eSICAQCCVwgKj794RoZHhCtkTKHcRC6vX8SpL2Q+3BUun4AYmp876teicCf/sOkrPIUuvdfr4q9XQ3CPizqos1z/37pE/P8BeLdNSjzTrigVwAOlrI8VrfiDs+Ce9zyJIiMY9Z7hh9A334LUBfphY7i0pZROcw7w2SHMxa8LDMZ6k7erBPZwQSCZ24xk94i8m1zDiu6rpvsd93s+ilZMgFa6qCz7Tis4jOyQmL2V3GLLHYFw7/9Siy71C5E9JtMnCZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747318965; bh=B4U8PfaFAcTRk04G+vbSw+b5MGFpSq6zGhWQxb0yhcG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lfqrIjBLXXVlcRz5NqScx/KoMNKsGq9nI43MMyi1KfI6ZWI5b19+b8XoF6UY+V3+SMzx/ActrlV08HrdqE9Q1H3nqnOQgp9BN5CEmUU4qRjst5avi83Bk6otMy7VU6KbNTpvprL2U9sV+/M69pqtHSz41mrIn6J1TzCD6FquBqGFkaCd1tPacznA05E2b5JE5/WPBxsO645wVIAI+f9p0xnw+yuQsaFmCmp+ze39RkpSBaIH002LncKmRTyfu/UhbByP6OJ5HFnVqoNDMBDGLGcxhRuVJs1ni+FwvKB/VFcWMu45AAAZBmOGihscTTgbzqP1QwWZ6eurd9g1JZyobw==
X-YMail-OSG: zKfG4fkVM1mZvYyFDUHMcEDmTLZwH0bdTPpD9KnlFEwXF3Ct.dM3lKPtb8V_TqP
 8JTi7w3_WCNTEgimsja7FjPyLzR8eq0ixYwIBZ5xe6rQIfK_EIFJzoi.OU7Ow6LteB.j7BADDmDg
 BEaOpXz1uT1t1q6_LboewdHi23exfs4rEgO1yzBBuThKbl1zZRPvtIbXD5xYz25_uhhKZZmIoApH
 RzGkQpt3xv.CY859cUocq0sPUIe4qGx5mLZssdfHLdMgsG9w5RMzh.54I5nqFQxZ23cQVD3iGvRT
 3jRupook.FmJRsyu4Aitpz5bqJaY1rgT1OKeznmcAbQpprT5bOAKdUWMA.Y3t9ZqOZSFqUcybeZf
 B0TLx4Xj4wt8FEQBXobUWQFGbjbWNStEAdftoKy.JrahM4xlEJjrNT2aWpfKUpy9H3gdMqahAQ18
 t.UTCWxcU7THnTqKKGQjqVXIeBN15dp4lWKLAPs8IRv2zY1Wy5.r.0RhT76snL8slMgeposteRfE
 ePefNmqQavpotnf1gb3PC2FGQezESj8I1PEUKurRUc4QihzphKCRRa.tMBaUWEhNiuFhK1Ibs.WX
 RCJEBzQIY34io5xj3Ln8Aa3I8tOyhKAlugRqkhcg_zlcDJzMIbCw0lpUNeA4q.H_9wFAqCUPCt38
 2Qvan817aUkQzWczyg3BN1YH5CUQK1FohFpHgO_Z.iY3PtAdwY29uDPEOI3LNSFE3xer0jaJSdcy
 ir9OW6zwXj4lFX5ondfPJM17Hpj.6F9ioFGgKxpQ1rTuf7pw3CgsYp9YiZ0UyeT1ECoWAkaQdGmw
 Z_LHiPthCvb68fayMlAenKnKIEWd.xMKd8Av8Mklhdi9s9I1m8pjTQwfDK78aXUoKlrNpU1Ns4ch
 OdLHJVg3GBsS_v0ZX4jgfu.LJb.IsLrA7xa.ymDcSKTMfbet_qG74kuFQDzLXl_055YHRxNLHGj4
 Pgaj6Cxg2tTQbV7XT9NjFufisNmCHQ0JfoM.W_CvnBPGG7Qgky.NEvKYo7VOF.df3DIQi_5ZXJnm
 Rmj8B_0V..9UQpjZ4OPFTtCq6jVml10RZVt2eP.5mPIvS.qiuUWU14FNw4vRgXKNWK6ZA6qMRNe8
 NvkGH2w84c_2PMYE7I1r3ltJDW07kv36gHBmjXKcHtLp2xY4IT0_HCGqnX6JSMwMDPSZv_KMWFfa
 KbAvOUvbbSGGqWYz2YvO6nezo_DoLUkA.N6Zach8in3uqmsO2vwP6OVSL2f9yFPNjw3LnVnGFKm1
 caZ7_VkkOBweuHYHO_AulNq9z8sJ38PleX8oOpSLQJXwGGTMVz3D.40alNnrLTzkBqA9PQsj_bcs
 NLLgOKf1.20WwOYgiqgHEpMtXBtEkbgFf1r1O3NBmndIDu3yVq29bfy2S2MNo7izNkYjHQMvl2at
 7rd2iihwU2rDstJT3K.6G.05Cae4d.oD3vszywQoMTs3nhZZjiYyszKH7QGIgL.MyPw.CYGqdEJb
 xZrkSRbqcNNnRMWo88PCTqljVkLDOUSH33wWWiTijIVG2LIrYUFBlp2GpOQZx5Nbg.UTwir.SQWo
 SuYVtLVPGg8KmOAccTtjQe0sB78Q.q1qhRWedjKTBmczYbk9_L9DfEoTp2zH1S3mXx29kUWsRiTc
 1eyBsH0OKbGeRXCwPOFx_CZXQ4QT1E6scPQ0fhVjs7YmeAG0veBNJ93ZYXqGDK_AN8L6OnuUyIoQ
 0_3r._GOXfZU.DI3lA1_mFeCqHeRjTWgVWI7_ufnrlNEoqlww11PLaSUXid9rnXXAa8rm.NGiUAg
 Q6cEhxxFlYko1.Nkxssqa7lYFz0dg_OixqhjLoQGEtE5pkc1_RRsdPOMfBwbfwP1ab8M.NnUq0oz
 f.kSkfZYW2VxlEqIaEyC_lES6oQi1h3UNbsFPKnRxhDFg.nQZhd77y_.yIQzfVZCJCsykul.1wnF
 U.Ywx9vJ.Pot.ddYaSGm0_xe5_Osi32yB0.PU8b8r7o1mgjNA7OWFZl2umvvTqCemDCyYU7iWfsH
 I9JhmtlscyzPS8Be95yE7WpMb8UPSZHqHaSudKuCzdw0dfSzhml387kIPQzDc_27sw_FvMVdE4xA
 azMNbI1C9WEudlSmJTpB0y3PQPOJF7c5rUh0QVWWRe3XlqXDQ35UYxNdfRhlSs5HKAcOazDyIxDm
 7byQEYmKUmuEAH7dm17TqIyODC91ieZHusCSNIfj9q9va3KnjLva_jNDc.bsfMA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8a0d18a3-bd50-4481-8e7e-ed356c9a3dec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 May 2025 14:22:45 +0000
Received: by hermes--production-gq1-74d64bb7d7-6nlps (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8fa50ead4c89150223d08180ee80e1f5;
          Thu, 15 May 2025 14:22:39 +0000 (UTC)
Message-ID: <947cf99e-41c4-4c95-8f08-b35a76246593@schaufler-ca.com>
Date: Thu, 15 May 2025 07:22:38 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix variable type to be 'bool' instead of incorrect
 'int'.
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org,
 LSM List <linux-security-module@vger.kernel.org>
References: <20250515092402.14564-1-kalevi@kolttonen.fi>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250515092402.14564-1-kalevi@kolttonen.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23840 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/15/2025 2:24 AM, Kalevi Kolttonen wrote:
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

This needs to be sent to the LSM list: linux-security-module@vger.kernel.org

There is a major rework of the LSM initialization process. You may want to
base future patches on that.

https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..02336de43ba9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -288,7 +288,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>  /* Prepare LSM for initialization. */
>  static void __init prepare_lsm(struct lsm_info *lsm)
>  {
> -	int enabled = lsm_allowed(lsm);
> +	bool enabled = lsm_allowed(lsm);
>  
>  	/* Record enablement (to handle any following exclusive LSMs). */
>  	set_enabled(lsm, enabled);
