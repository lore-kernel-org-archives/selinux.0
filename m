Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38D1DA3D
	for <selinux@vger.kernel.org>; Fri,  8 Aug 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678115; cv=none; b=E+G3LjoMwqkXRLhkp5xPFTWGPIZ/rpwLefTqwrTMU7UPD53Ks1ycmTYt9bvlKBD3MP3i4lSP9unDQxHNKt6qMpYDrj284sPUqU9/gUrBYoTQNJJvl4Ebvul7dERpMtPtse5BZQp5yxEvZDVkojUbw8TkxgZbvS7+FlNrc5ZErOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678115; c=relaxed/simple;
	bh=jrVjrVlVhSVRf6iPrpXsFJgbGnG2uanqTpysEJZf0mU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UVoNnwvmB9rGsFJ7JvSiT5Vh45a+wYz+QICxJ/vQ7QBxkjTI5bhv4bLNnmdF6f9Mi60gcXhi0PKfmr1UvLZJEGmFuQgK/yy6EpInHaiErfOfYVlh9bXbby0dgKvdCMRQkAGSrR6fYBrS2/vVMoVRVnoOVMY56JyUkAF7L2gjFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d/PGocmY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d/PGocmY"
Received: from ericsu-dev1 (unknown [131.107.160.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85FDE2112215
	for <selinux@vger.kernel.org>; Fri,  8 Aug 2025 11:35:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85FDE2112215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754678106;
	bh=5qU7/Mdp2EWnkEH/JGD1kePuPZ4+pd/CmMJjxl92GX0=;
	h=From:To:Subject:Date:From;
	b=d/PGocmYQNJU8ZfM5wMYGDwLgv9xfu0vcX2Ae3k4hh8UsdxWtAzDzk3bAt6IrvwmO
	 kFP1L5+PFI6OrrjnzSxqmXaFpUvpT/iKZ43wmtjAN9/46VItotuLwd1YDkr6+ofk5p
	 QSN4qoMGRBQ5GyGv0wi7Cp5k/biBOAdecepxVpKk=
From: Eric Suen <ericsu@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace] libsepol: add bpf_token_perms polcap
Date: Fri,  8 Aug 2025 11:35:06 -0700
Message-ID: <20250808183506.665-1-ericsu@linux.microsoft.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New policy capability 'bpf_token_perms' required by patch to support SELinux
for BPF token control:
  https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.microsoft.com/

Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 0835ea21..9868d41a 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -19,6 +19,7 @@ enum {
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
+	POLICYDB_CAP_BPF_TOKEN_PERMS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 7ac0ae7c..0cb68fc0 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
 	[POLICYDB_CAP_NETIF_WILDCARD]			= "netif_wildcard",
 	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
+	[POLICYDB_CAP_BPF_TOKEN_PERMS]                  = "bpf_token_perms",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.50.1.windows.1

