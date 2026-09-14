Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E735676B
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418519; cv=none; b=iaEV+zLFHGLX6OHTIOUagvt2eMkKtlLSj48+y7TQ4OL7D71G0Km87n7ifo6qe4YyhmzIdAKB+UVkaiLX4fKh9TlAXtRDM/bZm58yBXk7ZzUqlc0e9xz87Wp57/EGFeRrKu1pApOwVhAL60BwDGZZRUB86R4RWzHRIRevgV7ySX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418519; c=relaxed/simple;
	bh=7lTv3k07zA7RFFF2IudlduRWQ6nXWPTkRfXfmwqrpmg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WGVIqKsuBdYAc1KA+nn0IJVEVPVbkr77RshlM1uFp3X+NO7yGgniWIfrR4rLy2EzMrfRERwd20wZgY/es/ZZ4dWJykH5SWKQLXF2gBKtyMzuQZ1A4h9fFpnecaic+TJGYKMhKhUqBB8w/4yfSaPLTkj5X8F91vaGHZoPk/i7CVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SEF5ugga; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SEF5ugga"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90e9e042ee1so43628386d6.1
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789418513; x=1790023313; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duuPvdB4qaHPpjjbBizZlT/PQ2qkQWx6bSPOOeU9NRQ=;
        b=SEF5uggay4dlMAl2tPfntHb/aTTPGNwMmCpQFP9rIrryHgaD9+ElcAjxeQeSlL0wWB
         FHwUilZr0oeZ0/3tHgRUypLNsyBQxCZqIoE3FyTrv5LigFRVsXrLoA326XyHGSXWq8+9
         bIyqu3Cv0iD0gFra2rJom0neFV65HWZtehniWcLOBV94Z5FM98Ratkge6pgUXbAvSoCF
         Y1D59GV+/EOd5G9Q6YuKZtFg3ft4mAkXeWB5bi7L8k0JQ+F4hwV1xbnBh+JWpKLg0Glj
         0Bf3GJhDJmXL+AjMo/CnNCG5Jif8SlnrCcn+fOQuoKaIZBRwpEfLbL03JljI5vey+N+L
         MM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418513; x=1790023313;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duuPvdB4qaHPpjjbBizZlT/PQ2qkQWx6bSPOOeU9NRQ=;
        b=G0ih/XlnK3FMSppN1QZdX/krA1ZnyG6qmSG4H1oM4AnO1ljQwYnMbiFzhPyou9cAe0
         hMxCZ9s3VkE3D1gyhc0cGnQphrol4ZbL349U3N4PbB8XkfUgvIO3YMUlwp2ik63oN5h5
         hr5gNrGh4x0zq4SZDzcpvyvJvuBSq/r3cxO/gFo1MEKRRdmd0MctDTcMFJubYeUjV7Pt
         z03QQwC0ofIugD8LAYk9NT/InjEULRZKab5sYqp5mDPy+cPq5cQ9FCn7FrFqO21WkjQC
         3noORwnWKHxVhCUKJMPe0M+fbGyx6aQBOzEHiI3OG4RGEWUuQwShCvGWY+fRE7JJaMIr
         7JDg==
X-Forwarded-Encrypted: i=1; AKwUvByxzV/d56NrIE58r2+PnKIC5zsi/2NVli7berG9EzEOedhw5a6mznNfUn0c38TH6dQVcCtGhfTh@vger.kernel.org
X-Gm-Message-State: AFuF++kK+ttEND5NFupWRC5XCs45X50NPEXPH/X2tq366zctAkNy9fuv
	OlLxybdgjCXwHnRFh66G0K4Yqx4O832r5Qh5PUs228pBEOnG+0LhF1bjkVqJ8x5O7A==
X-Gm-Gg: AYBFou0zd2jGTUf51+1D0dduXQTmP1ge7kjkl5coqW4awkeVed+rROvl9eP7ij14q6W
	Wgz2HIWbGBqny0KahnQdG9BWcppItA2vwoFSt/QV6c4fhLucHb0qR5YEIKh4dBzUhlRNeaF0LT5
	UidRYsFHhAzAhQgF3YyZNKR+EnXLJxJy9lLlOiTJPkmq1FnYJGZZYHq6u2dINL/5S8hB/HjxD0b
	Kjlnqdhu6DfPTp6WO+JfgOeBtY4aXvj3ho4Rk54prRUNf2CYTnUpATmmx7abDk8NBGMscwQo+2w
	fXpEA0VlhSMDKqXlhVPa7WEA7zSIhVTW1polee8NGNhYCGWqSrmmAKjZ0rQH4/eMGrXwZ3YQYiL
	P20pmAr6b6xjz1+VSmlthHnzIO++eSGIimj1jQrkNCedGAGH/iQa8i8GCNGrEY16itSugvJeVJf
	RDWo1LpiC1DP0yQUGn1p/haGkr5mtMquLEmE0slTCprFr55VOAXkkeLHrD7Lzd3jM7u5FFxZunK
	k+dJ+t809TsKiuERaRFUFLrB66fWtdFY3dO9ncXiqsAD5+cWhmiS6IipWI5cw+p5yw7Tf2LL2ar
X-Received: by 2002:a05:620a:2707:b0:939:bd4e:b2fe with SMTP id af79cd13be357-93a29a12d15mr593158585a.40.1789418513279;
        Mon, 14 Sep 2026 13:41:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ebda519bsm1046663585a.26.2026.09.14.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:41:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:41:52 -0400
Message-ID: <506803b6b6c4a74551bc5c0d6e31cf71@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260914_1619/pstg-lib:20260914_1251/pstg-pwork:20260914_1619
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Check full ioctl commands in  audit records
References: <20260910144837.381855-3-mic@digikod.net>
In-Reply-To: <20260910144837.381855-3-mic@digikod.net>

On Sep 10, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> The ioctl audit test uses FIONREAD, whose command value fits in 16 bits.
> It therefore cannot detect truncation of encoded direction and size
> bits.
> 
> Use an architecture-independent unknown command with set upper bits and
> require its complete value in the audit record.  Landlock rejects the
> command before the device handles it, and the existing ioctl enforcement
> test already exercises the same request.  The new expectation fails with
> ioctlcmd=0xfeee on an unfixed kernel and passes with ioctlcmd=0xc00ffeee
> after the shared audit field is widened.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
