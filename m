Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1029A329
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314645; cv=none; b=Wij+EQV5jjhwT30w/lSN2Ikinav+lWRzk0eXIKTkagmkoY/WL2fT/Q8sb2gBjtEShAVvgkEDNhdR0i4bK+a/iKyVaQ56/mih+x31a2WvVD/Bu0/BRua6Pwm224BU6wk5bVxZqn+MxC+zAzTU97hMCMAVyDoxTY1vQpG5QT8YODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314645; c=relaxed/simple;
	bh=nTdauKNIEOysa7xgetD2P5oLIBidbJd+cQw6MMlIvH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfa9Fj701CcZWxHe/Fu+v6p+/aMh0VZ8XTtDlL5iEoYWD78u9l2zdBhQZvi5G4ImP4ebVwBLX1vURGTOVCjDGScayknz4aLNeQejAqmP+cAZ+GZuQd11UeoEJsShPSQmXObjMwlyla9tE/iYh8lq8JELN8m71W2JbQ9EttL1R3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTx10SjH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTx10SjH"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4768f90bf36so10526621cf.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314642; x=1747919442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf/maLWHDRy6JlCpFW31jLMQ3hFZ9KoDlrlI74kLDfs=;
        b=MTx10SjHNbpYuU6RHNnemgjk/QE1oWurW9DNMzqJqkkQdycksMy0iuXdnzUaW6T6lt
         dWV7W75Gqfu4wy/nm6LIp5S0zneNnDebDFc2bItCrJrU+VfcM74IjH0lFnT4uMo8e32j
         gkU327Ovi/TlehHHsdXBGlZluTl5CFVMWyA73H27CJ+I22iQ2J3T17T+tu7iwErglIWc
         VI9ATNJcVdXjhzJBRzEyYlmOTUul5ovWeL+WjjgwkDt+JK8kQw0f5OSOTXGKtFxcE6Io
         tuiFbnZinf6uhHAJmzQ8/AcjCVjz/RChIND4WIxt3lTEhoYLaBdPZc5pHd9fo5nm4wNU
         YJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314642; x=1747919442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf/maLWHDRy6JlCpFW31jLMQ3hFZ9KoDlrlI74kLDfs=;
        b=HjjdfphW92UliHrkB8NrbyW+Er2o5TjKWLAP9mGMOypFW2z3XGX2/9/YwtJ2QhUqS8
         Cpf6Ib0ryTl+COQ6qQ1YW+NIYQgjyPpo5YKoC48d4Mq/Z+O7SLi1opuYsR5diBzAu96/
         1njJva2Rpyd5T/RpDYwX9EU9CdSXk+uIRfOzw2DQ9oo2w1EPyKHI2GGz4FPsVwg1eP79
         oseyrmnUO/TgSWDxdgTR0lB9zrbQqeKU2HgpCp39Niydiah74Clx7O7L/4VJC9MPewyk
         58tIHUV1wUSmlaHWalN3r5oDEVtlIA9MUoCyaJITVB+qMHmAZSImOICAdJ+o9hC7lFUR
         i3JA==
X-Gm-Message-State: AOJu0Yw7HZzT9mC3/U2kduNVndjsiEOdOr20hymL1rzugGU2ixK11Lvt
	BBB2ks3zbJiBOorNfRoVbGJwMrekrfIiGvHGuxlMnEQNH1DhTeMGbPS9lg==
X-Gm-Gg: ASbGncuTvjJLzRcYE+DeAqlVgsQUFMPo34Vv2WZHsKffCqO9lu3noBPd2ilpNIfnEvK
	L5vxANgrLpsWkd5F+5au/YHXUStWkpPquq7NYxaEdIlNoLr+T0P+INM8M0yoK9376mXehJpKsjL
	ea2FEODQTxGxGMgQGFBRsesB7ZGt6y/0Jwo35NriloJVMFOTqL96sxOEFhcYoyqbWrzZoG4xVPq
	K8Ei0scnbyBOpGUjKp9uHEOgjTz1gwILjOhz3SQIfg6bRs2o9T7NCG5XKpEEkvdT/9LWPQ0MunC
	cqyvk1FR9cl4yP9NrVPvRJjSYsX0vtGtMcD40r+FZJsYDs7Yrm7n6MO9mFM4v6wNBSEjGDE8y/B
	WLPDCOmnioCb++x+W15ptZ5immP0OQW/JXpEmxyowPOQRtIcdbhT+hw==
X-Google-Smtp-Source: AGHT+IHOZH3CTeBVzbCkYWH9FX9xYnxOWqCjHRSp8ZRUF+JK4xlVPae6I1/kYQAsPSxUbhl7HojoZw==
X-Received: by 2002:a05:622a:590a:b0:494:57af:bf9a with SMTP id d75a77b69052e-494a368043bmr53504581cf.50.1747314642359;
        Thu, 15 May 2025 06:10:42 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:41 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 31/49] selinux: fix namespace creation
Date: Thu, 15 May 2025 09:09:29 -0400
Message-ID: <20250515130947.52806-32-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index 8ec6e2295921..d9ec8add75e3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7809,7 +7809,8 @@ int selinux_state_create(struct selinux_state *parent,
 		goto err;
 
 	if (parent) {
-		newstate->parent = get_selinux_state(parent);
+		/* Consumes parent reference */
+		newstate->parent = parent;
 		newstate->depth = parent->depth + 1;
 	}
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b084cd2deaf8..9b537de75480 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -386,6 +386,8 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 		tsec->osid = tsec->sid = SECINITSID_INIT;
 		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
 			tsec->sockcreate_sid = SECSID_NULL;
+		if (tsec->parent_cred)
+			put_cred(tsec->parent_cred);
 		tsec->parent_cred = get_current_cred();
 		commit_creds(cred);
 	}
-- 
2.49.0

