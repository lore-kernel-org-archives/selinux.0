Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE01EA6F
	for <selinux@vger.kernel.org>; Thu, 19 Sep 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761475; cv=none; b=PWY2KwbAoBA36pxeDyPTyKDoDUFuWS9WuwY2ribeEOAkWr+GzwrWlksGn+Fgl4lmAGvpjBSZHuJFWYSUaIMCn7JKJGta3W6UQzq880OcmAbjaDRzIfPASLzlWEuLLpI18ZvmIndRhwPgVMBzcHrW41hequlvFd8arWZg/6pW/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761475; c=relaxed/simple;
	bh=Kidi4PPcyhIsESsDEVjJ2wCDVwyhlo2TZo13+znU/vk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c0fIl+JsT9hck/4INzIIhbYmg+QdDhhCWCFc/WDS22N1raNcnVlm/xS8Qa2lGh5pMFvH6b/aQpmpTWLnAlf89ihHzMXSpw/Di26sS3qLRd+ZeNxMdIOzhM2ADqIaNChn31LV6NcjIvO8wGEKrbap9wVEbspgB+6ezaMH5hhR7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VNeJeDui; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VNeJeDui"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso1043041f8f.1
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2024 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726761471; x=1727366271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh2mxs0a2Eedk0d8fLD2DnCcosaQ59+xSoMFqy8z+ms=;
        b=VNeJeDuiKcveuqezpmFfh35olz0qSlvplXptM++n3t5GWoKwj6D9Ul2Q+xuf1qoMaw
         fA6nwXy46xeBKAmQCKaSe4mjIpveT0sA2se3tN0DjFTocN+J+s2SE4+Footisj+0x7P4
         YWcI+ADbSQutZiirSvNonnPSzicw2Q3jxtwkb9dB4CsW8AYFgRb9jQjPDrETriMg1j6b
         FvXy81zmatzMDKoeL/Lc5O2szibOu4pfhS62qOtTSzrXsMoy8O6uujC3TJ/QpOdPqIS6
         cjv1vYNaon2kYe3Ndw5jgFCG94wgc15I4ld94s3NrXeUjIQEczhZqiJp0sL1U9r1E5FO
         HO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761471; x=1727366271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh2mxs0a2Eedk0d8fLD2DnCcosaQ59+xSoMFqy8z+ms=;
        b=gZHfcuQ3XtTpjIl2TLzlgshQ+L+3qxUFa5ahrAu3xD3UyENNzJEakk75BfGNOl7ILv
         1lYXGeHgA7ofMzJDgpdmXktTsVjz4UL+Rlat3K5jWZRoxkBiOcaJ14FUcjFMnAZQVHPz
         EPSNgvv3dkel4QkoRRM1NyNqSwmeqVBlbWgjHmKrsIMAymQuPX1Je45swG8tDNVzhYTd
         LwHRshmrQ/Jzt2FNXJ+V0atU8cVtRgx+9yQ5QzrlRIsUuFM7wq+ayFZqc2YyKd/sgF3A
         NaxOMU4hXXtD9ghChSrR6GwVJMGQWRDJLPJTNT5bvJW194TPsHWYXyLKvP5p8nBidD8b
         yDcg==
X-Forwarded-Encrypted: i=1; AJvYcCV9O/bPSp/zpd2uubWsb/x2LjyYeb08+iawQFHCY0XRrWxHJLLayaGUP06Opekzb7sH4AEKiP1J@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMps68jgc2q0InqA96j+ofmdXkWzkO4cyrL8dzq9NHpcYKnpE
	ksfY4fy9YMJZswotwC3Uxve+gUeu4zN1WqwxR0YkIa3t1mKXfjF7PB7PXZElFnMiTpRf+IEfZfj
	ebA==
X-Google-Smtp-Source: AGHT+IHDxiaLHmLtW+GuNB/xzHHPYPe0Q9bJaQRXHyxF26LgzRt7QxN8gJoBQRXCc69o1D2qp35/XQ==
X-Received: by 2002:a05:6000:184f:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-378d61e2ad1mr21074729f8f.24.1726761471503;
        Thu, 19 Sep 2024 08:57:51 -0700 (PDT)
Received: from localhost ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b389asm729311866b.122.2024.09.19.08.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 08:57:51 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	casey@schaufler-ca.com
Subject: [PATCH] selinux,smack: properly reference the LSM blob in security_watch_key()
Date: Thu, 19 Sep 2024 11:57:41 -0400
Message-ID: <20240919155740.29539-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2365; i=paul@paul-moore.com; h=from:subject; bh=Kidi4PPcyhIsESsDEVjJ2wCDVwyhlo2TZo13+znU/vk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBm7En0tiGoDCOg+i13BjWLXIQ3I8DyGH6XfyXze Lf9uEtDn4+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZuxJ9AAKCRDqIPLalzeJ c+efEACo6LUX7/aFzj02g69dQDCQD27+co0900p4JiN9gSfFPJMgrUdm2JIZK91cYiOPdB6Dvgt oCOBabNqJL9AeLlAZ6BntYHo6Gw5vPsrtc4pquHLlJg/WbD5K6OUfRTJPYLvQWUoWl9yytoCxkw NHy6SU93QvTOw1CW7WjjEckG4HBnpweKYQpVExTjpyTOYcV0pEcUWcEYIy86vx3pK3NwZ6zXaa+ bSt1RrtaroxaKdwldOGIn5pIzmG8PIpV2ireXjlVJ9XEMgQ2RHt/Imp0hUd6YONKGj6JmRn5fry yVEWDgcY9BdyZ8WK5mt4XJUFGEkFZFgv8uvjDHPrCyi8Ne6xCB2Zhcaue5s1zBwbbamUhp/NcrV v9+iFe+O7Y9tO4qOsphXA7CqfEcDvRcqJMCH6aXN7IP7Geu8KaejkzHr78H1cVgdzORbf9XYsFo rDwd/UZ3H/6Ki9oI+ZNj6t/kt6NorlNptDu4x8oU3S5PEJumZ+YXQS+5M5SO8gxsDFZ8cpqxMDA EosuMKt4weIP05Q6Dddaf0WfSojTjhKz+k1VTX5uccKz+F+Vi27Dxb+HneneQW9wR85B0Jenrds ULDojZV5DzvbdjYJe3DuViNf1IA7gcUq17/BXf36BFG+0lRbXEqbwlxbRJWqveFYqOvAOcYBaI9 BiVgngAnx0iW0ig==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Unfortunately when we migrated the lifecycle management of the key LSM
blob to the LSM framework we forgot to convert the security_watch_key()
callbacks for SELinux and Smack.  This patch corrects this by making use
of the selinux_key() and smack_key() helper functions respectively.

This patch also removes some input checking in the Smack callback as it
is no longer needed.

Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security blob")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c | 13 +++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 81fbfa5b80d4..67baa487cf7a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6720,7 +6720,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_KEY_NOTIFICATIONS
 static int selinux_watch_key(struct key *key)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = selinux_key(key);
 	u32 sid = current_sid();
 
 	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, KEY__VIEW, NULL);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index da0c2bffbd08..563fb404f659 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4629,16 +4629,9 @@ static int smack_watch_key(struct key *key)
 {
 	struct smk_audit_info ad;
 	struct smack_known *tkp = smk_of_current();
+	struct smack_known **blob = smack_key(key);
 	int rc;
 
-	if (key == NULL)
-		return -EINVAL;
-	/*
-	 * If the key hasn't been initialized give it access so that
-	 * it may do so.
-	 */
-	if (key->security == NULL)
-		return 0;
 	/*
 	 * This should not occur
 	 */
@@ -4653,8 +4646,8 @@ static int smack_watch_key(struct key *key)
 	ad.a.u.key_struct.key = key->serial;
 	ad.a.u.key_struct.key_desc = key->description;
 #endif
-	rc = smk_access(tkp, key->security, MAY_READ, &ad);
-	rc = smk_bu_note("key watch", tkp, key->security, MAY_READ, rc);
+	rc = smk_access(tkp, *blob, MAY_READ, &ad);
+	rc = smk_bu_note("key watch", tkp, *blob, MAY_READ, rc);
 	return rc;
 }
 #endif /* CONFIG_KEY_NOTIFICATIONS */
-- 
2.46.1

