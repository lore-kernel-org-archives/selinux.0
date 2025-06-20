Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2772F0039;
	Fri, 20 Jun 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441547; cv=none; b=mh9GC/nyyPYOkSoOdMhZApYMsh4g/EZS80srO3L9UAbuBjj+T581gY2Fy8qgLg4ymjMSwoGyKrjURT3+CybY+6TA0AGpVidep1Q1/cXLnahPGqfZIlpESqz9jDCiJTMJj3jPiFYUfoSFn7ehKl7iwv//039t30xIn8Nnw6a0dMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441547; c=relaxed/simple;
	bh=MjKpAKZo5FjX7PaT+QemFCIUT9Y9dnutKzpHDdj24Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvxErAcFQZYxClqD0Jg8zbWhwHDWRFpEdBHIV4UjBFU8bpPz9BMPsWi4FQOQ9M7LSQsXs784vjaH9g7ktCATNqZSqEwfb/pQZ+wifZ+vXrTtAdvDi5nSP/dV+InSwy0kTHE/llyItRp99AgvCoR9yya5P7zW9CkJOPVqOP9Czts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbj5JTCm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbj5JTCm"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fabe9446a0so22332266d6.2;
        Fri, 20 Jun 2025 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441545; x=1751046345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jOr8p7GpT+fo1u8WRYAqzyLQU5YxkegLOqOZEkQe4o=;
        b=Xbj5JTCmo8j4YxPQW9OKUv6SD0/rY8O9ENPAQuAnDjL7+GdtezO6mOmUznnpbhwyh3
         RvXENGNRcfx6KPZrucbAQ/3dEhBCLgawZIOWnvQ74orGVvYUR45Hh5mgizU2t5IqRErF
         WAUOaLklDLgTeo6+3iHEkzesoiptgYJnt+iXAB+Malfbb0plE/3Lvn6qAXljFZDD+QWb
         yYjE4zSLVgGuOz+I22u5q4VpCxUOupVo/O8jVufacqiLh4SzLmDwXLyJE7NocrNHAFda
         DSiON20kx0AwIYd1Rda4ufXnBvvfcyvpf1xtfDEO7+SeXK9UDzwFDu5FiTfx5Kh7XEV8
         Z0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441545; x=1751046345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jOr8p7GpT+fo1u8WRYAqzyLQU5YxkegLOqOZEkQe4o=;
        b=DdZOcoArZBiUCAx9ZGZ6b5z+K9oV2hM1QkZEa9h1Vs0X+aP4GKPEUuUCU3tm+nbu4n
         msS9FLek/eWk/EtHN2rf1CvpudKmQtYEJViNkYi0yc/BodMw+FzAt1Rshl98JZM9+0uE
         9E2mjA07eP+FUHLA5FS4z2OxxlA0+ZXWK++lwUyxDYQylsbCm0uG2Yod9eGGK/163IXe
         mAvnqxjcvnjYQS5TAGlBakxxyRvoANLmMmCdwtp2o7Tq+SdDGjiWnDpEo3OD47dAC45X
         vi7+h2/9awMpVvFnllxp8o1OUmAD9SvSVDcn4HSbd8VjLqn8bxTr6u1MK1CevUK5X2v3
         TzWw==
X-Forwarded-Encrypted: i=1; AJvYcCVD32TPG/gWWgfE+RDxJaSsJ2YR1yO8h6KOEULkJkkm2zgqKQHQJjPzyFv7pznol4qnD6CbD0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWEy2sU6MbGUnj2BIwFIgvmpviWkJM2lJTu04sSHWfl1m7pNG
	em2uCPKOFfIyz0JooCvGiYuHCiVlIcu7TipltjKyDTjToHIc1qm8xP+29oIwOA==
X-Gm-Gg: ASbGnctet2g7ZhNV4ZhriyKj2RgzkOWGwyJnaAMD9GHzcxgjQDaexiXg/X5Qr6+Es+I
	Pys6vdidY/LZ8wP2VFE90TgykiWPfgB5XKIxTkDw7Ihz4VHa9gl6PI9hNg3fNiogF2rvcvYTF/g
	MQ/BxvWy/ZZdyZEDiWp+EpLxih5b85/5VCiaZgqknDkh7tOSbDzG4Hrx5aLX/+MXU+8T8LWMTAq
	aqa2l3XYCNLRnXy+Tslf7aFIyyAyjS21g2oYUa9iciPX95vTFbk+GNU4skWUW2zML9GYj3OHJFr
	1XjTXDiYaD8fh02PBMQiEH+ViplWbinpXPzOoZuDeRd1l/DPskVLRAfCPuYlcCGwayBt3IVsajO
	Xtsa7SpdlGXehWRrgFiaBqjMoT/fgk/w2giQZBKkm26AjcSdprfyg1dTlZ5hCI4oIKg==
X-Google-Smtp-Source: AGHT+IEhW+2wzEg+VGCPwiqrg8H35eO+0t8v6jANQdm8o3h9BOcXMF3qT8MljzvFNvxczqboAZ0Kfw==
X-Received: by 2002:a05:6214:4b13:b0:6fa:b9e9:e799 with SMTP id 6a1803df08f44-6fd0a558a03mr52994396d6.24.1750441544719;
        Fri, 20 Jun 2025 10:45:44 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 32/42] selinux: update cred_tsid_has_perm_noaudit() to return the combined avd
Date: Fri, 20 Jun 2025 13:44:44 -0400
Message-ID: <20250620174502.1838-33-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cred_tsid_has_perm_noaudit() currently just returns the last computed
av_decision (avd) structure, which in the case of multiple SELinux
namespaces will only contain the decisions from the init SELinux
namespace. Generally this has no effect since a permission denial
by any namespace will cause an immediate error return with -EACCES,
but in the case where permission is allowed and the caller caches
the avd itself for later reuse, it could lead to the caller
incorrectly only using the cached decisions from the init namespace.
Change cred_tsid_has_perm_noaudit() to combine the results from any
avc_has_perm_noaudit() calls to produce the final avd that is returned
to the caller to avoid this problem. The combining logic varies
for different fields of the avd, e.g. intersection for allowed
and flags (per-domain permissive), union for auditallow and auditdeny,
and the seqno is always set from the current namespace only.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 2b567fe2b52b..61716e17538d 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1558,28 +1558,38 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 {
 	struct task_security_struct *tsec;
 	struct selinux_state *state;
+	struct av_decision tmp_avd;
 	u32 ssid;
 	int rc;
 
-	do {
+	tsec = selinux_cred(cred);
+	ssid = tsec->sid;
+	state = tsec->state;
+
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass,
+				requested, 0, avd);
+	if (rc)
+		return rc;
+
+	cred = tsec->parent_cred;
+	while (cred) {
 		tsec = selinux_cred(cred);
 		ssid = tsec->sid;
 		state = tsec->state;
 
-		/*
-		 * TODO Do we need to use a tmp avd for each
-		 * avc_has_perm_noaudit() call and intersect/union
-		 * the sets as appropriate as we go? Or can we
-		 * simply use the last result since we generally
-		 * only care when there is a denial?
-		 */
 		rc = avc_has_perm_noaudit(state, ssid, tsid, tclass,
-					  requested, 0, avd);
+					  requested, 0, &tmp_avd);
+
+		avd->allowed &= tmp_avd.allowed;
+		avd->auditallow |= tmp_avd.auditallow;
+		avd->auditdeny |= tmp_avd.auditdeny;
+		avd->flags &= tmp_avd.flags;
+
 		if (rc)
 			return rc;
 
 		cred = tsec->parent_cred;
-	} while (cred);
+	}
 
 	return 0;
 }
-- 
2.49.0

