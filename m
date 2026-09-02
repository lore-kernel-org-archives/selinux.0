Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7249C4AA
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357819; cv=none; b=UtoKKXdjN+QVk0kaHfllGdNp8MOrb++e+fZJQHmZwsazx7jVWzmOpnkZnjZBnO3Nj+xybkJpr01W2/dqby1JZ0V6L7WJWVlxGdI+2clDc8VKzSw1vIemMrjfmQaQqL/JKjt9ooKo3HR9psv7vLilJhxVXH+vxx/+Z4xEusbC/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357819; c=relaxed/simple;
	bh=giwkwmwWYefdj+mMptT/bxSo2dW4Oh9CinO9gy5sQA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqyKBtoQWZpxJ/fJBz6Y8tXtV4SCJMR7pT9d+5GcOkiHP0CkNc87+44sIYjkZuqWnwUVkZP1izVkC00ceyYE40ejmVluy1kvpgjV3oPJnapUaH49zC4fl4NByUTt95oj2Gc5RlFewiAWkgO9u8xSmgaoAvNBUEOhkPgOd8Ck4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0uPohyQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0uPohyQ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d8679c149so10151281cf.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357817; x=1788962617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0OISHGrBZ32x3IL0iwVuG2BIhkhnyD1u7Puq0KdCjI=;
        b=R0uPohyQX2PBgm7I1SwJVspVG13h4bOhncQIK/4u1UJeXmjPG5tDrrKQmWBIv/gcSi
         aPZbqlHKPCNmTJD1oHp2UGnHu1rOQ/u+zU7BVDYmmPeKei58ayjxFYU1X6LRp33K7Mq7
         i5vFo6tkL3Ryqt8DzHwvhJ+U7NWOkyWk5o34x7BhPZ8yecHk9bBVF5jMHGxHtRtDcBXX
         0491kVkzwpVqNiQlCSjyQW7O7u4zHADFny3q5c0yTam4CWZaQFVYvOBMzA+8iQFO/alq
         U6+uP+1NC2zcuw6zloMZjTtgNNAT9CfCSEfQ7Gb5pVpgI6NH7SCEiuEraSRx34SNliwx
         l9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357817; x=1788962617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V0OISHGrBZ32x3IL0iwVuG2BIhkhnyD1u7Puq0KdCjI=;
        b=UVfuWM+3WzXw+VILh/t1b4D7qHYyMxofQjn3n5WUy11eV2FUUxQCNl3np9Eqkq8MJz
         5ZDEI5WNDw5f9lBJtokKgOG/PK4YxOBDldBfuj4WQKSBJ7KeaMpLw4rl/i9ROqaSt77Y
         iqU9R2RdtUlYFr6mFEC5+RmGW1TgpAbnoArJvnpESyFZMuLsIIRD6FQzzNIDn26t45WM
         b2y5mhiwESD2amZnR/17rg7LIMrJart4CjQICTz6q9ePzTp0n36fKIqDJMF3tNcRrgdr
         8gTlSJE4DrQ7wH3D8KGtor0tPaQp9DNg1vq9At995Ez/xFJ849Vw90n/ZumzUcNFS16w
         pqOg==
X-Gm-Message-State: AFuF++nToo3spSqAmCKS0P3ngyn7O6XuQxP2rGSXbt88ilOPLFugiaY3
	7ITzAdytufF4exuzQJUIYE7TEMEE+kRQ+G3A7HQekwfoN7OS9L/9cL3sciYZqw==
X-Gm-Gg: AR+sD11CCh/AP8bM1tMaIil1br3o+1kryQfOulBs6yX4jJuqwC9rVSdZXJVQ+0RgcJG
	hLCjgFRlZP2scGBuASdNdF/f5uW42QNBNpZj/j5jLImXHhmhFhtIYlSGKlkt3lrdiI+WRjgnvym
	db1lkYuOLolGLn2qxfpg988TbJRY5G9V6Id/n6tLoNom2I1Wq8s7KxuHVi9X7IyYOkmHIGenx/9
	V2EsT6qr2pp4lOpWgBxZJKWDK/RwKkDpaWOL5nQDzHEOecVFwwh5F8+JOYjpz0FA0yWKagtl7tI
	Ys1FKhbeLEiJdrrKpkXfjgg/15hS4ooprAi+3ky90WhshNrneBc/IwZViIhxnV7JnjyxPSEo7BS
	oySOmXf8RNPzFajboBA3yMjx896Oxb2QA8bOsv96NJvvlGl6fR/AqiLhvkBA/or7r/OtwwNAa5T
	skewTqY3ts+RaBXYFOt9CW4vyKnJBv4aAxEIPs7llyGg+w/Z4lc8LrhAQO16w2IiT/qtFenqjOI
	Fje5Ma92o2+vt7p+zi0lYgRPiRRH3fLdOM11ojVgxiODhwCOIJgwvhgmHttz2JL6hUkWH69oOQ=
X-Received: by 2002:a05:620a:26e6:b0:939:40d1:2d6d with SMTP id af79cd13be357-93960fa6728mr486101285a.37.1788357814901;
        Wed, 02 Sep 2026 07:03:34 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 7/9] libsemanage: refuse to remove or enable a module owned by a RO store
Date: Wed,  2 Sep 2026 10:02:09 -0400
Message-ID: <20260902140211.53084-9-stephen.smalley.work@gmail.com>
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

semodule -r <name> on a module that exists only in a read-only store
has nothing to unlink in the writable one. Detect that case in
semanage_direct_remove_key(), notify the user, and suggest using -d to
disable it instead. Removing a writable-store copy that shadows a
read-only one is still allowed and simply un-shadows the vendor
module.

semodule -e <name> when a read-only store carries the disabled marker
has no effect since get_module_info() reads the marker via
semanage_module_find_path(). After removing any writable marker,
re-probe; if a read-only marker remains, fail with an error message
pointing to its path as the cause.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/direct_api.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 547c2975..2e45c41a 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2276,6 +2276,23 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 			}
 		}
 
+		/*
+		 * A read-only store may still carry a disabled marker for
+		 * this module; the writable store cannot override it.
+		 */
+		if (semanage_ro_root_count() > 0 &&
+		    semanage_module_find_path(sh, modinfo,
+					      SEMANAGE_MODULE_PATH_DISABLED, fn,
+					      sizeof(fn)) == 0 &&
+		    access(fn, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s is disabled by the read-only store at %s and cannot be enabled here.",
+			    modkey->name, fn);
+			status = -1;
+			goto cleanup;
+		}
+
 		break;
 	case -1: /* warn about ignored setting to default */
 		WARN(sh, "Setting module %s to 'default' state has no effect",
@@ -3058,6 +3075,29 @@ static int semanage_direct_remove_key(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
+	/*
+	 * A module that lives only in a read-only store has nothing to
+	 * remove in the writable one; disabling is the closest equivalent.
+	 * Removing a writable-store copy that shadows a read-only one is
+	 * still allowed and simply un-shadows the vendor module.
+	 */
+	if (semanage_ro_root_count() > 0 && access(path, F_OK) != 0) {
+		char ro_path[PATH_MAX];
+
+		if (semanage_module_find_path(
+			    sh, (const semanage_module_info_t *)modkey,
+			    SEMANAGE_MODULE_PATH_NAME, ro_path,
+			    sizeof(ro_path)) &&
+		    access(ro_path, F_OK) == 0) {
+			errno = 0;
+			ERR(sh,
+			    "Module %s at priority %d is provided by the read-only store at %s and cannot be removed; use -d to disable it.",
+			    modkey->name, modkey->priority, ro_path);
+			status = -2;
+			goto cleanup;
+		}
+	}
+
 	/* remove directory */
 	ret = semanage_remove_directory(path);
 	if (ret != 0) {
-- 
2.55.0

