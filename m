Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562142;
	b=XvcMODQc+HQNdzA2uZ7BV+KFjA3cPi1OHRJxzDxOqWYV9hdM6cK4Q9A9wfK6w3YFqL7V
	 a4qjkXL9pqDouujMruLVJWdTusVEaAug55dQizl6n8yYjrUQlaAGPmfBDd3Ww56lGtzsN
	 YAOjq0/Xj4ls5o9XI5WMV+sqz2fssVNl88IM5Rlysr+9vhCIQFGFXPf0t2o5Ym4Z1D0nq
	 ddQXzHC8SOGWkGmeWwvl6NiSSGG7//1pNKAwktYh79mUN9PsJwJkivFa0j1eBL881VD0w
	 v7NdrrGH/J+bBz1cxsHV6lL4QAG6TzbWLoupmwwyyti1vkPbnAA5dtbBxQmG+mZfgDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oIZT7tB41b9AWvmwg33GqQUqplzuehVeKcWpy9kup2o=;
	b=5XZfyxhfUn8Fz/dtjOmYBHaHAXAiGr7v/FTJbAAmLp055065r0WIBaHOg4pNBRP+1FM4
	 2QOddRFwApnDichWIRo8MPK1h30eA7A0ZO7psPECjkUTNi5owXVXGEhx3hrvChWRyown0
	 lMQwQxX65qIWeBCM0oeSwFkvW43t1gv6ikSycmX5h7nw9+N72ke0dalhZyIagwW4yr0OO
	 MSsUVFQ2xFXShDYprWT0DyMGKIKdx/5FifrjY3eb3VjxGGUT2XY7G0BszZQmLtE6yMvkP
	 ffJHb82Wchz4pM8Ix107tbhq4WeUGb1t9oAnWaeXZUa7cmItRN6gtCLek5H81OUYQJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1b8NVrQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54141606A31E;
	Tue, 24 Nov 2026 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1b8NVrQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB131F000C6;
	Tue, 24 Nov 2026 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795562141;
	bh=oIZT7tB41b9AWvmwg33GqQUqplzuehVeKcWpy9kup2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1b8NVrQ7kmPRhltnFO+AREKKN/yg/mNdHKfmnZwY9Z4Ohp4+fvwTMYEf23G6N9T1
	 lXns+2L87pHvlNmP2cUhzABpjxKQXCHMRhLRVqKpZ2MmJqxcwY6xyGUgFJSL3XM/IV
	 gD/PWdZCkIDjG8zXFyFlXc9xip8//b3wPWTeHHKYQw8pkbP8m4gvcP1NQLGSpepx7v
	 jqS90nszQ8M3g5fQKnqMOOhMGFIC3tZlPbHggb4ZJCH4/LdltT/Nej1srj3kZ4SaMi
	 hwVKyVkmwiuwVSFgd5vTp/am94VINlJYjZCKyL5e/2Q9+EWxnIJoQ7jTZarkobMqMB
	 FiF5DCLjBrJsQ==
Message-ID: <sashiko-outbox-232216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 00/19] exec: move sleeping work out of
 exec_update_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-perf-users@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 23:15:41 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 19-patch series:

- Patches 1-16, 18, and 19: no issues found.
- Patch 17 ("proc: look up map_files vma without exec_update_lock..."):
  1 potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 17.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-work-exec-=
update_lock-v1-0-e489035395b8@kernel.org
