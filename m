Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24539279DAF
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854467; cv=none; b=oA/erAU6H6PZ9lT/33aL3ibP+F/KpQyANlYMpRF3Yht9IhjfSxL8Mb4LN102hzE3Vp/YYRD80DGNSUNIYsloyhjPZa5xxtfKhRh0OxjUAknEFhvYkNvGOvRmOHMIAObUVeGN2onV8X9BVWcYVXZY79E1c8S0DwBatB92DOW3+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854467; c=relaxed/simple;
	bh=FM0OdBYG0vSxFuR9cmHn7nqo6adiDXMHH3RclFg8LCo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VAega52fhLtFcErxeIl+YC7hF6LVC+NkG7btFL+TYWmJe1lr4lEDKILKFGI6EK54QL9pwLgXdkm2rs+o+iTA5I3vlmjlNRi9Xnjk3Y0tNja6tk/SMuSPzazRlkSzS7hU0CxExG2KsagPKBJzUIjI7Mcx09AXMzdgClgCRntF/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ii7aUpIR; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ii7aUpIR"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc86a9ef97so26873895ad.3
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854465; x=1785459265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cmVBOWxCPFI8EYzXzZND8KrmqqJy+guIgJsPJEAz8lM=;
        b=ii7aUpIRH707NWUcHNHZMN3Ckbg6O28CbBuOgij2YZr4qzqbml57fuak1QjULRAzgn
         5J1hTYXIYfZExjhYQ9Y588zVi8+XZ0cV0z3CiTTrUm2+TGQkmdbhj5vTIaY+VD1UluFM
         U7wHkVYrCVP8vpqkOgEhMPjud1anuCgsPn5nQNHtGHMHuzejtwT2gbKeC5Um1wD0ytOo
         lqfcGn3SU5BjXhQFwpmwftEuEPWDY85PYt3jJqHC7lWobWNmroaBRumGNvPV3ygZqmvH
         3FqXjv4ePoY1VFGTtkcAfxkY+iP5kWMxMNyo0l6Rtz5tGWohaVIDG+E1a8Zztpm81TPi
         Lb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854465; x=1785459265;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cmVBOWxCPFI8EYzXzZND8KrmqqJy+guIgJsPJEAz8lM=;
        b=f2Ho7H0YhKFrMBy1xM+cEJ70Z2LWYjiu6oJ0TSbOjFGUnReo2pqQigQ9ISUEhPgJEg
         GPzi74i2nd7eg/r05Gs7Fu8wWcdfbyZP+43l2VERrzPL2/tDR/zZMEufmbyOKxEp9o4e
         C270xsL3VPz0ZcHAIJTdJP0xsE224AnZ615fC80IQMY7hK0RTEXwHRG/sf8WYAQUuXc3
         gXj7beoeOWPw96wKT/c9s139myrrA85/OrYMXmZdSfU68amoujxSUwM9Pb9ZxexVDGGo
         d/Ya2jIInMuaqqYdHqC/SocOPq/GQToB6Z86t7+oCMgug+RL+SlwtB0k5ILTMg5uCaGw
         C5DA==
X-Gm-Message-State: AOJu0Yz/YbtrgXyD180svTTA0cKLDRANzr+Yc6I+HfuQP5e6xcBBUord
	Etn+iWHyPUawdpyvr+rD46ctzuxglynMDOmgr/R1VOkxvtasXCyZ4cGaRWcqdB2Z4QkhYque2WV
	0YfjTa7247l6iM9oxieRIfDrYn3K44zJgL+rbO3rZN6HckBq2DRuuZLdkEqHOgb1dDCDM91xe4U
	W6Mj4QnRNhv0pYCF8capaWgqwTZI8MsSNTv0MMRg==
X-Received: from plgc3.prod.google.com ([2002:a17:902:d483:b0:2ca:6d6d:5267])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:7c03:b0:2cf:4339:aaa
 with SMTP id d9443c01a7336-2cfa7435a2bmr46025895ad.12.1784854465136; Thu, 23
 Jul 2026 17:54:25 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:54:16 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724005416.805098-1-inseob@google.com>
Subject: [PATCH v3] libselinux: improve performance with pcre matches
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, Eric Biggers <ebiggers@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?=" <carenas@gmail.com>, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
2023-01-12), performance of PCRE2 matches has been affected due to
excessive recreation of the match_data in an attempt to reduce memory
utilization; instead of a workaround, it would be better to address
the problem and maybe even improve performance in the process.

The issue is that currently the structure that holds PCRE state has
both a pcre2_code (which is per pattern) and a pcre2_match_data (which
is per match), forcing us to add a mutex to prevent multiple matches to
step on each other.

Lets remove the match_data and the mutex and instead allocate one once
in a thread independent way that could be used and reused, by extending
our pthread interface to not only store TLS variables but also retrieve
them, and then use one of those.

Since we are not interested on the capture groups (if any) lets only
allocate 1 pair which is all that will be needed and change the logic
so that a return of 0 (which means the pattern matched but there were
not enough capture spots) is also considered a match.

This will ensure that the memory use would be bound to the number of
concurrent matches instead of the number of patterns and therefore
reduce the impact that recent changes on the way that the frames used
for matching are allocated have brought since PCRE2 10.41 was released.

For cases where threads are not available, just keep it working in slow
mode as done before the workaround was reverted.

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Inseob Kim <inseob@google.com>
---
v2:
 - Fix the dual destructor antipattern by separating the thread-exit
   destructor (match_data_thread_free) from the library-unload key cleanup
   (match_data_key_destroy, annotated with __attribute__((destructor))).
 - Eliminate the data race on match_data_key_initialized by using pthread_o=
nce
   (via __selinux_once) for safe, race-free initialization of match_data_ke=
y.
 - Remove redundant match_data_initialized thread-local variable, making
   lookups purely based on __selinux_getspecific().
v3:
 - Fix typos in the commit message, along with "PCRE2 10.41"
   clarification
---
 libselinux/src/regex.c            | 105 +++++++++++++++---------------
 libselinux/src/selinux_internal.h |   4 ++
 2 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 80b01692..b132b558 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -36,6 +36,10 @@
 static struct regex_data *regex_data_create(void);
=20
 #ifdef USE_PCRE2
+static pthread_key_t match_data_key;
+static pthread_once_t match_data_key_once =3D PTHREAD_ONCE_INIT;
+static int match_data_key_alloc_failed =3D 0;
+static int match_data_key_created =3D 0;
 static pthread_once_t once =3D PTHREAD_ONCE_INIT;
 static char arch_string_buffer[32];
=20
@@ -71,14 +75,6 @@ const char *regex_arch_string(void)
=20
 struct regex_data {
 	pcre2_code *regex; /* compiled regular expression */
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	/*
-	 * match data block required for the compiled
-	 * pattern in pcre2
-	 */
-	pcre2_match_data *match_data;
-#endif
-	pthread_mutex_t match_mutex;
 };
=20
 int regex_prepare_data(struct regex_data **regex, char const *pattern_stri=
ng,
@@ -98,13 +94,6 @@ int regex_prepare_data(struct regex_data **regex, char c=
onst *pattern_string,
 		goto err;
 	}
=20
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	(*regex)->match_data =3D
-		pcre2_match_data_create_from_pattern((*regex)->regex, NULL);
-	if (!(*regex)->match_data) {
-		goto err;
-	}
-#endif
 	return 0;
=20
 err:
@@ -159,13 +148,6 @@ int regex_load_mmap(struct mmap_area *mmap_area, struc=
t regex_data **regex,
 		if (rc !=3D 1)
 			goto err;
=20
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-		(*regex)->match_data =3D pcre2_match_data_create_from_pattern(
-			(*regex)->regex, NULL);
-		if (!(*regex)->match_data)
-			goto err;
-#endif
-
 		*regex_compiled =3D true;
 	}
=20
@@ -223,18 +205,32 @@ out:
 	return rc;
 }
=20
+static void match_data_thread_free(void *ptr)
+{
+	pcre2_match_data_free(ptr);
+}
+
+static void match_data_key_init(void)
+{
+	if (__selinux_key_create(&match_data_key, match_data_thread_free) =3D=3D =
0)
+		match_data_key_created =3D 1;
+	else
+		match_data_key_alloc_failed =3D 1;
+}
+
+static void __attribute__((destructor)) match_data_key_destroy(void)
+{
+	if (match_data_key_created) {
+		__selinux_key_delete(match_data_key);
+		match_data_key_created =3D 0;
+	}
+}
+
 void regex_data_free(struct regex_data *regex)
 {
 	if (regex) {
 		if (regex->regex)
 			pcre2_code_free(regex->regex);
-
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-		if (regex->match_data)
-			pcre2_match_data_free(regex->match_data);
-#endif
-
-		__pthread_mutex_destroy(&regex->match_mutex);
 		free(regex);
 	}
 }
@@ -242,31 +238,38 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int partial=
)
 {
 	int rc;
-	pcre2_match_data *match_data;
-	__pthread_mutex_lock(&regex->match_mutex);
+	bool slow;
+	pcre2_match_data *match_data =3D NULL;
+
+	__selinux_once(match_data_key_once, match_data_key_init);
+
+	if (!match_data_key_alloc_failed) {
+		match_data =3D __selinux_getspecific(match_data_key);
+		if (!match_data) {
+			match_data =3D pcre2_match_data_create(1, NULL);
+			if (match_data) {
+				__selinux_setspecific(match_data_key,
+							match_data);
+			}
+		}
+	}
=20
-#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	match_data =3D pcre2_match_data_create_from_pattern(regex->regex, NULL);
-	if (match_data =3D=3D NULL) {
-		__pthread_mutex_unlock(&regex->match_mutex);
-		return REGEX_ERROR;
+	slow =3D (match_data_key_alloc_failed || match_data =3D=3D NULL);
+	if (slow) {
+		match_data =3D pcre2_match_data_create_from_pattern(regex->regex,
+									NULL);
+		if (!match_data)
+			return REGEX_ERROR;
 	}
-#else
-	match_data =3D regex->match_data;
-#endif
=20
-	rc =3D pcre2_match(regex->regex, (PCRE2_SPTR)subject,
-			 PCRE2_ZERO_TERMINATED, 0,
-			 partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
+	rc =3D pcre2_match(
+	    regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
+	    partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
=20
-#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	// pcre2_match allocates heap and it won't be freed until
-	// pcre2_match_data_free, resulting in heap overhead.
-	pcre2_match_data_free(match_data);
-#endif
+	if (slow)
+		pcre2_match_data_free(match_data);
=20
-	__pthread_mutex_unlock(&regex->match_mutex);
-	if (rc > 0)
+	if (rc >=3D 0)
 		return REGEX_MATCH;
 	switch (rc) {
 	case PCRE2_ERROR_PARTIAL:
@@ -305,10 +308,6 @@ static struct regex_data *regex_data_create(void)
 {
 	struct regex_data *regex_data =3D
 		(struct regex_data *)calloc(1, sizeof(struct regex_data));
-	if (!regex_data)
-		return NULL;
-
-	__pthread_mutex_init(&regex_data->match_mutex, NULL);
 	return regex_data;
 }
=20
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_int=
ernal.h
index b0ef5a75..5feb5d97 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -14,6 +14,7 @@ extern size_t selinux_page_size;
 #pragma weak pthread_key_create
 #pragma weak pthread_key_delete
 #pragma weak pthread_setspecific
+#pragma weak pthread_getspecific
=20
 /* Call handler iff the first call.  */
 #define __selinux_once(ONCE_CONTROL, INIT_FUNCTION)                     \
@@ -42,6 +43,9 @@ extern size_t selinux_page_size;
 			pthread_setspecific(KEY, VALUE); \
 	} while (0)
=20
+#define __selinux_getspecific(KEY) \
+	(pthread_getspecific !=3D NULL ? pthread_getspecific(KEY) : NULL)
+
 /* selabel_lookup() is only thread safe if we're compiled with pthreads */
=20
 #pragma weak pthread_mutex_init
--=20
2.55.0.229.g6434b31f56-goog

