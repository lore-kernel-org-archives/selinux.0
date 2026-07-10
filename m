Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126A386C3F
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711822; cv=none; b=NKdiNrgoKhZolSyX/QSOQXAbHiCZ6Rh5ANyCf6HPqOMlv0bGRj3BF2b3A/7p2ueMcjUZ9CSSNz5E3sFL7zuezD+jZUo3iSv7yru4fjSrNXKfqmKnUtzldZie1O4BBw4WjN0N4keg+mLNmMMzlI+OsaOneOS1mbEri3d00ZgodDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711822; c=relaxed/simple;
	bh=/6JPUtlJ0PVfX0K9q9JnUdGb7CFCZxOUINfuheUqIuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uj0ApVDPElWrWPk+De/lnKV8ixYJsNh7nRaSjNFgAvSDtFgSYQagEueKBuVq+99b2JTtqUQB/lTFhPl6DTD64EonzK+VDT67Xxq6MVfpdc16YUy50xyqHs9cHGJg2Y1aAd7zNZUG2vmdxqxsKfkxNNQumbxLOrHO4YUeMb2KCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYJSaFEI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYJSaFEI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cad8076b01so15882995ad.2
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783711819; x=1784316619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yicEEEkdqigTSoeiVxdn+geLXghvTP+Vdc5qiRKDVXc=;
        b=SYJSaFEIW0LtkHlO80L/IcRX6BjjmBQSY0ykKw3+x9lcGB4EuNeVYQIp3r+UVUWYJh
         sBAZqx8vByIjgGSkRqx++83cWC8c8Wyg8Mq3/dpEP1m3Lu1rfGwFQua3mhqhYna1yP1Z
         Im385OvbHlfkgCDIlZ9OoYzRW+iOKb8e5uWLFbvpD7lOENl0WHWEj7x6F3UIXNouJMNJ
         0OJMnGvyGwXOjnzlAB3RtnxKYtedB1m/e0E5hUddDdUpJZMtddhxJyjEM5ahqUrmHJae
         obLdG/6/2bE0IPwZzXoN3x2cNuZPuF3bVfYVeAPUxvT9px1Jzbr9y1bfOsIilBU7b6AB
         aQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711819; x=1784316619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yicEEEkdqigTSoeiVxdn+geLXghvTP+Vdc5qiRKDVXc=;
        b=c3/G+eXoFLK2E4kr6GCEFTXH7RXNNUcCMkPqjJqPwyU2BVGi5u9auxf/xtWuYmTwe9
         Y0T1XgZ/hgsn3v401Yc22X9tecBbxyziT1VyjvhHzNpcI/75d0WrFIx53q3153AJ3K2r
         9d4QSNEkL+NJNRLCmgVAA6J6B204p/q1t48gMUjha+agg/aDhFNY4C2aQwoHjoix6qyp
         N/Shifnz+mEw32rGOLme+cRj2MMgmAKJ76S2BySIkWFqr7QdqAFYSh9VRMiKCaYf2lwW
         93BOq7ikVgV/MdLwtlMBLtppUxgd82H1gXM4vnvBhZgOR6Vp6nF767OdDUHXFEf9vZGV
         ZCXg==
X-Gm-Message-State: AOJu0YwJ63TJ7o/283lBsqm1xPEh71zZZkZE0CMY2YcH+BAPESAIMMEf
	G0t42xczI0HvTGfWyq7M9yjGhn8ZoamyOgMaXcpye98i+YLm/lkxpgKJvQ6/E8br
X-Gm-Gg: AfdE7cm96SUOjZiQSwHI60ay4pOkZNgBfVMNONK+EgO2dRRRK1bPhllEwHgKrtnnCm1
	JF0kZa9cTgxVR89YVEM+eBI9YZVFDgPGQJxcN4k90+M6khUhvdPUiwXUrU8SXeR/2qJu3aBKZpR
	HFonIdbE3GqYeOm/28a3/XDO6FJjmnZ6TwyikfzPvmtpiQaDaF9NtMgzjhPsHJyaKXnqVgu0CC7
	OM9TugqncMz+s8EKgkWVEiPBAkBbFbalS5koNI9i7mU2vngblpoRTvbUjCimSkfZdhRkGZZD5YT
	r13WWnvQmzfab9yyLkSyVHWj7KbN2u0wVVUye+zwEMlzGcqyfuJYd7LGqVstp/VMYDtklcAGBOU
	IduGuRVDXqkOdUmzfvWJYIZoQKhgIBcoyaOk8ckxOnsoOWmWuIVQ2CPMTuzKyTu7+YyPcp8hS40
	u6Hv8QzXpTE0nxpIo5xPYG/xoXlv5W2sfuBUOT1600tceSJjrqw8WbhUvZdFVpTd2KydrqZDDZA
	K5N/ufUzH240pCg/M5mS0oeckUn
X-Received: by 2002:a05:6a20:a11b:b0:3bf:6c05:ad with SMTP id adf61e73a8af0-3c110e3c0b4mr357479637.60.1783711818655;
        Fri, 10 Jul 2026 12:30:18 -0700 (PDT)
Received: from shafi-Zenbook-Flip-UP3404VA-UP3404VA.ucsb.edu (128-111-180-95.vpn.ucsb.edu. [128.111.180.95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c9a1sm52413887c88.2.2026.07.10.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:30:17 -0700 (PDT)
From: shafiuzzaman-md <md.shafiuzzaman.hira@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	coms-vlab@ucsb.edu,
	Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
Subject: [PATCH] checkpolicy: fix double free of fstype in define_genfs_context_helper
Date: Fri, 10 Jul 2026 12:29:53 -0700
Message-ID: <20260710192953.2083527-1-md.shafiuzzaman.hira@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>

When parsing a new filesystem type, define_genfs_context_helper() transfers
ownership of fstype into a genfs struct linked into the policydb's genfs
list, but does not clear the local fstype. A later goto fail then frees it,
leaving a dangling pointer that policydb_destroy() frees again.

Clear fstype after the ownership transfer, mirroring the else branch.

Reported-by: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
Signed-off-by: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
---
 checkpolicy/policy_define.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 982de3f..3015782 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -6054,6 +6054,8 @@ static int define_genfs_context_helper(char *fstype, int has_type)
 			return -1;
 		}
 		newgenfs->fstype = fstype;
+		/* ownership transferred into the genfs list; do not free on error */
+		fstype = NULL;
 		newgenfs->next = genfs;
 		if (genfs_p)
 			genfs_p->next = newgenfs;
-- 
2.54.0

