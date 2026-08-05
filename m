Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215447D957
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943814; cv=none; b=oqJIt3fUsu4Q/pqrSyFDNS+y87mkR9FJavPi6r4NAAlC8DlGeRRwDAF38KMhJe2QpQt1fJhgq20+lSWtt5rq2gNEEMaymsY4WpW2t7JE84eIR+ceMPyjZ2Wp78EBiAh5eMfAZ/GZTPU7k4/1lt6ZZ1tqOkF085d1TGoDpmAZGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943814; c=relaxed/simple;
	bh=tuqJMlIAgWJ16h/OteefQ9FziuNAsI6EGjhXvIBtEwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqFwIZ7fzQOmbNTOU4G4XJBK5SfGSr22Y0WLsJ7fXNFgoUVId/KxRhFpDZRUisGNRfeCC5NsIJhVyoqtwNzq7FOIPSv5NxCw6QTITwxdXtET0hagWGhBYoLk0qMbI2oPcRk3ONEFs9x9XK79YgLNCNP5pkBOOZzU9r7ufa9W8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mueH4Zc7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mueH4Zc7"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e54f8c051so60195985a.3
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785943801; x=1786548601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQ2qDMYX742sAkXml2KgLnJyqlnKiWAkYuvkM6nzF+w=;
        b=mueH4Zc7ZfMiMGF7t8LLrZMenG5v+eChqDdFmpWQmEvVScVOnm10MEI+kOV4eWXNMY
         4jIpcfIpE4qg+yAMkgwr0nAjdy5qPUlGx1sb9m1G04k7RJCkwAV4zQKj9c1IzkYrYT1N
         3cQmo/nmQbdzFCh/cdsFNDAoAcFlqSeixT0E30mATPe4DiyQpT7y/B1SFTqfRbM9ho0o
         EZcWdipQUhxerk4SYfXFZHa1DRS/xPJlDZkQGun2DNND37JEDF/6ATMf329dO2h/0hFD
         4WkomWtDzb7UpLrRIBQHnSRfLGE4dmYF810pUkQwE5sUTSVDOHiqZCZv1SWehc4v+uvi
         er/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943801; x=1786548601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQ2qDMYX742sAkXml2KgLnJyqlnKiWAkYuvkM6nzF+w=;
        b=Tchm09YIYMj9JDDuph3YYfXXlyOWiZAhAqQMUu5saKemLWIG6VDXrrqCN0/+uHSXlY
         5I+GypID981SfP0/YZRGUVrbQ9XnKHiP4sKp3Urx6rzLbD7CDJTyXgTL1YOxzhWp34gw
         Aox8dz5aDl+PbCqcchl1TXnDa5VpC1wUvtYuX/FzmajuvAmtLWqKX4aEZ+TAlhWgJWF1
         y8nDRDoY03BmV1wKN0gX/bH7RnhQxrvBFKRYlykIH3G3obNn8BWXYZ65ObBvg/nII9Q/
         xJqr8uLfRhl31oqYamkIGpox/yvLK9vERlGAcDP8z1Es1f9T098vlL+OYwS6eMAsr/Tc
         1QXg==
X-Gm-Message-State: AOJu0Yz2ZRm7dpEuLDvA5dVe+tzFTJJnT5RbDilAu85YrJe+GtPGuG3t
	MS6t48A+dmdx/QBOXN3SDvr7XqYAj6TycxK/sf/R5T0uS87W0hsjtLVV6idAgQ==
X-Gm-Gg: AR+sD11Og2nK6E10QZZP5XEPwsj9KDerFS3Vmkq5AWT6tY1Z5l0jBZgN7IXXIcHEEjk
	YwGml1mSr/WAQgw0MWNTC1sSpd7xrZkwExhZm7uq3/6bY9Wj6Sp+Db1V26vAPv07PzVruNsX1J1
	wwSjrfiHkAMl1wz2bq+sXWOh8D9qkVlFgcEDp/7Ns/31yq+V3JDeN4AyB/ZYd9k2ggwv0NkmfMW
	LDGYXhCIlMHRD7KRKr5luhNNGSZU2W8ZhFhh+ilHD+nLtbqFK/RdjYNua2xOnpMIc2QzaeAoqbk
	2GiQrOAbh41dgFyBwZ4KjbZflILd/IsrNfvwggCibYqN39CAet99ufKCSsxWJ7LoTfFfNYVtnQN
	tz6vCZiME73oznak85dmfs2Zo/sZGdUQcwH300tNCJofKFLWwYm5SjKgGVrZREIDaGujldA0zy7
	JH/uB9A17pNGlNI8fRRK7Fk4A4ckoMsSr3uW3H/3EelJxujfNY3Pa+xs6HgtlWg9LhzwolNbqI6
	dIdTny+D5Q=
X-Received: by 2002:a05:620a:29c2:b0:92e:f101:5dd6 with SMTP id af79cd13be357-93648fc72bdmr523691485a.6.1785943801185;
        Wed, 05 Aug 2026 08:30:01 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a5b9bd2sm174088085a.45.2026.08.05.08.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:30:00 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v3] libsepol: Validate any levels that appear in a policy
Date: Wed,  5 Aug 2026 11:29:46 -0400
Message-ID: <20260805152947.15933-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Policy validation only validates levels for MLS policies, but it
is easy to create a non-mls policy with levels (just read the
policy in, change the "mls" field of the policydb to 0, and write
the policy out). A maliciously crafted non-mls policy could have
levels that cause an OOB access when processed.

Because of this, validate any levels that appear in any policy,
even if it is a non-mls policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3: Fix formating

 libsepol/src/policydb_validate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fc66a4c7..4cdf0b78 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1024,8 +1024,8 @@ static int validate_datum_array_entries(sepol_handle_t *handle,
 			&margs))
 		goto bad;
 
-	if (p->mls && hashtab_map(symtabs[SYM_LEVELS].table,
-				  validate_level_datum_wrapper, &margs))
+	if (hashtab_map(symtabs[SYM_LEVELS].table, validate_level_datum_wrapper,
+			&margs))
 		goto bad;
 
 	if (hashtab_map(symtabs[SYM_CATS].table, validate_datum,
-- 
2.55.0

