Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035D241CB7
	for <selinux@vger.kernel.org>; Mon, 12 Jan 2026 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261756; cv=none; b=Ale4eV94HQynNHucotF2FUpIFiG9S8hO8hoc0UTVFiipGQUEkUEePgwEn+ISAkkl/qpmfy+i6cvC65v9XffTB4zvMbhLYzCo7ES8wE3+9pi3NPfLjbOHREItz+1Y2LSwg+RQx57ozJ0Nt2GxAk/BtebVf01grVLlPk2M+hqDMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261756; c=relaxed/simple;
	bh=7c2pDMQ/TSxfUFhLiMVWwWCTqlcAYrXWIZno8jMCdTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/Nz4TfARFiEDE5mkgWlIIL3Y63mqO1RExIvgAQG3tDEdseXPWYcNP91F/KfyNFOmMgeKQUQuhMnmrtzlsJaNkDCj+Z0c20A/5uaZf9AcXiMtYOyjEx54cfCOdiHrPlTvGAt6YbSwHaHVkCAkztBCwAbR95DDEbKWTH1IXLSOQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djPgZLwl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djPgZLwl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so31367125e9.2
        for <selinux@vger.kernel.org>; Mon, 12 Jan 2026 15:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768261753; x=1768866553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGKRULbs+5kTxneb03QIEfEZLJKmrhq54TFWVH2N8G0=;
        b=djPgZLwlnl3bZHwqc0GzwinJB1xObHsLc/bMvaDrudi447Z+Kz2/Oo/4O5ucZrGQAS
         kJkRO/V/q7NccEYXtugcTOeyTs2e3LodYD9DJFRTEXjsCi7feSil3H5zakXsBdree/dE
         j/Q9CCZb6fQ6MHMYgDtCedQCx0MTWU8TY19tOUNZXoFTw6LeOOsyLWKNzfiQ7lCJ6aMz
         wl/4sut0mjeYTAAyzUMYBT4Zri5GkbGHLbzqlH4bcdcP6d721J67JTNEIAOYnmRLSgE4
         OK2IYDgeCuwlvYoh+Wl/i1kJp3jlLMMp6AICaAN8XHn5bgWEerPAi+Bpb6yNkw3krez/
         OKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261753; x=1768866553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGKRULbs+5kTxneb03QIEfEZLJKmrhq54TFWVH2N8G0=;
        b=lCvcsIbw/79dfhft2KbzI3BDzL9i9KkYaMiPploWkVh1SjlKsnoE7ydY5Xx8iwXRuz
         3y/NKfPqYzoYsQiVyEROT8NJOqsMQlNU0UkVc2gzsmHqHE/9VOidBZWJqOHbyPPTQlGZ
         S+yMNCRz8/43rs60790H+GHtLcodRRWknHAb1yt3+IvOZiNrgM/Y0wuE3QOsHmvRrn0r
         ZFaSdtXeJnRz6sGay+akKpbwCG7ByGXckrhilJ3FyKnAzpi+r/AB5ascJVyj5GR8Imhy
         H3ZmdKKctrJZivQvNqzFW3G8pFOIzrBZrkU3e985wG+hkzq2f+BjGK9WMZaM5meZad5x
         PIvQ==
X-Gm-Message-State: AOJu0YxvAi2iQExaNvTvBXEPGM4A8CqDUmNOIRQ9XlwOp8fNgIASXl+o
	OBNegjmRStuaPoqjKO2iI7VF/k/pLu8JvTS641x7MMTRgFZr0wID8f7gPyMR0w==
X-Gm-Gg: AY/fxX7/7Xb+4qK+WK8unBnb4K/dhPO/XAgkvbtaE7CzwKKlsKhjN1BENdWKsiwrfpw
	phtsO7ryPS1X+Kt46PSWX/kucLgCY8tlJ3Kxq82OHsjLQTJ/E9M0ly5apySBFHHU10z9Ub9RYhp
	vbmXf+sSH71737vjo4Xxuc3q+qTGi9oJNt6AfjnuX6K5Ax2oP2TwrHkKNufFK/TUDafdH3ADlwl
	V11KJbH+1yohnLYMuN35JD/Z4syV+U5hoXeT1VsTyAabpLMtkzbvdSQaHD6iqn3IDvQjpOY41Ve
	nIK6ps3+V0hewzwWCZFLO1618YIwXekUb2JlLnxMY20abV+XNLUlGPDMdbS56vLLp0h5orWdq4H
	vWxHxMIjTypim87ajkH0YOwjkz1gkuhE99LR72eduv6UTaU6tGw/z3tQXltPCY4Rhdz1Nv4A=
X-Google-Smtp-Source: AGHT+IEaIBDHNe/F2lEQbkhPmaYIJVTv31LRhF9/JnUd4ajjRDvC1hARc0nkmYTpNLI1gu/IYrJ9uA==
X-Received: by 2002:a05:600c:45c7:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-47d84b2cf22mr229578495e9.11.1768261753337;
        Mon, 12 Jan 2026 15:49:13 -0800 (PST)
Received: from graphite ([2a0a:ef40:90a:9600:de8b:28ff:fe7c:941c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f686sm374029365e9.3.2026.01.12.15.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:49:12 -0800 (PST)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libsepol: policydb_read(): use a static string for policydb_str
Date: Mon, 12 Jan 2026 23:48:40 +0000
Message-ID: <20260112234839.13732-2-nvraxn@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=nvraxn@gmail.com; h=from:subject; bh=7c2pDMQ/TSxfUFhLiMVWwWCTqlcAYrXWIZno8jMCdTk=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhszUjvDCCKZHWmr6O7Q2PqssPXMl5Dqn8f4/FpN7vXxK3 u4S+6HSsZGFQZiTwVJMkWX/PrYbJU/n/j765HUHzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn aKgDZDJwcQrAVDu3M9YHHJXrmxbjJPDuafyy+x8ULO6WmMk73oqJXVEXNmXW810m8Wxqsu6J+tO 6MoOUspeqHmOsT737wOWExsPZWu+m9KQuW//4TmTB74z1Ey83u0zR3j8l0cfwkOiJbckal430zr FbmX7hAwA=
X-Developer-Key: i=nvraxn@gmail.com; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

We know the maximum possible size of policydb_str at compile time; it's
POLICYDB_STRING_MAX_LENGTH + 1 (with + 1 accounting for the null term).
As POLICYDB_STRING_MAX_LENGTH is trivially small, make it a static str,
avoiding an extra allocation.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsepol/src/policydb.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6aaa18f2..2b0e32f7 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4192,7 +4192,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	unsigned int i, j, r_policyvers;
 	uint32_t buf[5], nprim;
 	size_t len, nel;
-	char *policydb_str;
+	static char policydb_str[POLICYDB_STRING_MAX_LENGTH + 1];
 	const struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
@@ -4222,16 +4222,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		return POLICYDB_ERROR;
 	}
 
-	policydb_str = malloc(len + 1);
-	if (!policydb_str) {
-		ERR(fp->handle, "unable to allocate memory for policydb "
-		    "string of length %zu", len);
-		return POLICYDB_ERROR;
-	}
 	rc = next_entry(policydb_str, fp, len);
 	if (rc < 0) {
 		ERR(fp->handle, "truncated policydb string identifier");
-		free(policydb_str);
 		return POLICYDB_ERROR;
 	}
 	policydb_str[len] = 0;
@@ -4248,22 +4241,16 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (i == POLICYDB_TARGET_SZ) {
 			ERR(fp->handle, "cannot find a valid target for policy "
 				"string %s", policydb_str);
-			free(policydb_str);
 			return POLICYDB_ERROR;
 		}
 	} else {
 		if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
 			ERR(fp->handle, "invalid string identifier %s",
 				policydb_str);
-			free(policydb_str);
 			return POLICYDB_ERROR;
 		}
 	}
 
-	/* Done with policydb_str. */
-	free(policydb_str);
-	policydb_str = NULL;
-
 	/* Read the version, config, and table sizes (and policy type if it's a module). */
 	if (policy_type == POLICY_KERN)
 		nel = 4;
-- 
2.52.0

