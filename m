Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0F24C68B;
	Tue, 10 Jun 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576206; cv=none; b=C+U8AY6tWppSrVAidRL9uHGJM/YUZpW2cHdwSwiCZd1OmkuM/mV7rd/7mB6EvsQsHvdd3KfKZm3FkoTqAg0WbcbSH74dnaPz/3NhbTRgKfF9jqABQRNNUAbmsYVFq5mBTwYDAnXS3gUpCfr/7LIhViKaIon3eSSgqI4WpbG9v4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576206; c=relaxed/simple;
	bh=dmlC9vCx/cjd8t180gK3iH72DBeKN08btiG3Lz/Uev8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeCt3nqDLPlgmrC2wKeY7VDjAtk0RzDLlNGJiGBGwvjTSTD7QfDAMLa6v15KuGgvt7xJ3V9veyJ1MFAHKnH4DIemWg444rrNoB7eKJOdlkVTm3DTxZWxLtpAOpXWtUAcijwunx4Gm3nQ63oPP6rYAl5qni7LoBMI+HVLIz9KJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtALLtsJ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtALLtsJ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7cadd46ea9aso832439885a.1;
        Tue, 10 Jun 2025 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576203; x=1750181003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JEjxGOq/Zd4Bd7XW8vuItSiK8Ht5QKss+KyyUpNftY=;
        b=gtALLtsJkSTm9nFhnAR5ugxPXeIt97slnlQ3/H9+tl9qQp4jzqasR4ciWDTrCv8ArX
         waqmt/wqGwdsuX5/FkJf3NxslwyiHVy/xuJjBA0SPQUMtg21Zelky+7trEZDYGpMvnox
         hD1g/gu2H88UcE2AOpQqUQr82+MhouhnhXXOZxdmrb60RX3iJEs7Rvt2poH3qNyl5tf4
         HfeImNakMMedCHS6CrdiI3AWmPGKP/Q0gyjE9CX+VDGlilSBHr73TXSQj3IeOjamV6JL
         Ttx6NlzSDk2dWbsAjyxCXYjWDO8WQWSgRJNz5OwgGDt+9ljH1Is1Hg8cnN2/ciJd/P67
         Ws5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576203; x=1750181003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JEjxGOq/Zd4Bd7XW8vuItSiK8Ht5QKss+KyyUpNftY=;
        b=hb9JoYg/dJXrPR0zzWljmOAXvq3VjyScCbq1Hh+Adhq1mZ+3HhEwoRn5DbNRmSUXt9
         ZYNrD/6g9yu2WxuaNtuH3t8ftnMGob3rHN86rNhd9RDPN8slx9nx2VhUunHjCkg1d38z
         4hD9HKQ2Bo5s0HM+s4Sk93tGl5LGmjf6OfIGl80/2asZ0tuf2cQ35KL5JQfWbaMftD/u
         arP6SnMpg7GJGTNTR7tZ12YXrrA661nxwZAVzJqOJR5y16ajxGKTuMJDFgKVeGGQRfhE
         n11ugTflQMHbs8O+9T430qQYSSBCw6dvPtn92DwE5Y8aX1x20OEWlssg0v86FXOsVUhU
         BR6A==
X-Forwarded-Encrypted: i=1; AJvYcCUdh+TLEAn9mecqYc2hcL+0ZMRgxXyceRiahT1hCPI69m9IszIpzKqs02tuc6mKr557RepFfn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWoznKbX1WQYFNbF3ifBKxPhaDFFbT3+Ye6G7Fs+p2j7Wm0uW
	O2FHxhKsjyLmYVk7dqJ/MbNcWo5kqI82ToLvn18N5TwtjRe3lknqAzwvxdmNKA==
X-Gm-Gg: ASbGncu2oQvMPyD3QrHXB86aVsE5H0nBckDAhVccbE4r2yeRx9+T85uvNkCmxTkHAJc
	u/60rsfMVkJgYoYS/g9vAIGjqYFaoTQSV7kBan/L4+p7+wZMH6+RTd9wsk+SxqgJlytO/vnkkpt
	fVAYFSKzQpv8Vv1zMeTvLNpZAorjnUxoo824SNkiWs7OX1Iar5i5rgYCpu0zHsANVqVJqxQm1ld
	gexkertyz9yliDyzFvsyVOJNhqIegrE+RsRSvbKBfzhYq4hrCWvKPdk0EFnJL7a60Ti6L+PcDeL
	vPmesq+S0+lWlP5sGOspXWjfAFz/t6qgtA73z2FdoKaTjhDGxd4ELqMFLAx8qSKky282mxD/QRD
	nLjMVAlIce4ksgEkedDw8Wa+u6YTCWe6jFs+vb9dzayX3E48vhdmCrJW5T56LbNTosQ==
X-Google-Smtp-Source: AGHT+IHZrLgpPpfwBbbF9MX4fOYRpjpQ3r8tm5oqicMlYL0Rl0uSJD/OKdhGYOsNsv2w1GgOGjmLiQ==
X-Received: by 2002:a05:620a:40ca:b0:7d0:98fc:83f9 with SMTP id af79cd13be357-7d3a87e5e36mr40473885a.18.1749576203048;
        Tue, 10 Jun 2025 10:23:23 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 27/42] selinux: introduce task_obj_perm()
Date: Tue, 10 Jun 2025 13:21:58 -0400
Message-ID: <20250610172226.1470741-28-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce task_obj_perm() for namespace-aware permission checking
between two tasks using the objective SID for both tasks and
without assuming that either task is current.

Convert the permission checks of this form in the hook functions
to use this new helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 56 ++++++++++++++++++++++++++++++++++
 security/selinux/hooks.c       |  5 ++-
 security/selinux/include/avc.h |  3 ++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9385dcd84eee..07cd1b037ed1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1291,6 +1291,62 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 	return 0;
 }
 
+static const struct task_security_struct *task_security(
+	const struct task_struct *p)
+{
+	const struct task_security_struct *tsec;
+
+	tsec = selinux_cred(__task_cred(p));
+	while (tsec->state != current_selinux_state && tsec->parent_cred)
+		tsec = selinux_cred(tsec->parent_cred);
+	if (tsec->state != current_selinux_state)
+		return NULL;
+	return tsec;
+}
+
+int task_obj_has_perm(const struct task_struct *s,
+		      const struct task_struct *t,
+		      u16 tclass, u32 requested,
+		      struct common_audit_data *ad)
+{
+	const struct cred *cred;
+	const struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	u32 tsid;
+	int rc;
+
+	state = current_selinux_state;
+	rcu_read_lock();
+	tsec = task_security(s);
+	if (tsec)
+		ssid = tsec->sid;
+	else
+		ssid = SECINITSID_UNLABELED;
+	rcu_read_unlock();
+
+	do {
+		tsid = task_sid_obj_for_state(t, state);
+
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		cred = tsec->parent_cred;
+		if (!cred)
+			break;
+
+		rcu_read_lock();
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+		rcu_read_unlock();
+	} while (cred);
+
+	return 0;
+}
+
+
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
 			    struct common_audit_data *ad)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4c2f7491803b..44730629c772 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2126,9 +2126,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return avc_has_perm(current_selinux_state,
-			    task_sid_obj(parent), task_sid_obj(current),
-			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
+	return task_obj_has_perm(parent, current, SECCLASS_PROCESS,
+				 PROCESS__PTRACE, NULL);
 }
 
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 1631f6cdbefd..2c2268249b44 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -173,6 +173,9 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 			u16 tclass, u32 requested,
 			struct common_audit_data *ad);
 
+int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
+		      u16 tclass, u32 requested, struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.49.0

