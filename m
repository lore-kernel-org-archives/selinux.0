Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D560361DB8
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356766; cv=none; b=pPfV6L9BsOQY2kRRmtMzCAAlMSWlqeURWnIhaNiPm4MH83RMRs/sjF6KbBus12twEtj0RRhsP92lI9mOQ61tFyyS+NpQ1UeotpT6zpkVcydZ5OBh3UVnWiqDfBoAZDX2VttHqMFZ/LlGJkKrAVFT2jtHSE+kKZW1pru4Tnv5VpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356766; c=relaxed/simple;
	bh=mgGMCweOihgkjTgLyAt4KmpnshDFU7m/OorMZ/SzVZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f42PYDjuDylC2EpqAoNb0yR5j96Sqk4b1SwHSxQMBXYqISuCWUio2po/voiMI9HGSma8OyhHfwlyKlq5x42k+O4GtIAwc5gCWuyCkFE4+B/E1FwE9WvCmehML9LAaMgWt4FqwqUpYVqnkxULYN9Ijk/LXPjbWFgI9FalTFCZPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3E4XSiy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3E4XSiy"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9391e3b21fbso94800085a.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356764; x=1788961564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdWc6ke6l3KoUZNpCaYiCFjpDw+Znod+SWnlCK8CL6k=;
        b=a3E4XSiycPt72z0meCM/fpshPG8x5QvSbdscXE5LeIPyhz/Yw76nYzFlqo30qOQGdX
         1pRM5z+sC3laN2Kh1VwLB40q4pnD26Cg8Q8GUMD1dXYMd+RMETh9ZXG7vUxJKBtxwq7j
         Nqb1XiyPMycqbNjcst2UHxielALborzOcz+kYmdcVCbP2mHXVhEdFMYDuns1vPNJLyNG
         1cnrCRZQ9+KLZMdaZP9RejisImrqXg2mUd1EU78O6HXgNcsdNUD8VWupwWWQHOTxQlx+
         pd/QBMYg5wtCP2POG0gKkW4aTcBN1oKs5UUE2elKW4IHIGnfQy37OqGlUyfCiu9rQXMt
         1u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356764; x=1788961564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZdWc6ke6l3KoUZNpCaYiCFjpDw+Znod+SWnlCK8CL6k=;
        b=YpGx5hSAnadVlldKCUT1PMwinkxzV7DtT08RtQ+31eF7cbDZ6oQBVGFgrXIQtOXmMS
         3cQt8e2xpDAYgtYoqSJ/N9HcNmjVTP/icH2pTeCTsUlJRf7E7CiLVDTZFOnTMwzJtDtM
         R/Gs6O11lBGx5WK+WOA+RaxaKfzeH6t+bj/TcSMwt5E5MsbY2FfD7PnHhlzICFFGwuwX
         9ukgURCPbcRncZI7/uku8Bt9SDTJppDM4Y7/6TNtvmo61ZkK3MIH9wbv90J41MLWP8Jt
         op7ZdhzWkTAtWF5/XxnbHNMLmY4XolOqvuUY0AJGuvJcERCU/AcEDzNaufV8klFKb/I9
         gN/Q==
X-Gm-Message-State: AFuF++nSLiUjbOw8BSi07QcN334VJE+xNqDYSgqc/jt1nIuEmXpk0c3G
	veS4MATgUlAqMUy7lvDoCZ7i62TpKgj0IM9d1Qmh7D7NoqMrUhKTm4FShPiaGw==
X-Gm-Gg: AR+sD11fsBQB8szb1N2v/5bSMIFjBEVRtbVXw97YGzoQmhYTUXgS/Ow/yicKY8qYBpv
	dkpWBXlPEWtgr8Fwy8UT+xfFIjkvex7h7U+ibLL0zD9mwIweWnT5HlQUzl3wHLTdN92t79Zgotr
	1pY/O4oOB/EpuyzFOS4N+YoFDhzgXcbVoi9WbcQUq7Myo7CYSqUuKsYuw59eWjMhy9pnW5SS4l/
	Kih1bgNj15yHWQ9Pzy305+ZO1EoMLtvhF2EJZ8bl+vmsWFGugXZs2JcM+xZ7Q1c75Mg25YmxYKQ
	rzUl+EEG59FlU5l72PFw34prNbUyqjadTeVwHwbI4t6YE1+nebslFeTU2mB5O3YZjylnw6aHtzp
	29LBD6uEaL45r2gD2JiZxNehJhgjgcxqpe1kdU+lAepMDnjd9x5Q3jum7TEY5j8yuRVkNPPpANB
	OfzfxLVPuKQCReB1GGSyoQa4t/HGxWp+UfDTWjJF87plUjGa2hLw6jQ0PxZLB17KOpy+OpZfr+F
	y/QIxnM9JipiAENmJsmx+HBz62uOm+EUVgJ7Q48D1KEfUGC4JSOv5y9dskF3tdz
X-Received: by 2002:ac8:5e10:0:b0:52f:b0f9:e4f2 with SMTP id d75a77b69052e-53036b97d24mr51983861cf.1.1788356763219;
        Wed, 02 Sep 2026 06:46:03 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:46:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6/9] libsemanage: create the store root when taking a lock
Date: Wed,  2 Sep 2026 09:33:14 -0400
Message-ID: <20260902133316.51981-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
References: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
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

