Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBB1A23BC
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305211; cv=none; b=iV3Q5uSG3Q4p4nGrg3NZyQqPiG5TWk0eAOfdkn+pe/eD+j7p8q3XJJNQfrgKaKmY0lA0ys+RyatfH7QtSQZaIATayTMKMQtWnz43anAYuR+A3BOTbnE+uNu5pfQaJUpSXoGysg+rylxX3WB5P1hQFUhOhccVJDrBHm6va5bou3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305211; c=relaxed/simple;
	bh=ZPTrpXkGX9nmBxXD0CGCvXyP0lMxseg+fJgQD8tUf4Y=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=D35iL46UUj6uK1KD7pHkUangPMEYcjUoLCuQ7njt7Q1+D+MJz8hycgrPiV171TsDUQRVmUPv46bri3rZvPrYHkqCafQmriS4aQQibV6yaGQXq1yXh7r/0VRofW6XqKgqwZG1TtAb1X7F7Fzd1myp98y6qTdCkY0mIEY1T5h/NuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QwTnhnPk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QwTnhnPk"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd5c544813so120058086d6.1
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305208; x=1736910008; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7EaVgVQac1/TEDkojCgAqe//LrBeO261JouQgHJyfE=;
        b=QwTnhnPkb3zNjR/rQZu9v/Z6JJ/xG1Ae9ryKWR6vPfu67DrEZVjoCVMOhdIU7z+wyV
         N1CnxbLRHuD1j/8ZFVKuOixcPiE1LBL2LBsoe7R3P0gFJSpC7zqU1Fc0AWDN+D3jwc64
         7f/MTPsBDvRm3eonpsSEirefuhoVWZ/VU6wVsF6bmsDwXvKmVKPHGVsgWdoVPT6JQK2/
         J0JXLuOxI7GGWBv29odUg6vip6dkGuOaBrh7N1gfBvcMeJecOcY0kGL3hvJ0GhzSEQq3
         ZUU8mktpRCXAm90hT66zvD9U1KgGbmyLncVn+s/WzX+wQkhPUMggBinsIzdMj1Jic8aR
         ACww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305208; x=1736910008;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q7EaVgVQac1/TEDkojCgAqe//LrBeO261JouQgHJyfE=;
        b=YXqMTl9remmO4pCXrZvQTnGrPl0hesvtzqeLgnt9Jte4ng9HzkZh1U8MMZb5hdmSoE
         u564t6ujz2NuLCwsOzVWdXWNfxOoDj9DPJ9UmSLkEvU6clQRaQYB3VUFxJrJbkai3jj3
         iv+2GY5W7i2kyxsvh0B1gpmhHvMwzobc2J9AWGQSSbUvqiumHdA7oSaA3TfPTqS2i7ki
         fn88b0agVBDmyZXf9fOiefQuuHR5vteQ7H0SLMTlWRlsNUcRoDdxH4sVg0OhZuAsbGHO
         PiLvzhu7LrtoOmCziwDw8YFFQNx9CqALsrSA4Z0qqb5l7a7B9Fcx7teHKr2h0KYHv3+e
         8Skw==
X-Forwarded-Encrypted: i=1; AJvYcCUPUOc/5VHo7ieud4VavxDnNuXfkExWt/3VM80PsORoff40fucrtxJ2D4I9nGFCwJwQ7Ur4A2L9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8LyCiMwwRdldGly56nVGFXkNrVjjVMnYomXyzMOh4yH1+nY6
	+DaWUQHzYH5qyaa5VBPfE3emQ9CoWMElbZYMcxMeBrJzKHmbf/frH09DcE9XIw==
X-Gm-Gg: ASbGncv7QKERYHaMitLkIUUgMnktXAB/d1Ui+ehGC72H+oMb/BppBSCwINvMiF+Tve/
	llYfxVyvaOh7mLE6vfBbzWq17ZJflKGnfV9PqxLohSXcg1bYUiJ3ax8pX/UszepwcLrEP8MM5HY
	BjO8VTUe715rEPL4pYVjb4QRkvHsNFks9tjXVvm/dhp/GRpEBllJQVaZ9dCWQI/P+2Eh7KNKaNW
	3dAAis2WqWvr88TP9uSv52mtayNjT8KCAzfpE6E1pgZVS9LvGw=
X-Google-Smtp-Source: AGHT+IEsWE9jKo66b0sH4kNpmR4E5z25J+93wZQ/0L5/G7HovezZh2H2H6IY8vxs9TWJK0T88Zw41Q==
X-Received: by 2002:a05:6214:570b:b0:6dc:d101:2bb2 with SMTP id 6a1803df08f44-6df9b0ee9b8mr25760146d6.0.1736305207948;
        Tue, 07 Jan 2025 19:00:07 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea955sm187463756d6.21.2025.01.07.19.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:07 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:07 -0500
Message-ID: <fdaab30bbed2fe6565fc78227d17cdfa@paul-moore.com>
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
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Eric Suen <ericsu@linux.microsoft.com>
Subject: Re: [PATCH RFC v2 12/22] selinux: check length fields in policies
References: <20241216164055.96267-12-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-12-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> In multiple places the binary policy announces how many items of some
> kind are to be expected next.  Before reading them the kernel already
> allocates enough memory for that announced size.  Validate that the
> remaining input size can actually fit the announced items, to avoid OOM
> issues on malformed binary policies.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c       |  4 ++++
>  security/selinux/ss/conditional.c | 14 ++++++++++++++
>  security/selinux/ss/policydb.c    | 23 +++++++++++++++++++++++
>  security/selinux/ss/policydb.h    | 13 +++++++++++++
>  4 files changed, 54 insertions(+)
> 
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 3bd949a200ef..a7bf0ceb45d4 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -550,6 +550,10 @@ int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol)
>  		goto bad;
>  	}
>  
> +	rc = oom_check(2 * sizeof(u32), nel, fp);
> +	if (rc)
> +		goto bad;
> +
>  	rc = avtab_alloc(a, nel);
>  	if (rc)
>  		goto bad;
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 35442f4ceedf..de29948efb48 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -12,6 +12,7 @@
>  
>  #include "security.h"
>  #include "conditional.h"
> +#include "policydb.h"
>  #include "services.h"
>  
>  /*
> @@ -329,6 +330,10 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
>  	if (len == 0)
>  		return 0;
>  
> +	rc = oom_check(2 * sizeof(u32), len, fp);
> +	if (rc)
> +		return rc;

Magic number, we should make it obvious why '2' is being used, if we
can't do that we should add a comment.

This comment applies several other places in this patch, I'll refrain
from mentioning all of them.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 1275fd7d9148..4bc1e225f2fe 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1174,6 +1177,10 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
>  	if (nel > 32)
>  		goto bad;
>  
> +	rc = oom_check(/*guaranteed read by perm_read()*/2 * sizeof(u32), nel, fp);
> +	if (rc)
> +		goto bad;

Please don't add a comment *inside* code like that, it makes the code
awful to read.

> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 690dc4a00cf3..828fef98e340 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -352,6 +352,19 @@ struct policy_data {
>  	struct policy_file *fp;
>  };
>  
> +static inline int oom_check(size_t bytes, size_t num, const struct policy_file *fp)
> +{
> +	size_t len;
> +
> +	if (unlikely(check_mul_overflow(bytes, num, &len)))
> +		return -EINVAL;
> +
> +	if (unlikely(len > fp->len))
> +		return -EINVAL;
> +
> +	return 0;
> +}

I'd prefer if we could use a different name than "oom_check()", perhaps
"size_check()"?

--
paul-moore.com
