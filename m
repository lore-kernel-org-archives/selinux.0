Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF053175B
	for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DzhwS3mJ"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb945f88b4so259910b6e.3
        for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 15:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703286260; x=1703891060; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQytfSjCmL3EQHZjhyJrGAoLpqUvAj/xRD63z8Te0x4=;
        b=DzhwS3mJFE0wruNd99tswL5H1nSLJ2OmAUgiwGhrfKalYD/zvlMM+hnm6AAVCBq3JT
         s1098hxYyXJ3g0asrPXKABlCO79P6Q6coscM6N+6RSfRUj1E71jbB2lOCDJApPxGqQsf
         JO+T00rTysKB9lHr7TByFzXhMuyzHNvfWrafmZeuehPJvMjBIiIuSMQ2opqnX3PtDvQB
         NMrbvpP7UwzgxAfsxSSc1mziYKQdsd1JPrs6yKCJRhPh0cRNGtN1qaGtx+F5mA9FS+7B
         IbA95MBJOYFYJerJBgfQPBtSIe8qjTtaJGwXBnNCO2Sakp6NPI6Yq6+tKxIlEHzuo4Ls
         sGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703286260; x=1703891060;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQytfSjCmL3EQHZjhyJrGAoLpqUvAj/xRD63z8Te0x4=;
        b=uKJa/xeOp92ZQ5nYhWsL+qCvNzLrnwyZCFE/WhT4he3M69754U5cydQGxioT4i8h3d
         QOyR7iOt5UN/1CSmVae7DgxlITHw+u//DQ3Xoc2HhYK51ZQOkZqoAzFxNxcVH+slwr4y
         Pcuiv7rajfRRFrzTdHDz2O/v1JsJkbzc+xIuNaRsU2sEeuLqBV0EAN47bAnzhlhDBxOG
         Z3J2QT+9VCjioySbJIOKDvWhq8XIS5/nlNEPgni4bCHtRn3f1xLthpvNK+HoBXNPiGn2
         ecIT3GK7LRXGvDYjP0GQWzgepXAGkv12sP8OSk2z/cfXUNpad9Nwhue1d02Ueu3m4e9k
         9ubg==
X-Gm-Message-State: AOJu0YzgU//NAFp6QrZ3bbRFNH2CX4AgNUCrRW+I1gLUMcD8IK+J/SIC
	ffHVnicSEMx2nsSeGmeHEF8bwxmAKqjSV7Mr7NsW5BOjwQ==
X-Google-Smtp-Source: AGHT+IG9KybRqNTm+eVd82YDtGPMkpId/C1TP2kd4+AYS8J7XZZ3/yixaoAGt+nfJPiQyiu6ALe+HQ==
X-Received: by 2002:a05:6359:5d29:b0:172:de4f:f5b4 with SMTP id ps41-20020a0563595d2900b00172de4ff5b4mr1667182rwb.22.1703286260333;
        Fri, 22 Dec 2023 15:04:20 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bt7-20020ad455c7000000b0067aa31371ddsm1676727qvb.80.2023.12.22.15.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:04:19 -0800 (PST)
Date: Fri, 22 Dec 2023 18:04:19 -0500
Message-ID: <b9b52e039a4e2a85e29a1107c5b337e4@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add Ondrej Mosnacek as a SELinux reviewer
References: <20231220165244.126550-2-paul@paul-moore.com>
In-Reply-To: <20231220165244.126550-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

On Dec 20, 2023 Paul Moore <paul@paul-moore.com> wrote:
> 
> Add Ondrej as a trusted SELinux reviewer.  Ondrej has a long history
> of providing quality SELinux kernel patches and we're lucky to have
> him as an official SELinux reviewer.
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/dev, thanks!

--
paul-moore.com
