Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D848665C
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330859; cv=none; b=e0+V+xGbKmgmZPp8wU6mLfgVAkZwNpDJZEH6EugOPSioGArVo7ToBWmVSjtaZYXSCJQjPDe+iE6mlVCxJwW2E615FrDJYjPln2/oIy3nbewWNEdJYfZ2a3PJv7RIKjawSzj4Qrpay/3xaDSgiXGRwbeLRoz6N+DfCoWhKrUEgvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330859; c=relaxed/simple;
	bh=1lr1NzwGuYb0M8EkQHZNDg8obqHY+DyY11HG5cxiAw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMTfcOTJEjyW37oc7CbNs1rRxYL6SYRjQ4oXaxiIoY9geWjk2KnG/xNi0ULOyoVNwiG04au6ArO6ZlvggxrUk1pI6coIPab1qiU9NB6PUtfLCUPGMKPk8Wpsna0uPRzF08Q0cPAFlpCE7m7XmZTxZlg1FB0EgHo2vc+sqxQD5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jywq6E4e; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jywq6E4e"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e5cb052edso71463585a.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330857; x=1785935657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slbUkQ/STJgbVOlPvroVdlDQMltWSWnZ0LogqNwVHQA=;
        b=Jywq6E4eMsd8h1myVKi6vH6VCGq07DzicavklKJrrFeUjZK27AgQnzu+QO7BJML55N
         eIBaUNt8giqK/c1kTSz+pHN4aMvUmNvWi6ZSbWx/T8E3DhHJu0p2NVo4xXmd0hZIQYZW
         R8jl6hMMsWgPgLWPQVAzgAST0LHBy9ZDkwDaxs66JjJ1XFgnwRNp48ebHhh6k2nN+yDA
         mGNMfNuzj3hcKDxh0Xg8v13sgIRMeB+x5v2TS+NK2E9idXDo+13ucl5qskvf08hGakAy
         W5psHNpqGHR27sNgVc7QW5y+fFeJhXfgJMgFI5Da3UACds9mH9te0VRBM83Ckh8526wt
         t6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330857; x=1785935657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slbUkQ/STJgbVOlPvroVdlDQMltWSWnZ0LogqNwVHQA=;
        b=AJkHYU5jnXALG++TQ4xub1PiIDRnDD/scg+WUOyLkF/u+qVXtUucIMCZ4zI1pEhtVr
         TF1PRwtk6fuk2eRXHlhwUBgxIDzWwrSEW2P6jJH/ogQ7CG0kOTQkIgty7FJMyho0Tt9s
         L4RiXNsJGGGEmKwmbFiwThxo8Vi8yK4pHOVjnoGtMDwRVcfABEFYRfxr/x+j73Q6R0bW
         k9S0yDvp7bg5zQum/FQgShr4qe6xXZzechGWk+XYDDQWxZf8kVyvxF3rV8iawt0iQ8sb
         hFqV4zcqecgWtbe0MO7u6YfgKTyah7ch58GFNXbgGTBi1xcZ34CWiq5/TH2mUSp4O06Z
         uL8A==
X-Gm-Message-State: AOJu0YzfBh5WrVjMco8xswxpuTDn2v8lu3Rct8RCaWa7O+5+j9Sx9aC9
	2Jnbn2x+pdl7X9Q54dx8ZS4E+S8E3m72JcSylcBVS1JqdugE6QfHAk2k2VgkKQ==
X-Gm-Gg: AR+sD13qpaNJObuwiGssIFQ32pc+Hp0mNVKequo/GXYZ2lwvOkDNXQK0hG5jh2Ajsma
	MwD22M+apEThulRQeay9YO5VU3p9hAH1Dth5EujiBkuAeVrqxKr0a9TSxZr/4bpILI50s0+yJa2
	HDsimrTY9BGZMEwGqCoOvbnoRiYEGCUFmq/P6lpTA0FO3EtFwCbrQ0CKbwPFF1uyPc6DOX5EkDs
	DA/7+8apH+JORepiZarcoa0kd9aMgM0EFt8wvybICBwkQnYWc8GdxzUZsVFF2GW69seOnuT2rS4
	KkM67EXjGbKQdlGubgzpqJEcejL4FNgfMX9YnYrdZ7fvK/SB+mw2fecvtVLP1Ilq2ZZxDGKuXge
	jRvBQuDRXNtQNwBV2AbRcm8IS0n1M8gJs2fXU1yKBFZKsYyqwDHEmVzvJV3taWCfTG5Jc9dQMey
	l+iVE6PP0DHrKgzxyOgbh4UqIVMAof6nrOCGcN3kgxKCrbB6o6CQLsGf1Cg5Vs5Z0g7FqrR2B/t
	aU3bKtnvF/v1bqeVs/dgN3AFpOVuNOoLAhoUS0=
X-Received: by 2002:a05:620a:6481:b0:92e:4e88:f453 with SMTP id af79cd13be357-933027cdab8mr661977385a.52.1785330857381;
        Wed, 29 Jul 2026 06:14:17 -0700 (PDT)
Received: from pmatyas-fedora.rhev.lab.eng.brq2.redhat.com ([85.93.121.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e735e0cdsm163731485a.42.2026.07.29.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:14:17 -0700 (PDT)
From: Petr Matyas <p.matyas13@gmail.com>
X-Google-Original-From: Petr Matyas <pmatyas@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Matyas <pmatyas@redhat.com>
Subject: [PATCH 2/2] libselinux: fix infinite loop and missing errno in partial <<none>> lookup
Date: Wed, 29 Jul 2026 15:14:13 +0200
Message-ID: <20260729131413.1390890-2-pmatyas@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729131413.1390890-1-pmatyas@redhat.com>
References: <20260729131413.1390890-1-pmatyas@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_check_node() has a do-while loop that iterates over matching
literal specs. When partial=true and a matching spec has <<none>>
context the loop body used `continue` to skip to the next entry.
In a do-while, `continue` jumps to the condition rather than the
loop increment, so `literal_idx` was never advanced and the loop
spun forever.

Fix by explicitly incrementing literal_idx before the continue so
the loop moves to the next literal spec as intended.

Additionally, set errno = ENOENT before continuing so that callers
which test errno after a NULL return (such as the selabel_file_text
fuzzer) see a valid error code. Without this, lookup_all() returned
NULL with errno still 0, violating the expected contract that a NULL
result is always accompanied by a non-zero errno.

Signed-off-by: Petr Matyas <pmatyas@redhat.com>
---
 libselinux/src/label_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 63066228..d716e0f1 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1936,10 +1936,12 @@ lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind,
 
 						if (strcmp(lspec->lr.ctx_raw,
 							   "<<none>>") == 0) {
-							if (partial)
+							errno = ENOENT;
+							if (partial) {
+								literal_idx++;
 								continue;
+							}
 
-							errno = ENOENT;
 							goto fail;
 						}
 
@@ -2025,10 +2027,10 @@ lookup_check_node(struct spec_node *node, const char *key, uint8_t file_kind,
 
 				if (strcmp(rspec->lr.ctx_raw, "<<none>>") ==
 				    0) {
+					errno = ENOENT;
 					if (partial)
 						continue;
 
-					errno = ENOENT;
 					goto fail;
 				}
 
-- 
2.55.0

