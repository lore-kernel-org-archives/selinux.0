Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C177F09
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VqY+I3l2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f85d29d14so4777496d6.1
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197563; x=1703802363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdxpKz75d+4pLhW3O5m2nFrGNXoeAYFGrBxgKR6TRF4=;
        b=VqY+I3l2Hkf6KgeZWqldZyWCi3VPmfgAcEOqKDDxpSqKGu4g7Wj7NqNeEv0rNy96Ej
         Qq7X57UySWCUlCfaBrRp7W2iYAZ0cD2o1ouvkkmbUL8Wur6sVzDtBchNAvOoxb3+zPP2
         DGMe4Q4Y2azHeGe6DtBff0quDu9xCNSCUTclIlN0fsfx6sOqzLNUvlGCoiPucAYSV05h
         YTvXvMvepE8z+PdOTdrZQmyZ8ffsmg9aWR3FJLvroLz5kqD+SWIk5Co2TkOw6Mh3P8mz
         Pdih5fFzftmxOosZEq5zsTWQhr8HE1PGRfHjowNwgtK6CMgoWm5v3bpouc9zrrg2P0i5
         4t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197563; x=1703802363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdxpKz75d+4pLhW3O5m2nFrGNXoeAYFGrBxgKR6TRF4=;
        b=KjxQaEDbP9w5rsWX19+Nx/9T+8Isry1ppSq1jfJ4DkxzbvHGUv02z0Fr8kJ46pJKYs
         QjU4ZEreHmHOWyPUb3iRmmk6pjdlqLUXLoflKTlRN+MZClX4Oew2D0eelQ+sB/zLpegK
         aybt5r1ltE9TA9QWSdhxLJU8vlvgcdnk1Pr0K4TX+OwQMXUnGu2Y4cN85fJDaer3b6Q0
         q2AT0dkjVwHFZQ9jv2jstdoGCE6KVLcID07vKwFmKg7C4BuFA2qKhUwpFWHseRTQeAHm
         6AaFxVfSp2AK62c7sOcE63bzBUV0KKwXM3EKpfPNtFD7CveK4KoerOQAP0p02P5ay9ot
         q+MA==
X-Gm-Message-State: AOJu0Yz5j21GZxsbMPEGdVNGZCCb4pzO3vOCWY1XDaWchwAuNsezUGFH
	0PjZmQ/RIzkcvEB1w0FRjUz3zo6TUhbw4TP0RuF+VSNZDg==
X-Google-Smtp-Source: AGHT+IH3/Tv6GsMloo7oQjPrOctahiqNNoBnRKqDqw9YZhrI/XcTXBubLMTPOjEzVIlkNAujNh4k7w==
X-Received: by 2002:a05:6214:5298:b0:67a:c241:488a with SMTP id kj24-20020a056214529800b0067ac241488amr429838qvb.83.1703197563450;
        Thu, 21 Dec 2023 14:26:03 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id t7-20020a056214118700b0067f80a27790sm814653qvv.37.2023.12.21.14.26.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:03 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 02/15] selinux: fix style issues in security/selinux/include/avc.h
Date: Thu, 21 Dec 2023 17:18:45 -0500
Message-ID: <20231221222342.334026-19-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4125; i=paul@paul-moore.com; h=from:subject; bh=xVD5ecJjl2FQQ0D5cuYBuLzMelq1egv5uxTYkGh+u5M=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLr1gh4y/4jkpZRr4YqG0644vW5Hq9veTqq/v QITEL1YQyeJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS69QAKCRDqIPLalzeJ c50pD/wMNs9vWZKGK+Jg98Vw+Z3+7Ze7gMdJP2NzNZEQemNyD/OSWNlNjKfE1dAqVXFyHmtajRN 37cgNwnNaYjddHQPKJT3WxTHC4ptMuabQPXS+f5xwe/cZW6k9IB6NLLXZwaAlnB1g7vlr3NKF9Y loLqL6mgPC4K9rBhTOE/SswkVDURld4TYo7bWcMo/IhcwLbATbun8lUMDsIceuo6o0qlA4/KhhV BymoSFIMq+T6qgT+cSboDmTyUhNKgjtP4uxwbwkdGT2KrXwKbtTQ6EvwPzn6JbkpuRE/A0tjCWN Q/QJbML7n/dF3SO3e1JckMlTuj+u9/BxHKIH1Ly+v0Zta/QvGXx3H9idEDECzptNGw+zugLJXDX qeaolEP3q9erRRbD56YGsCQ7rUknT0s4LNHf7YSR+/IywuHduOjM9eLy2L7dsX97rVbH3O5guKd c50Km2a5iivwUovLuDiaw0fzR4RXg6sa6xIL6HZWXNqyJ2odQ+nwqAIXK9LT7Un8H0bO8vzL9Dl L2wXXCsIVFFw6EOcn4T+hIWzWIMsz7p9lEMyO0sbBtjQISLW0ZbIOFd645m2Wc6r7AKgvgUdKoJ OjBM/bKqTs+AiAtvBbLUkeHHFmJykGlSqqz5z4duNm2sXvBIZ7Gb0OjVkjLSZLZi/CzD+nxoV6o pQNba7I2AiRnxOQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/avc.h | 41 +++++++++++++---------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 8f0aa66ccb13..eadae219fa78 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -4,6 +4,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SELINUX_AVC_H_
 #define _SELINUX_AVC_H_
 
@@ -60,11 +61,8 @@ struct selinux_audit_data {
 
 void __init avc_init(void);
 
-static inline u32 avc_audit_required(u32 requested,
-			      struct av_decision *avd,
-			      int result,
-			      u32 auditdeny,
-			      u32 *deniedp)
+static inline u32 avc_audit_required(u32 requested, struct av_decision *avd,
+				     int result, u32 auditdeny, u32 *deniedp)
 {
 	u32 denied, audited;
 	denied = requested & ~avd->allowed;
@@ -96,9 +94,8 @@ static inline u32 avc_audit_required(u32 requested,
 	return audited;
 }
 
-int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
-		   u32 requested, u32 audited, u32 denied, int result,
-		   struct common_audit_data *a);
+int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass, u32 requested, u32 audited,
+		   u32 denied, int result, struct common_audit_data *a);
 
 /**
  * avc_audit - Audit the granting or denial of permissions.
@@ -119,36 +116,29 @@ int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
  * be performed under a lock, to allow the lock to be released
  * before calling the auditing code.
  */
-static inline int avc_audit(u32 ssid, u32 tsid,
-			    u16 tclass, u32 requested,
-			    struct av_decision *avd,
-			    int result,
+static inline int avc_audit(u32 ssid, u32 tsid, u16 tclass, u32 requested,
+			    struct av_decision *avd, int result,
 			    struct common_audit_data *a)
 {
 	u32 audited, denied;
 	audited = avc_audit_required(requested, avd, result, 0, &denied);
 	if (likely(!audited))
 		return 0;
-	return slow_avc_audit(ssid, tsid, tclass,
-			      requested, audited, denied, result,
-			      a);
+	return slow_avc_audit(ssid, tsid, tclass, requested, audited, denied,
+			      result, a);
 }
 
-#define AVC_STRICT 1 /* Ignore permissive mode. */
-#define AVC_EXTENDED_PERMS 2	/* update extended permissions */
-int avc_has_perm_noaudit(u32 ssid, u32 tsid,
-			 u16 tclass, u32 requested,
-			 unsigned flags,
-			 struct av_decision *avd);
+#define AVC_STRICT	   1 /* Ignore permissive mode. */
+#define AVC_EXTENDED_PERMS 2 /* update extended permissions */
+int avc_has_perm_noaudit(u32 ssid, u32 tsid, u16 tclass, u32 requested,
+			 unsigned flags, struct av_decision *avd);
 
-int avc_has_perm(u32 ssid, u32 tsid,
-		 u16 tclass, u32 requested,
+int avc_has_perm(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
 
 int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 			   u8 driver, u8 perm, struct common_audit_data *ad);
 
-
 u32 avc_policy_seqno(void);
 
 #define AVC_CALLBACK_GRANT		1
@@ -156,7 +146,7 @@ u32 avc_policy_seqno(void);
 #define AVC_CALLBACK_REVOKE		4
 #define AVC_CALLBACK_RESET		8
 #define AVC_CALLBACK_AUDITALLOW_ENABLE	16
-#define AVC_CALLBACK_AUDITALLOW_DISABLE	32
+#define AVC_CALLBACK_AUDITALLOW_DISABLE 32
 #define AVC_CALLBACK_AUDITDENY_ENABLE	64
 #define AVC_CALLBACK_AUDITDENY_DISABLE	128
 #define AVC_CALLBACK_ADD_XPERMS		256
@@ -173,4 +163,3 @@ DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
 #endif
 
 #endif /* _SELINUX_AVC_H_ */
-
-- 
2.43.0

