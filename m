Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113273D34BC
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111000; cv=none; b=eaL4K9HMpYqf6SGcpZe6bfPyYHJL5Q5GH8UL7w1pNXAk27u7q5l5+FxRJ4SAeN1/htYV1NCD/hknaYZfBCmz6PdwdOnXIBxhILgD1QWki0p1xFoOjXKQM3S+J56Ru3RTdA0LN9p49aGFF2dpElJpDIKyXv7BGD5sqpCWAPPGyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111000; c=relaxed/simple;
	bh=VrhtxDHUUeFu0o5VmnJwmZF5v65oeWz1aqO85RgV8C8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=eza3/T+MFIwE+4oFnG/KkKLBDCVXGUWmWEY5DtVLFhXjs/lbSfIpwvcMKExKQ0dCq9nxAElHUPsvm1pj3UvG4RFv7l/HroqZ+/HfeMgDkYp0aowYce2cQD/bXFiS3UB7y+cXYDefkQgi+yi60R8VSia2Uy8R47uLufgPjhzjZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ae/wsCkH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ae/wsCkH"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8e0a768331cso159893685a.0
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778110996; x=1778715796; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoTC/lw/OUWxpldadyRFLcKS56uCYY4dboDv240sPdE=;
        b=Ae/wsCkHlYO6nkFDB3q14KPZmWcAxXsIkn8tlmGWziI86zH6j/g93jptOfTZFWCdmY
         6XWGBXWOt/fSYF4FrfHj7qYLsyIfxmHpGPL4/iaikWWqd+noPoLuuDeCwTpJKcJ1TVsh
         U+0UATOgx6IOFrEyoxXJ2SggOBm+GTBIIk3cH2sG5DciySfgyGRNdDPRWkGjw/WqJKXk
         C7bbF+ecKPDfBgYKV2Eib72s2IwXoCJ/T++Lls+LYWCx9f8FgYkrTEVgSxGif/jbCKZ0
         G9EsQL4eFVPbJ3VKrGsNzqRNGgzZgpPj1fzMPLk9tM74TdihhYpwhJ1rmEIosadG49Lg
         KpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110996; x=1778715796;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoTC/lw/OUWxpldadyRFLcKS56uCYY4dboDv240sPdE=;
        b=bWHYHm562YbTCdGnys8AkMoDl9fJuh/UuHeK1SOoHhgyzvUNXscRnqjyrr5jDQWfzB
         nEtGuc9+7WXtlXVFDOc1IpkEi+2S+l+mQZe6cb+o0cMx1+UpsTbLbSRVmzdQz7LY5vM6
         2MtqM8SvZVjEFlheAgwGAp4biDuvTViJOwIGsu2MJiL3geKVeu39W+IqTPPnvBdUHqHG
         Va7Q5aVHVdTc7QC/dT4ez2H0/lX4Z8/cAkiyaxxgCGhoDV6V2YSHxk4Edl+cpbnQSCoT
         dEiVARGdxCZn9g1pJmxfEbqYgQPdWPXf+mAKrxwKAe6gMYOPYDCR0SZUuBBsmf23SdUH
         WqMw==
X-Forwarded-Encrypted: i=1; AFNElJ9fHBhhsCcOVUnnTvCsL/O7iuvQQR5QjnM0OoyFwSwnBqTOUj2S+DgdVvpU64gAYLDq93Tpx6PK@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtgRVqSxFMwLdy7U5+vYndrGRqPXE95MhYhFF1Wmm0kqmo2uj
	ONllL8TdVJ7PRmwP76DcHAoP9i+7l6sK6eYdAXIepXwbYS/qaig7wJX/sbGE8nwGog==
X-Gm-Gg: AeBDieuCrsIQj75+XvT8Gn4rxHbX5TJsTETPFk92i0/Xy0uWQ2OvMZGPlHRiI9SGbMj
	nOTrQroKulACkdoxg9h1f/HXYkBjg3q2GgISihsfTh5PWNL5PXaWsl1xzBNTPZSnGHrtjREvpKH
	1SyjOdqI+MeIh9/6wetS+3XWIkQK7CwV08u6ZJTXL31aZpig0E2Te1ygIA7vjR4Tl85Wo5zvC+a
	lsR7AAztZel8PmrnjsIMdJoFvYksK6kOK7LJvDyG1/9C5bFuwY5aZJJLgSKx03Yhzd9RjJUcdw7
	Gx+F11zce3adGO6X2Rz0apotA/UHzLx/dhTBC8OYnjX28aakdgqzc91B1qH0PFZ6i2/AhBxIszb
	stBAVP3aItUgKGkXeitbzsFU1tP2fdwVVOejblX1YpvG6TOy48zLwIzV8dL7GSBFW//6m4s+2Fs
	KNXfQyH2yI71bqIcZMojnUs1kjcpjzeB54fTAPUf+cHGfIff5DLfVmSkwXqRzCdO0QQJXTeuIOB
	4zEEqswKV3itZ8vUw==
X-Received: by 2002:a05:620a:45a6:b0:8d6:6db0:88de with SMTP id af79cd13be357-90653728e7emr91239285a.44.1778110995685;
        Wed, 06 May 2026 16:43:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c1dc62csm211275276d6.23.2026.05.06.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:43:14 -0700 (PDT)
Date: Wed, 06 May 2026 19:43:14 -0400
Message-ID: <ba12d905fe53bfee14017bc3353144af@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260506_1600/pstg-lib:20260506_1556/pstg-pwork:20260506_1600
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v3 10/14] selinux: validate symbols
References: <20250511173055.406906-10-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-10-cgoettsche@seltendoof.de>

On May 11, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Some symbol tables need to be validated after indexing, since during
> indexing their referenced entries might not yet have been indexed.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 94 ++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)

...

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f8d6e993ce89..4559c8918134 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -765,6 +843,16 @@ static int policydb_index(struct policydb *p)
>  		if (rc)
>  			goto out;
>  	}
> +
> +	for (i = 0; i < SYM_NUM; i++) {
> +		if (!validate_f[i])
> +			continue;
> +
> +		rc = hashtab_map(&p->symtab[i].table, validate_f[i], p);
> +		if (rc)
> +			goto out;
> +	}

Is there a reason why we need a second loop to do the validation?  Can we
simply do the validation in the indexing loop above this?

  for (i = 0; i < SYM_NUM; i++) {
    p->table[i] = kvcalloc(...);

    hashtab_map(p->table, index_f[i]);

    if (validate_f[i])
      hashtab_map(p->table, validate_f[i]);
  }

--
paul-moore.com
