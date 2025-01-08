Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1DF1A7046
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305212; cv=none; b=XuyufYU5Wu8YfWyekoWqo9Wc9cRAxk3PeV3B10dClr8EBFnxeuo1rIAuo6WA1AM32ZKXW5dAQ9Q+6UISd27exckrRfDMWk8rn5TziJAJpx2zvS23oqVRPJMQfotnt1fLa8TqDPYponlG8LohltZmmmzONqbQVQ4WnJsyjVpkGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305212; c=relaxed/simple;
	bh=0VG17PRuHlW3P5YOhYh3yyxpCMq13IluxgCP9Xm0xDs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lxRvA+eL7w8Tl4N/OCJmnFPSO0XhrF/uESeSgJEJODpW8HxB/Eo7IkmLXKTClC0NgBKyuohkcMSZ6CEnPstsCS54WsVPeshAeMf0SNdj/j56xsX9A0M7vjfBSQb99iLTiItDjci2SBCtWTSZaNiyYZAzzjA0SAZt0HcI+ihEsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SkhrdvN+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SkhrdvN+"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46788c32a69so24250891cf.2
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305209; x=1736910009; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbS3FaNV2ZChC2KdX4lKqZIM1KAT1GNHxbb4N/ECpgI=;
        b=SkhrdvN+J8JTENVLfmuIS1xDu2VFq8eMaxD7b9h0T97d6sfo5RQQzbrmYQ55oCFSXN
         +icLff8wAyT5so7oaWjos3/jAemR0dp9yR5RGwJVCi2/0F0p3ESU8ID2NBhZf8xWKTgB
         F3AbtBU4ZLAkqGBVv4l8FSJSgfSzmnTMTwwb/Cnyhf5izNQPptqsIS63nx3crSyALZT3
         +351j9AlX4dBN9MsMUq5APdtSiYgWs7KTzVjDkD/+26hV1j1Hu6T8YcBm4qPAjwkl6K9
         dsTcAd+QND4Wh2q0myZI8qfSf0Xm3MHlj6w32uo7ZVM7mbBeDmjdQqGZK/2JMzYJB4Zg
         QY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305209; x=1736910009;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bbS3FaNV2ZChC2KdX4lKqZIM1KAT1GNHxbb4N/ECpgI=;
        b=fMEjPImM3QCDuvj/PFmzTH2Rk65/P5aUB/HBzj9aCaoMcCo9TDzu7iYtVedWN2bdtM
         LGkpeV+zSSuQpnYdJhswwtJ4YbY4m+BA1yVWimL2dCYIENvoi3TTToWGVP0Nt8NUQrha
         YQkZMOLh2hcxYKI4Xq7dqT3li1lBPZOtxoHQZaZcJlVQsHZZv9CYRqExwRxxUxA88IyX
         G9Rk+slRXxVAouDKibe5t3F2C4zHYq8p6dx85qKIIGGsqxSMBESpnmsFr5Cci8GLP9Al
         gdwVYqB5xrlP+8nma939iW/16OXV5iKphMyZFz9zHAPCkWNeBEg6e99L6mKaaNLL3QNC
         HBKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXMfQ1s47PmIscyXfDisWUTkMKWDMAlfubQuhPWMm9W3/Di1YO2LTOIE1y3yEd8TcO3W3r7lsf@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwx3O8PqXgxZ3o6Dv5wCmlGsn1KSuo3Z2py2kkSl3NTHqR+74
	+9cvdkiWb0oDlCs95wotHBq1cwC31ezoskf1yZPTHO4I/dp2j+1Z9gT8pGHQnQ==
X-Gm-Gg: ASbGncsDtthI4IDVTwREKabwz9TnhUIoBj0pqzf43jQjaNZGQYSM69uVzb4oJKwffAy
	Lj9zURmv16qSipFEY/CiII1aNxFJiQu5WdZ6t6mXtjZfornm7Rjo8zTkAZCYCnT6Fx46OCzNMLq
	kRk/RKhoq6liT8tyGphO0AqLSiPZ/DYNur6qa9WscHU6/hMKGJhB8toPR/IcZ36+SIbz/J84xAd
	1zqHYLK9Gj68da1X7ifHS8/BlxhrNV8XGL39wd6lNboWu77kFo=
X-Google-Smtp-Source: AGHT+IGlvlEtC2oSxSG/w2tS74y+OnJ6UIskVvDabz5llHEY9yRt3+4BKZSyuRVj3w8/8HU/CBRy6w==
X-Received: by 2002:a05:6214:20ce:b0:6dd:d24:3072 with SMTP id 6a1803df08f44-6df9b1f453fmr22476186d6.3.1736305209150;
        Tue, 07 Jan 2025 19:00:09 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18110450sm187110216d6.44.2025.01.07.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:08 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:08 -0500
Message-ID: <00d497cd0162f3033c8c7aa57daf4630@paul-moore.com>
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
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Eric Suen <ericsu@linux.microsoft.com>, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH RFC v2 15/22] selinux: introduce ebitmap_highest_set_bit()
References: <20241216164055.96267-15-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-15-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Introduce an ebitmap function to calculate the highest set bit.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/ebitmap.c | 27 +++++++++++++++++++++++++++
>  security/selinux/ss/ebitmap.h |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 43bc19e21960..5d6b5b72b3e5 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -257,6 +257,33 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
>  	return 1;
>  }
>  
> +u32 ebitmap_highest_set_bit(const struct ebitmap *e)
> +{
> +	const struct ebitmap_node *n;
> +	unsigned long unit;
> +	u32 pos = 0;
> +
> +	n = e->node;
> +	if (!n)
> +		return 0;
> +
> +	while (n->next)
> +		n = n->next;
> +
> +	for (unsigned int i = EBITMAP_UNIT_NUMS; i > 0; i--) {
> +		unit = n->maps[i - 1];
> +		if (unit == 0)
> +			continue;
> +
> +		pos = (i - 1) * EBITMAP_UNIT_SIZE;
> +		while (unit >>= 1)
> +			pos++;
> +		break;
> +	}
> +
> +	return n->startbit + pos;
> +}

Squash this patch with 16/22.  We generally don't add code that isn't
used, so squashing this with the caller in 16/22 ensures we have at
least one caller.

--
paul-moore.com
