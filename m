Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA21607AC
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592509; cv=none; b=fzO94T7Pc71Wbq9ndSyTGcI5ZU80+PQL3a5bQdkYwwSYUTnajSxtsrwMx8XinnaQXCvyczbOKmVa/3QdBbnalr9pZgkJ6J/a3+UWLwUtGHuT4nxUdw+4/ZReMxjKRE7ljbceW1+S/+hhlJkWZaiZPiFPsh6nNCow3gVX4oKvKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592509; c=relaxed/simple;
	bh=ysfQ4kzDYsp1J0RVrakm6D0hjV2km//kqG/X0JhYpb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwjXaFRhBAmdCRM/Vi5dyw/PXJjhGjRxrI/fTWwzWmgjN5TmFpbTxF5ZnmZrVod4L9A55JoKI2zFLq8Bkl+jAFy4HmfTZc3wnqryzd2Em+HRw+JprOAU7RUTUuPI04mqo/udiZvr1whoWeU+CkbG04YAP2HAz/GQ7imIFEz0He4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWhyvSek; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWhyvSek"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso24341416d6.2
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745592506; x=1746197306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfbCQZHJAE2c9HfkmSP4ENjdUkSnwhoiheGTz09BW2o=;
        b=cWhyvSekBO5oQ2M100/E98mgWdMM2mNWEfthCCsCX5BzSYKcgJ/8XlUFZXNp28qVGP
         MboVrWKD8SBLJoD1XeAmfGUQCjaY/x9bsuzAAs0mENaJXvR1gljX/S2OWncz/9W2a3pM
         UuTLK5S3logvToDFyhPgtwArkZIWxmXFXMTYdV/U4VjsHRhSN0Cii7UOdlhGkUBRMS0g
         0wmcmGouiXBYYRqNquyrvl3Qh7r3XORdw2R4Zdf7usrDjj29uLe+Rx4r1tEQfziI28E4
         X4r+UT2tXslKuBqbiV5t1efwX2/M6BARc7XkbIW6TOf49F8LR0XD4i9mrgeYn0JmmxzX
         +Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745592506; x=1746197306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfbCQZHJAE2c9HfkmSP4ENjdUkSnwhoiheGTz09BW2o=;
        b=X/E4hqWtbAqftbGUCX3BLUUi/PGKyvsUf32JJdzZxfHdb8lO4lfM0CzHc76ErPRvSW
         ZJhQGbQtfpOtFci8QWKjHN6+wklvWWrjDrhFn/SfJL3H2y1vFyU0sGEP8bHrDGp28sS0
         q6CMfPy8lW8Bt5e5nLm8gKz0UAhTGUDH22qXN+AqIlGRGdQU/XNCxj4eGrVgOiZk+05b
         jZ9ZweUc57+8ubcxwHcsI7e1t5lk1+o+0KYtl3IOz7I5L38dn9on+2L8SWTTwWk8Qm4Z
         zccN6QvbLyStvZZEu5ssZMdoFhkUGyL7UZWETHnPJZMciy/ae1a9A4aEBizKRE6G5wU0
         ANwg==
X-Gm-Message-State: AOJu0YxAaAPAFWpNNzB5HETXXfEcQxvmzqtqPW21rikVY6/5MW9yR4Bs
	hHjq4S1Si3lIw0ORMpAAnZsx74V7pm4Jb6SHmKQ4+vVQC8CWGQ784Qkgn9cl
X-Gm-Gg: ASbGncsgloPWlCNtn3YuViDmwSEFCOFDm2ss64pR6WWDE5RWZkCJtTpL0GuTmZfuCTG
	axSggJZkoM6DVl6BMDKaY9+9yeeFqTknmaZ9bL4xgUkCFa2NXzjJhjgjGonl7kQZ/28GxdUxBTL
	eGoeOqpafKjQ+vA6IBd9LWm41wBLBJ3L03vWdQ+/Qi256w7A7Aff/w8goS697YXOok0saJC185d
	DMazf079+EsLL+7Z6uRn0KqQUesz9kEa/IOgW0M7vCH+5+vLk/tn+jvx62Bdz3LW7Llm+pebzP0
	JLnd6YcIrGVIp1/1TWmzsfmTqbr/BCbnw+3IkDXAd2V3EIr2rgNePZaeKHJjXBLoqFfQ/cK7WIL
	CVZf1jmr8m/kMtf1yZXBcor1oTmVDSFsL5syhlzbh95ZjTTaYgJRV4dOsx8YN0Z4ppXYZ
X-Google-Smtp-Source: AGHT+IFWwlNjvrt3QszfxpmefVylyGZ1sh2lD09TEmyj8geU4G8cukSKFkwPcWay9VHx6YfrYTq9Cg==
X-Received: by 2002:a05:6214:76c:b0:6eb:28e4:8518 with SMTP id 6a1803df08f44-6f4cba46035mr44936456d6.34.1745592506102;
        Fri, 25 Apr 2025 07:48:26 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c093437dsm22781936d6.39.2025.04.25.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:48:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 2/2] selinux: optimize selinux_inode_permission() for unconfined tasks
Date: Fri, 25 Apr 2025 10:47:09 -0400
Message-ID: <20250425144708.14504-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425123719.5984-2-stephen.smalley.work@gmail.com>
References: <20250425123719.5984-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the task avdcache to also cache whether the task SID
unconfined aka permissive|neveraudit and if so, optimize
selinux_inode_permission(). The same approach could be applied
to all of the hook functions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This change demonstrates how the previous patch could be leveraged
to optimize selinux_inode_permission().

 security/selinux/hooks.c          | 7 ++++++-
 security/selinux/include/objsec.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8115df536ab..2e7eb0864bfd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3184,6 +3184,7 @@ static inline void task_avdcache_update(struct task_security_struct *tsec,
 	tsec->avdcache.dir[spot].audited = audited;
 	tsec->avdcache.dir[spot].allowed = avd->allowed;
 	tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;
+	tsec->avdcache.unconfined = (avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT));
 }
 
 /**
@@ -3210,10 +3211,14 @@ static int selinux_inode_permission(struct inode *inode, int requested)
 	if (!mask)
 		return 0;
 
+	tsec = selinux_cred(current_cred());
+	if (tsec->avdcache.unconfined && tsec->sid == tsec->avdcache.sid &&
+		tsec->avdcache.seqno == avc_policy_seqno())
+		return 0;
+
 	isec = inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
-	tsec = selinux_cred(current_cred());
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	rc = task_avdcache_search(tsec, isec, &avdc);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ee7dc4dfd6e..c659dafbee60 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -49,6 +49,7 @@ struct task_security_struct {
 		u32 seqno; /* AVC sequence number */
 		unsigned int dir_spot; /* dir cache index to check first */
 		struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries */
+		bool unconfined; /* unconfined */
 	} avdcache;
 } __randomize_layout;
 
-- 
2.49.0

