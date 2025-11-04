Received: from sonic301-32.consmr.mail.ne1.yahoo.com (sonic301-32.consmr.mail.ne1.yahoo.com [66.163.184.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A92D7DC0
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277511; cv=none; b=cFnbAQfhbaaBFwMxe8OwLkZY7PjJLn5ViYRiN8N8N8qBzGy9H78/PWh5YyyiVBNmIWQRaXIKb5WFYl8j773X1EtMS5F6+IGISrbRVjB0x2xKYI4cA60IKith8oybi/znDTbblKtFFiD2vUD13MsdWl23cWfOWvuikVnDSYzj2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277511; c=relaxed/simple;
	bh=/db1ZbUSY4AafApDJPDAXx1CSESKs+zLeT3adZX9NKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYRiFbacF6d0rmi9bSPbwrTkGZFHb6WgUHv2xRBNfKtBrtGm4/tXYjE5u1i5nPiYym85E/vyu+nUYbGirakYSkcYB9z4doD1EIi5Jf240b+GIp7jSv8gLdAxEdL0D5anHmQTqfn7Zl0TobU+kg8YZREjMVZ5oDPBDG4RfUASCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=A54wTRwQ; arc=none smtp.client-ip=66.163.184.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A54wTRwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762277508; bh=Rn+xeU8hbSVs5DH5wqprgrTEbP3KV4qe8WcAPaw+fUY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=A54wTRwQNT9P/i09Vx/eYI59YIqe5/xTHmpRSAP6S/zRdeACVFfXeuiuDE5VckKkejPZXgVtGQ2XBLvlIhnxq4O4oWuFsB1RULbWBR2P0Bd5pAzCNQ+jAsoVLFp2QtC7K+Rw2jqTh48tyKE/SaIxV8rSXDOa9zFS0rH17TTlKgzH9mkvkPO4RBFWjSONoiYsIUZwrk8OgZdjp/P/xNSChLd9OAQTx4/I0a4Uj72gDNhLZLN0g3EGP5+gFwQPFMTL8NaeQJhfqI0QGUyAWCEJyrVgK5F5ifv15B4W+zbY9xw6EpY2g6n8ALYhS5j2y/rT3RYUxmxIjP3K5iZRK83CgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762277508; bh=I12/uRTqJs5ZamlwGbOVs4RsWGAoxNq+7q4tGzO3XC5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=huBd3sGpd859wyLX37KbDrA/rYhHtK7ixAN3gOcYsUkmQfLzzZnSM0oGSTozaJBrm5OrmYxEHWCNM79J2o5mGGkBoWlxBtYzolmFhrQDA7ZNWq71HyKelo/yzDUysAqu2wToiA4J/LlbHmkoCWwmkeDuWyWOcl49mmt9GzkPExgiDGdGi4eQJ4lYGqxiHqBO7eZBZIBeyU965QModLID5ZIxV1fJyHQWs75QCZrlEaKYierDJzXjpD++4dBZ6Tj2xH4ThgA0v/d6epeVp3rHB2U1Rh6Gj4GuyyWGBeC85CtI8kQhsRe+KqS1EkmzeSxIzofghR3U1OjFYH+12ZZtOg==
X-YMail-OSG: WWEk1dAVM1mrc8MITgpROMUWlPqLyYzxww47OeGRef77El._tDqWTaO7qoyXDo_
 z2TLYXcnZws_bI4bn9e8E_eYwxGYd5xJnTx3caVNYr_Z5U1Qk5cGbwtUzZLtBCdGrV4ERW5T6c80
 7oevHK0Wd8a9jby0gJqF601uq_o_PPMVTOaUZlLIlBJmdegVVqjgcyWC3LbYOSAYRUMIRpJFFW0f
 nFGmOK3GB7HG99FPVU0oTP5dNaVrHBSiLpKZ38LIdvXqgHpggVsJJFFdVrDL5gQ1SVnUiHbYRlYe
 ywbdXtqtpa0eB0kFVWmepvrDWx6lVKpYD8mZOXfX2VV8mhV0OJ6dVy2hBorCqhk7rTdU3hknxwVO
 _C.3k8DOlue3hWPav.xL6V1O2IrxQQdETqEl_P12I4VoiOWvWEGqmdpnXBJWKwGGI7xoeCIiCRA8
 Q.fWkCc7qJufAbSPL1M4rvi_s.6Uz46nZ4UqdNSxuH05sd183SPeAVrAUsomepTnoYeqk6LvjKQK
 Vovgm8xysC8msvpj6gfuXy3R0LxoUQuaeagcXW1h_z9.z7k_jw5rfcR7IPsQsnDILTZEqDr.CMIl
 URIULOttmZbqDiKgnmfUByS_rXrYzK7OgRLWwrbCbu06CMugGxIjmJCXCKrgpzjDfFQUqIFLVbsG
 ncrKhicsloQW3GIxtiWK.KIUdfR9qcCRnLxu5Z1qQpRs6rO6cufkTOTb.GzerxHepSFmF8eyxIt4
 nbAxKt9VuMGKJzFGg0C5q.R4j2B4hOWKkB1akqFEtzj5M5ukepZpzfAf8Eu6b9cNwGxfSVPG9Jdw
 W1OLX.cBV44NS1Am6NIob7GkyW3pEzcoBOgJ44X.ia5HbWfaokCunhPEUjSy7LRv8B2VzoaC1uCn
 BKm.fDYCStz_WqRBw1w9W__CzbXt76IASSLkakgW5eG7ySd0VUFCWqIi9xKFOWdNeXbxhGomv_MB
 Rq2Ss5UL6gyDahAN5CJXbhBAsN06rNv6cDzEO0oWwoIdrPzMvBBGBWhZbjaYXSIO22wsCHXdvMvh
 cBAvSlqCNc3mWJeRQdaJE8QW_0_7sWlGK7J_GyRo1flkeXIhdUAFokBR0WRNcRLi9eSkqF11nOhK
 mpuS69UJBoubyY4qaSiZ7zlH6RzCqyoCEE9DJo0zPVReZhdbUVllgvSZ3cI8vkPszoRsR1HKlCzB
 Yrykh30l.lIThX.ym55MSLA1R4Z.PapkZryU2EyKsvUtvGm0QunaJjYIsc_CLGErmMzrrCWuSotY
 T17TzFY3GZwmSi0EoSSen7D0hFbEdVqTUhHepNxUELsnCDebPPc.jlkubwVjm3IRUoamGF0VONxq
 bPpivTXBgR910pHUNP45fOLcEXBzR.YmA9hT3Gdpqm_qHarXzbjkK4hvFe.tMV51kJe30lS_GEmx
 e8pnqNrbkC.wtiK_C8q_hHzF6IhFYuSbGTqnvbsV7IhdtRV1_rxyMhJ7RrcF1CDbCM6gqcnFTbQx
 Fwb7b28rYoGL9WlhrsQCtkIoyfnZfX93GNNywK_lMdLUzNUI895X1ZAYK2NtE1EiWgxBYgYQHGOX
 lDaSMPkyGbCyk9z8L2wJGZjawwgWeIQm8mILiNN25nrEv1YOrQC7D5RYCvQeYy8KgPC_xDCBlYaE
 y4smWXp2ijFbRbXO.FdQb77SGBrDV9drf3EvWcjc8vsMPFHx6pimZem1pHjFTvDtKnDs5HawYYUp
 YtFK6unsI0RK7SQ8rY.fUzbdGzXUyhisukXFGi3RzoPo9MIaDJO6FTM6V_AKVCD0s1TaT0cwf0Nh
 1CcxXoeQSq_oS0.uHHI9mkUjIHjUki2pOed7OoApteKTldhRvRmzKUJ21V0l05Oxo_10kA44cdib
 CqmtR6689ji8NCRPlh1ZFAnjiNut0TpOXkZhXGZ13pWLJGlCZc4.4tmafhMFwgR2flj5xixoF.jH
 zGTTFhAdlwve_LoTwdDG.qbdNcNq8StfXIHTXzWE3HJILKU9lko0GtkemphLad2NMMKNX0sqjeMZ
 7sdw73qeGU1FRUUxUv9Xw9.A-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e1279bf6-5061-4a24-b513-66a59e481355
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Nov 2025 17:31:48 +0000
Received: by hermes--production-gq1-bd8655d9-slzsr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 558e0f080ed7f3cb59bc4b957e1742fc;
          Tue, 04 Nov 2025 17:01:23 +0000 (UTC)
Message-ID: <2809ae58-8019-4f31-a4d5-69677f85c4d6@schaufler-ca.com>
Date: Tue, 4 Nov 2025 09:01:21 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-3-casey@schaufler-ca.com>
 <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/9/2025 11:53 AM, Stephen Smalley wrote:
> On Wed, Oct 1, 2025 at 5:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Allow LSMs to request exclusive access to the netlabel facility.
>> Provide mechanism for LSMs to determine if they have access to
>> netlabel. Update the current users of netlabel, SELinux and Smack,
>> to use and respect the exclusive use of netlabel.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>> diff --git a/security/security.c b/security/security.c
>> index e59e3d403de6..9eca10844b56 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -289,6 +289,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>                 else
>>                         blob_sizes.lbs_secmark = true;
>>         }
>> +       if (needed->lbs_netlabel) {
>> +               if (blob_sizes.lbs_netlabel)
>> +                       needed->lbs_netlabel = false;
>> +               else
>> +                       blob_sizes.lbs_netlabel = true;
>> +
> Same principle here - if a LSM wants to use netlabel, it may want to
> guarantee that it truly has exclusive access to it no matter what the
> LSM order is.

Again, SELinux doesn't actually use this very often. Declaring that SELinux
always wants it to the exclusion of others would be obstructionist.

