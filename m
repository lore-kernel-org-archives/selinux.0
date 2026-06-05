Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0E156CA
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668148; cv=none; b=kKSk33T/LZyLZs/BYEijxKbUT1j1UdmcHm3/Wek7O1vXXtNlN7+52DnFzYQWVvijEoVqBZO7wptnSUWSm7cpJZ2brme18X+woxifA1rxPFOij5lMnwauRehPsD7Xh3H0kuNbbz/ObDZd9Lacf06BN4T7RE3s5XRsTL0FGvJtAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668148; c=relaxed/simple;
	bh=vfUrpYu4mY/xrr2HRk3S/k2hBUuJA5Lt+cVvHZKafTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rueJa82MGsYOMzm0FcyA3J4vXn3OmgtxvApL1vhEAGjm1MjGLRp3nUS1aA8u32SpXZDlct1DRR8u0N0TOJ7XDkObL6D59sT3Sd1Z/P2w+dfkdx8MG3St3/voXIinC7iTF60fRz5xS3OhUJP43BnXOan2oHDcRkXzYHrx+hnIta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=oOxH4zun; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="oOxH4zun"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780668145;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LcYDnGitPm+fLH1m3Oc8NuegDJZktvMy732RAAaDMhM=;
	b=oOxH4zunND+oS/G8+CPGE2FUI1XKVqQHBPeHuMQllLNLdCzUjS1h38FJB+Y4O91nU+3HqU
	rqAu/Dz/+kSgoq+iq89JPsLRY+3xytqhPbvdWMyTZ8049tdgz3rENKFZFJvjkRDFv17DQw
	16nBwC7ci4n6sl/LvXFpxEzGhbkC4sK1jXPUcnORtXTpuqFDWqOhhTjaWeD6MzQ4/9L8SF
	kYPWsXsScb2Qh6PMMFS+r7JYt24Fh0heg1rvvbet8uvza8sjZ+7yqAZBceZ0ACqNawVBC+
	277nAqTaEiw9srCELeMrJTk5xYgYW1XyEuqTFxjOP9MWKXPSSnHVP2DhCZ+XAQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/4] libselinux: bounds-check serialized regex length before PCRE2 decode
Date: Fri,  5 Jun 2026 16:02:03 +0200
Message-ID: <20260605140203.76848-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260605140203.76848-1-cgoettsche@seltendoof.de>
References: <20260605140203.76848-1-cgoettsche@seltendoof.de>
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

regex_load_mmap() (PCRE2 build) passed mmap_area->next_addr to
pcre2_serialize_get_number_of_codes() and pcre2_serialize_decode()
before verifying that entry_len bytes were actually within the mapped
region.  The bounds check via next_entry() only happened afterwards.

Those PCRE2 routines take no buffer-length argument and trust the
serialized stream, so a crafted compiled fcontext file (e.g. a
file_contexts.bin reached via selabel_open() with SELABEL_OPT_PATH or a
"-f" argument to setfiles/restorecon) could trigger an out-of-bounds
read.  The version/architecture gate (do_load_precompregex) is not a
security boundary: the embedded version and arch strings are plain text
in the file and trivially forged to match the host.

Validate entry_len against mmap_area->next_len before the PCRE2 calls,
mirroring the ordering already used in the PCRE1 code path.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index c40d4cb4..0289a45a 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -137,6 +137,9 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 
 	entry_len = be32toh(data_u32);
 
+	if (entry_len > mmap_area->next_len)
+		return -1;
+
 	if (entry_len && do_load_precompregex) {
 		/*
 		 * this should yield exactly one because we store one pattern at
-- 
2.53.0

