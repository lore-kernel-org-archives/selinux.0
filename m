Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF274A64F6
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362129; cv=none; b=kAfjgvV1X2qO9CAT/Hz+E0w6nx745B4Kc/qZfYAfXjMBWn7pgbtmrwjsCy353rU0mPe6SzSYeqzzj2R2xE1zwvvgJbyfjexMI0grIyZW4lT59UOuTnycMdYfQluQJMig1Ge26EuBjDmueX4yEx3N6/JKAbHbz73T6c1iA8Olgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362129; c=relaxed/simple;
	bh=FoFyjPQ3UN2G2sLqDanOobObNYwfX3vwnmHCP7yoWmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMdCoHSEW5JhVx9wDrDem43dSqZ3wbyLhDqG0LO0uTJ88eMZM6satUtnZUi5cejw3eQI3L4BVsOX6SSx8qg14+rLdu9ryKAokNJWv1hyaq1Jv8dT3u64zPXs6wwQ/DAhBxOWlbXd/E6SY0QVk0uEwMEWSkSCRB/HWIinlP9Tldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDU6qRGi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDU6qRGi"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-936cda0e3fbso147813685a.3
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362126; x=1788966926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQ5is5BhdJ0SubSvcFyXrxZOlhACR088y9vfXVvVQVQ=;
        b=oDU6qRGiuPDv52swwYZMwLd7w9NEbw5bfQSoNFcZqReoVTPYfidLtzQvZs3MQGAhW7
         M7ssIPwAm+gV7bFZvh109OPLa/A8JsA3KZKiBTSuH23hSOrbofeWbxnCzoI9Zg6Dvog4
         nGEIe7nqX/ojCJkqmqAhRhtIjOEBTQKByzgD3jBWA1tGRI4GuExF+/GNz6RLGxgd1VjO
         z0AejXlTV1ucwATSDR7hTNWEEyOjgQIn15yedtARvB3vqgqCwiHpLk0iH91UMZ2fOGKH
         HvYIatwTVWe45J8vpPOlzpdtCqUd+5tuZ+cKKJNx5Rfs/+tZylCf/6TUkzvnCLafahox
         vHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362126; x=1788966926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQ5is5BhdJ0SubSvcFyXrxZOlhACR088y9vfXVvVQVQ=;
        b=ZiblqkQpoalUi5jW9lS6ZmO5f/fIuiJF6RGEaTfpAhKxx/79FPr0BO+OQOrsKZGGNk
         8IU7In0XhOkflNWrLMKmCubn67UqF+IjdD04L1+O31tvad0NqJvpi9fA6aGCem1iRQlb
         v62tI2W9AlxzODu44SP4iug0ITIbqT0i0Qw76xjqr3jZFoppqoXdih7dKZyq3QfRhQ6y
         2BNAsDITOJ0q8QoZBPmx1Z6YPOfPQZuHylVea+i3afAOHBQCDr4Fw+xiuDUObPvDN3W8
         D7HZo+DzX3O0CCHAcnjv0hWqKW9ujVOt92EaAN8CfxaSxGI6xQBTj71p6qqCsPyeuoA6
         JuVg==
X-Gm-Message-State: AFuF++m4UWrBKx++L+yMk3RpRED47PzOrfXt+to8M20aJL4WO4WoTryq
	A3CcpCKY9ZqeP0OYM5t+IrA6VfVbex2p01nL1RidHddavQP3ldjbREH0Fc5egw==
X-Gm-Gg: AR+sD12/h1e7246KFYWakbCaZcQB3wsiFDiEc53bXICDBPCq7xikmt3inGkL9pJ8Pm1
	m+33iLGNRD8vChNMM13CuroqYhGOJ901wwgbGTY01wjLynFaSocmFU/aUgEDSFIAVb2g52aiOWu
	jstm4bxQ1ga6oiS84F4MPLzl4x0zgN3tJsewCD2aHH1e7pJUAh9vB6h+dJYaPvuPIFR+FOz8NAr
	FCT7MEcs62IIt9V87G64UpWVd/OxEmCnnyxtYr0SxuXeNjYSEPwM3CFZ34GSmjvZNxcPk+h4Cgy
	1RFsjNX1dIyVXsRiEJkikdNtKRuLn1Jb97ibMeCCTnyS4fUQHyzeWMKP4nRc51vq2k3DEphnNiA
	UyGZIXwbo/uQ1dhnThpxHjIobazgYrXTquuFWg7dmvKIVU17c0du+Fr90Wvm+MAdFjhBp7r/5g5
	TP2TJRfiUnFmZ/PkDQveogFZU8/i6P++ULszVH+30HtV57IouMJEW3hh2vEU9DqDx+Q6/nGYFPb
	cs4sT60640EGiJHOSsPjELuEdwYpqDLCaNS4fbZhQZPvE6uYmdNV+DSA4w5qrn9
X-Received: by 2002:a05:620a:2943:b0:939:4abe:4517 with SMTP id af79cd13be357-93960e0553dmr703246685a.16.1788362123563;
        Wed, 02 Sep 2026 08:15:23 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f17eefdsm229299885a.11.2026.09.02.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:15:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 6/9] libsemanage: create the store root when taking a lock
Date: Wed,  2 Sep 2026 11:14:03 -0400
Message-ID: <20260902151406.54168-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
References: <20260902151406.54168-2-stephen.smalley.work@gmail.com>
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
index 7f7cd7d2..9bece5f2 100644
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
+		       (slash = strrchr(anc, '/')) != NULL) {
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

