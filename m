Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49847155A2F
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836360; cv=none; b=SdCuvs/hq+mOTFkOpo0l9uPT6yoOKr7sMgiNbSDvShCNBFGjwXOEiVijObPKuLKVh+tHTbGSZ22BMVhrVvPQXcaKEKBbmjbyjuQkys/KVOhtETJ2zLvdmcKjPq21O6CKHQWMqe5OmjtAZDWvli3NBEhndd7VFRfPxmGEYKrpDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836360; c=relaxed/simple;
	bh=B6+7Qlc+O4cbq//MdkQnEY1Z4rS49iki39lm94+XHtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ivu9vfdtm2I7RWibvjdkuEUhTEDtAHrPWUo3QI0BgRVvB3uIPPABr1PUdApYOEogt5aQp31bJm3WJXQfla/KU6pKfWA4bQcIBscWtyqUGDsvrAk/hz59bgDyT+nkmvQSaLTAArY4q6LPOXRkFrsKap8JCOuCjGCkU+JZU1HdW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9yomZeD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9yomZeD"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a3c85e11so72363961cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836356; x=1736441156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc67pef3KugB2832iY3lGROTmy7a72TTDa40iH9SJBk=;
        b=m9yomZeDlJJBD7j31qg+r4eKkSPgyxhbtSQoawGu55IBtyb1ojfqqme7kBloc62hF3
         x1DSm7OaGEp+W72U6OQFbklokdrqKMkuKi2BRShbWaTSc5YA9zrl3pUeBHMd3ZCMmxyd
         3cZmd7qKI+e/CdV8rlqNZ3Yc5txBIfZa3jropfqiGb6lHb805pUBut8PYiOcXHcUuRng
         MIOHpepPDfEY7hRjS3Hwb9NbxU6Cjijh1ITHKY+uSLhrCmG8/dNYTCZHr5IMniYP5J5m
         hwNWBwtDSYRh0ZpVNQ4vCoZ+lmgyWrEi52SMUc5sJJLyBwBEXJr2Qvbb+VYhjVeoiRYq
         HuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836356; x=1736441156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc67pef3KugB2832iY3lGROTmy7a72TTDa40iH9SJBk=;
        b=F+VJBIZFgdjJivZEhT8von9MMJeKaFxeNKKS8Tds21L4DK6EUlmgavef+bLGhwDoGd
         LLCMp4hZpqMgSFeEhOQg/puAZKHhtuQELDvigmpGoCMuhvfbIWgRJKVGJA+lhNlc6EUW
         AINZFN/z8s19/GkFzNx9K4pJaHruMYNblYxD9kRE1K2EMwYmZY4wAFp1dIqXlXu3uuyO
         NFiA6FPVNAUgd8YhQeoK2J21fVkmV+9iZS63VFiW/hj1hGgfSnRbrjXPnBLNj9gNv3LC
         fSzoeFfLomCXuFr6jlesZ/96w8Fns4d2Ig+bPvrteFmrtJcW7ok+uL4ttvUY/kg0Vytd
         zjEg==
X-Gm-Message-State: AOJu0YyH+E5UX4Q4jMU00w63eRRa2BGQZeZF9Zwo1fXaHINdPxZab08p
	F0bRsj8EE5R9lvljjhQda6pEzzmniRTvd/Ui9y0gYgkoVZjXhPkecHqoEw==
X-Gm-Gg: ASbGnctg4y+/1Lc7MUxSqREPseKVnkHuotjR/ksMqscvDFVEZqUllzWqUIDUsM8PVA2
	DqHvD08FrsguBNtQ9b4QmwsFkSywOxbBW0Avqkt3la0L+T/wYvAY110Wt8cTAJK4t5hM6C3dGAY
	cSBp0ghNnvgKelcH4I+dajqOC800fK8ou+DZBFwKd9zMLaKZKtzK+Z/dHesT/2dU6/a9Lfi6PKF
	LOTL9INy1GHlLDwb/4nYlvs21kZjFRhX5gP5dxiiZ88WAA44xWTasYGQ5l+cddSWnNLQ4yj9nHS
	QtCuPwtcUfeIZsF7cR3fGOyxQo0736yMzUxaIK6JaosWb5Zavi4K585xmKP/tDaFzFGGJA==
X-Google-Smtp-Source: AGHT+IETJogixn+uDooQ3dtjxMKfRw/KYRWEUBnz4EcKkm4DKDq7zAHZsf/Xt50fm7NYWC2u4FFGnw==
X-Received: by 2002:ac8:574a:0:b0:458:5716:fbd8 with SMTP id d75a77b69052e-46a4a8ebeb9mr795565461cf.32.1735836356631;
        Thu, 02 Jan 2025 08:45:56 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:56 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 31/44] selinux: fix namespace creation
Date: Thu,  2 Jan 2025 11:44:56 -0500
Message-Id: <20250102164509.25606-32-stephen.smalley.work@gmail.com>
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

Fix selinux_state_create() to consume the provided parent
state reference rather than incrementing its refcount.

Fix sel_write_unshare() to put any previously set parent_cred
prior to setting the new one.

With these two fixes, nested SELinux namespaces are properly
freed when all references are dropped.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c     | 3 ++-
 security/selinux/selinuxfs.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3bf4428ccfca..3c4ea7ed3750 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7606,7 +7606,8 @@ int selinux_state_create(struct selinux_state *parent,
 		goto err;
 
 	if (parent) {
-		newstate->parent = get_selinux_state(parent);
+		/* Consumes parent reference */
+		newstate->parent = parent;
 		newstate->depth = parent->depth + 1;
 	}
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 7a0947dece69..0395ab187fd9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -386,6 +386,8 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 		tsec->osid = tsec->sid = SECINITSID_KERNEL;
 		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
 			tsec->sockcreate_sid = SECSID_NULL;
+		if (tsec->parent_cred)
+			put_cred(tsec->parent_cred);
 		tsec->parent_cred = get_current_cred();
 		commit_creds(cred);
 	}
-- 
2.47.1

