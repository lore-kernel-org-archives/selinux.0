Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE94C8F
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400501; cv=none; b=qeQTCM7MjbefMmGckTIH8g8Gu7KiiZPS1zyh05tytYKE5r+klSurTQB/cY7eCTl2c47J62nS788w67BbKcQSKbYI/xQf8vyjlU6RkxyeYVeYCSOHe+LejxK4S375KQ/xA8EuuZWFgPeNXrKRN4ywU4noZ/EcYXYaAjbUv94Z3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400501; c=relaxed/simple;
	bh=IcEdiPNjSULk0gDBonXhBLKVl4qmOrgyTdZRCGwedrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj3O5mDyiVlnjAYcB0xQg62h94zV53VN0fQ3diLrCti1jP8JT0vj5AoJmUaWCwfo866DmkUHpVx9kuxp7QM01S2wvZEcGi2UhP2qKeVuUYfZ8nVvl1JpmXKsDAcKPFwdzFxuHEwE1gqGsAabi5h179yBzkmrd39kQ6rvKPbd7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pQdA73Dp; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pQdA73Dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400499; bh=41ss1xSkfipC5PdMJ61F11W3sliTJUTAad4bQhl6oM4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pQdA73DpkmP2YZaAO220ber2OCjQ8JZ6czLvtKAWq82N/aH9YvERplmURFSK9vAEiHORkaIDIZvssdGwAjLjFU66r2zgORQ3cJO6UhDO9/DGyGuH6J9YASDajjjFlnW4BshS8EQs5q+wrv5nkJd3MUoM8DwtQI2JB+pBliKkraB13xGqNSMb6osmHclKMSKMyC4RpG832UpeUx19GIzvAXMqX621B/V4iS5Ku0ww2xmmjfYOoMLtRbVL4p0LbD4jdLYdXKzDbOq8nSh96GoavF4RrZ3radVRYHLrkRJFHIHvUp7CycTG0ubCXtjgBbXLVokBm8NUF76kRA+OlpVqNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400499; bh=LMomKOhvx8zghBOAn6MTEZSg+0qNK98kHor/u7wAjbu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=B862nXskrOZKtNHPJJPKJ0St8ukSmCpiSZ5Zm94CfykrGy11MIHu1dwksRlJ8GG8rOxzGxwrVQZoAUTwQcE6p+1CW2rtknvR9PDmAYL1up115TJzve9wRr7bp9A3wxhC5Sflpyrrpkbik4Z0qaqBTQHL0uWwx0neTecYgRg87Sgi3FnXedcqjh8OY9c374uPJOi6X0ZanDmAN/0YlITJuGDgxxTun1NAlNVVC0j1sj0ImU9LCCfYINvzDrogMTlDj2XMsITZA8W4HDYyR2bdQ6yLmyx1UOxKLLBfG4K1tr7w7t9oLio4k+6wRX6fvO59puPlFhsMxjOXLvSNWsUQCg==
X-YMail-OSG: qc_NYO8VM1kpvPHHOrx3oKyJ7KmMDSfWDwV6QISHfQ58hbIZ1.EvGITOe.5sfsx
 9Hy7R5oLa5xKxR9xSeA1dvyi5d7vSHF.RyymvCNyEf_i3Y_hiqiLCrIcno_oZHNu2WsnPRX4JzFw
 Xvm2b6Qps2ZdbEkq6Dy1RFOmNiJlGhhbIxjkBSH1NhsGpemBvGh8GQpTz6ghvubgXd6R623rlEBj
 IC1FtbyqrmxUdt_OoS1fnH4dLyaRI5vuRm167rlu1JemQHaWnS1D47cjEps7_rWeKvPc1WKRf1Ao
 kPOu5OnhW_c00n9amwYh6JKt.AEShzomZ5p5reG0w7WdZlAiVYSJ55WnzEwVfTSmc5Iw0SRqyr_I
 UCMVbtr17scGxEhovZqj6Dvk.mnD.yWYjtNe_x4ijbEaWHxMEMoGM_OsQNN9N82a2ttRH1ivw7la
 GI.6Iw12QLsgWeRU8nd8Vp5hGmcbpGIpZw6Db2.ieDnq0CK4wVuy9bCJ6odCEjJ.o3McpgyCgfJd
 pNa_pU.A.Wkjro5Q_ofB8veMkEnejZ3d7eL1Jsv6NEAltoQH7tr3JfXAQXfSlSf5aB7reGbPoz1u
 ec6hko5Hd6jW23WkvpH6KzBgvuDWBSeI__AwNq_zXotgim5SlhigLGZuEWNweRX2ZKggxTzoMkVK
 iHlooofRfO5bLf87BRIq3xOD0mMxsdLRhgayQIEa4j2DxtIYMit9hTU6YFtkSsvkL_NgVWKHsw_I
 kNJsvKpRov8FPmgkvORUV_FbPxg9s6moWY7.y0b0HOFRzucUtn7xGbuIH32_5SkvyWXFZ8dqjToa
 xDq_kBN1ScQo0AkgNcQMM0VA6sHcbVS4K30ESOUpRqXVkzGX19pbxniGA3w7dEAXsHh_5JxfdFyZ
 opiHhukSbjjOnbmz4oWLVR16WKWyTBn9c6hyRo4TIavwF3LzO3pbfrd44uOqkRQO61fQwhVwpjn3
 EDpDccRRTZ40X_S0zMy_0NZzTAH6ffBv.ORZPS.ZtEKaodNpVocCtLjvfOcbURXxoghw2ILRWVUo
 G5hPnvLzwoEt8TbQmMIniXjA.syQOk0ZGaxMB4lZ6PuqzL9dJYDWq6ul5u7vXJarjAW2LVNmdOzW
 VbFg3MEvrhKAMNwu0_5hP3kOUNa6WQHDPD_vjyinJyo4ANN8RacRWBWwgFWFe6JWvj6Dnucyx3s6
 HitG_S_Un6AdwmiKdvmIYf_X4zgWWLwscfDpIGXVnB3uVBwn8zlcDMuKOyHcvB3HFKkBCoB2YZpk
 zhTwu3Vue61vyRQrOdt9UuJpVfHP2JGuzK4DY479ILQyn2QPoUCmQXcz29kyBcMl1DvqlL2hQqjV
 TlSm5GCozRR1nodLSU7a8eQl8A37yv4fMOlZRPf0WQthpmI64UBzRbndaPlUq_FCJvSqm17o6GFx
 TwxFkElYgdA4ZHlfVGfIhRfcdeb2f4sFTpWy9dCxK4uOqFC0ArPw4GLILVL8BYxxOfQEILaTccoc
 x9SfY2V59RvsP85HG2yL3Oef9AgAqE6RNj_N2Nl_drI6LBU4LyIFy_pyR2NnMIgoHTx4qEK4vFcH
 7_TE7KG0z9jCaxA7uDWC_l1EALrBrPwFV2FWfhrm9xlzz2CnEPM9BIWD55nnJ9hRQI8KbXFvA98P
 YkGrfmsqrqRmOkjbccNzWIid8fh0_SYX_XdRGJyj4poof4SI0IZUaRoxcpCEXZbj4XTMsBuE4tW1
 2kMDd3uXVy9oID2avzJPVTzdAShILxv6Q2sLMF6_gZZ2R1qtnesnPFRkIyl9M71t7X0wdVTYxx5d
 _e_dC6FglvSr9FDHZnvNhEDVoTZTwWA5yKsdKpaHCgBwzWRZEgxNLi5Gz3odhBSHNxXlDUnkegDN
 zPOJn0OAbs4Rl2gDG19vxR3v6lfChyC.zVTxjEMXTEViBEx8Dy.Mj6DEVrpOZCIKvmvAbpukbUze
 qNz0rmUzbBoS2C9uII7FOTLxhgDDFvg.n1uZHUSosc7IhF2ca19XaHyobpeOs7VPZBA6sKHZqxl0
 vu0nxcY2PhAbNOTLVDuLeP0hAx0FI2RP_aHVxk5bbviVHy2wjJYxAh9arJ_6A_OOQ.av7tXMgeph
 AnqdhLKNJdMnCIKn4EWSjX70RDXWEzNf4O3c3DlgqGNWpisiZ3bxsucEGKmA_SB3.1R4DWdg4Rvo
 JrMwovK3jnMG_yDXRoMDJDz9cg6lW4lhtBFWYvuk85OrXZrgVIF18sqWWNJBRnN2sedo6ANerqr3
 CzICNYABATJtBDdadJ.eKjnK1esRJ3T31VvzYF5nN5uyzkd9kLSVlp9UAyRNuWaX1sBDw1xismGt
 VACjTWDs3710b2Wss0HKc5fOHs.sCimdJvHHcCOM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 715c0da7-07a9-49a7-801d-5b9b055b5fb5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:41:39 +0000
Received: by hermes--production-gq1-74d64bb7d7-nrjbm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d01e5d3f8c474e81f79a181bb5f79386;
          Thu, 24 Jul 2025 23:31:30 +0000 (UTC)
Message-ID: <eb722871-649f-4284-a3c0-3db9f2423baf@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:31:28 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 19/34] lsm: add/tweak function header comment
 blocks in lsm_init.c
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-55-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-55-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Add function header comments for lsm_static_call_init() and
> early_security_init(), tweak the existing comment block for
> security_add_hooks().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 25fe0c89e884..75e97f6b530c 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -312,6 +312,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
>  	}
>  }
>  
> +/**
> + * lsm_static_call_init - Initialize a LSM's static calls
> + * @hl: LSM hook list
> + */
>  static void __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall = hl->scalls;
> @@ -332,12 +336,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>  }
>  
>  /**
> - * security_add_hooks - Add a modules hooks to the hook lists.
> - * @hooks: the hooks to add
> - * @count: the number of hooks to add
> - * @lsmid: the identification information for the security module
> + * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
> + * @hooks: LSM hooks to add
> + * @count: number of hooks to add
> + * @lsmid: identification information for the LSM
>   *
> - * Each LSM has to register its hooks with the infrastructure.
> + * Each LSM has to register its hooks with the LSM framework.
>   */
>  void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  			       const struct lsm_id *lsmid)
> @@ -350,6 +354,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	}
>  }
>  
> +/**
> + * early_security_init - Initialize the early LSMs
> + */
>  int __init early_security_init(void)
>  {
>  	struct lsm_info *lsm;
