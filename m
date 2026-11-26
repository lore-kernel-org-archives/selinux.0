Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663797;
	b=bZhMoukHECm0QMQVJhDptPaF7M92XoVpDQiUDhsQ7rWSo7O4d1G4LHDS3hHeMZm+I+EI
	 HokfM6pgRmYTgO79k6AqhcVIpCmxxbuNPTKI6EZ3/KBXaV7LQJsgGCEaNq3kDgCMJ3VxA
	 o74lF1rn7hW4pqdnmySgIkCx5uDN1ZV6qq2D7z5E/9n4OmgBjWKjId3vo5wxGEo3vr8S0
	 77DM/TCBlBuoqDCUtcA2C1ZNmrcVPvqAK30WS8EjMToRC9Dv77WUHY8x8nmxFLAh01xKm
	 iskjDWdn9Hy0GKTKDsthKdwoPcBNLC7scap5tjPYZsBPwoK0AyZYos5G+IM6Eb5/Dag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=4T7jddzvfeS7ujm4/4ZdWYz6tQyFVXRoBUyBh9PwoLM=;
	b=Gkz2tf5U/K+fNVydJRNngs3l0ZFocsfwovOYgwextMm4x2oSqZ//57R10DchMc94ZCFR
	 MsNgetfKvU1MLadEW5wCeGIYy3WLTzMp0I/7uk9MOT0Y7DcbZN5GMfc57Mf1rPC3c0ZM8
	 vjZI7MHazzHFlR/8lGPrdJgQVDvjIC2RZmN4tlHWDg9jeYROppWJx95IMVR/fa1fGglL7
	 zavtndAzneIPRQVKqayHjW8Vabo77kVVNSHgTZU9xj4mrQSvdfjNi72uuxhiYNpDkIMGJ
	 MVi8Gc9QYE7re7S7zb14lfZ85AmidaIoSo/hJ/CSqLgQXmUw5xbgWlNg7vJW6fSA7Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="m9wvzF/c";
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030A606A333
	for <selinux@vger.kernel.org>; Thu, 26 Nov 2026 03:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0030A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m9wvzF/c
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-54dbbf252cdso6583710b6e.2
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 19:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795663795; x=1796268595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4T7jddzvfeS7ujm4/4ZdWYz6tQyFVXRoBUyBh9PwoLM=;
        b=m9wvzF/c1gGdNYwRRAhTV7e5N4x5PP+fGfBpaJ7Z1kohQfh8FpHYHwRKxw5bT2xsA2
         B3jiqe7TiBEbi1u6OxHh/MD1TGA9/JpD49ka5TIZ+IXE+wo0Mfcuzm7fBbLmMzFiIeoD
         LGxZZsa/7uI4Vc1fm6U2fmkEbJ8+JCfGbIo/CS8hMv1jwUyGvTuBvm7sZTSct/1p+V1o
         1/oYnfJeYO4m9WGoIl6EsU1K5ikbrNH29jsIwxiyMvEEUBHEADdu+xQ69bwNvX0h8MQZ
         OTqUG8ys0uELXKVoTq8E0GPODdPV5YOu6wYCVy6zUc1t8D4ktOACZoD0GUAnzGCaflbz
         ZHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663795; x=1796268595;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4T7jddzvfeS7ujm4/4ZdWYz6tQyFVXRoBUyBh9PwoLM=;
        b=pSnlUjtqGWSk5Nv6mVALo0KCZYTx2d2boWD5oI82DBIILaQMnsRLroGYvLwvAtqZki
         q5JzIm4+S+LeG7jru6Mb5Nmp++UWMqU4OtvhWaT0XhGPMoaUTPUApG8RhtZC9G+JFVPj
         5pZYuFg4QWWu2Ac1WpmGtJwWNQohyzG0pwGbxnzKOaW/Ez2ESDw6Ny0XdUTsTd+GGQgp
         IGny0/EzWnBvPuiMPvk2WPeOtgY2KJ3+nyQZBY1L5J6pydCV+MeHjia76WTHwsD87xpT
         iX9StExb5ui3lfHyNE8AKqMNjNifaAjp6JmdajqSEqBMotKlxLV3i52kitbjix+JF9FQ
         Cn0w==
X-Gm-Message-State: APuU4Z9+0zd96MEmtDcyShW9jH8LS8L/4LIFWiBGvktvKUyNbyvMMTH6
	pD/XxYrH9jr0fqcK89uyIwKTAWHSwA+TsXKQxNfBjfIkfmTS5EDn2QCB7P+eogldLcK3yHLSk/v
	+CKj0gWmUiFwM6GVPDjr15SXGZsO69ys+yIf7CPTZRdI5MQl8B1iAZzgHp9j3O4WJB453m0Eys/
	Yba5bcKus2o6qDOnKI+umo5izCzUjO+WMz
X-Received: from oiic27-n2.prod.google.com ([2002:a05:6808:a5db:20b0:4f6:3107:c01b])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:6788:b0:4d6:90f4:48b1
 with SMTP id 5614622812f47-57a0c7c2a46mr21606563b6e.51.1795663794516; Wed, 25
 Nov 2026 19:29:54 -0800 (PST)
Date: Thu, 26 Nov 2026 14:29:23 +1100
In-Reply-To: <20261126032924.1868720-1-tweek@google.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126032924.1868720-1-tweek@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126032924.1868720-3-tweek@google.com>
Subject: [PATCH userspace 2/2] checkpolicy: warn on negative-only type sets
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Inseob Kim <inseob@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Policy authors sometimes write "{ -foo }" expecting set complement
("~foo"), when in fact "-" is set subtraction from the positive set in
the same expression.  Without any positive types (and without "*"),
"{ -foo }" evaluates to the empty set and "~{ -foo }" evaluates to all
types, silently turning rules such as "neverallow { -foo } ..." into
no-ops.

Emit a warning via yywarn() when a parsed type set has an empty positive
set, a non-empty negative set, and does not have TYPE_STAR set.  Using
yywarn() avoids breaking existing policies on upgrade while still
failing strict builds that pass -E / --werror.

Because the check inspects the parsed type_set_t bitmaps before
expansion, standard cases that legitimately expand to an empty set are
unaffected:
- Empty attributes (e.g. "{ empty_attr -foo }"), where the positive set
  contains the attribute symbol and types may be associated in other
  files or modules.
- Self-canceling sets (e.g. "{ foo -foo }" or "{ attr -foo }" when attr
  only contains foo), which can occur via macro expansion and already
  have identical empty semantics in expand.c and module_to_cil.c.
- "{ -self }" and "~self", which record RULE_NOTSELF without populating
  negset.

Add a regression test script covering AV rules, extended permission
rules, transition rules, role-types statements, checkmodule -m, and
valid set-subtraction/complement controls (including empty attributes
and self-canceling sets).

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 checkpolicy/Makefile                       |   1 +
 checkpolicy/policy_define.c                |  24 ++
 checkpolicy/tests/test_negative_typeset.sh | 245 +++++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 checkpolicy/tests/test_negative_typeset.sh

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 9d5b7123..9d0c69d6 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -57,6 +57,7 @@ test: checkpolicy checkmodule tests/test-type-enabled
 	sh ./tests/test_conditional_count.sh
 	./tests/test-type-enabled
 	sh ./tests/test_multiple_decls.sh
+	sh ./tests/test_negative_typeset.sh
=20
 tests/test-type-enabled: tests/test_type_enabled.c $(LIBSEPOLA)
 	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 349cd355..5e9715ea 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1729,6 +1729,18 @@ oom:
 	return -1;
 }
=20
+static void check_type_set(const type_set_t *set)
+{
+	if (ebitmap_is_empty(&set->types) && !ebitmap_is_empty(&set->negset) &&
+	    !(set->flags & TYPE_STAR)) {
+		if (set->flags & TYPE_COMP) {
+			yywarn("complemented type set has no positive types and matches all typ=
es");
+		} else {
+			yywarn("type set has no positive types and evaluates to the empty set")=
;
+		}
+	}
+}
+
 static int define_compute_type_helper(int which, avrule_t **rule)
 {
 	char *id;
@@ -1761,6 +1773,7 @@ static int define_compute_type_helper(int which, avru=
le_t **rule)
 		if (set_types(&avrule->stypes, id, &add, 0))
 			goto bad;
 	}
+	check_type_set(&avrule->stypes);
 	add =3D 1;
 	while ((id =3D queue_remove(id_queue))) {
 		if (strcmp(id, "self") =3D=3D 0) {
@@ -1775,6 +1788,7 @@ static int define_compute_type_helper(int which, avru=
le_t **rule)
 		if (set_types(&avrule->ttypes, id, &add, 0))
 			goto bad;
 	}
+	check_type_set(&avrule->ttypes);
=20
 	if (read_classes(&tclasses))
 		goto bad;
@@ -2236,6 +2250,7 @@ static int define_te_avtab_xperms_helper(int which, a=
vrule_t **rule)
 			goto out;
 		}
 	}
+	check_type_set(&avrule->stypes);
 	add =3D 1;
 	while ((id =3D queue_remove(id_queue))) {
 		if (strcmp(id, "self") =3D=3D 0) {
@@ -2268,6 +2283,7 @@ static int define_te_avtab_xperms_helper(int which, a=
vrule_t **rule)
 			avrule->flags |=3D RULE_NOTSELF;
 		}
 	}
+	check_type_set(&avrule->ttypes);
=20
 	ebitmap_init(&tclasses);
 	ret =3D read_classes(&tclasses);
@@ -2867,6 +2883,7 @@ static int define_te_avtab_helper(int which, avrule_t=
 **rule)
 			goto out;
 		}
 	}
+	check_type_set(&avrule->stypes);
 	add =3D 1;
 	while ((id =3D queue_remove(id_queue))) {
 		if (strcmp(id, "self") =3D=3D 0) {
@@ -2903,6 +2920,7 @@ static int define_te_avtab_helper(int which, avrule_t=
 **rule)
 			avrule->flags |=3D RULE_NOTSELF;
 		}
 	}
+	check_type_set(&avrule->ttypes);
=20
 	ret =3D read_classes(&tclasses);
 	if (ret)
@@ -3092,6 +3110,7 @@ int define_role_types(void)
 		if (set_types(&role->types, id, &add, 0))
 			return -1;
 	}
+	check_type_set(&role->types);
=20
 	return 0;
 }
@@ -3330,6 +3349,7 @@ int define_role_trans(int class_specified)
 		if (set_types(&types, id, &add, 0))
 			goto bad;
 	}
+	check_type_set(&types);
=20
 	if (class_specified) {
 		if (read_classes(&e_classes))
@@ -3532,6 +3552,7 @@ int define_filename_trans(void)
 		if (set_types(&stypes, id, &add, 0))
 			goto bad;
 	}
+	check_type_set(&stypes);
=20
 	self =3D 0;
 	add =3D 1;
@@ -3548,6 +3569,7 @@ int define_filename_trans(void)
 		if (set_types(&ttypes, id, &add, 0))
 			goto bad;
 	}
+	check_type_set(&ttypes);
=20
 	if (read_classes(&e_tclasses))
 		goto bad;
@@ -6257,11 +6279,13 @@ int define_range_trans(int class_specified)
 		if (set_types(&rule->stypes, id, &add, 0))
 			goto out;
 	}
+	check_type_set(&rule->stypes);
 	add =3D 1;
 	while ((id =3D queue_remove(id_queue))) {
 		if (set_types(&rule->ttypes, id, &add, 0))
 			goto out;
 	}
+	check_type_set(&rule->ttypes);
=20
 	if (class_specified) {
 		if (read_classes(&rule->tclasses))
diff --git a/checkpolicy/tests/test_negative_typeset.sh b/checkpolicy/tests=
/test_negative_typeset.sh
new file mode 100644
index 00000000..23204c05
--- /dev/null
+++ b/checkpolicy/tests/test_negative_typeset.sh
@@ -0,0 +1,245 @@
+#!/bin/sh
+set -eu
+
+BASEDIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
+CHECKPOLICY=3D${CHECKPOLICY:-"${BASEDIR}/../checkpolicy"}
+CHECKMODULE=3D${CHECKMODULE:-"${BASEDIR}/../checkmodule"}
+OUTDIR=3D$(mktemp -d "${TMPDIR:-/tmp}/negative-typeset.XXXXXX")
+trap 'rm -rf "$OUTDIR"' EXIT HUP INT TERM
+
+WARN_EMPTY=3D"type set has no positive types and evaluates to the empty se=
t"
+WARN_COMP=3D"complemented type set has no positive types and matches all t=
ypes"
+PASS=3D0
+
+write_conf() {
+	out=3D$1
+	mls=3D$2
+	extra=3D$3
+
+	{
+		printf '%s\n' \
+			'class CLASS1' \
+			'sid kernel' \
+			'class CLASS1 { PERM1 ioctl }'
+		if [ "$mls" =3D "1" ]; then
+			printf '%s\n' \
+				'sensitivity s0;' \
+				'dominance { s0 }' \
+				'category c0;' \
+				'level s0:c0;' \
+				'mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;'
+		fi
+		printf '%s\n' \
+			'attribute ATTR1;' \
+			'type TYPE1, ATTR1;' \
+			'type TYPE2, ATTR1;' \
+			'allow TYPE1 self:CLASS1 PERM1;' \
+			'role ROLE1;' \
+			'role ROLE1 types { TYPE1 TYPE2 };'
+		printf '%s\n' "$extra"
+		if [ "$mls" =3D "1" ]; then
+			printf '%s\n' \
+				'user USER1 roles ROLE1 level s0 range s0 - s0;' \
+				'sid kernel USER1:ROLE1:TYPE1:s0 - s0'
+		else
+			printf '%s\n' \
+				'user USER1 roles ROLE1;' \
+				'sid kernel USER1:ROLE1:TYPE1'
+		fi
+	} > "$out"
+}
+
+expect_conf_warn() {
+	desc=3D$1
+	mls=3D$2
+	rule=3D$3
+	pattern=3D$4
+
+	conf=3D"$OUTDIR/policy.conf"
+	bin=3D"$OUTDIR/policy.bin"
+	err=3D"$OUTDIR/stderr.txt"
+	opts=3D""
+	if [ "$mls" =3D "1" ]; then
+		opts=3D"-M"
+	fi
+
+	write_conf "$conf" "$mls" "$rule"
+
+	rm -f "$bin"
+	# Without -E: succeeds with a warning on stderr.
+	"$CHECKPOLICY" $opts -o "$bin" "$conf" 2> "$err"
+	if ! grep -Fq "$pattern" "$err"; then
+		echo "FAIL ($desc): expected warning '$pattern'" >&2
+		cat "$err" >&2
+		exit 1
+	fi
+
+	rm -f "$bin"
+	# With -E: fails and produces no output file.
+	if "$CHECKPOLICY" $opts -E -o "$bin" "$conf" 2> "$err"; then
+		echo "FAIL ($desc): expected failure with -E" >&2
+		exit 1
+	fi
+	if [ -f "$bin" ]; then
+		echo "FAIL ($desc): unexpected output file on -E failure" >&2
+		exit 1
+	fi
+	if ! grep -Fq "$pattern" "$err"; then
+		echo "FAIL ($desc): expected error '$pattern' with -E" >&2
+		cat "$err" >&2
+		exit 1
+	fi
+
+	PASS=3D$((PASS + 1))
+}
+
+expect_conf_clean() {
+	desc=3D$1
+	mls=3D$2
+	rule=3D$3
+
+	conf=3D"$OUTDIR/policy.conf"
+	bin=3D"$OUTDIR/policy.bin"
+	err=3D"$OUTDIR/stderr.txt"
+	opts=3D""
+	if [ "$mls" =3D "1" ]; then
+		opts=3D"-M"
+	fi
+
+	write_conf "$conf" "$mls" "$rule"
+	rm -f "$bin"
+	if ! "$CHECKPOLICY" $opts -E -o "$bin" "$conf" 2> "$err"; then
+		echo "FAIL ($desc): unexpected failure with -E" >&2
+		cat "$err" >&2
+		exit 1
+	fi
+	if [ ! -s "$bin" ]; then
+		echo "FAIL ($desc): expected non-empty output" >&2
+		exit 1
+	fi
+
+	PASS=3D$((PASS + 1))
+}
+
+expect_mod_warn() {
+	desc=3D$1
+	rule=3D$2
+	pattern=3D$3
+
+	te=3D"$OUTDIR/testmod.te"
+	mod=3D"$OUTDIR/testmod.mod"
+	err=3D"$OUTDIR/stderr.txt"
+
+	cat > "$te" <<EOF
+module testmod 1.0;
+require {
+	attribute ATTR1;
+	type TYPE1, TYPE2;
+	role ROLE1;
+	class CLASS1 { PERM1 };
+}
+$rule
+EOF
+
+	rm -f "$mod"
+	"$CHECKMODULE" -m -o "$mod" "$te" 2> "$err"
+	if ! grep -Fq "$pattern" "$err"; then
+		echo "FAIL ($desc): expected warning '$pattern'" >&2
+		cat "$err" >&2
+		exit 1
+	fi
+
+	rm -f "$mod"
+	if "$CHECKMODULE" -m -E -o "$mod" "$te" 2> "$err"; then
+		echo "FAIL ($desc): expected failure with -E" >&2
+		exit 1
+	fi
+	if [ -f "$mod" ]; then
+		echo "FAIL ($desc): unexpected output module on -E failure" >&2
+		exit 1
+	fi
+
+	PASS=3D$((PASS + 1))
+}
+
+expect_mod_clean() {
+	desc=3D$1
+	rule=3D$2
+
+	te=3D"$OUTDIR/testmod.te"
+	mod=3D"$OUTDIR/testmod.mod"
+	err=3D"$OUTDIR/stderr.txt"
+
+	cat > "$te" <<EOF
+module testmod 1.0;
+require {
+	attribute ATTR1;
+	type TYPE1, TYPE2;
+	role ROLE1;
+	class CLASS1 { PERM1 };
+}
+$rule
+EOF
+
+	rm -f "$mod"
+	if ! "$CHECKMODULE" -m -E -o "$mod" "$te" 2> "$err"; then
+		echo "FAIL ($desc): unexpected failure with -E" >&2
+		cat "$err" >&2
+		exit 1
+	fi
+
+	PASS=3D$((PASS + 1))
+}
+
+# Negative-only type sets must warn (and fail with -E).
+expect_conf_warn "neverallow source" 0 \
+	"neverallow { -TYPE1 } self:CLASS1 PERM1;" "$WARN_EMPTY"
+expect_conf_warn "allow source" 0 \
+	"allow { -TYPE1 } self:CLASS1 PERM1;" "$WARN_EMPTY"
+expect_conf_warn "allow target" 0 \
+	"allow TYPE1 { -TYPE2 }:CLASS1 PERM1;" "$WARN_EMPTY"
+expect_conf_warn "neverallow complemented" 0 \
+	"neverallow ~{ -TYPE1 } self:CLASS1 ioctl;" "$WARN_COMP"
+expect_conf_warn "neverallowxperm source" 0 \
+	"neverallowxperm { -TYPE1 } self:CLASS1 ioctl 0x1;" "$WARN_EMPTY"
+expect_conf_warn "type_transition source" 0 \
+	"type_transition { -TYPE1 } TYPE2:CLASS1 TYPE1;" "$WARN_EMPTY"
+expect_conf_warn "filename type_transition source" 0 \
+	'type_transition { -TYPE1 } TYPE2:CLASS1 TYPE1 "foo";' "$WARN_EMPTY"
+expect_conf_warn "role_transition target" 0 \
+	"role_transition ROLE1 { -TYPE1 }:CLASS1 ROLE1;" "$WARN_EMPTY"
+expect_conf_warn "range_transition source" 1 \
+	"range_transition { -TYPE1 } TYPE2:CLASS1 s0;" "$WARN_EMPTY"
+expect_conf_warn "role types negative-only" 0 \
+	"role ROLE2; role ROLE2 types { -TYPE1 };" "$WARN_EMPTY"
+
+expect_mod_warn "module allow negative-only" \
+	"allow { -TYPE1 } self:CLASS1 PERM1;" "$WARN_EMPTY"
+expect_mod_warn "module neverallow complemented negative-only" \
+	"neverallow ~{ -TYPE1 } self:CLASS1 PERM1;" "$WARN_COMP"
+expect_mod_warn "module role types negative-only" \
+	"role ROLE1 types { -TYPE1 };" "$WARN_EMPTY"
+
+# Valid type sets must compile cleanly with -E.
+expect_conf_clean "set subtraction with positive attr" 0 \
+	"allow { ATTR1 -TYPE1 } self:CLASS1 PERM1;"
+expect_conf_clean "set subtraction with empty attr" 0 \
+	"attribute EMPTY_ATTR; allow { EMPTY_ATTR -TYPE1 } self:CLASS1 PERM1;"
+expect_conf_clean "self-canceling set" 0 \
+	"allow { TYPE1 -TYPE1 } self:CLASS1 PERM1;"
+expect_conf_clean "set complement" 0 \
+	"neverallow ~TYPE1 self:CLASS1 ioctl;"
+expect_conf_clean "complemented subtraction with positive attr" 0 \
+	"neverallow ~{ ATTR1 -TYPE1 } self:CLASS1 ioctl;"
+expect_conf_clean "star wildcard" 0 \
+	"neverallow * self:CLASS1 ioctl;"
+expect_conf_clean "neverallow -self" 0 \
+	"neverallow TYPE1 { -self }:CLASS1 ioctl;"
+expect_conf_clean "neverallow ~self" 0 \
+	"neverallow TYPE1 ~self:CLASS1 ioctl;"
+expect_conf_clean "role types subtraction after positive types" 0 \
+	"role ROLE1 types { -TYPE2 };"
+expect_mod_clean "module set subtraction with positive attr" \
+	"allow { ATTR1 -TYPE1 } self:CLASS1 PERM1;"
+
+printf 'PASS %s negative-only type set tests\n' "$PASS"
--=20
2.56.1.839.g22a8290db9-goog

