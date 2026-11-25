Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611931;
	b=LkaeRSrKK/1urwTOzz4xVsOOwGyA7AwPT4+JwXg1E8yz9cR/0DwTzBJTfVNmCluYtW1P
	 p/0v5vYrierCr/2udF6hs1lXd9ZYNSty6QgJeer7UMS9qqI2Dt07RnvN0x0zyjewjq0fB
	 KkAsKZiMC3mYCbBuYCWXY8iY66doOVEANTmazl0LClF1sh1/Ogy99XawGxYuWPD1gi/kg
	 qiorLTBzr099WiJSFs9QHZHyts253X4HIEhAcql8OfvYLqmXfUB/SqSu/QjTgyLYk5xT9
	 EYjLvyS2SxRZpqkEziNUSgEYS6tOEThpQTbpS7VETgdg0+H2BzD7o37JFSV7F2MhEWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611931;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EV9Qw4kJbToqsC3BI2e9QXVVVw7xTBo0QCTBy4lyGc0=;
	b=jgmEJgnao9zSQBeyblqUD5dj+MoWqPlsJKPdRhttpxsICqrOmHEEh2BLvZBqBog2jA8a
	 +V0DR3VY0DeCZLoQs5bAFQk2UJtQvoVI3YL9OaS/rt2Bdv9tzPF5uN+8/n1wP9yXFYM4S
	 L/GYwc5UhEIssLLz6eK2tx434cZXmpH0s5jk+cR8EbzNZnhiAG1DEgXNENzlUBEf1bYXd
	 xCeWfZ5Yv/XoSA0Wm9CzBabeXHMum75ttm5VQ27eJJJe4kpWIjaUrBDaMwAqKtqZJu4mi
	 Ms1OG2c8a871s98PjctlaemRHbXb/HPzLJNBGHxTEqv4F/B0JtmXuaw57N9LrPA9IZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnJXl0CV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2349606A331;
	Wed, 25 Nov 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnJXl0CV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DCE1F000CF;
	Wed, 25 Nov 2026 13:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795611930;
	bh=EV9Qw4kJbToqsC3BI2e9QXVVVw7xTBo0QCTBy4lyGc0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DnJXl0CVV/0U02UEI3Nh09jlveQkBtheFz3b60NQ83BoxRRzfHTBmD7HDiL1ZDATX
	 BquEgTY22H0GXqc3oCRKd7iYlfpvpIqD6Dc49vG29m2lZpq5JhXlywjumyWWNTUVsP
	 R26IvRlV75WzAFI9NexaHAgvyq3S76EYzPHt+HYo4WGwWri5PQG7RWmf02as15p4x8
	 PgKrXyWp0Gibsxyb317VaWI2RJdJ0Pjcv4UkX4E8Zjej+obyK8p9nDXZg8I3BpY7uE
	 9HtxLB0A9TpmtcqxPOFqOHWBdJRgJKED0bt0/vaV47E2Lk1LssLuSnO5cgpW4g9J1U
	 Q4aWHWL6crnyw==
Message-ID: <sashiko-outbox-233450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 0/7] memcg: dma-buf cgroup accounting and charge
 transfer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:05:29 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 7-patch series:

- Patches 1 and 3-6: no issues found.
- Patch 2 ("dma-heap: charge dma-buf memory via explicit memcg"): 1
  potential issue (1 Low)
- Patch 7 ("selftests/dmabuf-heaps: Add dma-buf memcg accounting..."): 9
  potential issues (5 Medium, 4 Low)

Detailed reviews have been sent as separate replies to patches 2 and 7.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_2023012=
3_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com
