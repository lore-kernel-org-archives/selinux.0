Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D553F413B
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791681; cv=none; b=rRsvKBhkEnwwRBxlmbz4YGfTG0lKVV2CM6c0QLk9UiwGwu3g+GAY74aYUOejuVZOcwiEzZAcA/ghl4Ww/PN02Hptnt4byNcisxcU/lCfqE3u8m23xN31x2ITHXsoPdjXJdBq2yko8EZjrsM6eyXNOb+cmrGn1UN1aDA5bkPXQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791681; c=relaxed/simple;
	bh=4y79Kl8WzXCr5Rk9Zb629M35maQPDXeKDyl7nj8DYVc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=IcUCPaWReX09jEJvABBNAnLqS4/hG0DcxQHQ6Rsi3GrJYoq4EhefpPsnzLvSn9JGDmRN/g0AXWn/HDT28E212nNkuQUxtAC1kEvQ0xQexJqM0JILpePrwXgZELgPACiYftQtQuSE1Q3wSHT4rgk3YlN/pneORoxl0m9/TvTb2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QhOYmp9n; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QhOYmp9n"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-902deb2412fso938470485a.3
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778791679; x=1779396479; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOlLQlTi3o05frdZLbYuVm1cEc621rSLbOtr/H5CI6U=;
        b=QhOYmp9nyqmC94Wp3oB3TUXOXtz1bYLmQOz6aLV7W75XW/oibX6gOdIK0E0TYmR+dm
         TGuwwt+hJGyi2qfMLU6Uk7QzIpC4OD/aes8oVwd3pccTwGxmrZFdT3rQ7Xe+/cYXVOIM
         6tqXJVsxmUWCkkH7KL/Gd2AEMme00x6F8DRuem5QtsGMt14UvI34200eavM/4mKvvLj1
         C8f6ti9pPJkUyqXB10TQPMhYmvT2NBEOO+6mLfAkwsSHPi4aiMfHQiyq4t6eIUvak1rC
         xHNCY+IDXHfrE3LpJmKI86dqhzxcTqA2h5V6hKLA+X05BtDfi9id823dE5yy9z6k6dJ8
         JmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778791679; x=1779396479;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOlLQlTi3o05frdZLbYuVm1cEc621rSLbOtr/H5CI6U=;
        b=YnAyU6LOUHgcZ5E7iSmO0xk47lFqUbRnLp2i85VZis43g6/UI4UeDLT5IblBDZmstS
         SOj84gCMYY8VyqDwsuGCYOdbYMxK0ClRvB3ZTVB0Kcz3TVPjamUqHpWTjgG87Z9KKuQ9
         HmHeTBbQkdvHzIDdEbxygV0mp3bsOSzlNkL7VJRyhhZQkI5z8ZsJZNyAYGB9yVBERoNM
         wDYypzauAF1EwP7rZo54VG4mo3RxwwwP9ZHx+isDgUZBNwrbFQiRR6cHfi/52nAFyasp
         3nhnJqa5Hoi2QSzHZgYGd0e/oJeWUidOBpw+sI9zN5Ln/ixqqv9Yt3BeCvtK3wq9ZzXG
         +NcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fummOuPkkkH/gMBkTpmuLCSyInudV+uTEK/Z/FrXNc6l9sTic9EQWoJAA/CvzVbG4BHkISQbn@vger.kernel.org
X-Gm-Message-State: AOJu0YzouQgTTyB2NTgoA6bXR3Utt8WNqOMayYzLTttACjmR4sM0iflS
	MDrGJ+xn07CBG9w72mplhud9oMJxV4eUZ8tbmfBWBtmiTyt9lTvGggtkyfLlQy8npglwzk6YwpT
	tLxjm6ZhQ
X-Gm-Gg: Acq92OH1tGtjXzMWkK4RLCdk/5c8FxPREwYYMcvVnWpKVSnROLWgN7uuZF9hhuv6mCZ
	SpNKVc7WWQWXakmHG/pWzC5d0cQBzRykzFbgYAkV5zJlSGkZw7XYemaXDCZnYx+WQ/c5DnbfYeu
	p/aeEOmidjQt6TxNST2JGEQY8iGc6IojEUT86mNCSZUqXK39n70Y018ZFu0U1ZDSqyuHA8pcOw2
	iB90L2+dTfTTWofsauCNHDc10Ze1rQI4LN03/u1C/dmVb6e9354kuWy0gSwe6uZY19LzC/wudcD
	WGzB+7yia1gBO8WSHdbRCmKxxmrcPyfOg0fRNzlNcxiHBpYMF5HQcVFmmovnhcsppu6inluzlyF
	R2dLmaEytckM3ccuaKDAPNb32L+57imDH9qCQg7CfS/oYJO6dF1JPsds8hM8yvMG8ZS292WrZJZ
	Vcku690AYxLokWZVdWpN8gI4adFwbDTB2fbsmaKe14qpcLLu7vxNpVLLEte/lw7FNpTgEH
X-Received: by 2002:a05:620a:469e:b0:90f:6153:3eaa with SMTP id af79cd13be357-911cf002797mr205705485a.51.1778791679135;
        Thu, 14 May 2026 13:47:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm339202985a.28.2026.05.14.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:47:58 -0700 (PDT)
Date: Thu, 14 May 2026 16:47:58 -0400
Message-ID: <b99c011e6d988fb98ad017265115b323@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260514_1634/pstg-lib:20260514_1359/pstg-pwork:20260514_1634
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, casey@schaufler-ca.com, serge@hallyn.com, john.johansen@canonical.com, linux-security-module@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
References: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260513180506.760657-1-stephen.smalley.work@gmail.com>

On May 13, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Just as proc_pid_attr_write() already does before calling the LSM
> hook. This only matters for SELinux and AppArmor which check
> whether the process is being ptraced and if so, whether to
> allow the transition.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/lsm_syscalls.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Thanks Stephen.  I'm going to merge this into lsm/stable-7.1 now, but
hold on to it until next week before sending it to Linus.  While I
can't see why John would have any objections to this, the extra time
should give him a chance to respond.

--
paul-moore.com
