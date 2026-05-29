Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013873E959C
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068982; cv=none; b=lUIKP/7r5VcwbLccqu0K87dFDHiMDS/yMli7zaDmNQXrGn00OQRUAwY2KF9c+FI7qMKvyFsJv/SQsWU4tpCKXhrivTwPrUjx+exkQ5nHqJF83LbZE7l2RWxE72Vv9mJknlaQW7pgxBdkGo+Abd/4c4KNCD2FkALS37WknNtUQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068982; c=relaxed/simple;
	bh=vtX8yvwUGvmPqf2n+lJX8UBukNXHLC1na+qxSNgZNe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4nIyhCPMayMtpZddURZpaJcF0jGSqc9kBNyVTTpCIMMiIgfx66SxXqEaF5l1+5vOwd4POaDOWOR4KPKdIF4a91qq/NphZvH+qIj9CEgzK1hdknzOrO93Zhzo1Rc8vu8irBXwZ/i9PjFwVHza0XkkelkD6/JEsqao66UDPD/Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PmOk9K8u; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PmOk9K8u"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d634956fso88584691cf.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780068980; x=1780673780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua3iFl+aW3nY80QMN2cTHnaOlmLzFLY6md8vRMpVfL0=;
        b=PmOk9K8ulcNW81FQBzM1ScVInR4CkXOw5A8YpkcuZXcHhxwlm4MZe6pTDmlSZpLehT
         XpwKe36Fgbay73JFb39Bpyun4WqCWOAMCnz+r1A84zxuM7E64QhSXon9Z2sr8xaRLCpX
         qOWk8TCo51Ps80zcIWKx6HGnALn5U1HPIlrCGF2eSkpqCUtVZzm1jGDbZ2qHghfrksy1
         7srq8EcAPgi+6WejARqD/rBKZaFkmXbQFpBM66Lv8yTzWoNS4RJ/seRFAxDS1AIE1Jbl
         0xWdTP+42rT6YVcnSJwjLXt7jRxYw2AgExo23RxUKHP5nAeLh+SwHUz1rYpMKQVRsr/m
         Y1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068980; x=1780673780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua3iFl+aW3nY80QMN2cTHnaOlmLzFLY6md8vRMpVfL0=;
        b=flO/a1sVAC+4XbfblecyBFV8qjT+HRKFLOTcgfd95u0fBPEORP5gQnQ5EXw8zdMA0e
         L90xPoJQ697l1ld4uMtQQlo3aeUQBGk96uH66QmV+cfqB38zTTQHAEiJlbtceU4d7QOk
         zERssfIp9SlrPRNb9g6IjKEGoF49nyG08wTMD6pgya4psWlV/HzTBj8SUEE279Lqezr/
         3xxJTZScb0VLi44Hf5l3T+JEG23ikk8dVZS7Oa/ZgqGWgtw9jamy66vG0F2BqVG9OK5b
         v7d3pPkS8/7Tj6CydlseDH9hatJQBcuwKew+5gzjj5LgWKDN06SIx5EqmwENq8PpLmty
         cWhA==
X-Gm-Message-State: AOJu0YwrsDOVgIrvvdeuABOwKkgcOLYLNWl0IH9HM4cdUjyXAUrE797t
	0hhmnFAmGGsLSZHpvUu8hQNohKEPb3byX558e0lq/QYAmIAvMiD/842nsMbFPUVUqUIXIo6DUsH
	kOuSFRzoa
X-Gm-Gg: Acq92OGqYxSzxGWwKX0O9Qlderu4cUrew/VsVthnSWRn0WPj1fQhP3nyUgUrqIh4aq6
	8QOci831lBrmx1dMeZGIamNPZLUWh9KZwQLaHhxtpk+EbK978uf/Rw49XdWVW9U8T48DCKvdBzl
	62mRbsvQE3Ye4ec0J2FbheLprsWxMJQb8pCYmhP+9sqoBl7Gb8DrKrXDlTCQf/JV+eSVbhOBOPP
	gwmnEu+YLTysXoI5wH/zJGU5rZ9b7dpfPfq7dxkHOPGO/HqPisuTFE+pIYxjZTtGnvTBFVCRFf1
	K49p0X4uER+eQvhcp5wnedfkYC8jYSEc70EaG7Ai12yRHoc/40UI72S/5n3jkVh9TeSCgLbdzww
	ZguyDvNgz0VpbEjpf1kcDo0yUIWTjF3vHawCJMINgQdkX80poO6l2b43VN6WuhTNJjFbrLl8/u7
	KxXh1VZE7y3xbgR45rk4/CDSUWY+OCwwbIMN5nNqDvuiqzIqIyjlebVHrxbOppfFtzoT3Xc6Cmc
	F/FQTI=
X-Received: by 2002:a05:620a:270d:b0:911:f0ff:3d20 with SMTP id af79cd13be357-9153dc69679mr17286885a.47.1780068979841;
        Fri, 29 May 2026 08:36:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244ad25sm222065085a.3.2026.05.29.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:36:19 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] selinux: revert use of __getname() in selinux_genfs_get_sid()
Date: Fri, 29 May 2026 11:36:08 -0400
Message-ID: <20260529153608.30853-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=paul@paul-moore.com; h=from:subject; bh=vtX8yvwUGvmPqf2n+lJX8UBukNXHLC1na+qxSNgZNe0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqGbJofmOXflPY31Bz8iiBVUElGCo1beGoJOFSu G1y21SMNfyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCahmyaAAKCRDqIPLalzeJ c+jxD/966lJgKWUMMgDYw9di9qHA6PSOCUF5bWNvw0Q2s2udEUGuTuEWXO+DVWk8pUI8vg5rR14 xQu8Q+GpPLexILm7vJNnQMB60l+SU53WWC/L9HamOlx7sdpNssCLUKa3GuJFo7rp9JgxrnDW7OB /GJNLUWedmc8h7trmfUXqNW192Ve9pbp02iUTd9NTXClFfPBdfqj2APu014o7UZJevC+Yc1+8+s 2OaxSzXi4LF05iHF3U0x+Vp9xdAQKcuEhs4CebouNI7AHR8qWgINpBmLby0eakpe6hRumyk3LeR PdO5YzWdnGZLiDez15ur3ve+3wCvde0ho0sXWTAh5u4Q2xOF69YHMXNCjOa4yDTaJYlTTfNbZz6 tZNRYByZgzVzPLdLv+TDKuXFr31BzzuLWXBccbY+dftqPjOnnV9px3loDLqJxSfERc779NknqLt 2D9Q4e7SQh6GD2nTxpwBN0/+7QLE0vrto4HWbhOjxUGndzlz3jZo1aLtwJe4O2sk082PvnYiYgh wVWs6M2Po9E68IH8Ior6Z8BXLUDKpEtDOn9GDGCeQyaE1HYUohTRtDpjzT40uVN9NQWMi+YZ8f1 FpwDTFqNfXihBCojss6yDQTdA5XBDVWF4zaZgt71pbI8IN71dSQhuzxtv8/bml2hHPZigSqrg+8 fclocBe0yjL+9iw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Revert commit 54067bacb49c ("selinux: hooks: use __getname() to allocate
path buffer") as it improperly assumed that PATH_MAX == PAGE_SIZE
everywhere.  Moving away from __get_free_page() is still a good thing and
will be revisited in the future.

Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 95d0fb20d84e..97801966bf32 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1336,7 +1336,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	struct super_block *sb = dentry->d_sb;
 	char *buffer, *path;
 
-	buffer = __getname();
+	buffer = (char *)__get_free_page(GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -1361,7 +1361,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 			rc = 0;
 		}
 	}
-	__putname(buffer);
+	free_page((unsigned long)buffer);
 	return rc;
 }
 
-- 
2.54.0

