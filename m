Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E42690EC
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208415; cv=none; b=lQtCMW5mjmVudkFqRyBkapj8xUW2xaXZTvdLpk8+cl4E7Ybd3xfFnezFZaABWAMYjYB2zQvpgHWr1ssfI3MhiG554BX0AhXnahjmiH8FH+FsF+8/IEisW9lZ0OVWLBxitXwiG8pq1jLPCRgGfnCec73kvp2zvocyjehm6PQn/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208415; c=relaxed/simple;
	bh=h66DNdUJ099PMNKg8KrSlC81YN6Vlj/cbKVyQsAT5HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5Fb4mRdB3d7+gl1yT9a6pqdHwv+8beffNqP1bYOjqZQHTFkUaql2CcdASklfytVe9GmcqAFi9P0b5ytlS5WeK24YCTtrO5yKJKqcQLrWCbBGgw+T/SZKZ/5890sZVFOwtt8KVLSQLL1J1uWHxQR3+XC20DWOSRUuxaH4fB7Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=g/y50YPy; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="g/y50YPy"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1779208408;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NavfeTTcRVSE+ebz8TglbMNjYujHNNb34IF2njL3nnQ=;
	b=g/y50YPyLgZmK7NHzfCGvP/Ji8wjnftkfrM7GAf8SBIr5QCXrhJJSaN9r69tCKPo/qJVeC
	ApK/gI02gtLF/QY+fzvFdDZLhrJEPVkGWpe7B8Vig5vptFOuUmszFFp3H/vHZQA8SjQh9i
	5IAXYw4fOkQ96eXUOgurR2ID+TGPY125bHfJaWWwS5204a0u5nm+fk7V3hh0dOV+r7SMOb
	G6Jr+nWZJauMv2mXNY8dbppitScA7nCOxfWyxL4fQQCs0XzuLjf+Q3NQ2dF1OdK7spUb4v
	u6gCrkNKtFA9BBYVzFI7EqNOjem4w+mMs0zv7s70F4ISfA+Adgc26ZhXhgiI7A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] gitignore: add entries for coverage related files extensions
Date: Tue, 19 May 2026 18:33:16 +0200
Message-ID: <20260519163316.450138-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 6ff61265..64927124 100644
--- a/.gitignore
+++ b/.gitignore
@@ -19,6 +19,9 @@
 *.rej
 *.pyc
 *.pyo
+*.gcno
+*.gcda
+*.gcov
 cscope.*
 .#*
 \#*
-- 
2.53.0

