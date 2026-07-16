Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDF23D2A4
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166125; cv=none; b=My+cIYNDyXILUU7MvyIpuCJvoVCzlpDvRA90CfOrhbkivSkSyX9YPZV5Bpaf8CUOcB2X0jOB5nU6ReEsBY/WaIR+uP/+qgdfibXlFtMWCM59pN9m8u65j4WrEW+37TBy8UAT9/+EkJ061HJEAHTaY/cvhe0lSw05G8jef/9Be2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166125; c=relaxed/simple;
	bh=Rm3zfzbiec/4wmTDpC28Dh2BIIMF1DdpynZYCJmLLXo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=FyAkuWH6vRDMVdW/WRh7tL2nFgfVF3DKpDs1zucSftsh3gUJV+5pTkX3iG6GWS4PmgEKW75EfzKccRwF8h7nSMzU8+cLP2REo3hxUc/dgU5TBLhZxzqfMuL/gk+p9CN/ZtoAafsqS2QSgAuFziUQUo01cfPXyqq55qo3Fsqkj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S5imNZSk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S5imNZSk"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ed19f4d60so6989785a.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784166121; x=1784770921; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAzFFJdbYYl7mHVxFK70YlTaNUU7tEmfvu8LFVmQ8u0=;
        b=S5imNZSkpkNGnY21UPbLWzr94ZuxD/K2yqbm5bS6xfUXiMvA6iiPt2qHcpkWcJrfAi
         GlYfgE/0BH9yhLN6KKWEdKPTm7pSiV64pjFVlIBjTTIeldqPppwOA7SDI1z+Hlw9OOYp
         CrRCPq7oY9sNq9OAN0HIDMpy46l4CwE+CWreadqjWNuvSZqF3z/GpV/VWtuFmh+zIItz
         UpxyYxnbkyHv4mvibwOOSelVXtV5IVk9qtIkcIeJSVxgvKZiNyT3JCyRVTA887DTCwIb
         AeIYUKkvfdLoeNiJShuQ6oCItR+CpWSSsJu5HwYAZl6sE3tzMJs5PnEN2ofmjOUCbAbc
         Ph3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784166121; x=1784770921;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pAzFFJdbYYl7mHVxFK70YlTaNUU7tEmfvu8LFVmQ8u0=;
        b=FBcqGmfOHqgSbjEy4cu1rsF4qknbx4gjZuIdckwLISqwUVa/xMVWgPgB+BRwN46+dq
         pzCiIlU1gY1EuB9X2G2PuP1G5e8zWBHuMHPZc+9Tz3sMGzJUj4qqXiy2G2BZNfmycDi5
         IMT2pZ3UMSqp0af22jKXELleRGBwp0NUfMDCxJxQzCBCO8c8v8QpPWc0YKcyEyzS6u5A
         Suz5tpYQPL1xw93DSECms34hAEixozFAqQrqNNawJW+nmkD7C0M6ZEiWaNuHFeI1NFq4
         1Fu8NBKdUiDi88khNZfr7o8JwxZVKg4NqtCpPNcgkvSIrEXKdKRpkjkqYGE6ngZFCvtb
         WMrA==
X-Gm-Message-State: AOJu0YysyWryQezDIdG3UdjhLl5lINZjg+Hf4jfPno3fC6EZJ8BX5tLY
	8+Q5K9A4BsclOV59YLkWE3voP7tPS+nePQd/TThWSqOCJZG6g6CvwrJonCn+IafPMA==
X-Gm-Gg: AfdE7cng9Y6Y1lQMdBNlvaygRS60CuhRKNfejz8HetOUtOaEMEzU+hpaLLJQUP7tZlb
	oaFqx0FtBOgL7Ulbpnw4A76xtxC40t8nZkfd0NJOGouV14EGLEEfhHnMsLqDjbRtCbBaaUf5eqt
	LJYp1Xnjd5KZETBP6QK79UOUh1SJX5k9pqOmcW5cbaFvvOuqpIwhpSfaAdx8QUyv/gwtvDKhDgE
	5gStpx5iF0B2gJpARYMzGEMaTqidlALTE9Eu7SYyE54Y6eRW1m5WXdmCc3kDuQDv6Bhxcp0Bya6
	Wtwy96Qw0tNurpbhN/ud7ltZkLti+6hDlaaFSKD0SX6a1LF3/pHSlog0Y+r8CskeuhlA6TOnr5i
	t0pqzTqAlh30uNOHvi0tWqAIZruxwMu0NjrPtxTXjzXiEcmGp+yCYSWVbhx7X2rTb/r7d9NqKmL
	L34aXIjscPyLxyI6Hu6Gu461Mq1ffdfZit6CxIAg4JnKrtw7M=
X-Received: by 2002:a05:620a:2546:b0:8cd:d688:7aef with SMTP id af79cd13be357-930a5eff868mr68030885a.19.1784166120795;
        Wed, 15 Jul 2026 18:42:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1796335785a.30.2026.07.15.18.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:41:59 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:41:59 -0400
Message-ID: <2e52b3433b9cac9466eab694752a7603@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260715_1900/pstg-lib:20260715_1853/pstg-pwork:20260715_1900
From: Paul Moore <paul@paul-moore.com>
To: Ian Bridges <icb@fastmail.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: compute the IMA configuration settings string  length once at boot
References: <alW2ktr8JUVlQNgU@dev>
In-Reply-To: <alW2ktr8JUVlQNgU@dev>

On Jul 14, 2026 Ian Bridges <icb@fastmail.org> wrote:
> 
> selinux_ima_collect_state() builds a string of the current SELinux
> configuration settings. The string lists each setting as a name and
> one digit. The length of the string therefore never changes, but is
> still recomputed on every call.
> 
> Add selinux_ima_config_len_init() to compute the length once during
> selinux_init(). Update selinux_ima_collect_state() to use the stored
> length.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Link: https://lore.kernel.org/r/df755e0282dab3b932d19aceab71b7d7@paul-moore.com
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> The produced string is unchanged. selinux_ima_collect_state() now
> depends on selinux_ima_config_len_init() having run. The call sits in
> selinux_init(), as suggested in the review of the seq_buf conversion.
> 
> The length computation itself moves verbatim. The strlen() + 1 on
> the string literal could become sizeof(), which counts the
> terminator. That rewrite was left out so the moved block stays
> identical to the applied code.
> 
> The patch was tested as follows.
> 
> - W=1 build of security/selinux with CONFIG_IMA=y, zero warnings.
> - A userspace differential harness compiled the old and the new
>   functions side by side, covering every combination of the settings
>   and the policy capabilities. The outputs were byte identical. The
>   stored length was an exact fit for the produced string in every
>   case, with no overflow and no slack.
> 
>  security/selinux/hooks.c       |  3 +++
>  security/selinux/ima.c         | 33 ++++++++++++++++++++++++---------
>  security/selinux/include/ima.h |  4 ++++
>  3 files changed, 31 insertions(+), 9 deletions(-)

Merged into selinux/dev, thanks for doing this.

--
paul-moore.com
