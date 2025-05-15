Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2629A9E5
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314659; cv=none; b=WyXdhMRVDRJX+hhv9Z+aLVoyi2zcflny+HWWGdIakyOZlvgCbVMzm8xhGYM7sWzyCbJFQKPDnv+GGYJ3EgkNwMHH5r8hRc6a9pN2xZlXkbTMTfrX42MyrodjzO1z6Nsr6YtQWuIi0m6599qUQoTrB1EQPXLsWg9Vw9f7TKi2XpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314659; c=relaxed/simple;
	bh=YGdFNX1Ldn5e1LvQRMP7uEC7rN26zt/CvUm9vCNrLwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc+r/cr/j6TY1lTTmTUlViLnA5HhmCQLRG4irSIGjaQtFITNMbU24dCyXim26qgkcUZa7VtKTd5bp9XBbRmmiOpBcGwAI+pkrYtdFRX6CFtBUDs9hYInVZb8QoPRdC3mprmKPAgqLKKgU0Aw2gRlzDVpk7ZQtqcSlCkdGwGruEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZSo8pF9; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZSo8pF9"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f8a954ff6bso3910826d6.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314656; x=1747919456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF70hMZ4c9hTg7Wy+OOnAp9o1FmPPUxd/mIYkXLA27A=;
        b=fZSo8pF9+vIiItqLxtqq85I6qDRaArIrosfj11FMkY6E84s3RbKiJBe2T5fwKJXT06
         +CEwI4dBWHFYLCuT8SKAG8zpfNglmZuUb3AHiJwclT/EZLXJvIyowAOLlBkhSGOJh8TI
         sQEW5f84/g3kRHz7hp3MYFbvqT7R8Ch0/+xQ6BhkCsFOMfZNFa1FQeV11P7TvPGwjkT/
         mwMq6YrQLs9uOHdzjUU7SSBRwW9cWhgaC53SaEAbilOJodwYeovXB7UKoYt5b7Dlxexa
         TAam4GSc4IbI5TYpj2lUcJLcmkufSjA2xZ1oV/tQpo7sGIltHwop0BwjyPt2Jqda/Xla
         NwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314656; x=1747919456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZF70hMZ4c9hTg7Wy+OOnAp9o1FmPPUxd/mIYkXLA27A=;
        b=qeOd2QchkNzyhTqqxflTdMFok9q+qDvfr3tfFtY9HViDk9qiZB8Sdk417YqCVJL52K
         m5EAaEpTWqu3jEEhhr7bWydAkJ5Pzz8V3E3u+9oeyZR3hdWsK5RBxD3zp8eRXUyGnDDW
         Th4aLU72xdCyp5v1DMIAqoqf73eE3Ea6D4GSYiM6dyQHcGC/hVXL0NKUOzTBddputMcT
         PE5JFw7d4ZmWJojXbGUndab+4dqvyw96ceSFsaD2TBaEheaIpjkOFu91KPM/cjz/oHvf
         ZzFFrLC4/PuC2BzQWf6alJrwolhPaAYD8arKcZLkVRLtyAVkrcjox+WTj8dAvX0T0hwx
         hecg==
X-Gm-Message-State: AOJu0Yz2QaywmtALujF9durGHxfxGho7Osnr2T7bDdKZ2KD20SncNmo1
	n2tPoul52XseV2tsrF0WKxAah5hLlX5oyw/fkWl+ObHx67QcvqNUyqMM8iOqYA==
X-Gm-Gg: ASbGncuB2BwbfADYxRIn8U6lTub3+IuRmuKVaBhEDncqPUQIC52ezIBYQY4AcCyJOys
	8ly3qx6Hx2uU55dGllxDubPcCAB551mXVHhudsXh4JnFvq9g3gcLgwel/zMduMkkTSe+gNGitpk
	eAcfAqSZS5+MkHord2jCtrT38oUulCTleNPQ8jfLrnUIKKnMxT4TsPoVwmJCwHxwfnZI8TVsOSp
	hkn8/X8Lb0bg4R5mm7TzFOS8cDu0W9fBf4n5AXt50A2vkeCb8cdKE5WjD+o5AS2gPqQlkkquy/e
	mvBKdJtlFjhKjxQaqMgBRTDUvsfE5vvb1wpg9H6kcoKXNKhQd0n81WMAmbllSz1udaeuJxFxybi
	UFvaPjrewk+VdfKfQrqTBspk/AE/FzuazWFSwq7SCVgIlOdyQuTPzxRezgtNsXNjI
X-Google-Smtp-Source: AGHT+IHagpd5GKV1FcILRn+JBTRl1ir/BoHhisGrnF2knCSj6+iBDVjg+t6hvf+gX1h1wX0QcBnMUg==
X-Received: by 2002:a05:6214:e88:b0:6e8:f296:5f57 with SMTP id 6a1803df08f44-6f8a3226240mr53526976d6.20.1747314654772;
        Thu, 15 May 2025 06:10:54 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 49/49] selinux: style cleanups for node_sid prototypes
Date: Thu, 15 May 2025 09:09:47 -0400
Message-ID: <20250515130947.52806-50-stephen.smalley.work@gmail.com>
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

Some style cleanups for the security_node_sid() and
selinux_ss_node_sid() function prototypes.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/include/security.h   | 7 +++----
 security/selinux/include/selinux_ss.h | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d1f65e0741a8..22de64287b4d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -400,8 +400,8 @@ int security_ib_endport_sid(struct selinux_state *state, const char *dev_name,
 int security_netif_sid(struct selinux_state *state, const char *name,
 		       u32 *if_sid);
 
-int security_node_sid(struct selinux_state *state, u16 domain,
-		      const void *addr, u32 addrlen, u32 *out_sid);
+int security_node_sid(struct selinux_state *state, u16 domain, const void *addr,
+		      u32 addrlen, u32 *out_sid);
 
 int security_validate_transition(struct selinux_state *state, u32 oldsid,
 				 u32 newsid, u32 tasksid, u16 tclass);
@@ -534,8 +534,7 @@ static inline int security_netif_sid(struct selinux_state *state,
 }
 
 static inline int security_node_sid(struct selinux_state *state, u16 domain,
-				    const void *addr, u32 addrlen,
-				    u32 *out_sid)
+				    const void *addr, u32 addrlen, u32 *out_sid)
 {
 	return selinux_ss_node_sid(state, domain, addr, addrlen, out_sid);
 }
diff --git a/security/selinux/include/selinux_ss.h b/security/selinux/include/selinux_ss.h
index e7b5346d2b49..0c3c6df88f5d 100644
--- a/security/selinux/include/selinux_ss.h
+++ b/security/selinux/include/selinux_ss.h
@@ -76,8 +76,8 @@ int selinux_ss_ib_endport_sid(struct selinux_state *state, const char *dev_name,
 int selinux_ss_netif_sid(struct selinux_state *state, const char *name,
 			 u32 *if_sid);
 
-int selinux_ss_node_sid(struct selinux_state *state, u16 domain, const void *addr,
-			u32 addrlen, u32 *out_sid);
+int selinux_ss_node_sid(struct selinux_state *state, u16 domain,
+			const void *addr, u32 addrlen, u32 *out_sid);
 
 int selinux_ss_validate_transition(struct selinux_state *state, u32 oldsid,
 				   u32 newsid, u32 tasksid, u16 tclass);
-- 
2.49.0

