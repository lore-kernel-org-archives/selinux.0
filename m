Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CED285C88
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041452; cv=none; b=OjYnmR6HjzUle7KvqXpBDLcARJ7yzuohJvrRBD4I7sZkFi/EP497MF0h8JtMtTUGLhB8OGQSwKe7lNzG4TJdgIH/sC3vVPQXPZEVm1N5G723Jzl2S+nkVujQtc0ImFdPszkdKhQmOOchrp8M5eEHWAfARoRxpiViW7CbfFu6gBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041452; c=relaxed/simple;
	bh=Kq1DmevsGFEeR7y/WTnIIlyOUU9XA/lR5Py28f3f3PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nx30BfBQ1sfLGy8SrdZ9lBD+7iBPkT7t/ysQ5tBBtQbjIy55X9vrCzXKW+bAMFDiKR4SwcVfA6xC3R85zN0xAaif8/Zd94138yJ42MkTO0D3fanVsKCUc/eGlwCoOTszzIlRZPgBzCY91/3AQM+QBbRn6Np2FNM4OhRNx4I6Xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ae1eyYpZ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ae1eyYpZ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770041448;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AF9P6Rt27YEPiEpPUqUpKviXgWVRUcAUuHa8reccLsc=;
	b=ae1eyYpZCKiZVCrH98kOd4Ig9KCwYuhtSCL//V1sSgXMXHJiGc/UKTC3qHhnhRxDPPjzDH
	X4pKwb0Rnzo08tCcL5ajLubiOJjPWvFrqyvtTry7TvTy8b0/hkZr3CkXJva1ZGx3egYdHW
	L9CoVq4Azwa9RR2cmpe2iuKrswacdiVokvYMjeB1YirqkVyvQqU5xuBuKwwSrsu4tP2HM8
	ZABtxRQt9JolBE6LFeud994p+hUYP/kXBFeO8vJghHigBmlZlQvOkXWqTbdhQS58onLdBK
	TnfhG3ZU5LXWnH5yw+h85jGUSq+3O+qsDjfbNJAMwV0BhtyZXvu+poJuN++ghA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Helmut Grohne <helmut@subdivi.de>
Subject: [PATCH 1/2] libselinux: prefix ruby objects with interpreter
Date: Mon,  2 Feb 2026 15:10:43 +0100
Message-ID: <20260202141043.85962-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260202141043.85962-1-cgoettsche@seltendoof.de>
References: <20260202141043.85962-1-cgoettsche@seltendoof.de>
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

Avoid cache mismatches when multiple ruby versions are available,
exactly like the libsemanage Makefile.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 0dbba7f4..a9bfe069 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -40,7 +40,7 @@ SWIGCOUT= selinuxswig_python_wrap.c
 SWIGPYOUT= selinux.py
 SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
-SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
+SWIGRUBYLOBJ:= $(patsubst %.c,$(RUBYPREFIX)%.lo,$(SWIGRUBYCOUT))
 SWIGSO=$(PYPREFIX)_selinux.so
 SWIGFILES=$(SWIGSO) $(SWIGPYOUT)
 SWIGRUBYSO=$(RUBYPREFIX)_selinux.so
-- 
2.51.0

