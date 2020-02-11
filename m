Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A78CC352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1CA20848
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLkqmvtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgBKKOt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:14:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727561AbgBKKOt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 05:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581416088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YurMyGQJI0qVzyNOK51r9pEmvIT3D3KjccihBs8AeC8=;
        b=gLkqmvtKQ6424O0YET1IAMA2aFXeLIeUr6a1oQFjPusC64EBlFSfY9k8G0BWN8qmnOLu1z
        1kFK5XeejM60rpf/g9ebj8Jr8A/Gen3I8bRKmzPN9Bm+krmNXXhN13v4hvMGdATzhfuz1p
        EROoavGVGDuAZlUY00NrNM+9RetGWVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-JRbDPID4OhePio7KkU-uGA-1; Tue, 11 Feb 2020 05:14:45 -0500
X-MC-Unique: JRbDPID4OhePio7KkU-uGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7004800D48
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 10:14:44 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.43.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECD966055B;
        Tue, 11 Feb 2020 10:14:43 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v5] libselinux: Eliminate use of security_compute_user()
Date:   Tue, 11 Feb 2020 11:14:38 +0100
Message-Id: <20200211101438.403297-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

get_ordered_context_list() code used to ask the kernel to compute the com=
plete
set of reachable contexts using /sys/fs/selinux/user aka
security_compute_user(). This set can be so huge so that it doesn't fit i=
nto a
kernel page and security_compute_user() fails. Even if it doesn't fail,
get_ordered_context_list() throws away the vast majority of the returned
contexts because they don't match anything in
/etc/selinux/targeted/contexts/default_contexts or
/etc/selinux/targeted/contexts/users/

get_ordered_context_list() is rewritten to compute set of contexts based =
on
/etc/selinux/targeted/contexts/users/ and
/etc/selinux/targeted/contexts/default_contexts files and to return only =
valid
contexts, using security_check_context(), from this set.

Fixes: https://github.com/SELinuxProject/selinux/issues/28

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

v5 changes:

- context_free(usercon) when is_in_reachable() finds a duplicate

I see some value in reporting problem context during parsing a file and s=
kipping this context
so I left the code after usercon =3D context_new(usercon_str) untouched.


 libselinux/src/get_context_list.c | 214 ++++++++++++++----------------
 1 file changed, 98 insertions(+), 116 deletions(-)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
index 689e46589f30..6078d980cde1 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdio_ext.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
@@ -114,61 +115,38 @@ int get_default_context(const char *user,
 	return 0;
 }
=20
-static int find_partialcon(char ** list,
-			   unsigned int nreach, char *part)
+static int is_in_reachable(char **reachable, const char *usercon_str)
 {
-	const char *conrole, *contype;
-	char *partrole, *parttype, *ptr;
-	context_t con;
-	unsigned int i;
+	if (!reachable)
+		return 0;
=20
-	partrole =3D part;
-	ptr =3D part;
-	while (*ptr && !isspace(*ptr) && *ptr !=3D ':')
-		ptr++;
-	if (*ptr !=3D ':')
-		return -1;
-	*ptr++ =3D 0;
-	parttype =3D ptr;
-	while (*ptr && !isspace(*ptr) && *ptr !=3D ':')
-		ptr++;
-	*ptr =3D 0;
-
-	for (i =3D 0; i < nreach; i++) {
-		con =3D context_new(list[i]);
-		if (!con)
-			return -1;
-		conrole =3D context_role_get(con);
-		contype =3D context_type_get(con);
-		if (!conrole || !contype) {
-			context_free(con);
-			return -1;
-		}
-		if (!strcmp(conrole, partrole) && !strcmp(contype, parttype)) {
-			context_free(con);
-			return i;
+	for (; *reachable !=3D NULL; reachable++) {
+		if (strcmp(*reachable, usercon_str) =3D=3D 0) {
+			return 1;
 		}
-		context_free(con);
 	}
-
-	return -1;
+	return 0;
 }
=20
-static int get_context_order(FILE * fp,
+static int get_context_user(FILE * fp,
 			     char * fromcon,
-			     char ** reachable,
-			     unsigned int nreach,
-			     unsigned int *ordering, unsigned int *nordered)
+			     const char * user,
+			     char ***reachable,
+			     unsigned int *nreachable)
 {
 	char *start, *end =3D NULL;
 	char *line =3D NULL;
-	size_t line_len =3D 0;
+	size_t line_len =3D 0, usercon_len;
+	size_t user_len =3D strlen(user);
 	ssize_t len;
 	int found =3D 0;
-	const char *fromrole, *fromtype;
+	const char *fromrole, *fromtype, *fromlevel;
 	char *linerole, *linetype;
-	unsigned int i;
+	char **new_reachable =3D NULL;
+	char *usercon_str;
 	context_t con;
+	context_t usercon;
+
 	int rc;
=20
 	errno =3D -EINVAL;
@@ -180,6 +158,7 @@ static int get_context_order(FILE * fp,
 		return -1;
 	fromrole =3D context_role_get(con);
 	fromtype =3D context_type_get(con);
+	fromlevel =3D context_range_get(con);
 	if (!fromrole || !fromtype) {
 		context_free(con);
 		return -1;
@@ -243,23 +222,84 @@ static int get_context_order(FILE * fp,
 		if (*end)
 			*end++ =3D 0;
=20
-		/* Check for a match in the reachable list. */
-		rc =3D find_partialcon(reachable, nreach, start);
-		if (rc < 0) {
-			/* No match, skip it. */
+		/* Check whether a new context is valid */
+		if (SIZE_MAX - user_len < strlen(start) + 2) {
+			fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTIO=
N__);
+			errno =3D EINVAL;
+			rc =3D -1;
+			goto out;
+		}
+		usercon_len =3D user_len + strlen(start) + 2;
+		usercon_str =3D malloc(usercon_len);
+		if (!usercon_str) {
+			rc =3D -1;
+			goto out;
+		}
+
+		/* set range from fromcon in the new usercon */
+		snprintf(usercon_str, usercon_len, "%s:%s", user, start);
+		usercon =3D context_new(usercon_str);
+		if (!usercon) {
+			if (errno !=3D EINVAL) {
+				free(usercon_str);
+				rc =3D -1;
+				goto out;
+			}
+			fprintf(stderr,
+				"%s: can't create a context from %s, skipping\n",
+				__FUNCTION__, usercon_str);
+			free(usercon_str);
 			start =3D end;
 			continue;
 		}
+		free(usercon_str);
+		if (context_range_set(usercon, fromlevel) !=3D 0) {
+			context_free(usercon);
+			rc =3D -1;
+			goto out;
+		}
+		usercon_str =3D context_str(usercon);
+		if (!usercon_str) {
+			context_free(usercon);
+			rc =3D -1;
+			goto out;
+		}
=20
-		/* If a match is found and the entry is not already ordered
-		   (e.g. due to prior match in prior config file), then set
-		   the ordering for it. */
-		i =3D rc;
-		if (ordering[i] =3D=3D nreach)
-			ordering[i] =3D (*nordered)++;
+		/* check whether usercon is already in reachable */
+		if (is_in_reachable(*reachable, usercon_str)) {
+			context_free(usercon);
+			start =3D end;
+			continue;
+		}
+		if (security_check_context(usercon_str) =3D=3D 0) {
+			if (*nreachable =3D=3D 0) {
+				new_reachable =3D malloc(2 * sizeof(char *));
+				if (!new_reachable) {
+					context_free(usercon);
+					rc =3D -1;
+					goto out;
+				}
+			} else {
+				new_reachable =3D realloc(*reachable, (*nreachable + 2) * sizeof(cha=
r *));
+				if (!new_reachable) {
+					context_free(usercon);
+					rc =3D -1;
+					goto out;
+				}
+			}
+			new_reachable[*nreachable] =3D strdup(usercon_str);
+			if (new_reachable[*nreachable] =3D=3D NULL) {
+				context_free(usercon);
+				rc =3D -1;
+				goto out;
+			}
+			new_reachable[*nreachable + 1] =3D 0;
+			*reachable =3D new_reachable;
+			*nreachable +=3D 1;
+		}
+		context_free(usercon);
 		start =3D end;
 	}
-
 	rc =3D 0;
=20
       out:
@@ -313,21 +353,6 @@ static int get_failsafe_context(const char *user, ch=
ar ** newcon)
 	return 0;
 }
=20
-struct context_order {
-	char * con;
-	unsigned int order;
-};
-
-static int order_compare(const void *A, const void *B)
-{
-	const struct context_order *c1 =3D A, *c2 =3D B;
-	if (c1->order < c2->order)
-		return -1;
-	else if (c1->order > c2->order)
-		return 1;
-	return strcmp(c1->con, c2->con);
-}
-
 int get_ordered_context_list_with_level(const char *user,
 					const char *level,
 					char * fromcon,
@@ -395,11 +420,8 @@ int get_ordered_context_list(const char *user,
 			     char *** list)
 {
 	char **reachable =3D NULL;
-	unsigned int *ordering =3D NULL;
-	struct context_order *co =3D NULL;
-	char **ptr;
 	int rc =3D 0;
-	unsigned int nreach =3D 0, nordered =3D 0, freefrom =3D 0, i;
+	unsigned nreachable =3D 0, freefrom =3D 0;
 	FILE *fp;
 	char *fname =3D NULL;
 	size_t fname_len;
@@ -413,23 +435,6 @@ int get_ordered_context_list(const char *user,
 		freefrom =3D 1;
 	}
=20
-	/* Determine the set of reachable contexts for the user. */
-	rc =3D security_compute_user(fromcon, user, &reachable);
-	if (rc < 0)
-		goto failsafe;
-	nreach =3D 0;
-	for (ptr =3D reachable; *ptr; ptr++)
-		nreach++;
-	if (!nreach)
-		goto failsafe;
-
-	/* Initialize ordering array. */
-	ordering =3D malloc(nreach * sizeof(unsigned int));
-	if (!ordering)
-		goto failsafe;
-	for (i =3D 0; i < nreach; i++)
-		ordering[i] =3D nreach;
-
 	/* Determine the ordering to apply from the optional per-user config
 	   and from the global config. */
 	fname_len =3D strlen(user_contexts_path) + strlen(user) + 2;
@@ -440,8 +445,8 @@ int get_ordered_context_list(const char *user,
 	fp =3D fopen(fname, "re");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
-		rc =3D get_context_order(fp, fromcon, reachable, nreach, ordering,
-				       &nordered);
+		rc =3D get_context_user(fp, fromcon, user, &reachable, &nreachable);
+
 		fclose(fp);
 		if (rc < 0 && errno !=3D ENOENT) {
 			fprintf(stderr,
@@ -454,8 +459,7 @@ int get_ordered_context_list(const char *user,
 	fp =3D fopen(selinux_default_context_path(), "re");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
-		rc =3D get_context_order(fp, fromcon, reachable, nreach, ordering,
-				       &nordered);
+		rc =3D get_context_user(fp, fromcon, user, &reachable, &nreachable);
 		fclose(fp);
 		if (rc < 0 && errno !=3D ENOENT) {
 			fprintf(stderr,
@@ -463,40 +467,18 @@ int get_ordered_context_list(const char *user,
 				__FUNCTION__, selinux_default_context_path());
 			/* Fall through */
 		}
-		rc =3D 0;
+		rc =3D nreachable;
 	}
=20
-	if (!nordered)
+	if (!nreachable)
 		goto failsafe;
=20
-	/* Apply the ordering. */
-	co =3D malloc(nreach * sizeof(struct context_order));
-	if (!co)
-		goto failsafe;
-	for (i =3D 0; i < nreach; i++) {
-		co[i].con =3D reachable[i];
-		co[i].order =3D ordering[i];
-	}
-	qsort(co, nreach, sizeof(struct context_order), order_compare);
-	for (i =3D 0; i < nreach; i++)
-		reachable[i] =3D co[i].con;
-	free(co);
-
-	/* Only report the ordered entries to the caller. */
-	if (nordered <=3D nreach) {
-		for (i =3D nordered; i < nreach; i++)
-			free(reachable[i]);
-		reachable[nordered] =3D NULL;
-		rc =3D nordered;
-	}
-
       out:
 	if (rc > 0)
 		*list =3D reachable;
 	else
 		freeconary(reachable);
=20
-	free(ordering);
 	if (freefrom)
 		freecon(fromcon);
=20
--=20
2.25.0

