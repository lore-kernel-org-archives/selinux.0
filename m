Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA34239E94
	for <selinux@vger.kernel.org>; Fri,  9 May 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815013; cv=none; b=PUQ1UFd+lvHaBb1lz3ThZgUMfp5spPo5BMglFgIyWx6CB+eoVRY05PT2X8fjwtSrT0GQ6cN+UGObYUWTmR2xniDuww0pcnSX2K67kBinQbcpfpK/6EMwyRLOwKggtv1ArVSDS7ENpmbYR3V8N06qRQO5GsEHYOn3vvNfD5tyjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815013; c=relaxed/simple;
	bh=27QszuN/uHw7LYDCSP3ulUqy4wDRgv7+6ejhxAaBzjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0TaZd6bsxfBzqbwmKk2dXy724Dh2TyaqqID6qfWXZpZ3FYrpEWnr8o9N8Y/wvtJUlXox5ogLC1vE2qDt/b+vGmo917rouchf25d8CO7wkFZQMZHgS6xlfJhLuy1RWtApWczzd2vBPlNfQcADfgl1ZWsMqmNLFzMiUkkXFGt6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwfdT17T; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwfdT17T"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30820167b47so2174320a91.0
        for <selinux@vger.kernel.org>; Fri, 09 May 2025 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746815010; x=1747419810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27QszuN/uHw7LYDCSP3ulUqy4wDRgv7+6ejhxAaBzjM=;
        b=OwfdT17TTWdoB48zhtHXWidetvHSPcv2vkXvrhGPMAPygjLCgzrGDihqHTopYTv9e5
         TkTCdDM15ROOipVvP2PEZfz+MchRYAlRGJd8rHQbpd8RdG0jkHXwUKsVC6vU4G8Av+j8
         pZ846f/wRw+voHNLo+fGJDU/LWpk97kCZlZRz3pT4M/RQ/Mie2vNOHQakS3oY5wXoG8m
         90Dr8R0rSEs7uWNVuKaZHRJL05hQchZ23VwYimX+iV3GSrkhv+ynbT5jF30Hf8+hrpL8
         4BdzDE3Y9ccf+Z1IWu1gQCbib5dfAhTMxCFj/9vcAspg9qp9u1SMNG88n974N++AY9NH
         fh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746815010; x=1747419810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27QszuN/uHw7LYDCSP3ulUqy4wDRgv7+6ejhxAaBzjM=;
        b=JyMfGenpCGpyeGyFf5qTwCM9hGHtUBWSjGMuiKq0HQv4Yhz4AXsm5RfpvNYlyBBaL6
         BgBUZVIol2CmdghZn7ic8XxbGZltUrfnwnDmQjxGrRDOMRe5e7IEUXigTUW1Y+GySaB1
         9OA2993I2Dc7cXDCcg8WeFVw+F68FCSDHwmAnTg3Azu53/z3H9a/oEjvmMNK3pq3J+pF
         dUymplrIE8vhNseYLYc0u1vx1MqgK0I0chIEYE1KmZn3CeRBNZ2XS66l0QERJ+IvxQOI
         3YfkFsiha333V8rOH49/ilQJ8FE1Y+gGdFRUKa7QFtcTxqvhN/I0Gaq2GNyJG6+5HKiV
         3BiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+LEJ97p54UYaDhcU+GOh06vDdXdU3IJgj0qAkaJTEzv6gfurO/ap8N4iLmXRr//FnbPkefVKW@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+lxSfKgzcN02Dh7FERxpBWAneDt9aV+0p1nPjpLrKeFoqCdx
	OQXK2qVSd6xYL92vrWaOsdJ/DM/U1QOJvAvRdfFrm07dBsO+icK8acR6zpphDM6+3Vscq7WnzBx
	7Z811YqdWNPg95fhPff1moUXXKbY=
X-Gm-Gg: ASbGncsSoHzqywvPDyM0kRC9LENjZtp+3ZSBvMGNh8NLQgqmTFgRSI+1Ak+Qxl76KWM
	HfnnlANHRSB+Gg0SYnJJYGhjTQAU+LUbEj8QYY55JPHVcb9F/7JcUK0Crc3gCIpwkDkCmnbM0TQ
	dqz2pRo7TkFTtwSC5Fd4mcZKV5YiW/f8kM
X-Google-Smtp-Source: AGHT+IH1m8uSkunT7ePfvR8SzyH+X4zL9cR741uSpLA3fNgOPN7h8PXyknr570+EePKFAkPhxGrG7ej6C2M9+i2b/ls=
X-Received: by 2002:a17:90b:3f86:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-30adbf1150cmr12406675a91.6.1746815010327; Fri, 09 May 2025
 11:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
In-Reply-To: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 9 May 2025 14:23:19 -0400
X-Gm-Features: ATxdqUE9qwdSPUd09eCrGSRojgeofu9ytOsc-H69Relk1UVrs7kfKKW3BcOfMOA
Message-ID: <CAEjxPJ7KWhJEkWB7s+kLyT+-yXE9vyNzYgfGUS_i1jF7FzujOQ@mail.gmail.com>
Subject: Re: [RFC] selinux: Keep genfscon prefix match semantics in userspace
 for wildcard
To: Takaya Saeki <takayas@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Inseob Kim <inseob@google.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Junichi Uekawa <uekawa@chromium.org>, Tatsuyuki Ishi <ishitatsuyuki@google.com>, 
	James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:50=E2=80=AFPM Takaya Saeki <takayas@chromium.org>=
 wrote:
>
> Hello Stephen, Paul, and all libselinux maintainers.
>
> I'd like to ask your opinions about an idea to keep the semantics of genf=
s in
> the userspace, before sending a patch to expose the new genfs_seclabel_wi=
ldcard
> kernel capability to libselinux users in polcaps.h as
> POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.
>
> As a background, we introduced the genfs wildcard feature to the kernel s=
elinux
> in https://lore.kernel.org/selinux/20250318083139.1515253-1-takayas@chrom=
ium.org/
> (Thank you for your help and reviews!)
> That enabled libselinux to use wildcards in genfs rules. There we changed=
 the
> semantics of genfs with the capability enabled in the kernel space from p=
refix
> match to exact match with wildcards for kernel implementation simplicity.
>
> I'm wondering whether we can keep the user-facing semantics of (genfscon =
...)
> statements in CIL files in the following way.
>
> When secilc compiles a (genfscon ...) statement to the kernel binary form=
at, it
> adds a following `*` to the compiled kernel genfscon statement if the inp=
ut has
> (policycap genfs_seclabel_wildcard). If the input doesn't have one, secil=
c does
> not add any following `*`. That keeps the behavior of (genfscon ...) in C=
IL
> from the user perspective with and without the new wildcard capability. T=
his is
> similar to what our first kernel patch did, but done in the userspace by =
secilc
> this time. So, the (genfscon ...) keeps the backward compatibility of pre=
fix
> match for libselinux users, while keeping the kernel implementation simpl=
e.
> That would allow users to keep existing rules without modification.
>
> I'd like to hear your opinions.

(added James to cc for the secilc question)

I'm assuming you mean libsepol rather than libselinux. I could be
wrong, but I believe that in general policy capabilities are only
declared once in the policy and typically in the base module, and
those settings are then applied globally to all policy modules. While
you can put one in a non-base module, it still has a global effect on
the final policy. Putting a policycap statement into every CIL module
that wants this behavior would possibly trigger an error (not sure
how/if libsepol/secilc handles duplicate policycap statements) and
regardless would enable it for the entire policy.
