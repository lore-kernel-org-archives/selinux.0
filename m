Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57F2ECEA6;
	Tue, 17 Jun 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169208; cv=none; b=k5SIVR8rFdRz2944O84xI7Vx2ExBRhR/FKMTwafjTWCTNOn13pM81Hh+DqOKJG+EpJGnQu5+qGLReatJaEIF1RDxR1jDznqqadwwF+lDvRungo8hW5E0tgCf/YqJxXBjhBGQCWcdSjZ4hE2rT2td9hTu9oq+5njPFIofbi8Xh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169208; c=relaxed/simple;
	bh=MjKpAKZo5FjX7PaT+QemFCIUT9Y9dnutKzpHDdj24Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HN9/1avYa3fyaP/jcuYweH7VI8NUhOYOSmfK0KCQ/Tmc+jJ2NbKab6rB0wiD9nMk1R068Tp20fa3JOeRj4QHp9WlYbCGjhzmC4J0tJqlVO39gJKEbHREuYcHg5KokcvazcVlGoYtiT8XbJUO8JEHa00DPX7vCGOzJoZ7GSfdyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jydj6OCG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jydj6OCG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d094d1fd7cso826992885a.3;
        Tue, 17 Jun 2025 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169206; x=1750774006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jOr8p7GpT+fo1u8WRYAqzyLQU5YxkegLOqOZEkQe4o=;
        b=Jydj6OCGLgapWMt2JbOcOfPQp/2vuyq53CMP3nDxs8g0LZQvL+58EW9DWbhYJa2c35
         F8uXyCuVyV6/DE3XN75DK50g7wmslwj1DiB0xxKW4Ga9CtITdRvSrKR/npwKutwG6ysi
         /UYLdfiw+1gU5JXW/5/TPtYS4/zUTMXt6M405F4siZBxSk8biA5GUJ/AeVRC0ZY36FiH
         NR02uBu5Wmw7jTlEUIWB/wxhd3r2usT7hmHRGyHRTf/aU1l4brjXfvfQnkxm0ObqHxCj
         aE4nyzoXVr4XTfunlZhwepj4BtNKG+toPNPVg1mgUjKrEkfwaBLkwblCNcejItkOmfME
         Xa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169206; x=1750774006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jOr8p7GpT+fo1u8WRYAqzyLQU5YxkegLOqOZEkQe4o=;
        b=jdjzD5jogLO/GX6rCA+RlhV+OUXnwMJReJ8TnYX7+9t22qjYJLrCAzkewglKjpz954
         iXZUfa7xHqkigOpkVT/tWazBKxzWWd9GqmvKD7eMBjvTHfUUsWxuN3ABlsgZSlsMtmNP
         C+SnO6NMbyWwSV6gvqkTGrYZv0uwCInteFnsUzI6Qv7tiQmreuHBbmJznRIuYxpPKLjG
         rOVC3R5ltWJIrZtbPJaF0BoiGUXT0rpI4YZvJJCi/QZ519e7j+Uih41XVDW6y2VjksmJ
         ENO5YBnR2geGGTb1bs8QodpsCI9gKCPt8bwVKaBFqIDgF6n8M+xoEdGY8OBIX7iILl+L
         QFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRsqEI+BY6GfAjhlbawjk6siqv61HKqbU8KCQj18qcaYK8EIqJn+AMtqG2/Z5NOwxGVrRxxbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPg+278O6bNuz4dapeFGaNX9HNQNKD7qAL++d3+MbVbdpk3xIF
	b54hmEq2zE9f1DQYABZl+Gkti4P/lDfWoMSUGZGokKCCauzKyDkgCPb+dTcvmQ==
X-Gm-Gg: ASbGnctVZblZ3NYfs8RFLM+TzT9QLYQ7RSCCDvQ0HajTLIjvCwqYk6eFUvLxmg3FEmS
	wG2AZWDvfmsNr9NMoPn5phE2Dr5O/ay4kgyh00GJ3TIU/araE+zgHM/VYseLZvcnhmSX+Y1Q5Yd
	Uvu6oTZPxeNhMj1qhLstWox654HOFN7+SYyzlwL8Dt2B6Kuy6wk35UowxFf9rdi/JuFgdUjXe2I
	H/1l2Zcri2yZg9YN3elzA6WRfoc+WIPhXwB8ta9G5mvyBRTKXR8SzUKMBUQmXd5f+/dCc5MWVzu
	bTc6RWEUkYZOZDqSqYBjD2PrZA8ptyX9BbvpjLMqzgK9m7Fk7X7ApgeOiKxu0OGyDDT8OBtWi1X
	K1DBkoMVbjwTeitSQTJMKwWpm+Njw84X40VlLu0VGBz8juJ9X2FQazwA3aNkqo4eAwL5Z4jlSUv
	HD
X-Google-Smtp-Source: AGHT+IHIwbdv6Iqau9nyE6em0fyX5Wp4o5FKOi08H9x/da7OM9uoYfQ+08hJ/MugBE7U011VCTfsbA==
X-Received: by 2002:a05:620a:414a:b0:7d0:97fd:8861 with SMTP id af79cd13be357-7d3c6d00ce1mr2065039885a.49.1750169205486;
        Tue, 17 Jun 2025 07:06:45 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 32/42] selinux: update cred_tsid_has_perm_noaudit() to return the combined avd
Date: Tue, 17 Jun 2025 10:05:19 -0400
Message-ID: <20250617140531.2036-33-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cred_tsid_has_perm_noaudit() currently just returns the last computed
av_decision (avd) structure, which in the case of multiple SELinux
namespaces will only contain the decisions from the init SELinux
namespace. Generally this has no effect since a permission denial
by any namespace will cause an immediate error return with -EACCES,
but in the case where permission is allowed and the caller caches
the avd itself for later reuse, it could lead to the caller
incorrectly only using the cached decisions from the init namespace.
Change cred_tsid_has_perm_noaudit() to combine the results from any
avc_has_perm_noaudit() calls to produce the final avd that is returned
to the caller to avoid this problem. The combining logic varies
for different fields of the avd, e.g. intersection for allowed
and flags (per-domain permissive), union for auditallow and auditdeny,
and the seqno is always set from the current namespace only.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 2b567fe2b52b..61716e17538d 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1558,28 +1558,38 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 {
 	struct task_security_struct *tsec;
 	struct selinux_state *state;
+	struct av_decision tmp_avd;
 	u32 ssid;
 	int rc;
 
-	do {
+	tsec = selinux_cred(cred);
+	ssid = tsec->sid;
+	state = tsec->state;
+
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass,
+				requested, 0, avd);
+	if (rc)
+		return rc;
+
+	cred = tsec->parent_cred;
+	while (cred) {
 		tsec = selinux_cred(cred);
 		ssid = tsec->sid;
 		state = tsec->state;
 
-		/*
-		 * TODO Do we need to use a tmp avd for each
-		 * avc_has_perm_noaudit() call and intersect/union
-		 * the sets as appropriate as we go? Or can we
-		 * simply use the last result since we generally
-		 * only care when there is a denial?
-		 */
 		rc = avc_has_perm_noaudit(state, ssid, tsid, tclass,
-					  requested, 0, avd);
+					  requested, 0, &tmp_avd);
+
+		avd->allowed &= tmp_avd.allowed;
+		avd->auditallow |= tmp_avd.auditallow;
+		avd->auditdeny |= tmp_avd.auditdeny;
+		avd->flags &= tmp_avd.flags;
+
 		if (rc)
 			return rc;
 
 		cred = tsec->parent_cred;
-	} while (cred);
+	}
 
 	return 0;
 }
-- 
2.49.0

