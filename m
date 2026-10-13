Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25A337BAB
	for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900612; cv=none; b=gHoThTeXa8RpxutHTlspNeSbn/10fC1QSa7Qk1ZPs6nehNt+SMzRWKguAVzxF9X92MW2Ha0muSOzV+XqvVf2oVvCS4X53Dk4+yiFgz7tugaVm72JcRCmOcx6dOEJDlCDwTO1WmmQUmtCgLigTJA1BmOe3gpx82zxvV7mdxhozvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900612; c=relaxed/simple;
	bh=Rjr+YRHT1z4X1taUKfNKTtL1rVrUh3R1/etPbD7vTHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6nJmM9oyC4aZwibEurGuc5rGDnrP9coLDMNsDqYCGaULhIQ5I+epT1RoV2kcrhzyhxNt8dnxj+qm7kNySmvjY65IW1yfTA7SrZa2wGtj0J0jQW9FiHHtfzdBd+DmSnZ7FWomIPwfU9HsUeS7GnD7jg69KEelgrykwGxF58FCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiKgtnFs; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiKgtnFs"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9178510f3bdso41151816d6.2
        for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900610; x=1792505410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yisurU3t7l1Eyq6mHIwnfXowx/ZLuUP0rTi86AVVqvY=;
        b=FiKgtnFs8oObZSfWFphwdNQtwgELtvYq6ADpYHpGbhSLft8VAEfOb84lHjwmqXyeg9
         sDURJxidh+hLmn9CEOPVa8wf+Tp7xebVMNpbB9FgqFJgl2FHTAp0d201MoZNu0EaCfno
         3XaySShC+wpoX+oof4WdIB/soNXd0zEoL/4Eu5ocmla7ab5/y9+owzv/1dIQelhainQn
         flU/cNJVdfrrgyVDxDRETkRRfw10ArEA07jLkvctqad6S6vjrNtFWnBpX7BEEFwd3jmi
         3nwpRelf+Hv5cfJ8zAbzgGXCxlnUL4/aVn6pKhIjkx0rlPCFqua06QMaxWspNztO/0V0
         rE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900610; x=1792505410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yisurU3t7l1Eyq6mHIwnfXowx/ZLuUP0rTi86AVVqvY=;
        b=K5av/ePKrm0/uXzijvq6XR3Kz8Ek9/T48F2BOMgTifc8UIAScMric5e1kQXMtSging
         B+IJft7ZsvXJMgPh4Blw6Wt894YI8Bhz6ZtleEHNe9dY3Vo2iQjQg0bVx21bGFPc5kLk
         IonFxmJIxLt+rR2KJPPfnJOhyw5jCsagf2zZC8u1eYw0KQ8M661288XCmjlbmJRqAshu
         hQLlLhxK+NN3dJjgQXgZS6zV7nQCz4x4QSPHmkWQhiXwODw3JtPL7uSMrlv+6mw3pS6e
         38eswKKWVXskzv9h3Unaf3f+z/ytSTc2w1ni+cYpOnkHl0317uiGjaq0p40fbTJa2z2o
         C+TQ==
X-Gm-Message-State: AFq9FYLIlZxPupmljM2mwlDbDxtJIlUidH2ExKwN1fKOh9uGNMTfJpje
	8BKEYLwrqZ3NzCQlvFzy/oPjeUUXGk0eYz8zDaG6rnISNUEZGGpHvDzv2QIKyvFQ
X-Gm-Gg: AYBFou1G2aXaPZ+57smxT+nFSe26B2fdw/ktqRNGI2sVpCMsg2Uw3mXw3Vg+8h6CDlu
	OqneGDJq7bO9dmK6s+QrcROANX/juIuXUZaSzuXp6Wz5/rwzoHRnFRNmX8mNGrx3SYB78Nzk+zL
	CRkF7qj+UbrQe9tCIcbLyxzqPS8HubnXFLtIh49+Yu/thgGeBppPreSqcKG4mRnY2FhVSzJFPr7
	xiIQYsIqFjTDf2H0kvKz/tWDnHq25ooa48MykFsg8eWTP2qzDxPAQDeeu6mPZit327EyGw11BWD
	U7ml+z1FzyHD0QMMpttFcIfLPy/s1UdjzCLlLSdesY/Cf9XAxii+NPyvXlRVxOlG1t43udX+e4T
	Ro/4PB+4M5i84eN6lOl+r3Mqv5vXyAyYOKeAcr94zZTsPQjBX0U5To5cbb9OuyQcS8kA2vBBd/M
	iIDQGeX7WhBjCtya0ME22WX+O1O1cmB52dRWRy6ys3iF3ZeirEiwQtwIUbezj3sZ6NZIyOr5Pkv
	MisaONrMMeSwBPxBF+uzZ0n8exraRz9kVJyfXyOUo2fKl+DGmmZk9cN9neLqpDk1Ruo2CM1gh8H
	Ful0aFoW0A==
X-Received: by 2002:a05:6214:628e:b0:91b:5d39:e12f with SMTP id 6a1803df08f44-91b5d39e9abmr145797076d6.56.1791900609965;
        Tue, 13 Oct 2026 07:10:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bdfb89sm26022606d6.40.2026.10.13.07.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:10:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] checkpolicy: validate policydb before writing
Date: Tue, 13 Oct 2026 10:05:54 -0400
Message-ID: <20261013140553.217725-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpolicy does not currently validate the policydb with
policydb_validate() before writing it, which could consequently
generate a policy file that can't be consumed by the readers.
Validate and reject it before writing.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
This patch depends on
https://lore.kernel.org/selinux/20261013135042.217207-1-stephen.smalley.work@gmail.com/T/#u
since otherwise policydb_validate() fails after expand_module().
Similar patches could be created for checkmodule and secilc.
I am unclear though as to why we haven't been doing this all along,
which is why this is RFC-only at the moment.
policydb_validate() is currently private to libsepol but since
checkpolicy already requires the static libsepol it doesn't seem
to be an onerous dependency to add this. If/when the libsepol
public API for policy introspection lands, we could export
policydb_validate() and use it more nicely.

 checkpolicy/checkpolicy.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index cc866b3f..18039b3a 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -374,6 +374,8 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
+extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p);
+
 int main(int argc, char **argv)
 {
 	policydb_t parse_policy;
@@ -714,8 +716,22 @@ int main(int argc, char **argv)
 						exit(1);
 					}
 				}
+				ret = policydb_validate(NULL, &policydb);
+				if (ret) {
+					fprintf(stderr,
+						"%s: invalid policydb from %s\n",
+						argv[0], file);
+					exit(1);
+				}
 				ret = policydb_write(&policydb, &pf);
 			} else {
+				ret = policydb_validate(NULL, policydbp);
+				if (ret) {
+					fprintf(stderr,
+						"%s: invalid policydb from %s\n",
+						argv[0], file);
+					exit(1);
+				}
 				ret = sepol_kernel_policydb_to_conf(outfp,
 								    policydbp);
 			}
@@ -729,6 +745,13 @@ int main(int argc, char **argv)
 				policydbp->line_marker_avrules |=
 					AVRULE_ALLOWED | AVRULE_XPERMS_ALLOWED;
 			}
+			ret = policydb_validate(NULL, policydbp);
+			if (ret) {
+				fprintf(stderr,
+					"%s: invalid policydb from %s\n",
+					argv[0], file);
+				exit(1);
+			}
 			if (binary) {
 				ret = sepol_kernel_policydb_to_cil(outfp,
 								   policydbp);
-- 
2.55.0

