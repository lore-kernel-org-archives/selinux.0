Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D4298CDC
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080467; cv=none; b=HbnmtnrpJokXqtTVEnryo3FlnpXgpPWO2kl0XqJOmMrZBQ29UBf+BFBig12OCUcYdVkqmYkixuxS2Efnh4LKF92AeDdjdcOZbMKKgJB6LOIn0LZ+sETHq/YgG328MWE2kcoxDH5Alh3P6ptZq3zBIyY0NzINCSR4ZFN3pb+eUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080467; c=relaxed/simple;
	bh=DrJYfWH0rIupXO+/JG6WWDEt1pbEsJyO9rLVzW8uyxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvaRw2tpJVV3CTEUr6+6XQAyltqHIvIt/d5dbCFb/879SjvbV24R4UXoEGs/hm/FLnmz9s5hWodaoDMePV1cUJtPw/cfdK9Z7oKSfX4mS9//JSkTpQR0ldNDZFRSdkUOIHem2wyU2WyJuUWPOSWss36bBXVqHcSCfOVfhLhshMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kraq5Tfq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kraq5Tfq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43afb04a7so33460901cf.0
        for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750080464; x=1750685264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/ewe6WFbtYJrO6jq5GgSWgTu96WybUz2MtVJzinwUI=;
        b=Kraq5TfqTv2MbcjZa1bVnDYAd+4rp+sRD4Fk7EvjFFj9AwGLZ3o5BjmEjqqAAozmZb
         8BBl8Xwvd3nxO1mHuomBHntkeHLWecWJ6c45/dVZD+0Mk9ovrrQQZ+coTjBSqBhVIiYS
         yrC8dhE0NZgUH1gP0Suqel5N+AT2s1cZIXycGuLGCySkjuoQ0v1N82rw/tGkr82yNjpu
         891+QDlNSWEMQRY9J6YQntdYwHW1ZFsKU8nRjSlfE6PiiRsv20Y5VLMXPH3C1StoDkhV
         Nu1DVAnqXekDAwJyZF6n/plaAKUqwUZ2IpesIa+//usZvWYoh4rflPGE21db7D4Cc/CK
         dBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080464; x=1750685264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/ewe6WFbtYJrO6jq5GgSWgTu96WybUz2MtVJzinwUI=;
        b=jusjnEH+WXlZKIE2cRgd7WQpfDEOJBVMcYtP3yduNNY3LJhdbDHo1UVxOLOV/JlC2S
         TQQ9PeNpITy7+24XQ2gy5rVcPM8bh9/1GdNxXEpB4hEmzkZN0si2BS40O3z+G3aKbNyF
         ySOvZs083g/564AenYFLRWtdoKh0N/4E8x2Pdu/UUL7pNJa15iPSVZU0RhwC4Q5dd3Cv
         +xsngOc7G2084kgNFXQnLdVc1cZy7Y60vg85QkCGNbSTWCyMazFynHwvNYul4jxkQrDo
         /Mcac20cvB3gmUq7hYiFuVJ6BV+garkGB0P4dQEXhOZTKsxQryW3bsIlOuAIUm757ZIG
         z42A==
X-Gm-Message-State: AOJu0Ywl9eFEMsgcSsj4vINQBzyzdfTyOHgIXwmmqWjCfesR9zJ/J0VT
	Xdnrt6ECIyHr12afs9KJC6HbHxXdFCRd7Bn3z6Eh22tGl6pNX/HYolJQazxUaw==
X-Gm-Gg: ASbGncuF1sWCvx2duL/189CpMBbQJ5+/3/sG3JjSuHC/ETDqQS1PUTSgF+HwejwshUS
	rcdma+ZzmvLvrX9XNSFThjCXZqkseXbcr0Kp2Rr6Gnyza7dyzADP43vAKf8OW/v6fETsxQFFTrL
	HGXSYZmcWkCLE0kXehQflutdZ2E7X+rs/+mHb7HA9b+77TYzSztR3Z3BhJOsUUCxQLOczfpdJ96
	z4zTHk5qsWQ8R4CD8ds8wHhY367N4YLOZVhtlS4xbzIbbhrlc6ej/WR8X11NWk2kpZtKq35YAWX
	mQjnU6E4MGuR1jbfmrzCmRaV1EMPVMMxzm1gDPW84AUyTylt+XacJe70ate/o9cZVvgR3Y4xCMG
	YKnoB7U+zeIMdqoMlz79MovB/tXIPAFGE+M+mNbaoIYo8zobqYBt9KNH6FKrL6/wYRWwsgoyz0y
	6Kz7VPlNBibXUJzog=
X-Google-Smtp-Source: AGHT+IGA3s4ELg+ORtQBkY6+VxqCduVbB2djCWYwQkFJOuopoG9uHQ71obJd6CsSh4QdCMB0koYm+w==
X-Received: by 2002:ac8:7f53:0:b0:4a4:3913:c1a5 with SMTP id d75a77b69052e-4a73c4bf09cmr146490051cf.16.1750080463542;
        Mon, 16 Jun 2025 06:27:43 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a313c1csm49129951cf.33.2025.06.16.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:27:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	lautrbach@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] userspace: replace all links to selinuxproject.org
Date: Mon, 16 Jun 2025 09:27:24 -0400
Message-ID: <20250616132724.22406-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all links to selinuxproject.org with links to the
SELinux userspace wiki or the SELinux notebook as appropriate.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 CONTRIBUTING.md                    | 4 ++--
 libselinux/src/libselinux.pc.in    | 2 +-
 libsemanage/src/libsemanage.pc.in  | 2 +-
 libsepol/src/libsepol.pc.in        | 2 +-
 scripts/make-update                | 2 +-
 secilc/docs/cil_user_statements.md | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index e6a677a0..575410bf 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -8,8 +8,8 @@ You can find a list of open issues where you might contribute to the SELinux ker
 https://github.com/SELinuxProject/selinux-kernel/issues or to the SELinux userspace code at
 https://github.com/SELinuxProject/selinux/issues.
 
-See the selinuxproject.org [user resources
-page](http://selinuxproject.org/page/User_Resources) for more
+See the SELinux userspace
+[wiki page](https://github.com/selinuxproject/selinux/wiki) for more
 information on mailing lists, documentation, and other resources.
 
 ## Reporting Bugs
diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 7c66b1fa..587a4dd6 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -6,7 +6,7 @@ includedir=@includedir@
 Name: libselinux
 Description: SELinux utility library
 Version: @VERSION@
-URL: http://userspace.selinuxproject.org/
+URL: http://github.com/selinuxproject/selinux/wiki/Releases
 Requires.private: libsepol @PCRE_MODULE@
 Libs: -L${libdir} -lselinux
 Cflags: -I${includedir}
diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
index 43681ddb..978474dd 100644
--- a/libsemanage/src/libsemanage.pc.in
+++ b/libsemanage/src/libsemanage.pc.in
@@ -6,7 +6,7 @@ includedir=@includedir@
 Name: libsemanage
 Description: SELinux management library
 Version: @VERSION@
-URL: http://userspace.selinuxproject.org/
+URL: http://github.com/selinuxproject/selinux/wiki/Releases
 Requires.private: libselinux libsepol
 Libs: -L${libdir} -lsemanage
 Libs.private: -lbz2
diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
index f807fec6..55f06304 100644
--- a/libsepol/src/libsepol.pc.in
+++ b/libsepol/src/libsepol.pc.in
@@ -6,6 +6,6 @@ includedir=@includedir@
 Name: libsepol
 Description: SELinux policy library
 Version: @VERSION@
-URL: http://userspace.selinuxproject.org/
+URL: http://github.com/selinuxproject/selinux/wiki/Releases
 Libs: -L${libdir} -lsepol
 Cflags: -I${includedir}
diff --git a/scripts/make-update b/scripts/make-update
index 4c940e1b..5549904b 100755
--- a/scripts/make-update
+++ b/scripts/make-update
@@ -30,7 +30,7 @@ echo "Copy $ARCHIVE from $DEST to the server and update its download link and ch
 
 echo ""
 
-echo "[http://userspace.selinuxproject.org/releases/$TAG/$ARCHIVE $ARCHIVE]"
+echo "[http://github.com/selinuxproject/selinux/releases/download/$TAG/$ARCHIVE $ARCHIVE]"
 echo ""
 echo "`sha256sum $ARCHIVE`"
 echo ""
diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_statements.md
index d5674f12..dad88ef6 100644
--- a/secilc/docs/cil_user_statements.md
+++ b/secilc/docs/cil_user_statements.md
@@ -358,7 +358,7 @@ The user `test` cannot have greater privileges than `unconfined.user`:
 userprefix
 ----------
 
-Declare a user prefix that will be replaced by the file labeling utilities described at [http://selinuxproject.org/page/PolicyStoreConfigurationFiles](http://selinuxproject.org/page/PolicyStoreConfigurationFiles#file_contexts.template_File) that details the `file_contexts` entries.
+Declare a user prefix that will be replaced by the file labeling utilities described at [https://github.com/SELinuxProject/selinux-notebook/blob/main/src/policy_store_config_files.md](https://github.com/SELinuxProject/selinux-notebook/blob/main/src/policy_store_config_files.md#building-the-file-labeling-support-files) that details the `file_contexts` entries.
 
 **Statement definition:**
 
-- 
2.49.0

