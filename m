Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366414B966
	for <selinux@vger.kernel.org>; Wed,  3 Jul 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048409; cv=none; b=ZdpHJVJvsQLq1QXyf5RP0LnCVnLZrA2K4534vvnvIoSmk8iEA5KG5qDp9/Sa2YUTS3gXfT+MCJgoHXBVUH9fDcDEoBHoW5ptILIwnxt9a2MWtaXZx9+kTDc4tcdIDbQEh+nTNybFbyuIRnjuSZWHIIKkpq9l76Ay1nwBzqm6Pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048409; c=relaxed/simple;
	bh=wqV81PnFB3AgHqspkksCEQ5R6k9XNw8dflrW6IItyIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Zy+0Fcs08djNeOfiCKxl+baMYl4+K5vQb2PlsOpkFs8Awv/69GYeElX2ORsZ5AB2fC21MLixkAzN0aNErZN2O6atcPdzGZ+NHeJIe1GDbFvKZUqWXoAIwcpGZEsYL4eox9BXZry4b5hyCRiu+cPTO96zwCl9lO5PQBXQYFfe7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WkL18H9n; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WkL18H9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720048407; bh=4g2RXVynGgK2I2oATjWGxyXvNbEDD3VYktOHkX+Jw6k=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=WkL18H9ny/Dybt9Dmfdi5bXRy7jA0teJkCwkH3XFsGADgkG1Xw9vO0B6ch11eTvqetWXBoRYxRsJdTg1Fq4WEqI8n1xwC+/aU4eWvKD7SAC6Do4laKoEW+AdGXbywUXET3kGTLqL3ju1gaAURsPgvSHK/D0KgCfCHAo/AQUg5amckLNSbY/D3siNaQZL6bS8+BUQfeSKJEAh1em5fIi/XKXKRDrpprwfRrF0KkcmOzhAin4BGH1f77NlO+OF+j4yEFmK2upfFgroS4s+gWFivAXr2p/orPaWCbQGH7SN5xq96T4HaL6lUzbDCsy5Z7EBNqda7j21r0YUmJ7mGsrjMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720048407; bh=eJ8iE4jZOSRW+RAIgsejxN0G2DZS0xrn/wGAP1wErjb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mZU2zh0mExAAXjDC0SPJthjjFd0y2xfunnACbmpV4eGNDrF87FcGzDZ3u6RGLCMeEvR3nBRU0T/gm0SF9eag92NxEQZ4jJuYrohtrHxNCOjhSnObDlnhZjysKCRH74SWavPx6l8SOTJHFq8sG03CX7eu3kB7VdVH/YqhmzsRqEugzVKoE27I5CTho9md96G+lqGi0BSJrlcRKCOrMNvXo+OPAywD6y6IyYHW+WUcVQGVR/B/PSKQBVQavn4/PAS8u//KMJf/y3EpQ3dE55MtKt9lY6p3rJeofue+Z9k6++CVgvT+rIW/8ZLrl2cwwq68SvUoS4nfwsG0s8QKZ8eUoQ==
X-YMail-OSG: 3rWLRtQVM1l_nCEuFjOWhuGmE9lXdTo4r8.ZpowdTMmaI1BDdt_2NaLvmtJ0yGU
 ok7VAIL4ZGCQbLknLEB08wsRYu9VnJSYerjH4fFvy9Jh6tRMaSrb8RcKwnTcGg8nyvEvXoKsDaK2
 ePG6.f29JAY7LXyTlDSug1YdLb.R4KSj7sCm2hrOOF0oBhxC75UQFRmstmjoYOAz5iA9oublosAF
 4WiiY2iGLdmYzablHyOYRXJetE9WFTcZJ.JZYq4yxpq.NRRNbcdIafGx2Kh8tAouLzkq9nkff_IW
 IX9WDMfByrUQeDmnm7_CYFNaFZN3OnI1DtwPhWpMYuQCD9Y9HJ9ELVuY4KfqQQfF9kBRUzFh8tVB
 QBkmFGr9kKi5C1PaORdr.2mHwxVHWDAIFaSkz3mE38ZPjIIkl4g4J8A6it1bfnhskLnGTMbqmIih
 PmZVJTUx7Zkq3.SfBKNfcUHCOlTavFyOhEotEkPU5Mxnq52eG2bjc4ADrUwjMtH4Ngf0CHHoVG7v
 UFS.Cz6KkOKCNGDQQ4zmd_7NK0AOE4J_gHL8zhOe37HwgZTT8ePO0k3i6Lm487gYphhKOg3bL_JE
 _fZpiCO3FZyY0JYJNNp9JOxRBX333Lt3KXz5l_2n8zOGSY2AQRpB1DiGh9dVhXLHuO6qHIJTFTq7
 .B_xfKNdlntHq5Rw_x8OFWT0EmiMa1Ihyj.oGjzqbWWMT5LDknvKuLDjhdE2PY8xAHUDtPdkfvSJ
 cBf9nBPn2nKirx0Gfys8gmhyIzAwaLtgEFxXB7aAuKwhkm3D04ownTux4KtAxtJZZfQuQuyZKM3l
 EKPjYhg3ZiRlOzQUbkgHh3fGNn0bb451q4aaTP385vXW5ugNJlD7RCFQWoFS91UYaGei1eoV5frM
 5sa5b6Kx9R3hDt1jOnYbg6VNFWDeBu6xXh_2StthgXHSQdUgAICZV9EzCf9_pLFBnYZRMixiZP1Z
 1LMLzgCGDseUdmHj.MZPi2FidpgZM.jVYXQrS_NRf9Vjrrgz_FpUtEWM8OP6maz7h0uy6cXUQPj4
 PZJZQRv4_0bn3nmHP5lzQ1cm_h_G0r84O3rAA89TIhsO_lOyBMVVvEoRBJphg2yIc55Yn3YX4V_c
 NTQmubyCQUycvdZs0LF67KwdwNNakCwL4Sa9lXnU6A3xnFKEYSjhcBFnpQcrI7TLTAaIrfo24LDu
 qH3aAPyqi52WOcNsoAlpzP1krijhxjF4UACrffgR.YgJTLRzTjAAZrpJCNTPvoBnZptzbdvCGLiN
 l60AHvgQ42xJ0FQ75ljv3_k7gUMsuVRR7CdSdAnhW2OhQBjyIWoJ6FAOKSR1FuF3EudHDalToP7h
 eejjynwOrbSsf1XADf.tWJmg0nDOnxquEgFhskbSg3zjRFAV0knyfIVQcGdI6rN.P0FF89XJO6p.
 cNBXSTaISZphRxiTNQCjutjZlFd6MsguEQHYlzR04894oiadsz3EcFs1p6Upnhb5CZZleYP9nkVe
 4ErqzYfeNpLt6zbSqzjrzK4slJ0YcMjMiPBTlKUrG9lVtuvxzrz3yeU5tQ0epAy6yRUPEE4NlK7w
 nl45qe9Rz5DavUeitONmg1aiMYfNSTT6LJEPQB_iXfFFDrKH3YOWUj6Er0LnvUxZ2S16UQxBv.m9
 aGqGyK9xB3uY_A0tMk_oHHbTzWCZk0DN62_bRY9qUNPxJNr9aUnRor5DiOqrQiW1h9MHoXqkwJBL
 BuHRTg7S64KuQu9zL7Fmzo1RFHaIk4DgoH_k_r1KMRFbsFFZWZpHNNf.nwh_C1yYgXvq71xHon5l
 jMgvmKQf6g._laVnjCNyQzZ2.7QybRkZQ6jsWPefY36jwjfmqmDfAqSfW0EAfMhbKNl5urkQ1eUd
 HwBU0vKfkvDbmuCk8hrFeM_AmDXMxjnwxorv3dVxkZKQh0iEfjOnD21tSo9AflROgvbWOjY1Tsw5
 TwUVkll0.Vx6CGWzDZ26O8rrghvbd_xoYzQZmQ9I.ikP__asMvu8OZAJczdtdapjnl6l_ex85vnR
 XiurHD1xHcbk6yCEPVGZLlP06kTXbzjXA1OtSL7UWCGiYpFAz8skIVPVwzRvkf0k4LouiwD.7egT
 cW_.Y5subcPSe7azWxgCvfYzGDgD.wUFSLT1CFrZYlC.HdROl8ssPP5qxftMLiFcwdKEpywe6wld
 UBVJTqHqQI.siDdoLDbV3beCJMtiRW5cwUGiN2OcHtU0HR4lCbBEM0nxGgENk.jd7fEhztQmxhY8
 S7bqtYksS1TiKRMAnprnpPEEDyL0hpE74zw4fhf3hFlmTgpust65ky9Q0EuOKKk0E4FXfmGgqgM9
 wZeNc4FEn
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f7409f2e-0b0d-4613-bb98-fbdf1495c991
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jul 2024 23:13:27 +0000
Received: by hermes--production-gq1-5b4c49485c-vr5s6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fedbd83421b092a8c8bea15985592551;
          Wed, 03 Jul 2024 23:13:25 +0000 (UTC)
Message-ID: <9335721c-db66-43a4-8fc1-078d94550a0a@schaufler-ca.com>
Date: Wed, 3 Jul 2024 16:13:22 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux,smack: remove the capability checks in the
 removexattr hooks
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
References: <20240703211134.349950-2-paul@paul-moore.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240703211134.349950-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/3/2024 2:11 PM, Paul Moore wrote:
> Commit 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> moved the responsibility of doing the inode xattr capability checking
> out of the individual LSMs and into the LSM framework itself.
> Unfortunately, while the original commit added the capability checks
> to both the setxattr and removexattr code in the LSM framework, it
> only removed the setxattr capability checks from the individual LSMs,
> leaving duplicated removexattr capability checks in both the SELinux
> and Smack code.
>
> This patch removes the duplicated code from SELinux and Smack.
>
> Fixes: 61df7b828204 ("lsm: fixup the inode xattr capability handling")
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/selinux/hooks.c   | 10 ++--------
>  security/smack/smack_lsm.c |  3 +--
>  2 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2daa0961b7f1..c41bf07d4b06 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3356,15 +3356,9 @@ static int selinux_inode_listxattr(struct dentry *dentry)
>  static int selinux_inode_removexattr(struct mnt_idmap *idmap,
>  				     struct dentry *dentry, const char *name)
>  {
> -	if (strcmp(name, XATTR_NAME_SELINUX)) {
> -		int rc = cap_inode_removexattr(idmap, dentry, name);
> -		if (rc)
> -			return rc;
> -
> -		/* Not an attribute we recognize, so just check the
> -		   ordinary setattr permission. */
> +	/* if not a selinux xattr, only check the ordinary setattr perm */
> +	if (strcmp(name, XATTR_NAME_SELINUX))
>  		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> -	}
>  
>  	if (!selinux_initialized())
>  		return 0;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a19a94f27766..9f8a8ffb5dde 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1461,8 +1461,7 @@ static int smack_inode_removexattr(struct mnt_idmap *idmap,
>  	    strcmp(name, XATTR_NAME_SMACKMMAP) == 0) {
>  		if (!smack_privileged(CAP_MAC_ADMIN))
>  			rc = -EPERM;
> -	} else
> -		rc = cap_inode_removexattr(idmap, dentry, name);
> +	}
>  
>  	if (rc != 0)
>  		return rc;
