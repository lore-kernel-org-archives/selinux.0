Received: from sonic306-8.consmr.mail.bf2.yahoo.com (sonic306-8.consmr.mail.bf2.yahoo.com [74.6.132.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635818B493
	for <selinux@vger.kernel.org>; Sat,  2 Nov 2024 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569316; cv=none; b=gJh/BDN1OGMo0GIDXmVsxNLH6OyQCd2iG0jmcD24fKnXZZhOnH1YQj/Zpj72gWERIRODwlgpimzV6/MSA3kzGHt7IJsN1PlkAWKz0Wko0AeBHZTlIjaQ7Qb1QFn8vQ8eNSQbKQZnB7HBB4MPw8N+LXV1/ReDqPjhWxEGH1VoKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569316; c=relaxed/simple;
	bh=dFvM9H5o8lLuZ3v+nZHh7FedJzN3fiztbvdzhZ3/ovY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8MgS67TYlopa5dkxKyhIK8TAF6J2OLA5M0PrGY5UOKsANCSLNbHjXpHrW3sliASU6TcNCoJMvCtBzFW0Q0frhU+FT428R09YwvpJSFTR6PgUshtBok3H7ogo3XjQUtUlSaGoOC18Kpn+yRern+UfwWN7IMAX9wRLsO//xKlx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=I4FSFLAb; arc=none smtp.client-ip=74.6.132.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I4FSFLAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730569312; bh=MW6dV4JWMRLh67+TEVFd357UBd4Weuohh/ckRqkqiaw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=I4FSFLAbHeSyJReLKEzhwBJcsznT+8WVOISQO7YGEfuB0gKuADBRB5+ba61jQDjNDgfXDPFfJpWKsFVsyRnqJFHAh9TRL1hCU2OZDlvZ2YUWPkfh8hLWw1DOOym0lEqQmgevNNNjprawtPJE1YIPp4GPOJLahw/4oqb7YCfy1ubtOVHIx9uOOsR9TBK/j5z6VXEOkfBJAOOyYvQbuhobNSYCDdvwyt50fTVeQmoF3M9ZKM9SG14RSEJqSMW98trfn3NXaJbVvil6wvOVnSN9vPIZn/BRX+XWt8Aosh1LaFIuV4iat3KU1YPuJWI+JvPPs60855QEd1thEu0Ldbye3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730569312; bh=XhfspjvQrkwEIMZSitvDejkwxnCGC5wKxmdXHUMk6wz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WFFnygzaAUaT+GR+oNZK+IcO4uq+oGXRyKNWayrdeTuexv3OFArOnFErunz1EJQdLd/PLVBQbKy4ecthcIWflmzt1EH0R7WtRQy+jjiQO4lm6IIlPYOPj47VcUmt7PskDInmc5usS8AHy4yAFiFyOr+Esc/+YJ0eGEe3l2vLHPcTkvQ8EEhfnJLRJesJ9P7WrYV4u/Hj/FwGJ2YUDlqZ/TxM+5veMaJF2J2e0BXNmg4YZxzjtR/qCvrFzyKZQNh5gBsKhl7FLGyxGcN6ysq4mqe7BufqxT6918KHWp+hYn78Nzyl6fMY2acSWvOPMZZRI6xFlR2ccjfLjMvuEOYMKQ==
X-YMail-OSG: 00AVbv4VM1mBrYyX_FHYjm0lZJ12jZPOrI7sZy4elRJ3LOY.GTs3vN8Xez33U_x
 gCBrCaz30B2PY5TLHYAh2iCavEcLx1Cn3Q2mUnWT0ypQTcrCkljgYzjc1KkImHYPCDrUaOyueZa8
 xtkZWKr3M_ujJB9DMfrBhQ9MYG3sD1BiUsoX88I7ZBXif1eM47GpRmJyC.TJkygUAZucKG33OrQr
 CWHfz.3F6gd6_CAawOcNI9ULFcyc55opl.KE20MGyTZ.wNCb1QyA.3g9SykKkYWfd6BecXfK83s8
 cQOYlgvS1Lg4ymeNlTAh56Dv6dfKcSM_yTw135expLspQ9d8ZUcXu_gU7YbJXgtm7ldn99HVRV36
 ro4L6DWaB2Zda9NfURUZkUbeqL9DLNJcvHc6W9Sj6GyI2pna62cjoK37MdyisqU6RijqiDpaq152
 JG1u4nlLxkSgIMmkpqwqrzwIxtZmv9rwbEYAPq6uu0b1pF0G.KZJEJlyXcbTTCG1hnTjNf7VEcxu
 t1_TFzUqGAMLnJfG6_Fmsw5UpjTejZAz002oaDtUrGuHCBKDMN.yhdkog.RY2Qp72ihlZ4wLH1rT
 uToU.oEs5kxJWJP4MGN_l.ud.dJYRcSSHf3cir_MzTS7Fe4kD0NQTDBzJwl6L8.hGv0PYnnyhbOo
 NDEQ5mHHunaZhQ7WcR5961L.KjjUeiaKTBrmQxEKHCEDz5K93x7.09.eOcdBjG2NJ3Y1zVW6vzYu
 bTrS9Fh6Lq0QOUiHdfd1oUF9G13TBi74xE8txnEABr0iZYpj_d4szdRyQtV8AHmgDWhOIwzbc545
 .XuMkR7tXxXfUv80ViUTRsdoFBDn0VJ9qoKwGTxcjhrpGCEb0kE6.o6ZX64HL6U3kwLxrYGoz36y
 F9kAUebeoTRS81pNCVqpXNMAcoWxM56mSUi9sf.CCCP_dcvY2xGITIrVmZTLB2l8.SVK0Nqxjbiz
 g6PpwHIdaCZ4zaLg5rjUob_Xi.qf5dLRCi.jwq2CweVw_OgYpJvSp2IkeiBKrdqzwqhDPipRvI6z
 kyBkqLHVzskMw.Dupnk8VRXgHJYVJszs3p9wMbLLUGfbXMHqb1OfIaaChWnMk07UWNh23AMzMCrW
 kM2bVRSpIqYG_c1pEru0fLPsc1fesoxDIdbzSt0ZAEkFIlCb808.ht2QwNrF93b5UenAAp37vjEn
 pryS95LQXfMlT6maBPNqAQ.bQdIJWDdsolTGWQ7W461gjPShiB1eVKF56u8dPlkpotj75rX3DII4
 biQhrRdoZQRVYswZfv4J9kEphYOcuetBfxCcX2XYTVV9Ptdb4Lq8vonuafEjLJ4ajJjVeq6BbBRj
 77tNCjV0lcmj_gYMWccq8b6xVhHzk_qDAFPfzrvoCHFo9dRDzxviDS8bRbUwJV8kF3eHDNB.cwdb
 xNs18WT_kF5OGHVaS1h4Akzi1awtk.34wUE6b2DFJun7Tbx4kiZ9SQaR4J_HCf.q67XtFP3QyMh7
 FEdLK3g9N.fiw40oxE11VGLD_JiMcDF_TnUCuQMCAHuWRtxlliEN6AV6vBythhvrpOQge.LnRVqn
 6YLXI8CP5xqhwM.i_XOpa1wc9rbGpz2zH4T1baztsnSqjneRD7SzAsff58Ajzki6dFwKzYGag.5r
 XlzQ1T55u4yTLFl2ZjLUAPRTVaEOE5RWSrgmp02.aMnjRtLcxmGJLeeydcGKjIrONBqLHumk7j6X
 ns1CoKfdjqXzeJItWMtnwtI25h3NzwO2mzBnzlS1e6wyDWKnu5Xmc5j5Fy_Xb9mw2ktJ7aujZS6Q
 qjfZ_Eo9vdfUhu_w6ykbD4wtOAw9lJGTXzxR98mgWFZRZPAP3YLpvV99s0f1IINp0xMe5huIWCKR
 NilegWMP64D75tSwU0TtJXSZX.2Bcn21DMLz2DDBktjn6Sz5APQjyc.LAkB6yCEjob25d.CraL7_
 fl8boejUa4wRM78gRbC97wh.Yd_ti4WtC9WuPJGHN.F4PG6BemOHGd2DuoprxG9z2XNoaYhwuw9N
 mcinU1ok8..B40RyVH7q4nb5OtIztrOwaglihi.ipEqHKyX6LuLgQDe0EKHwHPPjlaRE5hm7bGug
 YspayCmVU0rkjj_c4N8SEm5XC3rPVVE_4UTttDeSI2qPL.8GIkmdlv6wa.0p3aMRlKqTdZJs0wQp
 nWUTrmsXpPi46nOT_VWpdN1k3rdlsDwThxz8MjkRvPxCuTdjcUL.1FZwRS9oiI1seDI6g3mQ4UhB
 xyFh_WlLDuPvA3dAMD5MUpggsLY9Tq0.ho29fMneqKaZrJ6aTs5adIsXTy17NuudhNzuG3QcoGmV
 bIf6uZqd0_wzXtSQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 53e65d80-ff52-4089-be08-951dd0e3b7ee
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 2 Nov 2024 17:41:52 +0000
Received: by hermes--production-gq1-5dd4b47f46-whghm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bbb3197c4336a222fa4917ecdda88651;
          Sat, 02 Nov 2024 17:41:49 +0000 (UTC)
Message-ID: <b226a01a-2545-4b67-9cc6-59cfa0ffabbc@schaufler-ca.com>
Date: Sat, 2 Nov 2024 10:41:47 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] lsm: Fix signedness bug in selinux_secid_to_secctx()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <2d02f331-42ee-40db-a64f-5ee378eb44db@stanley.mountain>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <2d02f331-42ee-40db-a64f-5ee378eb44db@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/2/2024 2:31 AM, Dan Carpenter wrote:
> The "ret" variable needs to be signed for the error checking to work.

Doh.

Thank you.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

>
> Fixes: 95a3c11eb670 ("lsm: replace context+len with lsm_context")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index eca9674c9478..0ff018f557ac 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6644,7 +6644,7 @@ static int selinux_ismaclabel(const char *name)
>  static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
>  {
>  	u32 seclen;
> -	u32 ret;
> +	int ret;
>  
>  	if (cp) {
>  		cp->id = LSM_ID_SELINUX;
