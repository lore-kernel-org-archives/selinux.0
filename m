Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961902BEC39
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848095; cv=none; b=nxdNtbgG48GnuZV/FUX+K0Y2G0PE6IcKcrwIlIFeg4XJjS+AI0T2D5Hh0+1DGaPx717Ney4sKESDrXjh+9/xICMCPzigosEFv6y0chzU3PdyJbSL190/nTVgmDFFXVTMa5f8vaGE5QcCIUZJwFNyX6MBZ94YVF7+nroGKIiK/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848095; c=relaxed/simple;
	bh=zZ/dkROIv61VX7T3lUfkGB+7lotqUFJ+9BFI8lP50Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2PFA1ch4N73IMb7RIZLXrofmuR6NFNo8HYcuedxVOPwQPBl+lwcvGilIQ4aHDX7ij4VZWYigH6P9duoPUE43xGVUXwkR3qErZwp4Y0xIKqW94LmjNBJDY/jX6mqDg4kEuBxnNs1CGWgOOtFU2RgHozX8CC92wR/JAczrISmBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=H0Uu3Qf4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gStZB7gO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="H0Uu3Qf4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gStZB7gO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5386E1D000C0;
	Wed, 25 Jun 2025 06:41:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 25 Jun 2025 06:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1750848091; x=
	1750934491; bh=M8AukqUXAj0c0fdbESEUPCRC/1cW/snATDoICE66OoI=; b=H
	0Uu3Qf4250wrmz6ECjj11z4vudiZ0nHFEZCi/o+zU/3JoYj+1vJ4sYbUrelmyDRp
	dVjhobJgBYtBXIP5eLoOFuuKYQzNWOBZSBTnjin/Y0aHyG+ZPhzi6Fo++f3OXuFZ
	AUpb91hhdHXgSPay2w3Mk9oUx7uWoGhukvBTi1FdaI1p2iIaLL6xg2brKjcvF5g8
	TvbCnHuqCYO8IQuNXzu9MApo/OR2/4O5yX/ehd4uhD8yewLmSUTHus+q3jjCdp/z
	JyKiX1uL9suirapPgg2s8l0Drvocpp3ylPQcoxKDkKu9O6rK3oZS/C4eVQqpWb6D
	D9id6YXxUKDC3S0isHsUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1750848091; x=1750934491; bh=M
	8AukqUXAj0c0fdbESEUPCRC/1cW/snATDoICE66OoI=; b=gStZB7gO/QdbvrmKf
	rkZPwrAgngsCwbyeon3albTwZ28+mKv12gil/dzn0lEfClcqU7cp5Klf/VQ/ETKz
	E8JJvosssXZWJ6lwR8FgYhnpHs+2FlAZsfs+bSZdJ9tnSe7oTHxjJQDGQz2gdpEd
	KdWsaJVROhVCzi5A9bpS82UHbLqTsL10KMtgvCewP+KMSZ636BsuK3yc2URxAX3X
	JK0vMgZe3C4JYmPRLBrS4GPO6LRnQgxUGgRDJpJrTAgPg5mrPznNZKgCxAnuqq+f
	zyC32rjkXl/UCeMAqOgsR/rol3eYPfAGaVoLl90jQWpkMExIOPsPmHJUAKKiXLpq
	aC86g==
X-ME-Sender: <xms:WtJbaDGF6l2xaHEmugGdl7sO4Mcc83_o7JPkxYU4xcwCY7wIc2uNxw>
    <xme:WtJbaAXYpj85ax9a6YiDiBVPGpFrIcTPRQLbrPIZkxJRivLRN508hNvL4p-rvaUpH
    YKb9ksD8GoZ_LhanQ>
X-ME-Received: <xmr:WtJbaFLQGnL7D20m3MddJJstoSEu0qFE3fUPjPXzJPywcUqulSkS5EI8Pn0ruYB1qMNZfccpCZAb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpedugeefte
    ehudejteeukeettdelgeduleekfeefieeggfduhefhueffudfgudeiveenucffohhmrghi
    nhepphgtrdhinhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjfigtrghrthdvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepuggsuhhrghgvnhgvrheslhhinhhugidrmhhitghr
    ohhsohhfthdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdhiohhoshhssehmgeigrd
    horhhgpdhrtghpthhtohepugifrghlshhhsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pegvphgrrhhishesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgruhhtrhgsrggthh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgushesthihtghhohdrnhhsrgdrghho
    vhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WtJbaBHLDxmTbBlIjo-tHSGNna7dbw1k-69w6Gg_POWUM1WPVvRUgw>
    <xmx:WtJbaJWAGgoVDFu0CFVDQxlLB6AfSr3zemTttwXHgvCe7WIEU9VttA>
    <xmx:WtJbaMM5EV1gHhIzbP3TPyZgacqSyUVIeJLMGoRuWt6k9p9ve53moA>
    <xmx:WtJbaI1bnOa25AJdvmdPVdqTDC6hTg5F4RH78j_5s5hMR3x_2qqBMg>
    <xmx:W9JbaCsDHsdBJ6N-WLsB9iVbVirM4neDbf1mFxGcr2JFjotAhEoy0bCn>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 06:41:30 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id DFC1DB95192; Wed, 25 Jun 2025 12:41:28 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Nicolas Iooss <nicolas.iooss@m4x.org>,
	James Carter <jwcart2@gmail.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Dan Walsh <dwalsh@redhat.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	eparis@redhat.com
Subject: [PATCH 1/2] libsemanage: add missing libaudit private library
Date: Wed, 25 Jun 2025 12:41:02 +0200
Message-ID: <20250625104103.140498-1-hi@alyssa.is>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <87bjqebpre.fsf@redhat.com>
References: <87bjqebpre.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libsemanage always uses libaudit functions, so we need to make sure
that consumers of libsemanage.a know to link against libaudit too.

Fixes: 56d9d20a ("Pull auditing into libsemanage.")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 libsemanage/src/libsemanage.pc.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
index 303f8069..8b7c55a9 100644
--- a/libsemanage/src/libsemanage.pc.in
+++ b/libsemanage/src/libsemanage.pc.in
@@ -9,5 +9,5 @@ Version: @VERSION@
 URL: https://github.com/selinuxproject/selinux/wiki/Releases
 Requires.private: libselinux libsepol
 Libs: -L${libdir} -lsemanage
-Libs.private: -lbz2
+Libs.private: -laudit -lbz2
 Cflags: -I${includedir}

base-commit: 2304becd8154eeab084a7ef31b29048c0a780e84
-- 
2.49.0

