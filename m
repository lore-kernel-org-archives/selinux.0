Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC7233134
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797113; cv=none; b=ATzPwVLu3mGNPTN4Xp64nzPZ4OJcAmB3s6K+8WGMFeETirPijnTb4IvBvziMUcFNaMkmQIowTeJ9PiJtU3cbi+pyrXErI+/XYftpaoZzM3yJCgoQAY77WGu1hiIW7ktGmfsBIZ13rBS/POz8xROoF4aXMA7omJCB7qcDaq+9uy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797113; c=relaxed/simple;
	bh=zrLX9MMuRDVTCq+tl6z9AXBFVraQeCOkp6Ru/MBQp/4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DWv9Khag23I2Zykg175v1etIxP/kMic+eoWTsJ4Zo0FkbZ3sJ9cPYhYSO5dyxhdatSXs4399GwygV4jLDyNYId8UkyzYFL3ehBfSN9ffzNld5Ky3IPUfReBPIwecha/51N2zmLP3sZqEuKZHkZBtYwwwdbSD6pAMrhF+f2Q/QRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSzWEnce; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSzWEnce"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so8247695ad.2
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784797111; x=1785401911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Jk7GfYWgLro+9/ZTaNLYPCQwMbOr0xL8BRmaUR1ofU=;
        b=iSzWEnceYaWikMhLdlFNXxdEC637fCQePlj964OFIOuGfY3x8tmaRsT4B+O2h8Xcqj
         ooIEae4LLgN7mlM+8q0hiIXl9NngGATSIR1wlQUzeBA+kK1LIKUxTLbkLZY2S8f3aqwn
         5fWvHLl/OxwNY2ZRM5fQIJvbDC+Yy+4VRwtWvsSEF6aJgqCE+wod1ktWVmmd4jQ+HaOr
         4DyWvXR9p0dTHnzkYsYjNUEWDGKoGt9Ikm613pSWG0uzef2sAmwNLPe46vXHagWBx64H
         joEJhOA2eTSxb1QcqvBbuExJk8oPJRtgcLukAzmjtNApC4vgdQ9mqXJJ/4jVD/NAmHej
         4YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784797111; x=1785401911;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Jk7GfYWgLro+9/ZTaNLYPCQwMbOr0xL8BRmaUR1ofU=;
        b=EOis/h3TP3jaKsjFzLl7cSmM+7R5vChQvoyG9Felr4zmSDgkh3kzI3FyqhLiUHTDA/
         qyjn71F91swLegrfAAfF8uDBHwN5kHxxxoItXu1Vd7lpkmFj57GnL4jxut6GNvnfQo7X
         tnVoL3K8iE+1pnvFqh1Qr1d6468tCmy0zD+DALG6/DnyRkVL5SMV5kK7QcF22eneqw1g
         SDpPLHVVqx/SfMWatW7O4J4Ow0lwVeBwgtPd2On1GGpHL0Szo93TEZoYcxC4BbPkTXwe
         XwWrC1TpxuC9w6rvrCBhAE6dcLnGkOsk5WEpr0FH9RPMY/+vQAneoln+iZ8LiuqWFX2f
         lEtg==
X-Gm-Message-State: AOJu0YwB3Uj+U+QIHsdLW53MOGR5DzEzFYq0HCACb/thMyvipk6fAYd5
	u92aooNC11Xkudr5zBrY4CAZQdcz84nbMsVQ5g59AjbO6mgQwFmwMYjOAjEwlZgfUS9o4l1Clrx
	uJYL6LgAUJwX0djTbvn+zz8Lj1+09XYfwWug88Bx5Br308Squ/X0gRfqAlASFDqKG65URlhr7l3
	1ggp63w3m2uMXspaWgMzy18wpRx/c7kXI7fpRQtQ==
X-Received: from pgqs24.prod.google.com ([2002:a65:6918:0:b0:cbb:676d:ab19])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7284:b0:3c0:9c19:65c0
 with SMTP id adf61e73a8af0-3c44b273f86mr2325677637.72.1784797111062; Thu, 23
 Jul 2026 01:58:31 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:58:29 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723085829.318778-1-inseob@google.com>
Subject: [PATCH v2] libselinux: improve performance with pcre matches
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
excesive recreation of the match_data in an attempt to reduce memory
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
for matching are allocated might had brough since 10.41 was released.

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

