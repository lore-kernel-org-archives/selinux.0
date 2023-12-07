Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PNciar8/"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC41709
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 09:46:56 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77bcbc14899so49862085a.1
        for <selinux@vger.kernel.org>; Thu, 07 Dec 2023 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701971215; x=1702576015; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J03mv+l7rX8NcoLECb3l4SQ57K+9Oed1sZK/E/K4uG0=;
        b=PNciar8/oFTaQAEga4XRQMotPgfMyk3mK7hxcoSS7GNKgF2jp5wDNFZZQlrJkRoilZ
         2B9eMUlRxgr3vOkl98YpoQwKoY3dHB2DrtEkJXOn+qVfBupw+805eS5Cq0NfRVssG0TK
         7rOEdierqLJQYtqAfzlVaf8uVbBk+XLWpJd4QD4x8m/ETlUx4pARcWUU4ihZo79Q0685
         jf0ZEdM+hi+G6gwDmlF3SVv3w/LqqNH1NV6YVxvVEMChndgxiXq0gF1m5SvoCAyvOsyp
         UhKOjbZOEpJpCXzQDL6/ZbzeTzEvhcNSEkaXRDiaKmNE+aRAEP197Kc/G33Iot5rDZuF
         rvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701971215; x=1702576015;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J03mv+l7rX8NcoLECb3l4SQ57K+9Oed1sZK/E/K4uG0=;
        b=rhfj7bBIsJ7XCRVbb7Fj6BfQ8vTwYNPJqlIAB2uOoXXz0b+b7a/VinPoKZSs6tDZY2
         skDZMv7qZQYhpDMDBv34uBUyPxqIsgbN/gBLN8Rap84mLBkjw9Q03kcTl5mtftmiDJrf
         w985YkKRGCWaJyMxUarChxncNv5rAVyx8z5qIa9Xo3S7jqXAAj4XNfcxc3IXWEm6pw0G
         w/6Aaa9DUvmSM2zXOBc6Ts8CGo9l8tvWWi7ggYN8sKiociJDwikrWY53K0WvEC/3f/y7
         OeflcWJlcegFz0MgJ1ZfgkDTQ7OZt8TN1r1lNnwZVye8Ixk/6jM7GyP67CbwmnU+eRbl
         Vk3Q==
X-Gm-Message-State: AOJu0Yy07aHlmivQQd5Wr0DsSzVqwGfu+EDzXRJpKFnOeZxLr065ro7D
	BYg/Uh/U2een9cVfT8O+M45O
X-Google-Smtp-Source: AGHT+IEIzy4DMeXKFV4xP3D+FKh13SZ1HyBHfc5MXUIxTTPGzmuMcb2576v3x6LiUk8S8iAwOO0usQ==
X-Received: by 2002:a05:620a:5589:b0:77e:fba3:8204 with SMTP id vq9-20020a05620a558900b0077efba38204mr1496156qkn.154.1701971215636;
        Thu, 07 Dec 2023 09:46:55 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id rb17-20020a05620a8d1100b0077da601f06csm71643qkn.10.2023.12.07.09.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:46:55 -0800 (PST)
Date: Thu, 07 Dec 2023 12:46:54 -0500
Message-ID: <41bdb9588162bc706786e2c341f01f07@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Munehisa Kamata <kamatam@amazon.com>
Cc: <kamatam@amazon.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v2] selinux: remove the wrong comment about multithreaded  process handling
References: <20231207013356.20327-1-kamatam@amazon.com>
In-Reply-To: <20231207013356.20327-1-kamatam@amazon.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

On Dec  6, 2023 Munehisa Kamata <kamatam@amazon.com> wrote:
> 
> Since commit d9250dea3f89 ("SELinux: add boundary support and thread
> context assignment"), SELinux has been supporting assigning per-thread
> security context under a constraint and the comment was updated
> accordingly. However, seems like commit d84f4f992cbd ("CRED: Inaugurate
> COW credentials") accidentally brought the old comment back that doesn't
> match what the code does.
> 
> Considering the ease of understanding the code, this patch just removes the
> wrong comment.
> 
> Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> ---
> 
> v1 -> v2: just remove the comment instead of bringing back the old one as suggested by Paul
> 
>  security/selinux/hooks.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into selinux/dev, thanks!

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 855589b64641..863ff67e7849 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6459,7 +6459,6 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  		if (sid == 0)
>  			goto abort_change;
>  
> -		/* Only allow single threaded processes to change context */
>  		if (!current_is_single_threaded()) {
>  			error = security_bounded_transition(tsec->sid, sid);
>  			if (error)
> -- 
> 2.40.1

--
paul-moore.com
