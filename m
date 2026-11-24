Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540897;
	b=VsIGh5YiVPRwpEpiTxmThp8O9ge04Nu5hQWiDoXKjp60tTKCl22t5OmnbdqBRADpstFB
	 uHlG/HIlyu6XuukcA7xZviWGbaQstWBJwJhL4Gllbg7pfvFktPB0h9jKgZuAnlyi+9LkJ
	 uPoifkIp+LU5f/GGGG8b27ELK+o4X6yBIB7NyjdKKMrb8TiMt1i9fdxInFKzYioiugc/w
	 HEtmwNsY0s5yoGJ+QXANUKdIVZOJep8eLaUHrxFnew6p3RTXzRJhBdNgK9LCh9RR/ihnm
	 hwlq/Z+9rvmNwZGgfhcK0Tw3BORQFKsl6IiBtSOFAlrPIqM9mgPspebzKwEajr22Ikg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540897;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YP8u5TeLbitFt8szdsaebCPupsEyekLOvCPf5lODgZI=;
	b=abZYxYI24bqthYBWAMtHbmGUz+RXwG4CBuOa4XE9O8pLEUX3iJoJoZtIZNBaylVVGLwH
	 +wCWIemhLnQvlsdgs0zHlQcNNfrlnmUWbOJNACF89NW+VLA3/hLHv+3jmbfmidLhTFPpr
	 8mUOZasMiNaDZNNExKV13mMXib6vI0IiZEV/EsaXDKeHL6ll1BUknsJkTtanzHQXk8BWx
	 8iAS17K13qTJsTGsLhqnuoNMWiTujxt8q4UALSGWhv1YhIiQdCud//YsmJliVImD3Cog+
	 fQ1g3WrO/Glq4I5qjT2xURntpnc/YKLLFdPuJcNJbiBZMzngQ+YL0ZxN83Sj5O/qG2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Te9XzgjQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F671606A31E;
	Tue, 24 Nov 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Te9XzgjQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E0A1F000D0;
	Tue, 24 Nov 2026 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540897;
	bh=YP8u5TeLbitFt8szdsaebCPupsEyekLOvCPf5lODgZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Te9XzgjQF20LAhVOKUrKZ0T97dw4eE8O0lOceQn00c43z107MXK1qi8ttmJxtyJJj
	 eBlgqu83DW9xMB9g3Ted+1bH4/kCmBhinqpxFAvDUfn7M1vOtcoyhCrYYuYuOr6dz/
	 CgdyGJyqa9iCm2URjyQta03vuzF4gFmpCBbUBmJFijyphX1/DUXYR9gkcDqRsAcS2k
	 kZOPMADzNd8JBh0YGcy+S4ARulFwiOmoaOS0wN3+fFZEFMySVZHfQhf8ZHXxUB539h
	 F1oZqcpObo+PvqGCWjszZkf/PvnNsOCNK/gnr4CMEziIiRf8exOsXsN32VgnzsolTj
	 7gtYE7WnpUeLQ==
Message-ID: <sashiko-outbox-231695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 00/11] mm: continue vma_flags_t conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
References: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 17:21:36 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 11-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-late-2026-=
vma-flags-v2-0-bf3fade93064@kernel.org
