Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342501;
	b=Bcdht2LlhRUzzMbf2TjJhL6ToK+BJn0ogcfatBBgFOk/RgiibKR11gWIkemonJKAg5jQ
	 AA0ct0Jwmvkmg8utQhDA4AEGNUNVlzj575t4DewQkw4kHvqBQgwALO52to2UaFHYso5AH
	 ryKcYeXov07ECyhRzun3TPYWOCHjRGCMf7OYPVaiiV+ATgP5tAfpx0yEk/ZfeQfryAQNL
	 i78Q4bmGgs3lrH5NPJhEBIiLAcoqcTp+80JMZQNA+RuCw+lQeewTFvwOAlgy/LOckAPgn
	 DozkF4E3aNJF5dFT8asERqfCNoxJETWZn/dOVK0f9hINjVIN37BsoQz4C3iGd+S5yKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342501;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=18Upaku51TXF7f7RVBOgnNL6ZM9H8UnRIpYKn77kd8I=;
	b=06W4j1r/IzD180e5EYAtB5S/EcGc1Hd8lYp3UDyZFod3Zx9e/kH3xVeIMQ/QbFPRWdlZ
	 jEQujZFbHK38J8+U2kE5dc4hYNlPFHswN1sMsNZIgH2D9WpHlCXX42MWabbu3HN2IiHC8
	 VH4myJtKhd3yV3wk+Aiw0fmZuSK+SwWeC+aY6ZTS5Fm/V5lQLCV2UXtg8rcmFeXGNOPtS
	 rwRSIkS7Gn/fsV/hcwVC8uuQTGS4EgJBpcI1OlSpC2DUdreqBxjUEa0FdJt3XEm3ZLNtK
	 jWeK76VO9xYVtE+tHtEMQKTG/Uc9o0qQfrAkIf4zvUcT8p2FqfO+kgHom1Al6DNXoSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=aaKjNMAc;
	arc=none smtp.remote-ip=84.16.66.170
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65C606A882
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 20:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D65C606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=aaKjNMAc
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJBT1gXtzKxK;
	Tue, 10 Nov 2026 21:28:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342496;
	bh=18Upaku51TXF7f7RVBOgnNL6ZM9H8UnRIpYKn77kd8I=;
	h=From:To:Cc:Subject:Date:From;
	b=aaKjNMAcjUMpcK3Mi2cc1oWepPvafda5NnJXtg4O67fC0qezloWSeXBCwTQo0WHod
	 VC2xEceHUnvqQ15niSn2lfLoGJkZ5OVFgGqdite6eSyhFX/IBQERJ5Q7Ds/Au3mHUw
	 YBSMt3oTb34+vZdnzm8povctJdtPpHh8Mch1uiJU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJBR50kBztWR;
	Tue, 10 Nov 2026 21:28:15 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 0/2] Fix LSM mediation of PR_SET_SECUREBITS
Date: Tue, 10 Nov 2026 21:28:05 +0100
Message-ID: <20261110202811.2409395-1-mic@digikod.net>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This is series 2 of 3:

  1. fix Landlock mediation of commoncap's capability checks;
* 2. fix PR_SET_SECUREBITS mediation and add focused Landlock tests;
  3. fix Landlock mediation of capabilities guarding LSM policies.

This series applies on top of series 1:
https://patch.msgid.link/20261110202436.2408244-1-mic@digikod.net

Since per-process securebits were introduced, PR_SET_SECUREBITS checks
CAP_SETPCAP with cap_capable() instead of ns_capable(), so LSMs
restricting capabilities through the capable hook (SELinux, AppArmor,
Landlock and BPF LSM programs) cannot deny it.  A task with CAP_SETPCAP
can therefore change privileged securebits, and thus how its
capabilities evolve across UID changes and execve(), without the
expected denial or audit record.

Patch 1 uses ns_capable(), as PR_CAPBSET_DROP already does, for the
changes that require CAP_SETPCAP; changes limited to the unprivileged
securebits still do not check a capability.  It applies cleanly to the
6.18 and 7.2 stable branches; older ones need a simpler adapted
backport.  Patch 2 adds a Landlock audit test that fails without patch
1.  It shares cap_test.c with series 1, which is the only reason for the
ordering.

Serge and Paul, a review of the commoncap fix and an Acked-by for taking
both patches through the Landlock tree would be welcome.

John, Stephen, KP and Matt, please check the AppArmor, SELinux and BPF
LSM implications of exposing this CAP_SETPCAP check to the capable hook.

Regards,

Mickaël Salaün (2):
  capabilities: Check PR_SET_SECUREBITS with ns_capable()
  selftests/landlock: Test PR_SET_SECUREBITS mediation

 security/commoncap.c                        | 42 ++++++-------
 tools/testing/selftests/landlock/cap_test.c | 69 +++++++++++++++++++++
 2 files changed, 89 insertions(+), 22 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
prerequisite-patch-id: 365071039dd2be439f67707944d12edbe1422d60
prerequisite-patch-id: 021705fb5147cdc8edcac9dbe53c06b854cf976a
prerequisite-patch-id: 1dfd782b28feeac47423e702764778031b850d6c
prerequisite-patch-id: 0bf745b08b99168d266461ef5b0b943a2b71eceb
prerequisite-patch-id: 542fe806b611c7cc8e2ded656b62731d25dcba9b
prerequisite-patch-id: 39d6ce2bdfc170b545eb2d275ab781e15c9e887a
-- 
2.56.0

