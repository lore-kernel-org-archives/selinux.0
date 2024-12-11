Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F71C3F27
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947069; cv=none; b=TOJGRLEVTBLEf7vtMQc1zIebIX83AmjSigkSJRdKCMl0q5ebYlVjg1bCI1LM/nyaUSsJet3m+UmGfYvQ4CrDAljYCoV/a15nqUCgcPZOHiipNwrOHWQ0poFqZ89DZEKsudRDZy16RC2fuii8oaI/9AiNzLurgMXGdbBDa64G1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947069; c=relaxed/simple;
	bh=lZj3bD4Z/pQaDgBdcSdzNCiak3YKcyASpq+2ZOVMTMk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=he1EFe5R+sRxWMKzjABwTzLHS/63BqsW3lwnZYWUn+qJa5WZjY5m8/Xh0Ev//n+tK7hex/B4bLukwFB1Qk6NP4gALFPuVxq1K4jAOALwAX8mnNCDSSW692n8gjwuLkhVUszLtOXzHH2uH4d8pAKL5/3xEVBX3YOJe5LhxCuP/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PSSsoBVJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PSSsoBVJ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so57247076d6.2
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733947066; x=1734551866; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTaez587g5IVeczOdimPFhZ223GwIl+VkkzD+NSihqU=;
        b=PSSsoBVJyCGFZGWaltC9lvuHiJclynRGWC+r5NdYdiRwxS4Z7wKI5xPSgcFJYgqtTe
         yLltHKmiSA634LrhXtfSKOxd8AR+L4bdRtYuTG14+FD+uY0J+tHEpSFSxUGDkG08T4XF
         ybbA91USziPFvtsDiwhsAU8cQRj4ffMO7sNzYksCoqjaIfBUd2tiMWe4YchnmZ8FuYnc
         MF1rt5c8mlM317+Bu+4pjENQUzSpMsZyCYXKEHqeHoxwZ0Z3CeQkKBuH95i0izcPsyxd
         Fg5G0sbbezyTzN+idxo7l0PB5G0UCmtUhVRXFeOWR/27vsFJQOabsIc/b86i1oXKjjbu
         VISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947066; x=1734551866;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTaez587g5IVeczOdimPFhZ223GwIl+VkkzD+NSihqU=;
        b=c4Bx70Q+cQ/9IBxJaqfwbrRnQ0exT9bN8CpKFNOHih0WMle5PKGjAPrqoooLqzmTX0
         rvxbn1wSdKLmKvwsaspoo+fR1LOwJCA2SoPD+FH8y8r3beRRTD8Btl0QJYO3mdH46Z2+
         /6Gtzm5iyTWrMpLliXw/kQrEUixCiQY3zVljcPoDEyTAxwghYd8aje8Oo7O+P4Szuius
         qkM+aCYOjR9lB7B6XOofkKEL5QP/r1/IYHv30SqATmNMwCkBoa17UjxHGQsjxEFD7/z6
         VRBV18v1xnbhe4ZXelGC8uWiY0mCFfT6rxWFucviObQCwHaWzxogqducVxdISW2QU7PY
         Fkdg==
X-Forwarded-Encrypted: i=1; AJvYcCUkCnorA90a38wNBQeR/zpEpKMBmhBRYJ1i57He4nBUrOVVFnYSKzylX6xSxnv155wK/lckGxI0@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoEDD4/LAb5QsI95fG8DhLQzMOPgTcrca5jI5oAKdPakEExGC
	lkUmX4lFP5OeYPoeRsRYp2Nto/BKeYcBPJzDRJn0e/PXMBX98XqIumyxdh/MJA==
X-Gm-Gg: ASbGncvplQRScZvwlEoAEIXn1oGUXSmXi/7XaUWiz8VIw0RK3nZo8HjjnMF4cmsptTf
	yLJApQkGq9lqCjT2QzwwNv8JK8t8Qj3W3Q95aw1mV3q2AZqWUMM68mxGOr89urFCBikCnQ/70kq
	DfMgX8r5LEl3hBNgSAn0kyalrmGEAACo04Z6FAiPrWgrqpGRYFPCP3a2xx2WzpyTqEt582khRZ0
	rbTTxVNF6LhlnxRiOUxYNH2V9PWZybrO+wf4fB8kJ+3xqg2
X-Google-Smtp-Source: AGHT+IGBOUap8cv3SEb0cypjAet3rJA8zgKWZ7ah8T+B7ys5R1NUDfZ5hNnakEae+5HKZG4CIe3Nog==
X-Received: by 2002:a05:6214:d81:b0:6d8:8a9a:8d9c with SMTP id 6a1803df08f44-6dae39338ebmr9975466d6.27.1733947066586;
        Wed, 11 Dec 2024 11:57:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6c4bbb8absm472910285a.58.2024.12.11.11.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:57:46 -0800 (PST)
Date: Wed, 11 Dec 2024 14:57:45 -0500
Message-ID: <e24e5b0c4ea0c0ed3547d6bc4f34f4fa@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241211_1304/pstg-lib:20241211_1304/pstg-pwork:20241211_1304
From: Paul Moore <paul@paul-moore.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: <mic@digikod.net>, <selinux@vger.kernel.org>, <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>, <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH RFC] selinux: Fix SCTP error inconsistency in  selinux_socket_bind()
References: <20241112145203.2053193-1-ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241112145203.2053193-1-ivanov.mikhail1@huawei-partners.com>

On Nov 12, 2024 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com> wrote:
> 
> Check sk->sk_protocol instead of security class to recognize SCTP socket.
> SCTP socket is initialized with SECCLASS_SOCKET class if policy does not
> support EXTSOCKCLASS capability. In this case bind(2) hook wrongfully
> return EAFNOSUPPORT instead of EINVAL.
> 
> The inconsistency was detected with help of Landlock tests:
> https://lore.kernel.org/all/b58680ca-81b2-7222-7287-0ac7f4227c3c@huawei-partners.com/
> 
> Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()")
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me, merged into selinux/dev, thanks!

--
paul-moore.com
