Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B42E84B
	for <selinux@vger.kernel.org>; Thu,  8 Feb 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362333; cv=none; b=cqgeJ7Lzd41fbAqiGkcrIrVHZOfEU50dDgMCsbAQbwxdjlhxaCuDS0iQUoWv1Cxmdgu7XhXpx3ZsKTnFoqtGNoiNXMghm5/i//5AKyEbf7ZY3fkrDCYSvMGgJINKIDvP/YHrUxpjZfF+FuID6MBRxHOSt/vR8duMIjoBE3dsQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362333; c=relaxed/simple;
	bh=n5j/L9F3xsLbPBidtZMB2/YNVqrzOk80Gc5qUvKHdQw=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=pcyLN70GIJvJoDefJey5d5e32/CefX2Kzh8YVyeUIwmQWVS4tMdAw/XTgAYdJSsoupi8o1Z7Z7S6pM+2tHrXHN70PeW4GzVzGuRpUe/3+Pco81P8uabQLwK+YRpGeyPPD5YKBBNC1O+ygqKkERbG5//Dn5phzWYasJBvwOqVe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G4FgSFGV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G4FgSFGV"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso6161656d6.3
        for <selinux@vger.kernel.org>; Wed, 07 Feb 2024 19:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362324; x=1707967124; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rcHUqsXaENVjK0x9Kw/C2PfR/Swu4qnpY7geLqe+uoc=;
        b=G4FgSFGVZmIc6SO9YWK/8uXYgXbJOlCFxTprFtcjlvOlPkSoFPa4scJilJVUS3pFh3
         Bw5iQAaOaR8n5s78tBazVqIWhaeebTFZyqe0AYH/MDgIdm6tw6xNDW146bLMcd3wxKb9
         Zz94xAsYQn5npP9rJPhWQHCHijhY6TFt+nPaprDIOPUPYpOqvEpm6nQGL81BKVDtncMW
         43iK5O1ULq7ruIsLFOBs/zWuM16YFX3TTBUMKqQ//qalBCbd2JhhyppSG4V/WW44DQ7+
         qBRGD0HfqrWvP2FyakhCDpDWU5EwK9i6Hf9V8XfFJNBGPITnyvmX8EcCKg1MoBRwnMkW
         mXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362324; x=1707967124;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcHUqsXaENVjK0x9Kw/C2PfR/Swu4qnpY7geLqe+uoc=;
        b=Uc303N0nNGUcJqT/I8w9aYsndy50fY2Cbv7WSu1BhKEVy9XS3bCcGcrFgZUr+/7XI5
         12emfLHWTTeHJx/oJnUUFAOO51F0oI/9CPL3PGP8HJtkslpyuxo98tARl3ET07ZWlWJy
         rPwaNDZvr+3XupjpGR33ch7y9zSG7KwHjvorOu3Wz83wcRz/HcXZBls9X+yP92Lulgzr
         4+nNUIR9a4DSt0e2zF2iNnkp8maSUtf1YuPrYfc5w1OoXZc77BSN4TXE6o9WFrWfjwK+
         6P7J6SeYZgy0qj4c44g0wQwRwnOtdrQSnx/onN/Nb7WdecN3YG8WzR2FF/Yt+33G/m14
         nJJw==
X-Gm-Message-State: AOJu0YyN9Z6LEzgPx8vknxxsjrsB0Mt/BXrqtbvTArYrbTVg+7mBQCDr
	dC82FyTtPTU+rb5IOvfBhcKGQs4dlIdPtCP5b76Qf/SbXrXlGT4dbVQDi9WeB6ID/O7GmidkWWM
	Grg==
X-Google-Smtp-Source: AGHT+IHmrpceQz4//yVCXSgZJnRRTPXpz6wOmv93S0O+EJbZ/KpP0Q3z9VIOPdz5QK4KdMHMW87MqA==
X-Received: by 2002:a05:6214:21ae:b0:685:9a9f:9f77 with SMTP id t14-20020a05621421ae00b006859a9f9f77mr8987915qvc.9.1707362324383;
        Wed, 07 Feb 2024 19:18:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqjYBo/MyKjkgstIVWEHrqpEZEiTd+sDJJnqJv2C4SN6mbIe9hmC7p66b2AZnONMFjk5eUc/ly4+gcIcfUufuRPamU0iXmj3MX7yhDVQI1ZjGbjwjq9dDzRggRkDi5W6y9ALTTDMshObpOmmE7JJL+p85H02iMG04sh+XwK845ThXKDJTHZrJDydonQzk6czmNX/6/ANbpu/O4VhYwkcKjxeWF50SKkt/oldUROAyycLc5lZeOUOaw8AC+gLGmwIq4eDCcXglLe4FinmKFvZY+o4vSi1LVvNEUnPwLfLX9SI6aMEC5HhyZA39aQ7TPKlL5C0iY5ikKqQjLurb5WPrKbTLDz2Bt2JfVjA3KebwT1VvBZyS9KRr3jo/0HBVApYkan22zoAEeZmeGGILxAuxYvQXkvWlCmR4nEXRos9yaNTSN8BCxElwUYEFNJBCkmt678mCG6RwqoBmntFWqJ1oUNt59OeoKd3o7vqYwGUBwDedPjKG1g7ial9VvOWmv3Q1BLDBxvgBozneJUI5a/XVU4nSHmmj0Q4oGquTOMYr+Wcb9J0wQq57809wJ+9cWiyT+Mfdr04aQ+JDEsSWsOzmEBGwcBaFk+iS9u3NKYrUO/QYY+J7D+xK+mql2sSH+JSH9KnbDzpekdF+WAnAXmFXyI9Wt3V2Cix2mryk4SSkwOz53jLvYLJdndFq/md/50GBAGUa19Y0uHeRzJUPqd3hTGCsVSv6x/6HkSHw4ox7Ph/94ZbwKVeKtAumDuhqLvq3bc4ORKKiWGwi5EYtHezLmCgbemdbe9hrFqb7TjLo6Pd5R//nrb+4BOYxiQV9idei1BQkMvFiDHRNyGCnG1rjLVGAhEGj0sDFLc9jdO7fD1dMdG7ePN7NGQye3beH69Zd+T9Q1IfItcvZ7zeaex8Uyk+nuTjs/jDX0RdqSXu7fVU19P9nKD9WX9/7+5KoIIbCb1f
 pLig1umNpQ4os=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s9-20020a05621412c900b0068cb28c09besm1194497qvv.40.2024.02.07.19.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:43 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:43 -0500
Message-ID: <e08cab0b7c121ed110efa3c799f7e9fa@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
References: <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-13-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> file_post_open hook. Also, export security_file_post_open() for NFS.
> 
> Based on policy, IMA calculates the digest of the file content and
> extends the TPM with the digest, verifies the file's integrity based on
> the digest, and/or includes the file digest in the audit log.
> 
> LSMs could similarly take action depending on the file content and the
> access mask requested with open().
> 
> The new hook returns a value and can cause the open to be aborted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/namei.c                    |  2 ++
>  fs/nfsd/vfs.c                 |  6 ++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  5 files changed, 32 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
