Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F863D4108
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009261; cv=none; b=OuI8IgTt7CB/lH3fAwUFGFyVQLiKxDw7GoOthP2k0nh8jI+WsfcsoH7ETuWLyNq6pXinh7dubK/ezKLQ8pGOsiEbNUZ3QYoAKAzi7aQIm6k/R3fIZdYiBokChFXY0aloQLWAwP0afllXnO0Kv1ZyprDUWfy0yqsbo8AXEPWts9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009261; c=relaxed/simple;
	bh=28jr/V6wbfGOoPPq5ZTwocCYNHTiMp/C9E2oITG5owQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pia3Eu5yIIykhKAWjc4CQC0HGRqpl4qFnmotf85elpGcCPmFSyE6KoFl/dyeeOnK7VvsW8JwlzH9vn09V51RftVeJyhIewO0U+q2uZ2OBLHH2N/Ow2+Phy+s1bQhH8EEi3V1NyM+GnqRhs7wc5NxzQaGJYudTkKLP+Ix71GRvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IN+L5FI/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IN+L5FI/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fbd79350dso54278541cf.3
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778009259; x=1778614059; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll7P70c/Z9X5WEojKBU6A9BwUEn7gUM7o6hv0IqjI+0=;
        b=IN+L5FI/jau2c+nyDRo8mR6y7Su3aV+fHnvnBjr4MNdnx6tgEzIj80S/PWn4LdSp3o
         jVTDsADwfgm1+PN6jBSWY++YurRhnEmb76siJtvkTQwDctiQchkkk5Hgt+5nqwjasTsI
         S2l9f5pPLAPkkQjRJ4pGk5OBZNxPm4IySQrA8Dii6uzZWCeogVFQ8WxBAhd/+Zn6jPlx
         1UWjiz1IVViN62VAGmZjaiIgWTDw392O6MIy4Ix3jCzuQ2SMBDy/PSHynzCwEg5PcLm8
         SLYvVXqGhfeEtI5mCXPKnvvLK1devciMAyKProoNA1vXT0sbs+Smvg2ulH2r3BxCU3ea
         jEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009259; x=1778614059;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll7P70c/Z9X5WEojKBU6A9BwUEn7gUM7o6hv0IqjI+0=;
        b=inpaDSMV6tl02cLO+O4nH8I2LWMwuiZ0OVAxifcX2yyCTrXhyNOoskhNfD1qMTGy7q
         jGWVxrJIJ2AN3EMIe6h2kk3GY5D6w/EdPE3vHlfjZH+tHK1Lvl4PjaXTjLN2vEJao3FR
         o/ZwYsiyjYBsfdUNQdTW75xdawAvmTETJKYCvxzbKDSN0T7IZe3ZfkGuw3psWexlsGL7
         +JwjDKvNH/wZGJ9ZpXB+ThQzpp3N4mbxLnWKXzNqyuA54ui1Quzr4O1MMNqKONz5i68c
         aLWXmJ3CDtxPtZLDuMApR286KaVBg93igtOISrfMNEl2wz4xxj4fin4+ytqLuJBvy/WX
         htHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/avOzOapvXXJ2w9WsXw+lMcEKRJZ1LaqDXXUGu+9GDMO1sUYpG2RsQoR7VTcrRKrvD6TVEtcpV@vger.kernel.org
X-Gm-Message-State: AOJu0YyTR6+FPDRTTk1SHNve5Yk0OcI7l9jRWiFvh2u0cgz+FGFJ6D8w
	1y5sDb02OQaA/7aqDW+yHcvZ6g1k8aUhIs8aiVZ97lBfqMtFR/rUchQedkkABdpVKB28vAE4QkL
	wqe0=
X-Gm-Gg: AeBDietvFDheg4hSDvA90xIVAR6dqdT8eg+eLIEs4QuG8rijxPGihIjvRNsJ/RYJONM
	tHk39lrhGI/LoAxDSsRYYtuEuIFH8L6OwWaXSw+7rHwEBeE8wFKohphBIwFKSwElQlrbV8VbeDc
	vnhTxicWU+JG8AuT6KrEl7I9BAJf+t10068u7gpTQKrlzONep3khUKAdn+PuzsU6ZgivI5Lxgtr
	oO4PJHjhBVKGJed1N2C0jw4sdzhmRg+7kXoMnyB2uGXegKiL8A0b7wfrNG5KOIgB0b9jXF5EvcY
	lm0ElP6tq2HpuRDjLgb9NmVmdNUfzBhEtnzqEMS4ubMpC+Kz0EVlSem/jnXdxU64LZhqMhM3Fa+
	iupsUfVuXY/hmENomnz8bIMO3LeUahImmtVz6DqDQgvw9EwxkqarDAsceA8XA4mF4wrfo9udcKO
	9MBRcjd5ZrKyCtGWWMw6wlVreugFU2/FrzK2KNFbmCsCJ6z0luKQyLi9Ffesw0aobeE7OHO9hLN
	3uxL68=
X-Received: by 2002:a05:622a:1181:b0:50d:74e4:56b7 with SMTP id d75a77b69052e-514619ddcfcmr6612021cf.4.1778009258779;
        Tue, 05 May 2026 12:27:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8398sm175659186d6.37.2026.05.05.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:27:38 -0700 (PDT)
Date: Tue, 05 May 2026 15:27:37 -0400
Message-ID: <affa502e2d67ef641b05949afdce4344@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260504_2038/pstg-lib:20260504_1547/pstg-pwork:20260504_2038
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/3] selinux: prune /sys/fs/selinux/checkreqprot
References: <20260505124949.2541-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20260505124949.2541-3-stephen.smalley.work@gmail.com>

On May  5, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> commit a7e4676e8e2cb ("selinux: remove the 'checkreqprot'
> functionality") removed the ability to modify the checkreqprot setting
> but left everything except the updating of the checkreqprot value
> intact. Aside from unnecessary processing, this could produce a local
> DoS from log spam and incorrectly calls selinux_ima_measure_state() on
> each write even though no state has changed. Prune it to just log an
> error message once and return count (i.e. all bytes written
> successfully) so that userspace never breaks.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 adds a pr_err_once() call as requested. Note that we do not need
> to copy current->comm when using it in pr_*() calls; this is only
> necessary when acting on another task (get_task_comm) or saving
> for later use.
> 
>  security/selinux/selinuxfs.c | 47 ++++++------------------------------
>  1 file changed, 7 insertions(+), 40 deletions(-)

Merged into selinux/stable-7.1, thanks.

--
paul-moore.com
