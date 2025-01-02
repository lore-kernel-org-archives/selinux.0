Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D2282E1
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836367; cv=none; b=pLyPSici5ySd3Rgd3jZWnils9IlHaQUG7O15eU/Vup6/pJAF5XeeFztigJHplfAAyO99fyZlQDKUvvD+lBU8pkhr+pddBx4P257Dj0Mcn6DC30WkqVZ+pCXSRkrLwCR3vfkTQCiYbUMZuCvsT5cm6six504V3RUPEYE/ofC1fYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836367; c=relaxed/simple;
	bh=bPthf95/IjQcMu347ZTGwI7GRHK03+FW41G19lwYsM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFY7bA09T7Nx2mNWrXHSWLTUuM+C+XT3XxRuzmjjBHjRgtJR8NLH+hcFKCds4BJU+Ym2lbEqYlyI4IrtrCl1ODkiUWyZpdVSDGoM0FJ3leu+rrlfhu2zKfH2j4Wfl33gSvHKze/OhXZiM3hUFzbABTgMb3oP1ys9ibs4Bf2Vs7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR+KGH51; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR+KGH51"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467918c35easo154602411cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836363; x=1736441163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS0seltETOGWAVSrtmFxVuTXqLLPmq7wCJ7ziVzozOo=;
        b=UR+KGH516ilytbylX/lkftAceTbckUR3EQmu11ttZ93hJu7sAF4DKwAEL/KNWVeAVX
         bHQNOBIB7e9VgsC8VLSkeG4RSz4mSL1Bn16M8WwPqw32Q4aOXmDssWHa4dS1+QuGX6pJ
         kERYqJziPWd+peliSx0GsMbMFAZzl53dbMSJzXFeZsfFA0UEuHVQP328sZl1gzkgDDFS
         /0FhbB6ivngCVyEVa2CYCM8Xl5gfaoZEzs1x2UcgG9KGkg/Z7fTuM331tpxpkduEoixU
         witn2IKeJKCvYOh4xOSsEBkrO4tsbw2aJGpRY5ZqSYfcYNHo6NU/z+g9DrHOrK7vRKBX
         Gb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836363; x=1736441163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS0seltETOGWAVSrtmFxVuTXqLLPmq7wCJ7ziVzozOo=;
        b=eydRX2NhGph0pO7ajbMotv8D55MRDBtYwzZq9K0ajLAmbhcg3whPmvGO628BGjJnnc
         ik3R6DCEmGkiZBFDwlUmsrxQzewovGJjxcUMBugUjoqoLuStOaVnPspir8k/GIR20qA1
         GDZfATkLVNlY9rAnK3yRjF8nHkr0TC3yOoA3Wzm4GN+zRkTAeeWcDrn5V37khV20pWUq
         wnTCO7Su0j94W0rPUkq0t6YaJ4REo5c/7I/BnQWwnLEIj2wgIEqImaKjkSV5Ep8giVTw
         hyTgMHg0EtTNTZuZv9JFFW65tUZSQ15uajJ6UUzoSP0v5Eq3f6cQiu4i0QrEYiG+J2KB
         VFPA==
X-Gm-Message-State: AOJu0YyEW3I4kPn7q3Gv6l6ZXKDIIxqySo8cRK3V7xe/lTlw3iBbSgWP
	4HDY9/jMBttFg7/ez0EXwrOQrI9T8iLv14F9aHCwIKNN3F+gR3AYhhO47A==
X-Gm-Gg: ASbGnctN0+OSRD8Xyrmds8zN13OjjLUr5qoit3gy1ANgxS2Ldaxyod9V79UjCHrFvhe
	rkwuHTp3ruO2rf40BJ6fjbWy/58o6Bh7FAn20XyiGSUWjl75d8qzCSOjRs9fsOnqKOIHSgI37x0
	4EL+07katS2huc3JejAlyX/RVbfrWmoJ87f3DsM+93sbEbu51N+EpCwnrgzLSDXhVhAIU5qDvdl
	MbIoDsW/c4pxacz0gzlVH1x9GZzwXz6u1lMKnEG1F/UNARAlNDWRhXwxBIiIkR4dF9KX9vU6GB+
	wshuo5YrSrfAINnQXTUZrkcZDiuDWpMCIr/07ifodvKt7k1e/mHcrdRsPWxF5552pxaP7A==
X-Google-Smtp-Source: AGHT+IFUlMSVfeqOnWCBQ4i+pvjq/jahZyI8sF90lHLiV8Xnaa2TtVhN2ygNuslsb0K9caIhJq2Cng==
X-Received: by 2002:ac8:5dcd:0:b0:460:9b2b:e8b5 with SMTP id d75a77b69052e-46a4a8baef4mr891358491cf.4.1735836363002;
        Thu, 02 Jan 2025 08:46:03 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:46:02 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 41/44] selinux: allow userspace to detect non-init SELinux namespace
Date: Thu,  2 Jan 2025 11:45:06 -0500
Message-Id: <20250102164509.25606-42-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
index de4d7eda415f..efceb3ac9157 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -329,6 +329,19 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	char tmpbuf[1];
+
+	if (fsi->state == init_selinux_state)
+		tmpbuf[0] = '0';
+	else
+		tmpbuf[0] = '1';
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, 1);
+}
+
 static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
@@ -390,6 +403,7 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations sel_unshare_ops = {
+	.read		= sel_read_unshare,
 	.write		= sel_write_unshare,
 	.llseek		= generic_file_llseek,
 };
@@ -2339,7 +2353,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
-		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0600},
 		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
 		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
 		/* last one */ {""}
-- 
2.47.1

