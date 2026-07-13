Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D71342532
	for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980932; cv=none; b=gyW3BrxOK9J6KtqZAawDk7YJGRRoaPyVyxnHTleOGgHEwG169oUJvxizangRnwD6H+KKaMM8CjA9kcUBejF8Z4DTwOCmlqArSSd153Sll5qwoQAa45Itc6Lic/tc6N2tUeradWax7V7kIwXzfPgaskUh/H9orozCBW8agSMINRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980932; c=relaxed/simple;
	bh=EDMAekzapluN8qvqLwwRmxBiWYLSDHH4j1CTBMpYI8c=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=T4P9Nhp507pzG8SvmSYSmYtnkD8bf52bM+HnZR/QzTw3DLytiVNNoNv473pob1nya2cZdTzOyOLPaJ2kEJIm/Jo1pUlSRxiFVx5MBkd+PjEKP+VupnoN2RCVrUqfAJ8BwnZFsmTOADFuAnmBwObNouYu4Tzl6/Y+3KBv9jZJ5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JZkhv30v; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JZkhv30v"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2149571dso3028761cf.3
        for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 15:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783980930; x=1784585730; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6knqno33u0gKFnShVvAy1vOVQidX1D6I4tvt9i4jmuw=;
        b=JZkhv30vhx+vGk+seNoIcsgrBx5LtWeViBMuOjT2j5C9vxlYY4imKsV2zSxNeZEq7c
         wN4L+CzCOX8RHrf/s7zsbFG48UPBv0XXej9CHF0hKl4/dExkdtF54ADrSTNvDhjwVJ7e
         FD+nP3btnYSyBbdK5tUmriuesadgiHx9nr5u5WE82b8Y9PllEAKH5SrtHln7LoeN4x4d
         i6ZnJc10oSpTYBVZhbVrJr9TAdu5qNKA4jEtissEuB+c9AsgAhQWTMh7n01XZKoh9nxH
         vcwpfqE+gAlADDOfSxQceSHQ8m8bkMTTKAfqbpfeUWSqgl9407GVUzmkcDcmzt/JU71s
         xTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980930; x=1784585730;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6knqno33u0gKFnShVvAy1vOVQidX1D6I4tvt9i4jmuw=;
        b=YL90fQ0sIIrN4B/sAl/LayLpebwzAv2N9xRDGFLM/qCL/l0UM6GxyQrFuiThG3eg9O
         OH13jb5mfW1YwxL4usCyEtBDKEE+q6PSPh9CePGvOWZLcIP/52XPTqPss2bktqEkFi4X
         +r4R4quEEl0jIuCqAUCJ0AaDO7PAjOBLPaeCsgEC9FXjXOZrmDnsruy7Mh+r8/S2813d
         lJK5pgncearkDre0CeEQ3mRmD6tMEqimHx+f7akIchj/dwVFalrvSC7Ge7rb6Yk9Ng3y
         Fl9Mt6E+5jHzN9k85d+07FqOFw3prY9TDEjn57FeGGwbwjW7pXcbA/AFmwozdD1hH8W1
         kcYA==
X-Forwarded-Encrypted: i=1; AHgh+RoAnUVfcK5IRVwcHhOAMtuxvsgcW37Hl7SCQiwzrVks1LsLuO2B4R00drJt1DPQcV38OdKuir7F@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTGx+Z9IdMqFXaI2dVWZACIyK8SUz+1P8kwIdqZGBqicfr1oA
	U/EWfTwzHpC3Mw+sD3epqICFRW2tvuTiXXOzzUcKFw826HFGEssTaEBkZeKXcQepJQ==
X-Gm-Gg: AfdE7cmG6EmLtM5lpoc5O4XtMfCiiETaIWR7Dv4EwkzDoJIkBwZKuc4vHSenY/B3Fsk
	DgcNhpD3tRtS84rvvngMHDqPV+P1Iruu7g7cZYB9sRNmTV0YzjHWc3iLBx2F0L5FMU7Fd02r/bJ
	LReXYud9oT9xRztVsELQp5sxGIjNoZwzB1HYP/dogYpUjv857DsArkiVxKt3uoPPg3qRoxngotQ
	PK5snXS0axqoXFxKJa1LIsB9hnqLkg3XHUJu85RnTZnweVZDfCYMuQYqvKtWKXDaL66J4NAprff
	wWsEt9rOxarDYMmgJ4g4MUOdAm+UgjMfgXQzkHzvd5+ARuEL3W7F961bl1bL66l5/pHdkTX0QMS
	L140iKYwGe7i1FjJfnjrK6L08QE0ZYe7aEhiGRqmcEb8e3Ouw87Davd1gs2ruJQ9qT7DCSYWV9n
	o1u8JJHuDfjCVNktFWN1EW9Qq4gGSNpkDMkZDvblT9C+Aa+D/MxfAWbe9iyw==
X-Received: by 2002:a05:622a:2d5:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-51cbf0dff29mr107693501cf.11.1783980930061;
        Mon, 13 Jul 2026 15:15:30 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50df5e2sm144312526d6.4.2026.07.13.15.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:15:29 -0700 (PDT)
Date: Mon, 13 Jul 2026 18:15:28 -0400
Message-ID: <df755e0282dab3b932d19aceab71b7d7@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260713_1552/pstg-lib:20260713_1057/pstg-pwork:20260713_1552
From: Paul Moore <paul@paul-moore.com>
To: Ian Bridges <icb@fastmail.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] selinux: replace strlcat() with seq_buf in  selinux_ima_collect_state()
References: <aj6hVjECikvYtnED@dev>
In-Reply-To: <aj6hVjECikvYtnED@dev>

On Jun 26, 2026 Ian Bridges <icb@fastmail.org> wrote:
> 
> In preparation for removing the deprecated strlcat() API[1], replace the
> strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
> seq_buf, which tracks the write position and remaining space internally.
> 
> Each field is written with seq_buf_printf() using a "=%d;" format, which
> removes the open-coded "=1;"/"=0;" constants. The seven per-append
> WARN_ON(rc >= buf_len) truncation checks are replaced by a single
> seq_buf_has_overflowed() check after the string is built.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changed in v2: replace the v1 seq_buf_puts() pairs with seq_buf_printf()
> using a "=%d;" format, which drops the open-coded "=1;"/"=0;" constants.
> 
> v1: https://lore.kernel.org/all/ajlN94VO7BYNUTAy@dev/
> 
> I didn't change the precomputation of the string size. An alternative,
> which is used by other seq_buf callers (e.g. kernel/rcu/refscale.c,
> mm/memcontrol.c), is to drop the precomputation and allocate an oversized
> fixed buffer, relying on the seq_buf overflow check as a backstop. I'm
> happy to rework the patch to adopt that alternative.

Another option would be to split out the length calculation and only do
it once at boot, e.g. call a selinux_ima_calculate_len() function from
selinux_init(), and then reuse that length in
selinux_ima_collect_state().

What you're doing here is no worse than what we currently have so I'm
going to go ahead and merge it into selinux/dev, but if you could split
out the length calculation I think that would be worthwhile.  Thanks!

>  security/selinux/ima.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)

--
paul-moore.com
