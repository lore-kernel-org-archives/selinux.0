Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193F5326C4
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077268; cv=none; b=oUtN2ldrTuEQyAC2wx5dziaUeMdGR5Haug5/nN6PQjMuA3SUx4eGpZcZboVpqH3xEcBmfgR1z7o7JBHN2dU9ALwsziS0zuueOGHInAMJjN4TRbzzqqgQvsz9cpQqJTcG5YDgGs34htFjsiUhqWUzIrlbKZsL61kxGHbDy6qSD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077268; c=relaxed/simple;
	bh=JGASRn56CQtL6JyZOWaxU7TI0OiqNGUkiKcQSn3TYvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LakFbkU6gKB+RmFl+7iSkUWwfRV6eW59BWVeSTInYU/p1+07Gkg0gySkJtoTO0qHljFTaI3rlGTAYg8PvuquYddmC8ZkOuaB7WIA8ELIZoNN43f5rBUAxjUNp5XoBgPmf3SWwaHZydGWZNKOi4bq1dbDtPK0iLzBrBU5Nw4xNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tj5BULyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIZZqlq0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tj5BULyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIZZqlq0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DB717A00DB
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 11:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792077266; x=
	1792163666; bh=yBrziUAJFrUTYJzCpp8XvrSd/YFbdT7m9RLWWKpCKbw=; b=T
	j5BULylFi8lEWF6/eaFHXVGEcyNRne/NMO3qqyOLgbeqDmDbm2lA7lZq1bnU+fC6
	ezuhAugjPQ4wilDz2q1zaqDp52LlB3JJsOeK4hHwGjnTvpgFE024atSwN4t0JHYQ
	arGAB0ADXQnoS9wivfpn2MuWz9lPx3iE9yHzUnRB8Zwf5KMufCnW3zPZNRJ2B6VS
	B1ExTKngR8o2Kx6uDpL1rr9TpK21aSASsvH9UfRj1JA2G7DoPS5T5UPDcovFSJCn
	WmT4HnzvICtO/n7MFuR+e57T0xmbrwl5a9vRFv79GZGmo5J2YsLR/t9MSiErvvSh
	zcwWRDYS2UdQtxKnJA0Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792077266; x=1792163666; bh=yBrziUAJFrUTYJzCpp8XvrSd/YFb
	dT7m9RLWWKpCKbw=; b=uIZZqlq0H42XOiLqmJYOhoCYnEG5x+bVOiTsGhtBEe9r
	p8l2iKt1h7dL1Yfo+1vZ5HvZ+FuLOuLKszD10jgu6AmU2WdBuULHQA77m/s7g5WZ
	/6OuMZHtTKSOeAMXyZ47CDuSJoeeq4Esg3sP0bryFugJAIQSAg24H0TPQHqjRfbc
	rijzGfUw0Ntuupf3Rx2MNxdH+OmPtsze6xfFOIShU59vXEAu1sODH6R4z4hZoYDP
	P8z6XxtMXyrpGMxAUMwk6y+YPw6OYpKZCTSEqHz174FAbsf19LKEkxJPRwmEkRYP
	AR7NiGfZazKBqO9JZpflKiCySILfe3oviaEmbdpxeA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077266; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:HA/La8bGD4y6PmoIxVrz++lRAHxzriAwR5T6GHzbZV2z4pE
	L+Idb2YoOA/wF2vgYEfpBeVjVW58IjozsaqNWrxsI+99BkJEBf8dKrVTp2+iEGgr
	uynWTpbBkn51Q7krx6hWW4w8ICJcaLeL5Th93XplyaZFvu7gKxsNXWLFAZCEEsxl
	XtlrGBNRrM5o2WScSmS6x8OB4cwu0VLsfIz1hSMiGLOo4TRLRvGkdLqS5x1MjssD
	8MzaBX3MyTTYw89gU2GQ5Mqg9NhEDBV3YHo2E12/q/RY5MQzt+yK6SpYVzm0GB3x
	6onxSLat1IW6azFo/JpQfM+g4XjwflVlG7gNmWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:y14nn2+SynIRw2Clf5WK0uvjmG6m3R8azTMC9Y/5pFk=:JGASRn56CQtL6JyZOWaxU7TI0OiqNGUkiKcQSn3TYvg=;
X-ME-Sender: <xms:0u3Qasa3HiEum_g_U2vYWFTmw7vgdZky4SjjkVRDfnw3rsOHLYzplw>
    <xme:0u3QauU3WHhQx6-SkaPGhjLSC6u8CrnGWygAnIxf650tUwRfmrAczJVEKtKNL4JDZ
    GROz7xIQBtHC2wW4nAVJSVz_cnf2zmvnucdPWrNAEPaiowTeYogtw>
X-ME-Received: <xmr:0u3Qasn1BRmgwITNFuny1w4RB7IMbPMXGZV6jXe_geETnDE_naU7MrqKFJcNiGBl2o6Uu8S3Hw47vzDsy49vg8AlYg8g8UpY5pQ9hFjb8NRNGB10SJ-nIRnGgN_PRtWZW6EFCi3XpErJSBDa>
X-ME-Proxy-Cause: dmFkZTGvzYVLZxzBED0c/WpDmVurWCaMM6ep2gLBg1hhNFZvr6fTbGhlnNWkPSFsU+PAda
    ufZ7IroiJh01v82kzwapurO3ZXqAIJ10Hfi3EQ6+2MPyD9QM6pbYp/y0UUC49PSDTVi76/
    C1b6XKXcpf3UKKowKmlcp9skOXwi15Sy9CWplUq73Uqb1vDYsprRXjdgcqphhH5EfuV/2y
    T0GmRVHkrqu70dGKxBeUzc1XeSr1SMHIlVyYv5shaQSqx9ORInpy1rU0ksHB8g1aTz+3JM
    I7pXTe5afxOqq5q8xAhc+d3kuN6uJYGySEr5ap+/or0HHKH7GhUiVtR4cwcXs7C2YNrFsx
    /nPRT/G1GOeqkirU3HSw8u121HLnMgustJY4bYyz9PhQ9xUcNsD70wZ6VL4N1F05EvaN4U
    9i8b3K2FT9QvswoiXDv8sH2d3r0Wk2o15K2yyUkcvzDkPl7mCSRPgPv08SpRs7fCY2/jj8
    P7Qj6C591RZkYLkxNPJGe2YGytLLunvvcnd0oXCT/vTWjQaONFUkAYwzdVPV9EHKITuGdn
    j3W7mhHEHQF6WUVRRNGO8a3kq49TS4cFJWNxqhWLNS6wI6o98qrvtvtD2k3zKxW75Yvui5
    /+3I1oXSN1hMBHuZKWrc6k7CJiF6Ayq8YDVVnMhvajDYiXYEb+LzZRMeEIsA
X-ME-Proxy: <xmx:0u3Qary9HU7CC05GoUuz0XB9x4thVM7ihplmFZl0-01FhpQLoOyo9g>
    <xmx:0u3QanimlY2Wm1H_Vf_zBvWsjadXDSeKJ3OJw_oi8oPLK6V5n5g_5w>
    <xmx:0u3QagWekgQbLWqbBBPnd_PSgtbTGwbLN7jZdciLjO2mlwkdKnQPLQ>
    <xmx:0u3Qap3PAL4_vmW8r5ZeNKbMTpRWNMNGCuD1yHdEaU1WBZinf_LxEg>
    <xmx:0u3Qai70LOz5dQE4yR3Si1JrwW0JFumi5P8VnQH-lgq7f4ajUy6HI4Ax>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Thu, 15 Oct 2026 11:14:26 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 2/3] libselinux: add -i option to sefcontext_compile.8
Date: Thu, 15 Oct 2026 11:14:19 -0400
Message-ID: <20261015151422.1057210-3-tmz@pobox.com>
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

The -i option was added in 487d652e (libselinux: sefcontext_compile: Add
"-i" flag, 2016-09-28) but the man page was not updated accordingly.

Correct 'info end exit' to 'info and exit' in the usage string.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 libselinux/man/man8/sefcontext_compile.8 | 13 +++++++++++++
 libselinux/utils/sefcontext_compile.c    |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
index 11c2bbc3..d5ad3f62 100644
--- a/libselinux/man/man8/sefcontext_compile.8
+++ b/libselinux/man/man8/sefcontext_compile.8
@@ -5,6 +5,7 @@ sefcontext_compile \- compile file context regular expression files
 .SH "SYNOPSIS"
 .B sefcontext_compile
 .RB [ \-r ]
+.RB [ \-i ]
 .RB [ \-o
 .IR outputfile ]
 .RB [ \-p
@@ -48,6 +49,18 @@ Omit precompiled regular expressions from the output.
 (PCRE2 only. Compiled PCRE2 regular expressions are not portable across
 architectures.  Use this flag if you know that you build for an incompatible
 architecture to save space.  When linked against PCRE1 this flag is ignored.)
+.TP
+.B \-i
+Print regular expression info and exit. That is, back end version and
+architecture identifier.  Arch identifier format (PCRE2):
+.br
+.in +4n
+.EX
+<pointer width>\-<size type width>\-<endianness>
+.EE
+.br
+.in
+e.g., "8-8-el" for x86_64.
 
 .SH "RETURN VALUE"
 On error -1 is returned.  On success 0 is returned.
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 02d9a2b5..44728ec6 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -537,7 +537,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 		"         if you know that you build for an incompatible\n\t"
 		"         architecture to save space. When linked against\n\t"
 		"         PCRE1 this flag is ignored.)\n\t"
-		"-i       Print regular expression info end exit. That is, back\n\t"
+		"-i       Print regular expression info and exit. That is, back\n\t"
 		"         end version and architecture identifier.\n\t"
 		"         Arch identifier format (PCRE2):\n\t"
 		"         <pointer width>-<size type width>-<endianness>, e.g.,\n\t"
-- 
2.56.0

