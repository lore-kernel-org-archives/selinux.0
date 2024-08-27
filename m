Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865BD1D0DC6
	for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780413; cv=none; b=gvfIPHs7YyV2gkuvfwIa0rPyc2ulJYPH8RUzIMHEg0NQGjHiwCOVLDirCmU3J0iCURbRruFKz7L8AHN/aJ60bkQUpfkJ2UsZTC5XBZDKcZ1ZNc7QEkx36pBheD3YvEMZS1rE7Uub5x80cVRG0NWL4kn4sZp/GyzHNEjiuGBphBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780413; c=relaxed/simple;
	bh=ykE49z4MK1mQhxatx+8GOqMEcjjnnrKpHSCFeaRSAv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDrAwhIr38C7gJoUifwKTiYWvpSfig7EkrNWKFbUS2EIpNiEkRm9XoFRVOUx+hhI+jAxozB9aRHxcKq4YVx1K66bKmIhVNThd65JcM4D6h3vs4Rfg2GlwrWu9hUznaVp7p72Tdh6+akVl48Nj30VXQZAp0hQeu8Wr2FMJsdOAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OevPvvLQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OevPvvLQ"
Received: from fedora.mshome.net (unknown [131.107.147.68])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1159B20B7165;
	Tue, 27 Aug 2024 10:40:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1159B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724780412;
	bh=0PUQG5DOeH8yFcsIXxKFSkw9n3sJ858Tq//fn0pF/GI=;
	h=From:To:Cc:Subject:Date:From;
	b=OevPvvLQqt0Y57rSrLpC5EmTSxvJAtjLorH8T6lcW0o0UxWB6PFe4xUOoB3p5bs4o
	 B075C1PyvVoyfcWlOjuP2oEMDo6/pJjfMlaOwCwg7rCzA16CHN6Y7OJ1HWbML+SY69
	 cxl9TfUbLK48eF9k5Y5xx6Q+hWUzbjYWaJwRrvHU=
From: ericsu@linux.microsoft.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	Eric Suen <ericsu@linux.microsoft.com>
Subject: [PATCH] selinux: replace kmem_cache_create() with KMEM_CACHE()
Date: Tue, 27 Aug 2024 10:40:03 -0700
Message-ID: <20240827174003.52690-1-ericsu@linux.microsoft.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Suen <ericsu@linux.microsoft.com>

Based on guidance in include/linux/slab.h, replace kmem_cache_create()
with KMEM_CACHE() for sources under security/selinux, to simply creation
of SLAB caches.

Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
---
 security/selinux/avc.c        | 16 ++++------------
 security/selinux/ss/avtab.c   |  7 ++-----
 security/selinux/ss/ebitmap.c |  4 +---
 security/selinux/ss/hashtab.c |  4 +---
 4 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 32eb67fb3e42..1ec377ce6d22 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -134,18 +134,10 @@ static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
  */
 void __init avc_init(void)
 {
-	avc_node_cachep = kmem_cache_create("avc_node", sizeof(struct avc_node),
-					0, SLAB_PANIC, NULL);
-	avc_xperms_cachep = kmem_cache_create("avc_xperms_node",
-					sizeof(struct avc_xperms_node),
-					0, SLAB_PANIC, NULL);
-	avc_xperms_decision_cachep = kmem_cache_create(
-					"avc_xperms_decision_node",
-					sizeof(struct avc_xperms_decision_node),
-					0, SLAB_PANIC, NULL);
-	avc_xperms_data_cachep = kmem_cache_create("avc_xperms_data",
-					sizeof(struct extended_perms_data),
-					0, SLAB_PANIC, NULL);
+	avc_node_cachep = KMEM_CACHE(avc_node, SLAB_PANIC);
+	avc_xperms_cachep = KMEM_CACHE(avc_xperms_node, SLAB_PANIC);
+	avc_xperms_decision_cachep = KMEM_CACHE(avc_xperms_decision_node, SLAB_PANIC);
+	avc_xperms_data_cachep = KMEM_CACHE(extended_perms_data, SLAB_PANIC);
 }
 
 int avc_get_hash_stats(char *page)
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 2ad98732d052..8e400dd736b7 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -604,9 +604,6 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 
 void __init avtab_cache_init(void)
 {
-	avtab_node_cachep = kmem_cache_create(
-		"avtab_node", sizeof(struct avtab_node), 0, SLAB_PANIC, NULL);
-	avtab_xperms_cachep = kmem_cache_create(
-		"avtab_extended_perms", sizeof(struct avtab_extended_perms), 0,
-		SLAB_PANIC, NULL);
+	avtab_node_cachep = KMEM_CACHE(avtab_node, SLAB_PANIC);
+	avtab_xperms_cachep = KMEM_CACHE(avtab_extended_perms, SLAB_PANIC);
 }
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 04d7f4907a06..99c01be15115 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -572,7 +572,5 @@ u32 ebitmap_hash(const struct ebitmap *e, u32 hash)
 
 void __init ebitmap_cache_init(void)
 {
-	ebitmap_node_cachep = kmem_cache_create("ebitmap_node",
-						sizeof(struct ebitmap_node), 0,
-						SLAB_PANIC, NULL);
+	ebitmap_node_cachep = KMEM_CACHE(ebitmap_node, SLAB_PANIC);
 }
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 32c4cb37f3d2..383fd2d70878 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -194,7 +194,5 @@ int hashtab_duplicate(struct hashtab *new, const struct hashtab *orig,
 
 void __init hashtab_cache_init(void)
 {
-	hashtab_node_cachep = kmem_cache_create("hashtab_node",
-						sizeof(struct hashtab_node), 0,
-						SLAB_PANIC, NULL);
+	hashtab_node_cachep = KMEM_CACHE(hashtab_node, SLAB_PANIC);
 }
-- 
2.46.0

