Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501424BD0E8
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446608; cv=none; b=ldbGonJ7O/18CK9pO4BDDeotKvMc8n1g6K5MBxaA7mcqMzawTcz2KduUJTMJYbeZGf/GWddpKxEfgeAl801Q6X3hnKCTUalKSEjVkbqGfMSq3KWT4VM/BWK87aZ8oSj8hEDcvkHV3yFlRMU65zLjcTeIx5Ay3FHMhTZ414aZaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446608; c=relaxed/simple;
	bh=FoFyjPQ3UN2G2sLqDanOobObNYwfX3vwnmHCP7yoWmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meLZPOOApmmFe4N7TfcXdt5rKZEQuVWoGqhPDXCC6odgMH0GaJ2rUQrm0+SeBDbU8Amvg6ShCnDku42KemAGrO0bRXx6Gf/gmJs0bj5lOpeOsB1LSL20BOyfhcroxNu3VCT5SmKwo9lXgGzzW1l4MGNRjdre3EcZgei0vhr98Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDOslw75; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDOslw75"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52f1a320162so21821401cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446592; x=1789051392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQ5is5BhdJ0SubSvcFyXrxZOlhACR088y9vfXVvVQVQ=;
        b=QDOslw75hKqrvRZdDKH3oez/6UojAOXvW5ZfD5h/Hyrpy6ahyhZ1cnpkd9fYmAIaEg
         pPOgeYKNs8RASNVkgqni787V6AObmp6oRbMz3RO5/KOHm54tAbfyvaweMY7ITr6jqNCO
         JjeOMH+5/TrgM/z3NUUldOvUpqlvDR5LAtFW45icOy8L7OFs1652bWaMr8QTq3qt2K5H
         kR2tu+2UQ3D9o1oYzAS2V6ta7ZJU8e9OgZsh39xfvxFukFTJ5L0tjEYkK7k7NmEVHE/D
         Imi6fsuxYIh+oKdU7IA/tNH3+rMjOPcwZlYfNF7tu/ONxzoOjbYK1vk40TfOP8L69E1b
         gxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446592; x=1789051392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQ5is5BhdJ0SubSvcFyXrxZOlhACR088y9vfXVvVQVQ=;
        b=YNcO4qxvePb3kuHxPikYSPXgV/eIAwvkOuT8skH7c6NtydjYhbeUdi3omvJOzeK5va
         f8am4Tq17yjLfkhy9MnHJuMYh3QJMeiZb+IwCMgR+aq7dLJXVzSZy6d3/Jga55i8L6it
         +oO6t2CSMlcmY5IyuHgLKoQ9J1W+pggTNseA02yi5JyAP9Y6RATYcTjGRirM8l+GGD0K
         7rl9eLK4Ri4KE5z9W+ZlKTBoJU/Rs+c3DOOfs0YhsPd6x9uNXy9H4xitPRJusLq1mm7o
         EsdfsC6sNdLuX2kaKN1tLqYeHvEJ/lK52i7H/0rc7K8wucT6MrWdG1NruamxaRjnh1yC
         pHhg==
X-Gm-Message-State: AFuF++k+P7HqBeYa7Kqf2MvN0Yf99yuyVzlyQrZg4Zbz1hg62OzJZOMC
	srbi6kelTefrYjUpTI8EzNpcaru8AqUymZrEHvf8kLTxyxoSdtXyFMWyly+/2A==
X-Gm-Gg: AYBFou2YgarTfg3SnjC3cRXCewGglRFzCDZ5TiZa61LZWQWVRbqjB0sz4XOB6zzKpTG
	RXk32k/EDmxbFk8agScCDNSAmou0n84Lt1MnpPKKv+5T5jxnz9VgT2uf174Dhezy4ANx2+fu8b2
	ib8td3ei04Mgp52vzqKo+0oKkbmh7P54RKPlrHhK3B22qilBKunD1/ngOLZNf0+P65DdIeWND4t
	ssu6+MiLfEDsJBg7uolfxWbYEg7JDL1SX39XJv2HfiSufoekFdpQXvOnS9EiDPfVugoOmIsn+c3
	OwTdVrs9tPayYgXmwDRt6I4ciJXuNcK604TYds/WLlBfqFNbMA3j3DYQFXKR549UBGh8mej3UXs
	4LwT8YJSoxTJ3LMpVZh8ZhLnR+BlzP1odl07R0h2kkRar0XVrP9hDL/8Ke8TqbIIzvQyua18NRb
	QeaSjYVeEXJuGruAUIHS9M2vPcn8Xg+E9Mgf9sZO0hbf9vMeZNJ3/D5LIP25lGfAOhKFP4JBmQG
	Tp6I69Xn1uvpxGRi7I2N1K3St+o5pg98fpXxqkKV1CTqUwAAUvKmQfhY87/4L3Z
X-Received: by 2002:a05:622a:e11b:10b0:530:39f3:6c97 with SMTP id d75a77b69052e-53039f36f7amr88822421cf.23.1788446592168;
        Thu, 03 Sep 2026 07:43:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:43:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 6/9] libsemanage: create the store root when taking a lock
Date: Thu,  3 Sep 2026 10:34:31 -0400
Message-ID: <20260903143433.19810-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
References: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
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

