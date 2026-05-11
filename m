Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9637DEBA
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529173; cv=none; b=hBCBwQHqK4UV5jCcGqxjGa4Sg97s78euD0KZsgDOMwLEzG/OfYyVJV79tWef1EbepnTHXppkJR6oCA3yldAUYhi+MHPSedJPCWOZTBqWJTKECVfyATae5uaj8QDHyVcwu/258cuDMOWE9I6sxHVJYaCRA2lN4Xx9OPNRsIMa29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529173; c=relaxed/simple;
	bh=0tf1vl0SQGqUQbLj6jwYNf1qsghLHDsVRNEO69K9iPw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cWpRgpkthuiJ0y1gRronBHLMKittkEgE5QvllAncgNAtGIjkJShULxQOmUi26vmuNH79jsEbvKPmKjonb2os5ChUreDl74hxZcy5jyXDvJo4MVNB5HwxVk5ftg5H5dvVqvBculM26D9ysoDwzsHEOXsUR5vqZkjcdHBVFwHwdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=biyWdz0x; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="biyWdz0x"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d67a483d3eso524264085a.1
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529171; x=1779133971; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkJDSYXLDBh3wMcKjMLlLmxdhkbb1kc+xmdwPKDFOfA=;
        b=biyWdz0xBCqjy+IfyiVgCjYv1+E6xKH7Pn/z6rpid7y6nDkJvy2rty9GGpqO5x5uzg
         kdGplr9BasU6iasMX0EGI7BSesr189NpyJN9lDwJ2GgECV0HIVHVYJqrE6g9Uws1/D+z
         q/FW8fwydK1s+IVrhG8x5DAWKLLowphUDJPER4Wq9DbAad/9ylgG70WS31OS4noz0CgQ
         cGiCdNU3rY/OAwru59eIXBZO4CEsJqAvnybTIddF01nER1QeLX1eb/Mbo8kErJt2FKZx
         k8zJX0pnmbtmYmsQrdO7mzzlU6NbaFwhmhZNMinf8K1vBkfwk2/HcatFKKNuCl41ozaL
         T6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529171; x=1779133971;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkJDSYXLDBh3wMcKjMLlLmxdhkbb1kc+xmdwPKDFOfA=;
        b=SrdvKVbqocvt+zzTzAO9PpWXogKEafg7agL7XdxYSc/47+XgFu8s6YnF0pQSTN3HUJ
         kchJ1N7uHLVJQlCgCIy7WJTE1QNpw9N3tQZ+bkIxvdrL9FdDyAh/6Zk6OuRKuLWZFL/u
         gdHagsq1rcjYg0a0wX7aS5M3Ud67HIYH/DtHk/4CrKgxrBTv1tmSFPOu8JTmk2hioQRx
         1GPKNLYSmi/xClyln0+vewSYA184ntFr+WKmf5J/7uifzhwG3/7d4K4uy+jp6KbRq9As
         coPLIwzCeKwtxb3wew2hlS76rtHjlgYFPNrdOxN+ZPvdcocCS9MCrtqf5u8PtZT/IW1H
         ZllA==
X-Forwarded-Encrypted: i=1; AFNElJ9lozeJrrVhL9vmO8rUXoi63blRFzCLRhsa+Ws0ZFxoWUns+VnOicxvO686MQ7BpcaDH1Kid5IE@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAledyOs565gTHGxzWySQ203VoCrlxszyei9q8cIYUz5u+yrW
	ip3+Rfi/29XqVz0aqDOejk0+rDBFBT4KERI4hPjSoFSx5cMVXzheLS5MfKdEwks9TQ==
X-Gm-Gg: Acq92OGBo8jjn06IL4jT/OyZrTcpn2KFHK0JeLymJ4aYFFPKFYuyxEUiIlbWKtWxpDS
	1NOIR+3kcjDqmBhzJYFxa5yfGN995QcESUWc+9HecNwbRsESGSy4e5xG6d3JNpbd2emZ9jvgMIv
	3fha1P98QdbMHlMG9zzyFO/BH4O2VDDcZtK0fDKn8raZ2+WlPc+YDFeuBrzer5Qo2C9MTkI/ADE
	GsqKZKeEf0YhdPVm1H77G/3LmMeSJEVB7Be1uexhbbw2r4oVO1AKBlEoE8xv5M/Rhl/Bzzz1ZMW
	1WcGbiTYkq/ATk/pvjoAuPw7if1qD7owFxjXuUeC6aeaVyb1Gf2rFzz8+Hb071XD2gWhDl/2ZbX
	znv7DJ+8AXNxfwgB9yceHkiOKsdvLiMm9J6Z66UafMl9PQe181GoDLRH4QRNg/ITlFJylUScNIv
	icKMVrRE3RGnQy2hGnyPAF91ydFAEs0g38MDGwGwQ/Hbdn/H9M5If8UHson4uaiA1RJGQr+TL7O
	OuAp3Ui7VOq1sv/hw==
X-Received: by 2002:a05:620a:2954:b0:8ed:d6df:c778 with SMTP id af79cd13be357-907badfc044mr2333240085a.37.1778529170980;
        Mon, 11 May 2026 12:52:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-904f810e354sm1742542385a.45.2026.05.11.12.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:47 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:46 -0400
Message-ID: <eb3d42b49940d9ecdc4ef384989d8f8d@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: mic@digikod.net, gnoack@google.com, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 5/7] landlock: Convert from sb_mount to granular mount  hooks
References: <20260509015208.3853132-6-song@kernel.org>
In-Reply-To: <20260509015208.3853132-6-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> Replace hook_sb_mount() with granular mount hooks. Landlock denies
> all mount operations for sandboxed processes regardless of flags,
> so all new hooks share a common hook_mount_deny() helper. The
> mount_move hook reuses hook_move_mount().
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/landlock/fs.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)

Mickaël, Günther, are you okay with this patch?

--
paul-moore.com
