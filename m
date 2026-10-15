Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6534D926
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028710; cv=none; b=UpU1nIhIbpu50U9jJtmcZdvmydtm6wq/EZAq35/v2W0Ujg+f6BnTGwQk5sDZP2kirCxqOLTcf5foFh9ZnC//ELsrmxIEJpswbqKun7VOMZFoJPFog4TCR5mOZDYNVvy4dIwJZeu4EAgeqfZ/xYlw348d1nyJwqkWxUraptLO2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028710; c=relaxed/simple;
	bh=gwqT8EbrfpSvJgzKH2sGVXHjGpdhZkkj72jj5Ote3L8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCMEm/i6Aou9BSA7pVIiv+6sf8cuYB3xSfzOf+kjWP81QjQN0fLkz8qiQpsCFX6RjmGFl4Vx7qSgdafrc0p/wPVXeoKOCncsQTFhQ9jFJSEMrXVPCfmiKXhRgsSlYRPts8ZGmnO3ELSVGqK9aDPInN7jAgUoHCECFDEHQGfxEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o6ywkPK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xlbzw+MC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o6ywkPK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xlbzw+MC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 939D7EC0366
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 21:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792028708; x=
	1792115108; bh=EaXbolfhrJ0j6N8jWWbXzyFvjflttfTdh24JaZblaN4=; b=o
	6ywkPK15c5UXh30KQGRPVr0dd1lu2TPdZF3EOlvrL6Ill8uBzsu2ObVtXhNk+meN
	ocYMGcFpUSm/4j5F6BjRI7iRrsEC0CcKTeqfWRAGimyGp3+o5ObtYSQdM7jZ+mjt
	gdqvnFUOixPHN3DohzQZ/MVwr6JyPlW3VCwUTDZ0ixDutsVmjIlGIMrN+4FsrCbH
	MUUFOpk3r1W33PPihLrdNNEKKF88K0FvizC57zWlOOIiPrDg5qeYsGKTFagEuARP
	BOJD9pRwC0fFdna8y2/OJrRvszFJH9/c8CB+QteWzYmyOIKVr7MRqaZLDX2SURlD
	AuS2z0o4qnkCU9vFYGXHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792028708; x=1792115108; bh=EaXbolfhrJ0j6N8jWWbXzyFvjflt
	tfTdh24JaZblaN4=; b=Xlbzw+MCCogvjGhgn8chofFqm7hb3aY/hMBhAgcRkcCY
	QHgaU03YmoxVkRh0tbBjoCgnHaxnt9ObQQWLnId3wWKdBDwVo6UDJyrv2iUuxmif
	8TsL2eB1HH3RqsprilnLj05QAQWYMjf+wT+5cBG9vWeGrur60wkFVIyOXgKn74f8
	dALtKsZOemM5NIJ0O3/H6YSveJP40G/OJGqXoVyXvzatZHiXvBohOPprlSnrnkW0
	/3kST/lO392HavRRwVU16asht7YJkJCEtc4NK+b0c3rih0SVPXKZhTEzUM+RaZfP
	OWy84Swq2iOyQuKfVms5NJCR6AvAk7LQgpAtOF8aJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792028708; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:N7I2UsFqCmpubjdcEqtyiRRjbACZgerN0tqN/3PQgwJqWiN
	/Z0oSe09M68EdYPWIQvg3BKC5rXg9hYV9olXzKx1j42z+n6gZcLM6pX1hEMImG6R
	czfXXy84P6nQ7k9gmOLIBxCCj6BwsN29vBR/4Pqx81BGm2875K17TiUnUOXGFeRC
	gupLwIc638xqol+o33ql57slv6AuR9hsc38iCX11e/x+45U+7zi9raVRDqISoRJ5
	Gfl75boetRV+og/aK8rnNyYuez4wfZwG5+Sgv+G1jO0Zh0WnnDBPhBOug4LkE0X7
	VeJ6tgT6c06+ey1m2rwbAgpdVpnD/EoQdMbwnTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:atj0ieifXf1MvB5PJgVZ3hDI00KqZO5SdlHCKEKLqsI=:gwqT8EbrfpSvJgzKH2sGVXHjGpdhZkkj72jj5Ote3L8=;
X-ME-Sender: <xms:JDDQaklLUDODLPky9sxylwxFC4jT4b3dyTtMxoyEi2r0gi8ofA3MEw>
    <xme:JDDQaqy4v1jpJd_AUkFSsv12Nh9BNOUYYse3Tsbnws4DD_5xsuDJ1_woBd74KSqDt
    d6Cap_5ndNAi1Jul02HWSBLMvfhwK2LFsh4YQkVy-cPRUnqxy6Wjrk>
X-ME-Received: <xmr:JDDQaoSUPuxvOqOpam5RvIHMlE2wjAgjzn5V6VrRHB6VevW7M2b0HJdTQZzjU1rDU8A1mk6RSeWh6nSKiZwjUVRSroknD909JQ-GW9c3e4ETQgXbYwT6pzALh62bBOlAkTcZY0F6ZnPKojmq>
X-ME-Proxy-Cause: dmFkZTE0vJokWS8xRf3zf+vyOCP06Vk37MbgeXR11HabD3ZrhRUiUQXCdFUg/PhGQafbNP
    j4EHtYsf6dOzPtjMeyUA7q6e4OOsJ5sBGdY7G5ioX8jAPF1Q+ANrCsvAd2NJ/P/hILRUcN
    ds2L3DjFAWcXwASyJn29Zu6fqarYukqcXf8rhGrV0uPWOyiNAHEr2xe69+FYO6h5gq9drz
    vLJXE2cVRo5s6Utj/zySoUctot9irPLFResjiBWJl5kq0PMn7CDvgclgRk2j1797bGaPL6
    vQ8YcqZ07eQU6ORhNrKsDsbiwwFu4rcd3MZgaJCIbEbcvZcWyOo+GxQFQk2behRTRZbXsJ
    FvM3Qf1Jd9NjChIgMrXoX+wo3/SNe31FCGq/TdCowUwZ9K5ml0oLGodhK2/iNploNZCQrG
    Hkeu2sNNdBmbh52iTtp6UW1XI4qbLM0d/K1rHXXgxWeJ2s30DLlsTECx/5DjM/nmlHDHt2
    9rPtqkev/IKb7l1pZf7101xYeAVJ2xhpbmK63HUo3wUtTTVjLywpAoQkykMgxRCkBB/Gqj
    XrLahZ/BXUMDZnIzbeOgdPqm1ItCOgCWYtJpklaFCQ8N8+u/uHNQMRN9m4FkMbSOQGc19s
    1TPZeF1v4wM+/Lk6ZEh2hh50/DNQ7m6XBxSa+aEsQTPesDTGOkmPa3bDAvpw
X-ME-Proxy: <xmx:JDDQaltVOZoPB6A1q6UvsxkiG_27yXybiT_vYVIu8MnukW56tRpDtw>
    <xmx:JDDQaisPImhFWMF7CgbXwWcF4-gIwImLAHmiNWewaAY3QEDNb4t8Ig>
    <xmx:JDDQajwEcPf_lOosOk9Wcz1T9NYDMuGuGlNn5gsAdxjFwfjrUFWYpQ>
    <xmx:JDDQagi_zvyvGhDvxLVom6mbgRfKh27aE7kPYaDw0-PbZnN_QxL-bA>
    <xmx:JDDQao2xacq0YecWj3U5qBVZM3rQ7gyoGtvnpyZ3AKqKUR356lrwNd7f>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Wed, 14 Oct 2026 21:45:08 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/3] libselinux: add -V option to sefcontext_compile.8
Date: Wed, 14 Oct 2026 21:44:55 -0400
Message-ID: <20261015014457.877322-4-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015014457.877322-1-tmz@pobox.com>
References: <20261015014457.877322-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -V option was added in 92306daf (libselinux: rework selabel_file(5)
database, 2024-11-05), but the man page was not update accordingly.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 libselinux/man/man8/sefcontext_compile.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
index 13192e85..e298b1da 100644
--- a/libselinux/man/man8/sefcontext_compile.8
+++ b/libselinux/man/man8/sefcontext_compile.8
@@ -59,6 +59,9 @@ architecture identifier.  Arch identifier format (PCRE2):
 .br
 .in
 e.g., "8-8-el" for x86_64.
+.TP
+.B \-V
+Print binary output format version and exit.
 
 .SH "RETURN VALUE"
 On error -1 is returned.  On success 0 is returned.
-- 
2.56.0

