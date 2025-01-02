Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969113CFA6
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836340; cv=none; b=UKGgV6M3vP11xDHBWHXT8QsK6MaNAljlGj7sAH4VIplpfvRk8YVzsx2TsZNq/BbAehXJF07C2yqFDrXsDqE0FFRL4EZMr2tauRy/kxPyDPrle3FUzEtIfsmcVjEF79gZ2sLDQfA1HFu9pV+Yz9uvP8M/66KkVvqhcRbRIvlkk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836340; c=relaxed/simple;
	bh=IsM5WUBdwx2sXP82lwtcu8Gn3w3qglI+dLVRJkh3qCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hbvuto3jzJb+YBPkpmHoOdKAvy20hEeqjAI4+LJb7+/K0VlDRq0DvQxve2W7hArnxl/p3rAm+9zHjz93BewKLvcK8tRPb2juRkAOOnWkvc6elyJT55AtdPe2pa8TSilFDO1fL9Mj2t4yzOmQJq+Iaa8JYefUbtRwjOyS9DDiGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBbOekNW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBbOekNW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b98a2e3b3eso562802585a.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836335; x=1736441135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj/qraAyiwVXRUTldMCrvrVxR9Q3PGrd1d31XBZBmtg=;
        b=NBbOekNWXX1VcijDYk+gxg3stNuru0SJq/dFlQTTIFoNeFNE3i/7z0DxWKqvpyrS7p
         /2TdFXksO3/D8ilBpP7eR67eBeUF+Q1P4sbMxQuOjfcqHHh7rN8T1V1L/RR7bzp8lxbi
         9pJvXfgxxZqkJV5rYhvu/sdSTP+YBIYQ6O5LfDFQiQ1vDyYjUu47XdF9Oz98onbIOhXO
         OGKUl7cM72YVFOaQbUn5mLrKGjKy6yp919DDcbWlZ13zRNswRTrDpR/6stM6Rk0tvx4n
         lZXDrqKfhjSuyIXDKiefE7e8E28cSZLM7b70rBxBisMDRhidAO3PAcKdS50920OVWnyG
         /7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836335; x=1736441135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj/qraAyiwVXRUTldMCrvrVxR9Q3PGrd1d31XBZBmtg=;
        b=C/+0BxIVLVj0iQFyuWKvdNJ1oWYJxPKiXdbiEiuR7pmuHw9bhceKo6kaQj9eeHF/nQ
         JHHAp9KqDpOqHn1vXGtmbrcY3+BxYQfNvCqjHolfwwlT7a118eGvCA6FwZmcCpujstM5
         9KiLkq8J4hfZIwr/NkJOpn/rP3gOa6qfedv+nUeJ55FGRmb28kYNK8O6PMH13dcgqhCm
         rkQDJqzu8HVGXS0OQK657RHdC4Su3Zyd6X21VDm2FL82JAXsQ9e6NQQO5GhAmcBlJmNe
         rBD+u/3SzIZgI0aWGpxf49IppF8K4X97N/kTYVTIfK4qDD1IIIoKp8cBixAvqZ4a4/C2
         7SpQ==
X-Gm-Message-State: AOJu0Yxsks7QlqPJL6RG5HCnRFqdBdLbw4DgkdOmHCg+sDpXC0s/Xftf
	ZFE6b3mFLQi95WtmAyZb+b4oLX0Nl0WiCcJ35ykOhCknLIb5mrPwgHpNdA==
X-Gm-Gg: ASbGncsIx59Ed6tdmMYM1LajqVLaFMaiwhCJPN0IDu6MjIgMN+s1ywmcUxZsadmvZbr
	bJwgOA7vxsXBmkjN/pua4bYI0ANR/O6r4jGCinorkrBc2iPAoP1BpoOlpVG+bmSNEPUpPTnZJAe
	MD4N2hiNuXfvERuDDG4oib4ZI7gSM7CKu5LL1mv21TESBqWoUatV2gMRFa7v7f7RWNSijLEopUB
	0X9NgSwEUjSIiqPuwC90Wb1ZB9Z8PhWNAVC3YMoVeyUiXyhkQmFYZb8LatXU0K1RaEOvy7ydjdR
	xqt4eZpIW4AE+be/AOY7NhPlKLpQMYDXCjLD8xv2936cckmelWZU+sBcxTypTfnOykhOWw==
X-Google-Smtp-Source: AGHT+IEB1pnuwjwK7RZJpRLFmexc//dFJLg5my5LjMjTYPwcUQabd/4riY4FJopA/XdaZlrjvIH1Lg==
X-Received: by 2002:a05:620a:240c:b0:7b1:4327:7b63 with SMTP id af79cd13be357-7b9ba7a573bmr7927319085a.32.1735836334680;
        Thu, 02 Jan 2025 08:45:34 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:34 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 03/44] selinux: support multiple selinuxfs instances
Date: Thu,  2 Jan 2025 11:44:28 -0500
Message-Id: <20250102164509.25606-4-stephen.smalley.work@gmail.com>
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

Support multiple selinuxfs instances, one per selinux namespace.

The expected usage would be to unshare the SELinux namespace and
the mount namespace, and then mount a new selinuxfs instance.  The
new instance would then provide an interface for viewing and manipulating
the state of the new SELinux namespace and would not affect the parent
namespace in any manner.

This change by itself should have no effect on SELinux behavior or
APIs (userspace or LSM).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 5de86b2b3378..a72fc91f10ec 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2152,9 +2152,33 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	return ret;
 }
 
+static int selinuxfs_compare(struct super_block *sb, struct fs_context *fc)
+{
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+
+	return (current_selinux_state == fsi->state);
+}
+
 static int sel_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, sel_fill_super);
+	struct super_block *sb;
+	int err;
+
+	sb = sget_fc(fc, selinuxfs_compare, set_anon_super_fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		err = sel_fill_super(sb, fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	fc->root = dget(sb->s_root);
+	return 0;
 }
 
 static const struct fs_context_operations sel_context_ops = {
-- 
2.47.1

