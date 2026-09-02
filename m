Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FA4A261C
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357823; cv=none; b=o54v1/ZbfL0ASVWT09nLieZOuE3UqbLDdyxbXN72Guk1WEO+A5nRNoMt/plZnQ6qLeL4o78yQRT7PXaSLde4DQNOmzvtDhpiVrSMPo+3wtDqlbAku7slYJvzCWfX4jhjkH4REV6ejtOMTfg/MhOKF4ZKZmSyUtOWGfcVrNKMT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357823; c=relaxed/simple;
	bh=mgGMCweOihgkjTgLyAt4KmpnshDFU7m/OorMZ/SzVZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G95w1mVXi3yyYD/Bh215Sp1zDa2Dtlz5MxtSZTj4pIZR0dZFdUlc0NhNE+eTcUguhjsGMLGj053gpFNOP+QfzcWMoS+WtG9EEQMGxZchtfibxyoAkesLBL0kJz4Nv2uFI/rJteFc5aTtSQMbftw9wTtKXyNCbM0doFf43txS5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs10h9QC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs10h9QC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cbff85fa9so11908126d6.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357821; x=1788962621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdWc6ke6l3KoUZNpCaYiCFjpDw+Znod+SWnlCK8CL6k=;
        b=Vs10h9QCH57Ap1i+07Z7q/3I39QDQ1NWXXTsgfz+gg3FzVzOPN6ndmjq3YG7HUK7fB
         o7mYRR2vLzEimBAh6vBXuFiB+A987XJa6pnCK/upNVQMr8iBvxVjS4/rGNad/pQ1AnOY
         ZdNpKnhHV3kbs+G7LaAHAqXeEkl//CQvolm/NBRUqQdqXmrDRIp+/34AozwLZ+VN496r
         CQf5xtS06+hGjK0r2FLWNwdAxeLltwDTzsh9jxYdkKSNFTgkumdJrhMcunPEbxQILmiM
         StKQ0B/SZzSFTO+4JpCQJn/C5r1hiFFVYMmG48VVGyLEpkIQZrkqQZnawAxuRkaxAEuz
         YT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357821; x=1788962621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZdWc6ke6l3KoUZNpCaYiCFjpDw+Znod+SWnlCK8CL6k=;
        b=MbxMiwwE4KbaJEXU2v1GHCbroOMkR0ectd7Y40BMdwFg/TBUccZhuNytqdLNgoiPYr
         gx0lzxrWqz3AaS90Bia8R5Y1MzsUFjiVUGNa8y15EzX2WTynHr7o2hhmW0Q2t4PO/RUa
         JlxPEqJ/6BEUIbtLD/RjlbuRccR07PoSZ+pJtBoSI5W27f1RgQfY+NhyA2DEx8srFLxG
         60mHeocQhxgz9cq9sBM9J7bFpQYLswnDdAGQZdgSoK9KxJQzCscLcz6n8W8FbMOCyTHr
         oVECAz+Lel3yAseBrekMJ4mXdRiQ6jaLZ5CqZ6TMNStt/1Z7IDb3WE91b3yHNC+SgJK1
         2cHQ==
X-Gm-Message-State: AFuF++kTi3M27Hpf+X5JOAbb1yCUCNDXFrSgoyHlWNjfBzUJw8L4zkMd
	SO+D3KjRZHbFMReDM0nepjjubqcnQsT6lN+EasXtVA4s0MQzj6NvVcB6FIztpg==
X-Gm-Gg: AR+sD10x4QZ36RkcGZPdkVxtgv8JfQ+1MGE9tGh/DflbsQWnB4gfV8jmlNT7ErbdDgn
	4ywf/iU8E3G9T0ZQL1ORufLLnDLuNFfrSGt38N2lG1LcGOkuLZc4Cn83vhJuNTlN+ekC7/nadRB
	Ry/jIIb0+3YKKbMWQOgPkWoexzOMOzy0SRz3nuJCdTK0T7TtrXJkm00pwPD7Z18fy4hi/Ze3nak
	FVcxJhUNo9w+J5SPzIBb+4MFQAGhIGlBi5xfPYwiv53fZWBfUoP4wC8yNIoUwaC84K8WFRrOeiC
	F2dA9KxiXzHn2b6od0pX9o6HvrDgOexs3NUsEgjqybsHMYsQ8+DRi6If4zskxUxAzZieRHFOJpD
	hDk55EEtEJ3Vfpe6n9yEQatzX/3iLsgSQqc6RVitVWjy8SJrNIfey/MWBb1WCcPPYEjXyML7we1
	fWXhxoIwrAPGwEIyvNcZQ7ph+zVpTMkoE7dc1rB51oZZ2C25hveWgqI3KpHgxrRCdwx+geKwzD/
	3uSAdxvyK0JCkLO4LukwF6O9kXF6aZJqVXbRub4Jg7tufdQThGNLh76sreU+m2k
X-Received: by 2002:a05:6214:43c2:b0:90c:e3bd:dfe4 with SMTP id 6a1803df08f44-90eca403bf3mr66639066d6.21.1788357814206;
        Wed, 02 Sep 2026 07:03:34 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 6/9] libsemanage: create the store root when taking a lock
Date: Wed,  2 Sep 2026 10:02:08 -0400
Message-ID: <20260902140211.53084-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
References: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both semanage_get_active_lock() and semanage_get_trans_lock() open
their lock file with O_CREAT, but that fails with ENOENT when the
<store-root>/type>/ parent has not yet been created. Writers now
create the whole skeleton in begintrans() but a reader reaches
enter_ro() -> semanage_get_active_lock() with no transaction and
no create_store.

On ENOENT, mkdir_recursive() the store root and retry the open once.
A reader on a fresh /var/lib/selinux thus creates one directory and
one empty lock file and can then serialize against a concurrent
commit.

Update semanage_store_access_check() to predict this: when the read
lock does not exist, walk up from the store root to the first existing
ancestor and check W_OK|X_OK there instead of on the missing store
root itself, so the seobject.py >= SEMANAGE_CAN_READ check passes on
a fresh writable store.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanage_store.c | 34 ++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 7f7cd7d2..cdf4cf17 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -759,12 +759,25 @@ int semanage_store_access_check(void)
 	 */
 	path = semanage_files[SEMANAGE_READ_LOCK];
 	if (access(path, R_OK) != 0) {
+		char anc[PATH_MAX], *slash;
+
 		if (access(path, F_OK) == 0) {
 			goto out;
 		}
 
-		path = semanage_files[SEMANAGE_ROOT];
-		if (access(path, R_OK | W_OK | X_OK) != 0) {
+		/*
+		 * semanage_get_lock() will mkdir_recursive() the store
+		 * root on demand, so predict success if any existing
+		 * ancestor of <root>/<type> is writable.
+		 */
+		snprintf(anc, sizeof(anc), "%s", semanage_files[SEMANAGE_ROOT]);
+		while (access(anc, F_OK) != 0 &&
+		       (slash = strchr(anc, '/')) != NULL) {
+			if (slash == anc)
+				slash++;
+			*slash = '\0';
+		}
+		if (access(anc, R_OK | W_OK | X_OK) != 0) {
 			goto out;
 		}
 	}
@@ -2023,8 +2036,21 @@ static int semanage_get_lock(semanage_handle_t *sh, const char *lock_name,
 	int fd;
 	int left;
 
-	if ((fd = open(lock_file, O_RDWR | O_CREAT | O_CLOEXEC,
-		       S_IRUSR | S_IWUSR)) == -1) {
+	fd = open(lock_file, O_RDWR | O_CREAT | O_CLOEXEC, S_IRUSR | S_IWUSR);
+	if (fd == -1 && errno == ENOENT) {
+		/*
+		 * On a fresh writable store the <root>/<type>/ parent may
+		 * not exist yet for a reader (writers create it in
+		 * begintrans() via semanage_create_store()). Create it
+		 * here so a pure read can still take the lock and
+		 * serialize it against a concurrent commit.
+		 */
+		const char *root = semanage_files[SEMANAGE_ROOT];
+		if (mkdir_recursive(root, 0755) == 0 && chmod(root, 0700) == 0)
+			fd = open(lock_file, O_RDWR | O_CREAT | O_CLOEXEC,
+				  S_IRUSR | S_IWUSR);
+	}
+	if (fd == -1) {
 		ERR(sh, "Could not open direct %s at %s.", lock_name,
 		    lock_file);
 		return -1;
-- 
2.55.0

