Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C7420E7C
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663219; cv=none; b=e/1zUFFfKbgymP8/wcE+73IkVgtaHA5RLlGT2nUWDmUPbJTDrQmPeCyui8C84In8yDzsvPEOoVkjv2rzYK2sUBd4h6ss5tHEOKIyscHW/WYE64YYsylqOnhEOefiR/bNiW4JK4FjlUZxrGc+04l2qUCSqgp4juWjEcwlTzlTR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663219; c=relaxed/simple;
	bh=YY+T5n/vdT1i7CiUblm+95CzQVKa2Z17BfYeKl/0TH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q331rtodQdFW9EiApAFmdKmvYH8qf4Q0hdqo7O2xKXMTcujAHo5OyYDdAMnjHFszZgj5+x48xno5qsA0lvH3TvxD9c1rCsE0G35f43ZNXlmRS8xGJKb3M0fQ4dHyhu9KwxlpQ41e/7nUhBRD2YCT+nSrGUWIXUlsNHM+r60Lff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/4sy1S/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/4sy1S/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2cce930cso47881961cf.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787663217; x=1788268017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qi0coW40btDxPif/D6043r8xyZDzd1JQfvz+byfRvNg=;
        b=I/4sy1S/l4pUUS2JNV37uVbupOLFgshOyg52NY6ks9wugVgVqExT1mvqL3hueU5x4Z
         mIzuQq67BuraDKJA/uv9DFiTCsiJ7WS2XPepsffR0zxtmD8kdvjJbXT3vesbgibDGabR
         VC84AT1dg1oAIGMSYLvUnj66247FojAgpe+5da2yHVeYkUlzjrHSLjtkMXtqVQps+Dz/
         T4808aDgDkHZJKaGAcnbCqJbUS2aNeSE2sJl820vJfxn2BOfep3vXKPMW3gJ/r9Azr/B
         6emUh6sftp/59EqXd5P/CSFLhGOxTW4KHpNZSEjmSW/3r0eWZy4wAjRYBS00CnGRVUzr
         6vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663217; x=1788268017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qi0coW40btDxPif/D6043r8xyZDzd1JQfvz+byfRvNg=;
        b=dYM4TJRSfAZnZ2Fxq4I06JIMi/RbD4+h8Y6opAKkzhVkXuceS4hUBAX5ouzTMmI0Z2
         +qB6o9K2I3mX7YGrfVQE0/gB7IsaS9IZ1g2oWtSxL7mtRT6oRyLNOcpGOEOW3NhFSTkz
         LntVE6bwT0CrcpX1NHHk2SA38eKYYvgOO3NlUihiey/AWM93Wb/Yoij/qW340NuilRZt
         QNTOkNqdlIakq+L0DFcF5oj8eXfDjg1AHag19Ktkt1cVy2K0e9ekA1yw06fZR++xtYWX
         h+SqB4YOvNnc5Yk/rrUJU8Ch/IJxjofEJz46ek24NljeinLT0uAUXfZtBuUtYGfo6aU3
         F+1A==
X-Gm-Message-State: AFuF++mR7R4HpEQiZBaUQiswC2JtReAH+F1XPUz6/k5Jh3oFilnEOXUq
	LJIKrgm8TpQ4CV0FCBCJWZ1dPCJbnR80AzrQLH7hc05a6lNkWg4eTSmkXqxV0A==
X-Gm-Gg: AR+sD11+2uu99G6WylORq86vq14kq/K+u4qJ0nZgQ09+pz5rsdHh48L4CEkliOCyS7F
	Bs9CYa+mtYEe0/bVHKcnr87YSCAVOifpxAlxI9BGXkU/nfvB6CKm3ylU0tnTfeTTU9MOTlovqBc
	oO+Y8IT19F+34gk2+LPvxEEc754Qb+/11ZjzSTViedauPPXwWrKL/03J9e88KlpmnTN6/dxRDOL
	LsL8LyCds1I/gL2cIV5hQGKVp5uuSzR1m+fcvjP3SdSORSBmbvFr/l/sYHDyJ69Jqsxlop9xef5
	zNdVJ+23vU5apOdO6PNP2n5NL14EztIiEj4lSde4DSbM8vFXSeIKwpU0nBQqebRChBWNvX0OTKi
	G6906xyn6J5rfmo9EJT2ZjrFE7oFDQby6niZQ8tzq4TSx/AUfpQF50IMiGCT0vKnFdWfO/EThCn
	xCCcxbqnvuM2YhX2inaZgQOaiSfPnEhQ5W0OcqZtH4Rnt5mC3tB33WHeUKcgd4hNSXBMKJsIl4m
	SkqJvjeuQRzGu60OhaVcSp2XXLaSNXYNKS/ZTqn4o6f0Jo/WwW+XrSm41J5L/HeWYIeBg==
X-Received: by 2002:a05:622a:3ce:b0:52d:70b4:2e1a with SMTP id d75a77b69052e-52e2f05e230mr71224081cf.1.1787663216566;
        Tue, 25 Aug 2026 06:06:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e0980fe8dsm68668431cf.0.2026.08.25.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:06:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] checkpolicy: fix operator precedence in flavor check
Date: Tue, 25 Aug 2026 09:06:40 -0400
Message-ID: <20260825130640.85223-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_local_type() and get_local_role() intend to reject an existing
symbol whose flavor disagrees with the caller's isattr, but:
     if (dest->flavor != isattr ? TYPE_ATTRIB : TYPE_TYPE)
parses as:
     if ((dest->flavor != isattr) ? TYPE_ATTRIB : TYPE_TYPE)
since != takes precedence over ?:. This happens to be equivalent to
the intended check today becase TYPE_TYPE is 0 and TYPE_ATTRIB is 1,
matching the isattr values, and TYPE_ALIAS is rejected either way. Add
the parentheses so that the code reads as intended and stays correct
if the constants ever change.

No functional change.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/module_compiler.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index d59e493e..07f2b3bd 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -636,7 +636,8 @@ type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr)
 
 	} else {
 		free(id);
-		if (dest_typdatum->flavor != isattr ? TYPE_ATTRIB : TYPE_TYPE) {
+		if (dest_typdatum->flavor !=
+		    (isattr ? TYPE_ATTRIB : TYPE_TYPE)) {
 			return NULL;
 		}
 	}
@@ -685,7 +686,8 @@ role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr)
 		}
 	} else {
 		free(id);
-		if (dest_roledatum->flavor != isattr ? ROLE_ATTRIB : ROLE_ROLE)
+		if (dest_roledatum->flavor !=
+		    (isattr ? ROLE_ATTRIB : ROLE_ROLE))
 			return NULL;
 	}
 
-- 
2.55.0

