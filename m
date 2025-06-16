Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B01865EE
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081531; cv=none; b=qWemzROxx6Bel9ohp7/6d9FZ7rG29SkFr8kw/MswoccULet53ChMZeoPS4osSQ/orVCsMnhyhu+B2tBu39f9bKC+MuPqtKuDqTA3lmiAQQnvcIv43UVSWz1GCujZQC6lUbXeheqWoetaNLTI6ImlVNi0oiwme3bsvyeucoaCFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081531; c=relaxed/simple;
	bh=aGIcoBIgdDuqXZibpH4vhfglAM7ximi8SWcOKtPRgFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7qIQex4s6PDDZ1yLK/LILNuGvCkxsMi9+CoGHmahKoyGQHqhpgCiSkj7s56a/K6B/4ub6fZMfSmdAlOB7Bc8tskbMSBSGNobgVYY+JosUSXibLSYMScz/XuJ2V/AKwFxOvMa1C5zARhU1meIkVXQwOdkvpfCHvej3LbPwtNmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUlnq16E; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUlnq16E"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fae04a3795so48284156d6.3
        for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750081528; x=1750686328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SkgnrGS1NAIYogpSBmH8OZNlduSeoHvRZL7uVWMG7E=;
        b=QUlnq16E5TWXjnu4eKCb1Q3u6eUFgff1XESp99w28unXr5AvxQQJM0oBwcIShgTrBD
         Xczp6pj8MsTm0Kttwsv6ZWsnamH6InxE/nHej4W/c83BwJnWaSmJBPG4pqB496f8vrUR
         928biYLwj1DHVQcslS1LPAN5Ic6niaptTR9UZaXgzF1XspWoD+6YcZZl8BoID+O0MjOu
         FuRqKy4Z4/4XGb3eocBPfnDl23tuNj8RfvCdP/pJcpcMIzhCKDQKm4yPti9Zd8QqF5S2
         515epa7Xbi0E9v469Edi8tIS3yiXX/7qHuQBESi3jSTvmkb8rdKEv1t4HcC6zp6szkU+
         b3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750081528; x=1750686328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SkgnrGS1NAIYogpSBmH8OZNlduSeoHvRZL7uVWMG7E=;
        b=mEYAA+7+CC7JtAsQ3YUlzAP6e4juec60qIbzw5wMXjfzv69+hsZOcOBT22cQPH6bJD
         KdPXNwUVWEvC3v4NAJq0hViqeawu8IMjmWGd/e/pwY2NiayZNDF6LXPfKxAiAFnzIdS1
         haKYWxXo3S3Kcc+548vge2xdgEHMia1JgCmniX1ge/uUBO68V0JJRLw9h4DL77ZyIAnH
         6giqNUqkSwPa9AlptGabkHlafkjr2kIdDTQ+O7W3O/NfdGQg89hnlfkxDfEUBlasvxZx
         qG1hlpgl4AnfLa+dPSaxygKd6QNwkgfP3fFSpiXz9IynNSjruHxlqJpVko2rY0AIA1Da
         GLeA==
X-Gm-Message-State: AOJu0Yy5NeRioMeWlhCzjLyotHv9sPnwwD+5w5383RU303+rAHj//+BZ
	oPzwUhSsU76Pi3rMwY+bdJv8TeqpsYGm+muCcFgGdC4mrh+V5TmQxSC15IXnvw==
X-Gm-Gg: ASbGnctEaF+Tpvtmuo7Y9Nm9RzRR04ss7e11p7xw/LsV17TF1hfQUxyyj5QDdaibXH2
	+QA6nD5PFynMEXrFUgyqB5s2O4o4J8a4HB0vSpRsu9QqoETR9dafWcMaUFklTJHPL2BydlNpHOv
	+y89dLUqvNAZtppk85iSrQtO1XhBVpVt6Kv8cy81EIBrjymoNgi07Nhn2TFSVOR3E9959fwHL3A
	ejcAvnx62FeGN8RFxpdVM/lgO7r7pWgZC0vscZUbq5bwkPJyv1h91a31T3Vf+tmDcpxPOuUn3PW
	Q/mdxBiuJ/T8ETZKX2QEcSYZe7b0dxCY47/N6clXHCvdDXG+qBVBjKP+XYxZkb+vZb9+9L/t0JA
	Ca3l354kVjSdB+7Wz8Kk9Dq6QeLC0pPqXziBARNMd7gAhZOYS7SAPxi2uLCmbVWeWTyZE+f5uyx
	WXfb4IBjNvIUokF40=
X-Google-Smtp-Source: AGHT+IFuHxWl9Ve9bA50pTtbpIQpVr5bjKxh9EV/RiP2MYONAebfHJDyloTJJc+I4nJjsw+qHToz/Q==
X-Received: by 2002:a0c:f205:0:b0:6fa:9d4b:fa10 with SMTP id 6a1803df08f44-6fb4724ac41mr146585496d6.0.1750081528433;
        Mon, 16 Jun 2025 06:45:28 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb4e432100sm21585176d6.116.2025.06.16.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:45:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	lautrbach@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] userspace: replace all links to selinuxproject.org
Date: Mon, 16 Jun 2025 09:44:33 -0400
Message-ID: <20250616134433.23953-2-stephen.smalley.work@gmail.com>
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
v2 uses https rather than http.

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
index 7c66b1fa..cca4753b 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -6,7 +6,7 @@ includedir=@includedir@
 Name: libselinux
 Description: SELinux utility library
 Version: @VERSION@
-URL: http://userspace.selinuxproject.org/
+URL: https://github.com/selinuxproject/selinux/wiki/Releases
 Requires.private: libsepol @PCRE_MODULE@
 Libs: -L${libdir} -lselinux
 Cflags: -I${includedir}
diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
index 43681ddb..303f8069 100644
--- a/libsemanage/src/libsemanage.pc.in
+++ b/libsemanage/src/libsemanage.pc.in
@@ -6,7 +6,7 @@ includedir=@includedir@
 Name: libsemanage
 Description: SELinux management library
 Version: @VERSION@
-URL: http://userspace.selinuxproject.org/
+URL: https://github.com/selinuxproject/selinux/wiki/Releases
 Requires.private: libselinux libsepol
 Libs: -L${libdir} -lsemanage
 Libs.private: -lbz2
diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
index f807fec6..b5361404 100644
--- a/libsepol/src/libsepol.pc.in
+++ b/libsepol/src/libsepol.pc.in
@@ -6,6 +6,6 @@ includedir=@includedir@
 Name: libsepol
 Description: SELinux policy library
 Version: @VERSION@
-URL: http://userspace.selinuxproject.org/
+URL: https://github.com/selinuxproject/selinux/wiki/Releases
 Libs: -L${libdir} -lsepol
 Cflags: -I${includedir}
diff --git a/scripts/make-update b/scripts/make-update
index 4c940e1b..d83e1772 100755
--- a/scripts/make-update
+++ b/scripts/make-update
@@ -30,7 +30,7 @@ echo "Copy $ARCHIVE from $DEST to the server and update its download link and ch
 
 echo ""
 
-echo "[http://userspace.selinuxproject.org/releases/$TAG/$ARCHIVE $ARCHIVE]"
+echo "[https://github.com/selinuxproject/selinux/releases/download/$TAG/$ARCHIVE $ARCHIVE]"
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

