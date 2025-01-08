Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8519AD93
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305211; cv=none; b=ZRgeaMkk6wb75PEvZomEIYDlLBeK8NJHl4BQcObTHV5hc+O7nYfp0y4oEtgj2BM27HwlDL65F/KF4skaTZdmZ3w7aOim25mgpkn2qD6XB5UCnZYIF5sE4NWumdpfdctaJtxO+M5BGUeCuJ9JnZfFRQ21lytnPFg0rciFonRt6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305211; c=relaxed/simple;
	bh=HU8Sp7rs/6eXrWhZ8ytCpUps6t1FpHVBVNPG68KgZeA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=sIU9yBVSStURlxzp4T0mBiR6SPcC1tD5byPcpOktUWbB/UjoiHB+BHqnxsG6ntkpFS+ffB56Bt4c5X+bimCmxWUKoOo/JXE2laZM8FbhEGSwRGFyITG/Vy75ncDrMlctQtDU4RlnBepCV03J64wwTEm354Qj2TQ9MvUoa7+AzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IaqV2wqC; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IaqV2wqC"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d92cd1e811so3758816d6.1
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305206; x=1736910006; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFffj8OyFUR0Q+SLXK1K0ik0lcMFfCXWhx7x0gzeudo=;
        b=IaqV2wqCfWT6hMXOkDEOWVfdTbeyRzQQBFc781oW7c38sTODL90Y7pIZtmZEQ0JRha
         hI8aNkVjgdwQGvk3Xnb6TaNqCR1Bj+NmTXxJfBE5lMiJMd+1VeV3HvBq7KyQyWg8f+e5
         0tzqeq1KpPKlRoyZwSmLo9ZJ9uLhoNSYQEn/3VT87pkjkSPEptp5N349UJomHjEtrZaN
         ebfVGZIpG9y9AzmC28Ny9iY3xqG0jFnFNTyCx6psO+6j0NEAyYGc0413dNCd9cQG3Mxi
         sxrhBPrTuhoyYFyyGVViH5QxYLsfOGzXOU2YxSaqDfhybk31aXkg4Am3yONo+wjEWF4C
         dgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305206; x=1736910006;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFffj8OyFUR0Q+SLXK1K0ik0lcMFfCXWhx7x0gzeudo=;
        b=KMurtMpEtxeBUMbqZV/KjOLlMxKz8jD5VN021PV+57ZmLRwRGSylfXHudT/6ioYL68
         hMhsNNLBNNZiVS7dDl3vnqo2my7at3VM3rG3XILtjU5Cw5uzC4GSqeY6/Dz1XY74lNhg
         0GBF6P2ROX3fY/AjnV5iPY5eGdJvjvlRBehCqtQMQZXmb9PJghtDjLN9V7vtAgQwV6zc
         HzZXvxcd8AsnFlQ8bYASWg9TPtW3SwIEpZPfLyILP+GRJ3qzTEykkDgoq2ESeh0YhnuK
         IWDClFy+2zlN+YZ1NLlKcBG7roaL85QgcuX70lghjxj+UH/cVNDFHtGzWsTE9Vxjm+z0
         gnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW02T1h5A3/98h67L95O5vc2FpHePhV5Us8t14ITYstWmvLaL1N3YEb6wunXbEz/cpMnKaTxuos@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zJ9OtFP0M7hp6t7mVExNMoIaEw+vAbwRFA7QdT+s0O/8I3P0
	gG2WsSb10ftGZzGjqH+2luBATgH4vjWM4IbvHG9FkkXF5ulAwTdc0DZqeUA+Ug==
X-Gm-Gg: ASbGnctPwgIlkeNn9endkYJdPnchAmGoZYq6CDLdFGkSbDGNlh2oERuIeQVFl+VCltM
	VdWn/1iEoHLjblBvdzFTW5ufxoU5uy2Z+sk5BL8MpzJhaVYLI22m3anG5MsWfNNTfQsBLmDHZhK
	mqdmEcIrxg6SWU9JCUFIboqjSts6noS+YX2MuDdZHlARCk+lyYFQRvytMCf/OW+bMCeVzpXWciZ
	OYtj7vj7Wwf1zZWhwltMZouZv3ByYj2jy1NIoVRS4WwNKknpHI=
X-Google-Smtp-Source: AGHT+IGdp03/voSTgKYILgCBQb+C3zrHmVmP/meSGBil56EB+87hk12MwVh/nz/ecoIFTIdWZ/X//A==
X-Received: by 2002:ad4:5ba6:0:b0:6d8:ab3c:5d7 with SMTP id 6a1803df08f44-6df9ae6a5ebmr23852956d6.24.1736305205990;
        Tue, 07 Jan 2025 19:00:05 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180eaaa8sm186245836d6.1.2025.01.07.19.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:05 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:04 -0500
Message-ID: <06eb43271d150c5003b00baef7350161@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250107_1610/pstg-lib:20250107_1603/pstg-pwork:20250107_1610
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH RFC v2 10/22] selinux: use u16 for security classes
References: <20241216164055.96267-10-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-10-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Security class identifiers are limited to 2^16, thus use the appropriate
> type u16 consistently.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 52 +++++++++++++++++++++++++---------
>  security/selinux/ss/policydb.h | 10 +++----
>  security/selinux/ss/services.c |  2 +-
>  3 files changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 2408c3e8ae39..eeca470cc90c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -927,7 +927,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>  	return 0;
>  }
>  
> -int policydb_class_isvalid(struct policydb *p, unsigned int class)
> +int policydb_class_isvalid(struct policydb *p, u16 class)
>  {
>  	if (!class || class > p->p_classes.nprim)
>  		return 0;
> @@ -1321,7 +1321,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
>  	char *key = NULL;
>  	struct class_datum *cladatum;
>  	__le32 buf[6];
> -	u32 i, len, len2, ncons, nel;
> +	u32 i, len, len2, ncons, nel, val;
>  	int rc;
>  
>  	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
> @@ -1334,9 +1334,14 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
>  
>  	len = le32_to_cpu(buf[0]);
>  	len2 = le32_to_cpu(buf[1]);
> -	cladatum->value = le32_to_cpu(buf[2]);
>  	nel = le32_to_cpu(buf[4]);
>  
> +	val = le32_to_cpu(buf[2]);
> +	rc = -EINVAL;
> +	if (val >= U16_MAX)
> +		goto bad;

While this is a major issue, isn't U16_MAX technically still valid?  In
other words should this be: '(val > U16_MAX)'?

> @@ -1939,7 +1948,11 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
>  
>  	stype = le32_to_cpu(buf[0]);
>  	key.ttype = le32_to_cpu(buf[1]);
> -	key.tclass = le32_to_cpu(buf[2]);
> +	val = le32_to_cpu(buf[2]);
> +	rc = -EINVAL;
> +	if (val > U16_MAX || !policydb_class_isvalid(p, val))
> +		goto out;

We should split out the class validity check into a separate patch and
keep this just as the subject states: consolidate the class type to u16.

As an aside, I'm going to do a quick review pass on the rest of the
patches in this series, but I'm not going to merge them as I keep
hitting a number of merge failures due to this patch not being applied
and I'd rather not have to fix them all up :)

--
paul-moore.com
