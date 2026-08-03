Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B4331EAF
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772079; cv=none; b=Ni/tKY2tX8DLMsAdFTLABEUTabvGfB1+lFCuHaKNkTfXl8rDC1IMnU3h0Q0pKVTrRsZIH9OeqP5VnhrQvdEr/mVXu//MwEl3pH1hQ99QZHFmJ7+5Je5UsZO1AFOlFgtALLiP6gLio0lQzgNq+XubNOgYpJYBF2b59MfcZsLBx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772079; c=relaxed/simple;
	bh=AVbrxgL510177QoYETDelZrbdOo6GTz4GrCUUy+BMdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cv3x6e2A3UnOG/XDqNfqqA6efmwo7SJxq7EqgOGlUgaLjev0uEk3i188qiW49ZgDd1GmRb8K4UR7r92W77zG6/5OHcpyxcedvTyuQS69+WXCWFv/MMeTjuul1/v/7U/8FmfKwy7llVzR3QCfw0RTR+EsKZhCRZ9s33wWbbQGZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+r420eZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+r420eZ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2808dbc3so20585791cf.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785772077; x=1786376877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cSAGo/QtZtkVc2GRPFnsOtpSwWgy1Xo6jfAoW6ksW5M=;
        b=B+r420eZjMxW01JeoBKbTJRXdXLAmfUXxZSDgcWOaOd3aVQkUWVlhDkdkcGeRKCei4
         NnK8AcpAfb9qZGFFDfgsh+1mUjet7c0QukXX/4/06Rl7j7QzbOsAAa9VUQGTlJpHnroF
         8Wqwgm3z0FRphHIPcL9RIJFhfUdpWZWcT83+OuRlxaeTaN1N70ieJ0KxXORIttKYjhRM
         0O5prrxFGujZ0pkKDX/TlLUq3kEcyhOnrrmBP2/z7cm89p71Vk9Ebg8K2Sgtstpk2BjI
         LKH4JO1Xi2B9YddmjZBDgzs0hp2BmxVXAS528R+UsGjhOM/F+slG+BhgiSJx2uEp/97g
         RASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772077; x=1786376877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSAGo/QtZtkVc2GRPFnsOtpSwWgy1Xo6jfAoW6ksW5M=;
        b=qhVE7ifxt2xOlhLHL+EHHlzkqYLCnJfFOGdlx2iAzTDseFklAdUt0ZPKfJnUi6lKbE
         AZPFetCVF6BXvVWJYz5ScZDLXcAiMVWwlC0Y6uBACQqgaD+N5oKVyyH9VP3cOgQYqZhK
         DmSj86ydHQgZqbRN4aXqiZxh9RYlcONmkWnL8f11TC+ef3Jups17dSif9XzYmBZuInB9
         THliL2/V/uMGJwdKqeGQxohcJrVXBwJ1HoDoJ8XtdTQN+o2hoN+Zdg6336D6vxB8hclZ
         6AyNROZwyar6aPb6m/2VH3vNJ/nhBMnbf4rt0o8Gw3YSRmsHBiLdysXh0tCYRTcayRJG
         UY4A==
X-Gm-Message-State: AOJu0Ywae2h4K9lGwbcNx7QXEAc+WXW60GmsAhHOFeDvlMOXmnvKfPCf
	e3yzzdU36CLCmdbvytdvh0ECo3X8KZl+sxgBasugbaqysvF2V21g1wCsX7bSJA==
X-Gm-Gg: AR+sD13ZeNb/d3TOegqwnxEP/x6FB+OBBbsPl6ORatPdmC+U8q3ZwQLXcmPCClGW2Eq
	6Lsw4ujpRCGAoVCfwBlfSz8afSbVKAn/Qq8KD+8azjH2xi8Vtl0pMQTE98Y/EQx6BYLdwIEnZ8O
	sbXIJHj1d5NWDwcYJZxEsAC23vDaiA8Po/NRmAEv04vM7gOTMVMVoQRsv99BShWVP14/WJZgJQg
	nEQoDXm1OkpU1MaoIX8xiQIcwylV4mCuyKY484cAvnf//i0jbryk0om/nN8cMWalIT952gOGKro
	NN+WKnBIbapztv2AjOIp5IZUsf5TxUDXpZsNzKfwpR4GBX24YouXPwqL17dPQxKqH+zX71AOm2u
	G0YNlKdyChA7KEW1SMqVFEf9aCRktpgka6csTFU+Z/h7OluVlOpwcyE7BZ3C9hv7fASoBWN4AxF
	HzcF8bZXye3lr9CD9vt+3FODcO79GiXRl0qbn++Wei2r5xwwe4sNjOMnWSf5ahUw51L730zyPO8
	MKJGujSTLo=
X-Received: by 2002:a05:622a:4d8f:b0:51c:1967:5091 with SMTP id d75a77b69052e-52b567d8bb8mr215531601cf.41.1785772076749;
        Mon, 03 Aug 2026 08:47:56 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435dfa6dsm77858946d6.33.2026.08.03.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:47:56 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/fuzz: Validate output of expand_module() before proceeding
Date: Mon,  3 Aug 2026 11:47:48 -0400
Message-ID: <20260803154748.18370-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating actual policies the output of expand_module() is
written to disk. Converting that policy to CIL or performing other
operations on it will require it to be read by policydb_read() which
calls policydb_validate(). The fuzzer is not validating the policy,
so it is reporting bugs that would be caught by validation.

Have the fuzzer call policydb_validate() after expanding modules
so it will not report bugs that are caught by validation.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/fuzz/binpolicy-fuzzer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index 017f996e..f2379175 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -88,6 +88,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 					  /*check_assertions=*/0))
 				goto exit;
 
+			if (policydb_validate(NULL, &out))
+				goto exit;
+
 			(void)check_assertions(
 				NULL, &out, out.global->branch_list->avrules);
 			(void)hierarchy_check_constraints(NULL, &out);
-- 
2.55.0

