Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AF4BD0FC
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446608; cv=none; b=ERmT4KiSpp8K32AKDM0HmbH3ONDAmSuEuR3lpOeA7XzZfbCI9aJlpO8rrdIJiPsTMHcxpladHBuKoqgid2TTEBH+ADGuklrGs8acfG29UsW+vsB34xNrH7Ajkt+bwUAL0PMjCh3/FLwSjCs3WbAmdQjEnLreMtLYCh2nVYl0AbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446608; c=relaxed/simple;
	bh=VBluen8PTH9OI3TOhMnqdJPGM6k79/txMfe1pQgJLXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phPES2IXAoLulVbTW5RHNeIUOYKMGD+ApGUkuDCyxDVhvh7irNl+4RO7Ibm8kQnXM/u4Qx/Y7AuhrnrkBxCgYG7dAuQig58y6bTuGUmDihdvAAVJedHJYMRMIdCItZbFnv3uVDGEZiiBF1+U2CG+4pXnkFwhe1BgPOZfp0mdHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kns3431U; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kns3431U"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52d8679c149so23254211cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446596; x=1789051396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xto/F87EUdIquy3X2DDuJ/tQwiZNjeUFhwI+goVREYk=;
        b=Kns3431Uoze8+xNsmcyH2z/cO1h7qAR0L91fSabAii1+ViIhpFRBR0pjFHwVm/ZE1k
         NfjI/JhFc+fJSstp0mgY6zt8gd0pofRr2Oz1z3/Vhipzf9l/MMs+251wIKHFusQKT/Pm
         iSHZKRORkkk7SXBl3lzRNwpG802/pRbYAlq6hnLoIoIjMemTFdoLycmBSvUg+/e9I4gU
         1StIICiLk5D/YhvNcWzwqjcO00PuSYvaHNSuf1EobCAtmE4EYR8ITbZXTycjYfjK9OYa
         1kOLCR/7AW8TfTWt7/no2eEeKdkz5fcgNG+xx770QC1Eoj90rbpz5y9Wd63PLDdwFENE
         1Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446596; x=1789051396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xto/F87EUdIquy3X2DDuJ/tQwiZNjeUFhwI+goVREYk=;
        b=EdQIbsmX34MBv1T3aiDNk23o5UaUUc2C4CQsZXj4xg3kIIRjR1q79joFVEgztqhrCd
         CBwLSm6N696oN7rSS2kmA+iMhVUsLKyfNVN/qp8+pd7fICK85ecOcovQpeKgCTi0gpLT
         7+evGgiLEoeWB0a6AhIJLkp0giZOvnw0QoWZbyF3M8brG4jv09TgWthdk3QK3ZCXp3ip
         kzYUbLtDExwbetM3JaLv9h93/eZFbYsuJY5jdvfkoUjsbEctYny2Wcgn5V95jRI7FsMG
         GQ3Apgn340/plVtkeB4vFW6Yk3/vS52Soiy5NcNEJlbKj/RsH54lkfyz49L59A5NhzGD
         J37A==
X-Gm-Message-State: AFuF++kFGhaarnZsGfilnJx7o0FKGtYGludwc/NcO28hKFMu5h23exWY
	92pmcwwBAZ420/WE6WF8DhecJ0rrp2teFFr4/DCATTjd5Vi4hTEj7aY8tCrTxA==
X-Gm-Gg: AYBFou39nCfwGlcodnIYxxvRCMBUvGczTAs2bcjY0qs9CpP7wuKXrDt837MuvrvywXi
	zq8c5p9B7QDWT7OkbHuRRNV0RZhM8XNmJPWB5Qbt/tvdhXJtKCbvn50ZrazJ9xaoCFvTm1rCDFX
	zPDNCLdfdjpdLFhPkxWe7RD+RB/59K2KglB0iqLBa789Gy4H4i44AMVQoxHvUd52u47is5hs8fC
	HTVXoYUaEy5UVplbbZq8gv4wH6GQSdytDCNkQq4Ryn6wjmO1vEQDm9HB6/VYC+GqzG/jqH70ZFp
	Lng1CWUHIk9g/hGc4nvYpSMrXn8XzHbYRq1kR87U7kFVdj/Ha1p7B2hkK+rPfgRYR4cZkU8pvZ/
	uec2TEyp6ZXOVgmpwv9Hg5trsUEq73orhSbG9wOjlJ2czVCvWIBnwbhTWQV6EoLvMHAzVn9nP9V
	NlJaiksjScr/6Pu08Trflr4u/aeEKiJ3vOI+xvi0tJ2u9SCW+gwSwoyTUURG60ABydf9nedzXUW
	q25MZu/O04mJzUADHgTLL7FQq2fHVwmoL2wPoP1am2UKlVAbM9t0Y80zl2BTRpfMpR5aGQxjWI=
X-Received: by 2002:a05:622a:4085:b0:52d:7b6e:4986 with SMTP id d75a77b69052e-530524629a9mr10300701cf.23.1788446595660;
        Thu, 03 Sep 2026 07:43:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:43:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 7/9] libsemanage: refuse to remove or enable a module owned by a RO store
Date: Thu,  3 Sep 2026 10:34:32 -0400
Message-ID: <20260903143433.19810-10-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semodule -r <name> on a module that exists only in a read-only store
has nothing to unlink in the writable one. Detect that case in
semanage_direct_remove_key(), notify the user, and suggest using -d to
disable it instead. Removing a writable-store copy that shadows a
read-only one is still allowed and simply un-shadows the vendor
module.

semodule -e <name> when a read-only store carries the disabled marker
has no effect since get_module_info() reads the marker via
semanage_module_find_path(). After removing any writable marker,
re-probe; if a read-only marker remains, fail with an error message
pointing to its path as the cause.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 5646d451..3d203bd7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2276,6 +2276,23 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 			}
 		}
 
+		/*
+		 * A read-only store may still carry a disabled marker for
+		 * this module; the writable store cannot override it.
+		 */
+		if (semanage_ro_root_count() > 0 &&
+		    semanage_module_find_path(sh, modinfo,
+					      SEMANAGE_MODULE_PATH_DISABLED, fn,
+					      sizeof(fn)) == 0 &&
+		    access(fn, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s is disabled by the read-only store at %s and cannot be enabled here.",
+			    modkey->name, fn);
+			status = -1;
+			goto cleanup;
+		}
+
 		break;
 	case -1: /* warn about ignored setting to default */
 		WARN(sh, "Setting module %s to 'default' state has no effect",
@@ -3058,6 +3075,29 @@ static int semanage_direct_remove_key(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
+	/*
+	 * A module that lives only in a read-only store has nothing to
+	 * remove in the writable one; disabling is the closest equivalent.
+	 * Removing a writable-store copy that shadows a read-only one is
+	 * still allowed and simply un-shadows the vendor module.
+	 */
+	if (semanage_ro_root_count() > 0 && access(path, F_OK) != 0) {
+		char ro_path[PATH_MAX];
+
+		if (semanage_module_find_path(
+			    sh, (const semanage_module_info_t *)modkey,
+			    SEMANAGE_MODULE_PATH_NAME, ro_path,
+			    sizeof(ro_path)) == 0 &&
+		    access(ro_path, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s at priority %d is provided by the read-only store at %s and cannot be removed; use -d to disable it.",
+			    modkey->name, modkey->priority, ro_path);
+			status = -2;
+			goto cleanup;
+		}
+	}
+
 	/* remove directory */
 	ret = semanage_remove_directory(path);
 	if (ret != 0) {
-- 
2.55.0

