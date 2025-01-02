Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5291547C0
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836366; cv=none; b=aF9nMQa1Qz4zTjX2Hbn5bgziGs6gNvQ/XPMD3QPxBSP6tHVze6TkxsgAvgIU8+DvVT95KkyuaNMawEQIkXolUDHU7i+/J6IkGzl8ISsearTXijpjN4ha6iH/IUXPjMe7hQseuwlkP5Z5r8XTppCXeN0QrUqL3nM/HNp0bgbtwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836366; c=relaxed/simple;
	bh=iACk5BLwzEKGgFfMZYpmiwvvKZfyk58jc84cB19KqKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjQOXneNktT2d4RXuT/UbESwJ2GW+AgNMXE7OkF88+94tsriSE025U/xsPHZN32MGsc3F47RVK0qFM3AAkk3arO2cGu5fW9qie+8MSrhGRZoqgSo34jvPL7RWVjVxssa5GlAkvxBckX9Yp+Z28Jip3wKGym8XBTxed7cw/Jxv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJR67xMw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJR67xMw"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f95d2eafso1135341685a.3
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836362; x=1736441162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rFcz7YsS3yXQhalooHUjmrFUA0y1Gw78zxjoWAYYX8=;
        b=kJR67xMwmBbyHLTC5nORh0Ou9jhyT3ECwXotpVrGKlQzElyTuLtdc7QziIKF8pflI2
         MaGBe5KpfgMCgla+gJdr9l/3iiCk9t5Y0BGsHU38/xFzO5ZHpbKOXNXJ/NtI+EZMgmZR
         00AsA5EsijP04ZQyX3gR2DmGbxRJ7ClaibQ8jPb+BKC6ezFZcAc4WsDp+3GgUS2R8cj6
         K/yqRJJIb5WrPm5dTkxK+86rYsa/XI0TzLOnJOtsc2fWBfgJOfTfYlm8Om0F5X6swQzg
         d9DRDIFUSC4ONCVzliZfB4v30CupPPiUPM7Y16SCZMjk2VtPgCYJB/5TaeL/LobkdZPR
         DnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836362; x=1736441162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rFcz7YsS3yXQhalooHUjmrFUA0y1Gw78zxjoWAYYX8=;
        b=ZgdtajNKfBYo/K1/3ufFYTdnVxe31ga2Ic1YaZPwn/E40p8DpxVFEUXnFOj0itRRY7
         gShSu3V4aDmFpl3KC3IdIZ3AQuibjJtAh4I/Le1Akmbr0XI54ksUKmGynz4oB6cvHS2j
         1yxZ1AlnedOPzFmdWwQ0pJi7n2qLuUM4UzivVkBdPZOBNSsy4bIop0R5v+HN4tKeryH9
         7JQmmDd8SCptpcSqpb/zmyD4Iu24gBXaneF2oju2qjpyM455il+wksQB1r8PVS4O+r1w
         5gwS1DuWcQ/KHObIhpSIih8VQ2RTpWyy+WXyyfYWlxC/XwSbaVKc8cBy6qPri0ngxDjR
         ZrEg==
X-Gm-Message-State: AOJu0YzF0SwnpVLrjfULZrMjnbtlqVgMm3CxqWzySBsbBQqIjmtavw9N
	XmqschGyEJ14sO/QDbX9eHIeWqTZ6yYNz7QmwZqNdU0HDFTbdIFCF6XAGg==
X-Gm-Gg: ASbGncumEBsXRM+X1Gx5rXmjIsxFZbGAf6leNutdP20AOmhL1HwjfoU5h0Sgg0ArXfU
	ZNfdYtot/MEqBDo3Alve+/1PJJSltJRU4LTIsfX962e+fnTQZBMUCA2dFZ8Q63iUhCOz9Rbpou6
	WRHnRiPiguROBsiRruyJShi8Z3h/OFaloghBENEo2P9EO4ihYyKdEQktH+NUjkn6mu2m80p/cFM
	Cx8yr4DKibMVxy/rRUylFdTnJMLsCIS2l3PqxdTTcH8FhwD4j6tShzrdp2nIwomEByFlb6or498
	SvwIlynjttA7fSgubndyc+syWfCRmKOiDUhkGlaXxUovVACXovx0ykDNUCszDbEu3KYczQ==
X-Google-Smtp-Source: AGHT+IEQ4OjPb0yPMoAGB5HHBCC4kkrM05pRZj+DbxrW71kpN5lERZzpD4yJDuFiF9AI5v51PRwsdQ==
X-Received: by 2002:a05:622a:20f:b0:462:c473:94ee with SMTP id d75a77b69052e-46a4a9c71dbmr643015001cf.49.1735836361577;
        Thu, 02 Jan 2025 08:46:01 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.46.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:46:01 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 39/44] selinux: defer inode init on current selinux state
Date: Thu,  2 Jan 2025 11:45:04 -0500
Message-Id: <20250102164509.25606-40-stephen.smalley.work@gmail.com>
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

Previously inode_doinit_with_dentry() was only checking
sbsec->flags to see if it should defer the inode security
blob initialization, which was fine when there was only a
single SELinux state/namespace since that could only be
set if the state was initialized. However, with the
introduction of SELinux namespaces, the superblock
could be initialized in the parent (or other ancestor)
namespace but the current namespace may not yet be
initialized (i.e. the namespace was unshared but no policy
has yet been loaded into it). Add an explicit test
of selinux_initialized(current_selinux_state) to defer
initialization of the inode in this situation so that
we do not end up setting it to initialized with an
unlabeled SID prior to policy load. An alternative
would be to proceed with initialization but do it
against the parent namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 11d940fb79bd..dfc422d9c042 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1440,7 +1440,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
 	sbsec = selinux_superblock(inode->i_sb);
-	if (!(sbsec->flags & SE_SBINITIALIZED)) {
+	if (!(sbsec->flags & SE_SBINITIALIZED) ||
+		!selinux_initialized(current_selinux_state)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
-- 
2.47.1

