Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949F2E972C;
	Tue, 17 Jun 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169185; cv=none; b=k1Gt84hq7DSRbn5S8IUJ+NOsx8gm9rH4kbDTXwLAUajmU/YmV5lSz5i/28GQyhIkt6JSWvlmU8yH58gI//41UzB1pZIxoWblDALcpoRo3oEoDindU5sS8GM/NBeEn99rZ3FHHWOXlRpmMc6k52o7grbqUr7dsW/tns4ovfYEB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169185; c=relaxed/simple;
	bh=izuz55jNu4ZgmiUnswDtuQ+1y8m1i190LxHqmgggGYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYn4qPCyeQnjzgOTLBqMwrRIAOAUwQDSk8RBQuOuyFhEI5yYcI6Vj4kRYmN5wAan9uYVAUafvvXzG5CRH55Rc4SJxFHWIB//TNrfVfk8ZDvj/eyCzuUAuEmFMDql8sxcUO6OBIhE9/01OjYJcgg8ZQ2wbSQf1+fQWCnTUK34db8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxwiuMwd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxwiuMwd"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5b8d13f73so634570185a.0;
        Tue, 17 Jun 2025 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169183; x=1750773983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBme/MlItLgUu1volHIZk4vJAqhDoCryTZitGwn1JwI=;
        b=NxwiuMwdYftP3BQBegKztdbn99jGaKVx1o4sNv+vaBHA2W2Vx0Q6zd4Pmg3gaQN9KG
         ByMyysdgRpulIVH2kKCo+mI1dNuqLIDmAlzfbd7Mpd8ScDNlXxNMXwuIE4pBNBJAdnO5
         wBw1+xD8mmxYbHKuDlrMEk+7CRTkeZr4HPjH+7xT02JM8ENv70QRyDTaOSwP1iShGovW
         RmKm9gAaeUIFUGetzNKVTTfHUasxP0GILwOcWkhf6xbKyHTBWVblwvEmtq6D0IgE9i+W
         yv+WobFTWovrD5OVwB3Jia2g7xfttw+wn8lLWv5XSr6/UHWAJTLm9TCWsM/f8/XTYYLn
         JQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169183; x=1750773983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBme/MlItLgUu1volHIZk4vJAqhDoCryTZitGwn1JwI=;
        b=BOmnqfAKbFmsFkbnFxfZlXnPAUBWtIfGCTQFsUlXPNQ16mGrxkaXyn1aZ/K4y7ie9O
         hSOo6LLHGK6IET4WoM5j262P8OgRt3NmFm6pGqvQozHXImzhuy2JLhreuWesmjB/OM13
         b+eI2EG1zZkJrbhVRPRoTM/bVuIewdTc7BOXGG7v6sK/E7fxAxmFvWDGdQ2Ul8ygcR5s
         VXoNKYM10gnVvqo/qN+jRKvDtgGTwEOwI8GHF6NxlUT1sfoF3gdjP6hgL5Gu9jXPBMdH
         s4hcWWi4J9ITCZCXYihgMEHKZRP5IK1O8+F7d1NlUk4aH6bGss8ziaDQdDtJ3iFscxKx
         7pvg==
X-Forwarded-Encrypted: i=1; AJvYcCUxU1I5hh5Jitbo9X6Cd/Nzk8vMM6x7r0Ektg0yY6WrYteGVcEnJWRKpq2jLnKNlREC6JDdUf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3POmV1oSidoB5kD7VxklDHkxHgJ3RthEZX9o1oma75F7CzJc/
	IzG3LjwUXACJ+fGkvWPRZbpGu/rOMOHMRpSPDhVtKzOlfq91pNbibWwhPpb+Yg==
X-Gm-Gg: ASbGncuGR92YdJ8nny2/xiNNej4Wk6zq4gs0AR+dw59cec9JoyT/DeR3pE22ygBdYvd
	wRKuqpnYkFdt6LQWpo11QJvlPtQz7242unlOIVpfdRW84QaNgio+6DXVYjQvAq0tU9xynDmJ84D
	9q3L/dODDWx6pHWPxY9dDxNckKt4DLBqcJiq1J/mlYSUEZkg632KVDq7Mo04J44LFUDsVU0G6Xe
	0Cm0gjw19JC8gC2h1lxpN++BZtx1QM8qrVUDqlSijp1J+8A4tMXFiaw245Rxt9F87Pkz78wpLlF
	f5LzfLyVgbmEry2VIcPrZEcgD8mC6gkPlffNqGhPPIYM8oo3MFEEbIwzU3pAtyjofoG+TLRaJwu
	0DZ4wPoIjcmBgWbw5feZLNg5jgzeKd7HY0O2nwdaCfP7zH+z3Dr3Q0DAg8Ovd+bgreA==
X-Google-Smtp-Source: AGHT+IGnOAw312Zdy5WXEaUdfR9kzTOar2bk9sxtncgizZNd6EadXtdVZDsXTb09AnjRPQ+Gucxwfw==
X-Received: by 2002:a05:620a:f0e:b0:7ca:f3f7:e617 with SMTP id af79cd13be357-7d3c6c0e546mr1860840285a.1.1750169182715;
        Tue, 17 Jun 2025 07:06:22 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 14/42] selinux: allow userspace to detect non-init SELinux namespace
Date: Tue, 17 Jun 2025 10:05:01 -0400
Message-ID: <20250617140531.2036-15-stephen.smalley.work@gmail.com>
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

Enable reading of /sys/fs/selinux/unshare as a way to detect
whether a process is in a non-init SELinux namespace. This is
to allow the selinux-testsuite to adapt based on whether it is
run within a child SELinux namespace. Whether or not we want
to retain this as a userspace API is an open question.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0508ad18eb73..39a60d221143 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -321,6 +321,19 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	char tmpbuf[1];
+
+	if (tsec->state == init_selinux_state)
+		tmpbuf[0] = '0';
+	else
+		tmpbuf[0] = '1';
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, 1);
+}
+
 static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
@@ -373,6 +386,7 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations sel_unshare_ops = {
+	.read		= sel_read_unshare,
 	.write		= sel_write_unshare,
 	.llseek		= generic_file_llseek,
 };
@@ -2237,7 +2251,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
-		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0600},
 		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
 		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
 		/* last one */ {"", NULL, 0}
-- 
2.49.0

