Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649092BE65F
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966388; cv=none; b=azHAypPM+m1ERnA52Zy12mAXt/VYbidYBgdja6kxe0NcS6CGQwqLoTLVeajxJhp6dutJ3XN9IaFTpVmakt1Np/0gaPR9TkU7CfzXo9GYJRYr4ZrVWe0IRp7jlG1cewOtFquYdbHRiGUzib3sSo/TMRkVV/ReZq+3Y9xB5GqimPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966388; c=relaxed/simple;
	bh=REE9P6lOaGx4Ox9qsSti/FLFxemhhTop3ct/3pvOPnE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c/aJVyf1cZRS1mchwqQSELHSM8yf6JfAJLchhzN2o7yAyPkDXG/bK0HMDnO9dpvAUrAE9kgO8Ru8mLTzDRSZvvBwscEto2WZDeDBPRKakRLZkxufaTKvdVYmK1SgZ/Wyd/D3rBj4H6L1va+WT20OOZVbbUNQV32o/YAv+xZVS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cy+tTB3B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cy+tTB3B"
Received: from ericsu-dev1 (unknown [131.107.1.202])
	by linux.microsoft.com (Postfix) with ESMTPSA id 97A972038B7D
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 16:33:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97A972038B7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966385;
	bh=GpGE/pui/EBcWCyotbzKkntcZuwwNQfmk/UVBXWtNpg=;
	h=From:To:Subject:Date:From;
	b=cy+tTB3BuMXBamDnOS5PpGsCCaNKj37a9UpPlSDb+87I4phci+qA06R+qmhdwTQIv
	 Riq1jZPhBHbTS7nFKYCZTk4+UKjTwgogYDrZWGE363sfDkfOMRkN7/3Brih1xGwwMU
	 rRC/tFlEWHE0FiG6/ksP4CQSvAQtD4E7q8Ym0C7Y=
From: Eric Suen <ericsu@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace v2] libsepol: add bpf_token_perms polcap
Date: Wed,  8 Oct 2025 16:33:04 -0700
Message-ID: <20251008233305.2098-1-ericsu@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
Changes in v2:
- Rebase to the latest changes

 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 5a3fbdb4..ef529e76 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -21,6 +21,7 @@ enum {
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
 	POLICYDB_CAP_FUNCTIONFS_SECLABEL,
 	POLICYDB_CAP_MEMFD_CLASS,
+	POLICYDB_CAP_BPF_TOKEN_PERMS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 526f35ed..31b52d70 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -20,6 +20,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
 	[POLICYDB_CAP_FUNCTIONFS_SECLABEL]		= "functionfs_seclabel",
 	[POLICYDB_CAP_MEMFD_CLASS]			= "memfd_class",
+	[POLICYDB_CAP_BPF_TOKEN_PERMS]                  = "bpf_token_perms",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.50.1

