Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910664;
	b=qHRaNYuS//TBQV5jzoG12LZ5OkRRPwksNf+t6ekaIT11hfcBu9Sn+yYzN7JJYLrqUOFA
	 SslqyCE/GhiwFfhPfGncfoPGQaNJwAoujgqbcB4cVe0iemdS3+DRZZG29qzndqdvxq4Xx
	 wLJ3pUJobUfdSCw3QNVCGVKCgy2NjBVol+xk2S31Fq0lhxLzOWCGtA/I70F8RwCWqphql
	 h0JxPVJ1GPjlHA7OZuupEKBb7o11YvDrTk7JCPK7gDMRA8CA5z7XaGBIdln2AXDgy/tr5
	 GhmJRnaey6s/bKa0xzpeP8HKvTC0YbCjRzlcvK534J3A3LTIDJipzzv1s8RjOn2UmJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=CjEYOMn7s2iP08mjBQD8eE6pg/Zhs1AQoF4Jq89bkWI=;
	b=1N+3G2DUK0ZzYrRRWnJuYwyyxOg0bGAW8C/+iB0N1oOAwtVyJ3n0jqIJ+10j89SbbGm/
	 ZgUgyvU0LZS+fS8R4Ab7sSdj5pflcLF1w/ri03ZeuUfKz3xqvKvbd/Xew7ukvcjvLTv7Y
	 Do4KABbyVQ19aAFOrL757Gl1ofm2whBULvDEgnngXKZCHspH37TtNxiCwvOWt/56zq0XZ
	 s8g3QcDGOGxHUA4TCMfRYw/sHbDRnD6Sb+hYAToubjMtGo/CragyUM8Knhrb7Ra2pp4Eq
	 cWXfXpEncYlctEG6cFSpKEkDlMdyIpsJnvMZUhhmk4Gx61fqUTp1kdnnEXUTFaF/uVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Iic7KIp4;
	arc=none smtp.remote-ip=185.125.25.8
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C3606A31C
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 10:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Iic7KIp4
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLJh55dvz2kY;
	Tue, 17 Nov 2026 11:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910660;
	bh=CjEYOMn7s2iP08mjBQD8eE6pg/Zhs1AQoF4Jq89bkWI=;
	h=From:To:Cc:Subject:Date:From;
	b=Iic7KIp4Wr4+ClB9QUgXC0Hsr9GxBqLKiJ1bWSEDtLqt9YavaYTav3QUymLY/de8w
	 rMeOwLvKjAlKyDP1a7Jioc/knJPaBou8THSaSp5XBvi9oU3+W+uN9rItovvsr8fbEq
	 QiW1x+V1Kj/7qUTWwaCmT72ZRdpcMSqSc/6G3iYY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLJf6yVkzF7p;
	Tue, 17 Nov 2026 11:17:38 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>
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
Subject: [PATCH v2 0/2] Fix LSM mediation of PR_SET_SECUREBITS
Date: Tue, 17 Nov 2026 11:17:35 +0100
Message-ID: <20261117101738.2523492-1-mic@digikod.net>
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
https://patch.msgid.link/20261117101157.2520463-1-mic@digikod.net

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

Paul, John, Stephen, KP and Matt, please check the AppArmor, SELinux and
BPF LSM implications of exposing this CAP_SETPCAP check to the capable
hook.

Changes since v1:
https://patch.msgid.link/20261110202811.2409395-1-mic@digikod.net
- Shorten the commit message of patch 1 and check the non-change case
  separately (suggested by Serge Hallyn).
- Add Serge Hallyn's Reviewed-by.

Regards,

Mickaël Salaün (2):
  capabilities: Check PR_SET_SECUREBITS with ns_capable()
  selftests/landlock: Test PR_SET_SECUREBITS mediation

 security/commoncap.c                        | 45 +++++++-------
 tools/testing/selftests/landlock/cap_test.c | 69 +++++++++++++++++++++
 2 files changed, 92 insertions(+), 22 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
prerequisite-patch-id: 365071039dd2be439f67707944d12edbe1422d60
prerequisite-patch-id: 021705fb5147cdc8edcac9dbe53c06b854cf976a
prerequisite-patch-id: 1dfd782b28feeac47423e702764778031b850d6c
prerequisite-patch-id: 0bf745b08b99168d266461ef5b0b943a2b71eceb
prerequisite-patch-id: ad96449ac2b66342bdc171582d400276372ce386
prerequisite-patch-id: 39d6ce2bdfc170b545eb2d275ab781e15c9e887a
-- 
2.56.0

