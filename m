Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D63491595
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895683; cv=none; b=HD63gyOGxaTJ5imixhv/R+9xad+VWU2mfwwqQWEvSBUvu1uFNNjEh8WraI2zG0lUUrPnviei3pCBwA04Z2oQ9LudBXadEnjoqzzKBsO03KrR/r/AuxXUZ/5b4EAHIlmG/xp0ZIXmOMunTLsUg44cwBm17SUqEV1uuU5ud9/jIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895683; c=relaxed/simple;
	bh=LCtcl1FtQ1cxYZymjPsss/RPaL1sQSubErojIxu7IR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W91mKko0T+hQAADAAZXUv3b7bAQU/ixWYVIOiZMctR0ynvmF7GUMU6k3TB5YIH1PXOFUnybyO4ovQhBaX+ZIcQMXwzZWiPbAKIUYJOKH0Ck8J/fsgOHLO4z+XXINg2U9XRW/1TK1QZdxwwy424VqR9eM1IXXHbxTu02cO0lYiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeIWvhmo; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeIWvhmo"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5307898207dso33827321cf.0
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895680; x=1789500480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=joZkc+IRYBc+FnO3HZ5SSejbGsQAnGV4QZaVUfobSxk=;
        b=CeIWvhmoC2Gbc2MA2lKtBiVXEUEzppPJnGFdEoXFGJRWw71Pp2fJWIhCxvt+m2SN6p
         6fdGkeids2T7qZ6D/urV0aFf5tq3WwNJMJiNnZ4kOFDSHCz8qvYPjCFnV81WzFrEPfif
         J5ihO9SA7Eas9kygCLHAueu1h06xOxso9DE3kjPyK1iq8AocsltGp5AYQ9coA4heNoq2
         z0Xnhs4w7QkwKj6n9j+2T7ReJgwTbORg2yHTflCkEQ0BqawtH6KTsn4VreyQMA/jafiB
         1VgN9+fmnFS2wNNHYqHU5sufV+Vhber6wMzgvMCblKfIostJab+IwUppXsLSk5i8HCYh
         G2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895680; x=1789500480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=joZkc+IRYBc+FnO3HZ5SSejbGsQAnGV4QZaVUfobSxk=;
        b=lHR+iMRNxyLYQ7aRjHKpP8bBa2fIhqWJWk/qKQrnTyWMiYbd91kr52vlMl6HkDlVKA
         T4xj3lU98O/cMq2pdEkUoaLqtdI2Ht7CRb90LkuKPeUG0A8zM5AabojlNULGOZX60rt0
         oVCbt5hFV5xJbcVa0Zbd74b9RpqIBJgjVzE6wEqayqxJpkf8+Db3fI9EIrBVZ5Qdv7s2
         Fetmpsvq9k6rRzhzdPB1SzQ0ElRc5MvFg5isV0Fu3G+bKUyZiaslPr77ypD+PxJOV9HP
         ESTN6a7Dp8NVrFyz2TlCo5IERrdtdnLtsWjC42/8gF9szK/uomvSfpcTJwEGLx9lLCdu
         0s1A==
X-Gm-Message-State: AFuF++mlKLbuUZ1dYcT2vg2Ip5T+ElYwxuvfkbw9snEZ3Un5D4LkglP5
	dCAle8w3LNsvvCmvoDtsIXZGKyJUkCJIHSnKxkmfxPS5kA3NsoXc6TgJz2RJ+A==
X-Gm-Gg: AYBFou0NhsbtfdjbiTqONO5k6G5iJe3XPn02jjsxiHB3u2EBmyxo6Hb3Vjw2on+W1K2
	lPgJmVhvlU9w1D5sFA3AZZYMIfDj5PpcU0mnLqiwZ8F87JV9Y9I5YwsLTztXx+bwy98Djc3F3Dq
	vJcKxmxa/AwU9sLBGE5Q7EN3tbuaiDcmbBaJsl/YKiORotVRSkwrGpdSj41dXGuwJnYGKuOhXZI
	LvLmdT5mJpohAwjZblPMT5emyy0+TF6YEIz7vRK9l41ciK3UIqGgcHZw6fvnNUYRpHE+NDM7Wmk
	ii5yIQIpObDJDIjWg1huwq6JU8/O0nGyTWK2ab4t2FvnszyxW7tFvRj2O7BmAxpmsrOskWb6hB9
	7WsosyQzwKLc1SiiYetFrj//pFZhGehpoEEkYGUQg6rHRSt0Iqm7+swLSzoKOTxlOoK/Ztsm7rx
	DY+XsE80jdRVUSdUmww9zTytXKX03aqz2VFcyaHWzMygc1+BBpzDIaP7odmCGFie7GcivMbk927
	vCGQJEzgeqTHcY2h+WdaWL9oCWt1xcxkDbEkawPnhlThz7OPD0DRiRBwUAg91dI
X-Received: by 2002:a05:622a:2585:b0:51c:c6c:9d65 with SMTP id d75a77b69052e-530546bd8d3mr471577751cf.1.1788895679719;
        Tue, 08 Sep 2026 12:27:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5308a706823sm47606551cf.24.2026.09.08.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:27:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/4] libsepol: check user MLS levels by scope not policy type
Date: Tue,  8 Sep 2026 15:27:42 -0400
Message-ID: <20260908192743.21663-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
References: <20260908192743.21663-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e4be0092 ("libsepol: Tighten checks on MLS range and level when
validating") requires a set semantic level and range for every user in
a POLICY_MOD policydb. But a bare:

    require { user system_u; }

in an MLS module inserts a user datum into the global user symtab with
a zeroed semantic level, so any such module now fails policydb_read()
at the tail policydb_validate() and cannot be installed via the pp
HLL.

At the same time the check accepts an unset semantic level for a
POLICY_BASE policydb, but checkpolicy always requires the level for a
declared user in a MLS base ("no default level specified for user"),
so the only way to reach that path is a required-only user in an
optional block - the same case that must be accepted.

The distinction the policy compilers draw is scope: declared users
have their level set, required-only users do not. Look up the user in
the global scope table and only insist on a set semantic level when
the scope is SCOPE_DECL. Kernel policies carry no scope table, and
their expanded level and range remain checked separately.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb_validate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index b5b18dda..b2144dfd 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -893,9 +893,11 @@ bad:
 	return -1;
 }
 
-static int validate_user_datum(sepol_handle_t *handle, const user_datum_t *user,
-			       validate_t flavors[], const policydb_t *p)
+static int validate_user_datum(sepol_handle_t *handle, hashtab_key_t key,
+			       const user_datum_t *user, validate_t flavors[],
+			       const policydb_t *p)
 {
+	const scope_datum_t *scope;
 	int allow_unset;
 
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
@@ -903,7 +905,8 @@ static int validate_user_datum(sepol_handle_t *handle, const user_datum_t *user,
 	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
 		goto bad;
 
-	allow_unset = (!p->mls) || (p->policy_type != POLICY_MOD);
+	scope = hashtab_search(p->scope[SYM_USERS].table, key);
+	allow_unset = (!p->mls) || (!scope || scope->scope != SCOPE_DECL);
 	if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS],
 					&flavors[SYM_CATS], allow_unset))
 		goto bad;
@@ -929,12 +932,12 @@ bad:
 	return -1;
 }
 
-static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
-				       hashtab_datum_t d, void *args)
+static int validate_user_datum_wrapper(hashtab_key_t k, hashtab_datum_t d,
+				       void *args)
 {
 	map_arg_t *margs = args;
 
-	return validate_user_datum(margs->handle, d, margs->flavors,
+	return validate_user_datum(margs->handle, k, d, margs->flavors,
 				   margs->policy);
 }
 
-- 
2.55.0

