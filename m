Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626622098
	for <selinux@vger.kernel.org>; Sat, 26 Apr 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673514; cv=none; b=Epi8YZu89dqsp2F/sgrAkXoYN3p8pdyBVGU3bdKsM7r9OKyryB3zpnfq+U2XR++hnc4yo4wGySLyFaFtEQl18j+Zl+ZFtk/TZP7Rx+3/aZ8/AuHakn1DCY+b8CZnsFnhC89MwYsTt/ec+2w4OsgZ76tEmauCIeQ23aQvvPDkdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673514; c=relaxed/simple;
	bh=0FX1Gi1GajV5/QOVOL0jQXsvN71OQ4O3Wj9yXn5JPTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQ6+5Py5lImBYH1dlRoBk1WSorU0TmmELFf8akcNT0Iis6we/7kq8NWrU2f9vAET5XFa7jDF9PQZuX37d3ppWgHGrqgWFFD01ijiKvtP3k88VB8uPRJVWN7WIRA1yqNXsR5s70GaTwW0aqNDsA34k6TTauWf2UgRu/xTEZLsmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=Oi4D4MM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ml0JCFEX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="Oi4D4MM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ml0JCFEX"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 54F2011401B2;
	Sat, 26 Apr 2025 09:18:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 26 Apr 2025 09:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1745673509; x=1745759909; bh=H9
	+HroaFG0QIDvK5hi3sUShu20wyYyB/Rlw+RvZOYo4=; b=Oi4D4MM3TL/nL8G7kS
	/AOftlY9l4fgMz4Cdy6+qKdb612El8TrsNDwYmlrXroa7JNiOCC035iQYLWpELoM
	GLnUwVq0o+tZmvQGSBBI/W5z6jQIDm+BEQh3D+cp/N5DEPnO7cwcL9tXT4+crYwK
	8xlbKZe3xWdvZmPpGD0OOGZYTP0S7xrxOOJQmXasTO5O1T+zjmWlkOT+pIImElzq
	BxyeQL4lPMIol/5xoUD2uc9Av86PCnfqd8VWKLsdQSUl9+MQIiiXGZ5xI+5gEkhX
	l7QObKr0HdRpvXR5o8bSzBtRI4q8pJQCLiqLBz/HMOLOGUl7htky3EknXVxuXBxz
	vDeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1745673509; x=1745759909; bh=H9+HroaFG0QIDvK5hi3sUShu20wy
	YyB/Rlw+RvZOYo4=; b=ml0JCFEXcO994WK6TCyM+o3lLDPoMmWW7LiXicIAxLrq
	X9KyOC7r0mqRU3HkGNVDMAq+7Apa9azGJEkAG7dqPgfD40zRhyA+67Kg+ImV/8VH
	To81aEuDHhQoTLVRbVoBGsJW/Ewt7M+M1rTKKj1UwnHH/2NEgyS24GZfbgr5oMhB
	YA+gk1Yz34lzzwFNGrMUYTFRUROOUo/LTlhOLXfO/psDD0wNRcMjqSz0f3VrWiTN
	JyZEzNpR8g79Y9vm24fjMR8QbTsBJKH1eZ+UuQmXdZQOTjWj0lsBnDihpZYQmzO6
	j9rQjTkyllnVw0wrAIVdI1s/CATRCz177qwMeZmGXw==
X-ME-Sender: <xms:JN0MaOCflyIO33iHZiu3dOur98Yn7Lqc8v9WcrrV8QwOMoT4IlWSYQ>
    <xme:JN0MaIhuqN5OaNN9dKnd9VJ3lMZSw_GfUUmRt6wEnuot4DdU9cNeYSsKlmeYuitcz
    BAzoQHm_92t0EGOhg>
X-ME-Received: <xmr:JN0MaBmYxe1IRVoes8heqkv3DoyoW_zuQ0zZUZsf-ZLPFBveKdhN_zeDHR_xuWRf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdej
    necuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenuc
    ggtffrrghtthgvrhhnpeejfeehffehjeejgfdtffetkedtgfefgfefjeegffekjeejgedt
    veejleehleelhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsegrlhgsrgdrshhhpdhrtghpthhtohepjhiftg
    grrhhtvdesghhmrghilhdrtghomhdprhgtphhtthhopehnrggsihhjrggtiihlvgifvghl
    ihesnhgrsghijhgrtgiilhgvfigvlhhirdighiiipdhrtghpthhtohepshgvlhhinhhugi
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JN0MaMykt-2KoZsIZLZR7_OWp1hWLkok37YY45mL6EAo0oJ87Iyzbg>
    <xmx:JN0MaDQ3lEWpvGNL8roR1svc7GFdyews6clZZqXUCSAgAumwN1WUyA>
    <xmx:JN0MaHbVikawRhIv7yD___PScOtQz_S2ngHLgL5VA_QvXaO0xFZRiA>
    <xmx:JN0MaMR4SlT3j9Q0OuXSL2GFbm0QdHPBLdWX6eHudQtoGSj7GPii6g>
    <xmx:Jd0MaBeyzSIG8nccWctFdl0m2w9dJCrdiWgmWl2lWwATTZSB8PzjRROp>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Apr 2025 09:18:27 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id AC06311733; Sat, 26 Apr 2025 15:18:16 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?=D0=BD=D0=B0=D0=B1?= <nabijaczleweli@nabijaczleweli.xyz>,
	James Carter <jwcart2@gmail.com>,
	Alba Mendez <me@alba.sh>
Subject: [PATCH] libselinux: be careful with non-portable LFS macro
Date: Sat, 26 Apr 2025 15:18:07 +0200
Message-ID: <20250426131807.2812891-1-hi@alyssa.is>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

musl does not provide the obsolete LFS64 APIs (like ino64_t) — ino_t
has always been 64-bit on all platforms there.  That means there's
also no __INO_T_MATCHES_INO64_T macro, meaning the check would pass
and reach the static asserts for the shim, which would fail due to
there being no ino64_t to check the size of.  Fix this by only
assuming the absense of __INO_T_MATCHES_INO64_t is meaningful when
another non-portable Glibc macro, __INO64_T_TYPE, is defined.  If both
are missing, that probably just means there is no ino64_t.

Fixes: 5c3fcbd9 ("Inject matchpathcon_filespec_add64() if !defined(__INO_T_MATCHES_INO64_T) instead of using __BITS_PER_LONG < 64 as proxy")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 libselinux/src/matchpathcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index a4f65045..240c9fa7 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 	return -1;
 }
 
-#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) && !defined(__INO_T_MATCHES_INO64_T)
+#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64) && defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
 /* alias defined in the public header but we undefine it here */
 #undef matchpathcon_filespec_add
 

base-commit: 2647cc0fdca326b81ee3c08718cbe19b7866b53a
-- 
2.47.2

