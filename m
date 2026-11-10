Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318860;
	b=lw7tCHsC62CsumTBLFqXpylL0HEm9u2o84VOcegB51GdiEKMcpbmlUb3VnbMoBcfV3Qv
	 1Atb7d/jUgqFhBwCo1f9/nTnkxt7Mt+jUTGaU9JBmU1Qe5ARNowgZUEoxXD7fBSuQwZne
	 XIh6stGUQNgVYTN+E+ugWsjftfOh8Rs2iJD2idHk6/zrq+1jsfIgcreaQgq1dVOW3mZEW
	 1QTsivxO4xjiyIzU6Ojzkldme7vmaliWP1sKSuLqsOFsjOxa3u8vxXeEvAb6GinHCcKfn
	 n8tdqLwK9R/0lSmQo6+S6Geue2fx6AM/BukFmLnuVqtGS8JkZk9fyH+87a/MBolApKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iRYNH2n9N9tavQypvAN3++O2esG2OA4vIp/NaA3m1dE=;
	b=B1z8fE4xpfWXC6hX1A4iyn0vOanzw6T2N1p20xJgP2RgRV10g749qJaLCRmghIJq8qQE
	 N6M+hV53csMxN2yapqMRZT1kFLGPa8kJG7AT998vNaYcwMyp5S1OIJ7BnX3CCqEkP/uoo
	 efcuaZZGSlQ02hEFiVEF8hu9BoHszEzd+Vq1SWrV8VPnzEXUkkEGmr9KTQZJc/7PG/AO6
	 3Aw05JWJhh4kkYWrqzXEqQM/c5ZUiTdJ3y3XWRZI6BCRkzYmn68D7fwOjCgLtiYwbvFkA
	 HRFYrGoc3HJNsV7zfC2XV/w0X7Rq+pHOZapXEGTWst+sS585czSB2xVskfGyaoFu9YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=00DzNDsr;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E963606A325
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 13:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E963606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=00DzNDsr
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-54d9ac78f2eso13652791cf.0
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318859; x=1794923659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRYNH2n9N9tavQypvAN3++O2esG2OA4vIp/NaA3m1dE=;
        b=00DzNDsrSEchjz1JGap6DBiKxThtrwqyBdC8SPL41ibwjZ13fz8gwZVu4rC+GIePXz
         U4ldEu8TjbqoNJaHcrd7Md20VFn00VYSAwhLcaUX3jzba2jzU1uZv0eV0cMyZ5+Kxhw1
         PWfnR7zj90zTDNqjim6wZgFL6vbH4pu/6jvnrxUosCbKGS1EhjN0BP9S/R47KfN8Re8/
         FYK1PHKh/2una4/prq/qoi0XkRYLdRct0+MdbuIX0nCjIFwwPtfS4iMBNu9mmYYnelmO
         69tMFXjdk3JluzKojhD8ihsi/CAc6bQ94CjdY3brazqEZMLAqZl874fOUjAp4KaTreO9
         6PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318859; x=1794923659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRYNH2n9N9tavQypvAN3++O2esG2OA4vIp/NaA3m1dE=;
        b=nut1zqwTNP7UHolEPVaGnNxqiWScaPJf+59pG1SHOP5APuS7ULRBerRGKCa3CpxK/x
         JjrDSweQpJyHrkM2gmFu0YfIhMYZELZ6hy6+TW6XFvewW/wqrv86QG+U6l7Y+dB/HAfh
         1vU7SgfZHQdUF8lDIzt147vlVN2zdPLK8eBeQOZ5pcKZWuDE5MZVqZtOuDZActixKrKU
         KiD1S+Qo7wpWUcJamdY+jgvAYd+R3nXlotoiQ4k76RVC9qXrM8Zdh0l2D/1zVkVPLeRT
         8N+4Vz+q6ijD4mE8Ao31WAwTgx2C6pl3e24RVx3lyvZGO4jnCJ5nQmXxsQNEGMTcma6y
         n7MA==
X-Gm-Message-State: APuU4Z8qYcGVGqRlC3AIeotG+2UxZzpO4SQNnjzj9AcwXM0UTN1hbvDp
	do2QhQFun4V/PSVy6MvWbmARGDD5BxnnnGfNhrH51OqDEQAADbls+X/L7l98EpLd
X-Gm-Gg: AYBFou29G08mqJ9OxTeVI5dPpyssEJ6I4lPB9+przSKYULee5SS4YaUkTnxyp+akJxS
	luM7gLnOrRiYUh7XVq0hk3EX+asOF0OPdFxUqPEIifokLEx0fIqTOHyy7+2Y4VWWaGlPv7Yw8IP
	U/I7wVcAY+nE/u78fBpPK5NM/uE4aL7DW1Xij10PxgG31M70m8E/a22aTd3KXFvNbw8QI9jtLRM
	QYg4HR3c2dlAKA2eKEfKkaHVy6moSA/va4mGfxQ72CL1sHPTUv1zfH1udZT3M5HHHl1iXGeYrcQ
	7uYnjpNzNzeTxfOsdBLrLkCF0M42I80Ukwiq9nefKIMxljyFf8x8Dxal2LSsROfu8qDBO/2xhtk
	hXiSByGnjJRztHFnE0yWA7DqezljQSlRHgEmx1SBv+J3pk1caTmfzgQOj0WUQLkXZ1pTeEAVCnK
	4Unk4B7EenEFDrmhAPiQPT0ZCnwXvQUgbiSN84SS0niAEc+AXH1wJN571zqgOofTZtqypZnlZqq
	3FcWVu6Ca8oxGad96dXGTjvpeK2TjvprGqG/RJ5V3hfzifg5IUf+UD1WT7jPP60OzlPNsZu5zVb
	JKU6MwYIqWAhBq9FvE8wgGY4yhIQ2p8yWJdEv3g2/O8QC3LxJuouFF7S8yfm74VmugF21kBfar7
	5e2QlsM/6gmIKLV4WyLYGzvEAlf1c8eFFpgddojgK5grlbAPbsxT0RAP/B5dHOR3QNMgQA0Tenv
	t6WbU1PwDk0xXuBJGsvC29yfOmKYFaZ6a5KcUjLnnNvIyzU0H87M+IlWSJXJ1o04w5Vbw=
X-Received: by 2002:ac8:6104:0:b0:535:15a9:2514 with SMTP id d75a77b69052e-55528ec8197mr39326461cf.43.1794318856073;
        Tue, 10 Nov 2026 05:54:16 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm24307351cf.16.2026.11.10.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:54:15 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsepol: check all declaring blocks when enabling types
Date: Tue, 10 Nov 2026 08:54:04 -0500
Message-ID: <20261110135404.9965-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The multiple-decls option permits repeated type and attribute
declarations, but is_id_enabled() still checks only the last scope
entry for types. A declaration in a disabled optional block can
therefore hide a globally declared symbol or one declared in another
enabled optional block.

Besides removing types and positive rules, this can broaden
permissions: dropping an attribute used in a negative type set removes
the exclusion from the compiled allow rule.

Check all scope entries for types, requiring an enabled block whose
declared bitmap contains the symbol. Scope entries can also represent
requirements, so an enabled requiring block must not enable an
otherwise disabled declaration. Preserve the handling of other symbol
classes.

Add direct scope-order and requirement controls and native compiler
regressions for positive rules, source and target exclusions, aliases,
repeated types, optional ordering, and disabled dependent optionals.

Fixes: 392e42a8eb29 ("libsepol,checkpolicy: add --multiple-decls option")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/.gitignore                   |  1 +
 checkpolicy/Makefile                     |  8 ++-
 checkpolicy/tests/test_multiple_decls.sh | 83 ++++++++++++++++++++++++
 checkpolicy/tests/test_type_enabled.c    | 72 ++++++++++++++++++++
 libsepol/src/avrule_block.c              | 17 ++++-
 5 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 checkpolicy/tests/test_multiple_decls.sh
 create mode 100644 checkpolicy/tests/test_type_enabled.c

diff --git a/checkpolicy/.gitignore b/checkpolicy/.gitignore
index 01a694d4..401747df 100644
--- a/checkpolicy/.gitignore
+++ b/checkpolicy/.gitignore
@@ -5,3 +5,4 @@ y.tab.c
 y.tab.h
 tests/testpol.bin
 tests/testpol.conf
+tests/test-type-enabled
diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index d974d156..9d5b7123 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -51,10 +51,15 @@ lex.yy.c: policy_scan.l y.tab.c
 	$(LEX) policy_scan.l
 
 .PHONY: test
-test: checkpolicy checkmodule
+test: checkpolicy checkmodule tests/test-type-enabled
 	./tests/test_roundtrip.sh
 	./tests/test_checkmodule_negative.sh
 	sh ./tests/test_conditional_count.sh
+	./tests/test-type-enabled
+	sh ./tests/test_multiple_decls.sh
+
+tests/test-type-enabled: tests/test_type_enabled.c $(LIBSEPOLA)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 # helper target for fuzzing
 checkobjects: $(CHECKOBJS)
@@ -81,6 +86,7 @@ relabel: install
 	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
 
 clean:
+	-rm -f tests/test-type-enabled
 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
 	$(MAKE) -C test clean
 	$(MAKE) -C fuzz clean
diff --git a/checkpolicy/tests/test_multiple_decls.sh b/checkpolicy/tests/test_multiple_decls.sh
new file mode 100644
index 00000000..6863c6fd
--- /dev/null
+++ b/checkpolicy/tests/test_multiple_decls.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+set -eu
+
+CHECKPOLICY=${CHECKPOLICY:-./checkpolicy}
+tmp=$(mktemp -d)
+trap 'rm -rf "$tmp"' EXIT HUP INT TERM
+
+cat > "$tmp/prefix" <<'EOF'
+class file
+sid kernel
+class file { read write }
+attribute excluded;
+attribute domain;
+type source_t, domain;
+type excluded_t, excluded, domain;
+type ordinary_t, domain;
+typealias source_t alias source_alias_t;
+EOF
+cat > "$tmp/suffix" <<'EOF'
+user user_u roles role_r;
+sid kernel user_u:role_r:source_t
+EOF
+
+count=0
+for side in source target positive; do
+    case $side in
+        source) rule='allow { domain -excluded } ordinary_t:file write;' ;;
+        target) rule='allow source_t { domain -excluded }:file write;' ;;
+        positive) rule='allow excluded self:file write;' ;;
+    esac
+    for variant in control enabled disabled last_enabled last_disabled repeated_type require_only optional_only; do
+        cat "$tmp/prefix" > "$tmp/input.conf"
+        printf '%s\n' "$rule" \
+            'allow source_alias_t self:file read;' \
+            'role role_r;' 'role role_r types domain;' >> "$tmp/input.conf"
+        enabled='optional { require { class file { read }; } attribute excluded; }'
+        disabled='optional { require { type missing_t; } attribute excluded; }'
+        case $variant in
+            control) ;;
+            enabled) printf '%s\n' "$enabled" >> "$tmp/input.conf" ;;
+            disabled) printf '%s\n' "$disabled" >> "$tmp/input.conf" ;;
+            last_enabled) printf '%s\n' "$disabled" "$enabled" >> "$tmp/input.conf" ;;
+            last_disabled) printf '%s\n' "$enabled" "$disabled" >> "$tmp/input.conf" ;;
+            repeated_type)
+                printf '%s\n' 'optional { require { type missing_t; } type excluded_t; }' >> "$tmp/input.conf" ;;
+            require_only)
+                printf '%s\n' 'optional { require { attribute excluded; } allow source_t self:file read; }' >> "$tmp/input.conf" ;;
+            optional_only)
+                printf '%s\n' \
+                    'optional { require { type missing_t; } type absent_t; }' \
+                    'optional { require { type absent_t; } allow ordinary_t self:file write; }' >> "$tmp/input.conf" ;;
+        esac
+        cat "$tmp/suffix" >> "$tmp/input.conf"
+        "$CHECKPOLICY" -m -o "$tmp/policy.bin" "$tmp/input.conf"
+        "$CHECKPOLICY" -b -F -o "$tmp/output.conf" "$tmp/policy.bin"
+        # Full binary round-trip equality covers types, aliases, role membership,
+        # and rules, including exclusions on either side of an allow rule.
+        if [ "$variant" = control ]; then
+	    # System cp may link libselinux without the sanitizer runtime.
+            LD_LIBRARY_PATH= cp "$tmp/output.conf" "$tmp/expected.conf"
+        else
+            diff -u "$tmp/expected.conf" "$tmp/output.conf"
+        fi
+        count=$((count + 1))
+    done
+done
+
+for decl in \
+    'type excluded_t;' \
+    'typealias source_t alias source_alias_t;' \
+    'attribute source_t;' \
+    'type excluded;'; do
+    cat "$tmp/prefix" > "$tmp/input.conf"
+    printf '%s\n' "$decl" 'allow source_t self:file read;' \
+        'role role_r;' 'role role_r types domain;' >> "$tmp/input.conf"
+    cat "$tmp/suffix" >> "$tmp/input.conf"
+    if "$CHECKPOLICY" -o "$tmp/policy.bin" "$tmp/input.conf" 2> "$tmp/error"; then
+        echo 'unexpected duplicate declaration acceptance' >&2
+        exit 1
+    fi
+    count=$((count + 1))
+done
+printf 'PASS %s multiple-declaration compiler cases\n' "$count"
diff --git a/checkpolicy/tests/test_type_enabled.c b/checkpolicy/tests/test_type_enabled.c
new file mode 100644
index 00000000..c05feb13
--- /dev/null
+++ b/checkpolicy/tests/test_type_enabled.c
@@ -0,0 +1,72 @@
+#include <assert.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <sepol/policydb/avrule_block.h>
+#include <sepol/policydb/policydb.h>
+
+int main(void)
+{
+	policydb_t p = { 0 };
+	avrule_decl_t decls[3] = { 0 };
+	avrule_decl_t *index[] = { &decls[0], &decls[1], &decls[2] };
+	uint32_t ids[3];
+	scope_datum_t scope = { .scope = SCOPE_DECL,
+				.decl_ids = ids,
+				.decl_ids_len = 3 };
+	type_datum_t type = { .s.value = 1, .primary = 1 };
+	char name[] = "test_type";
+	const uint32_t orders[][3] = { { 1, 2, 3 }, { 1, 3, 2 }, { 2, 1, 3 },
+				       { 2, 3, 1 }, { 3, 1, 2 }, { 3, 2, 1 } };
+	unsigned int cases = 0;
+
+	assert(symtab_init(&p.scope[SYM_TYPES], 16) == 0);
+	assert(symtab_init(&p.p_types, 16) == 0);
+	assert(hashtab_insert(p.scope[SYM_TYPES].table, name, &scope) == 0);
+	assert(hashtab_insert(p.p_types.table, name, &type) == 0);
+	p.decl_val_to_struct = index;
+	/* Types, attributes, and aliases use the declared bitmap, not merely
+	 * the presence of an enabled block in the mixed scope list. */
+	for (unsigned int flavor = TYPE_TYPE; flavor <= TYPE_ALIAS; flavor++) {
+		type.flavor = flavor;
+		for (unsigned int enabled = 0; enabled < 8; enabled++)
+			for (unsigned int declared = 0; declared < 8;
+			     declared++) {
+				for (unsigned int i = 0; i < 3; i++) {
+					decls[i].enabled =
+						!!(enabled & (1U << i));
+					assert(ebitmap_set_bit(
+						       &decls[i].declared
+								.scope[SYM_TYPES],
+						       0,
+						       !!(declared &
+							  (1U << i))) == 0);
+				}
+				for (unsigned int order = 0; order < 6;
+				     order++) {
+					for (unsigned int i = 0; i < 3; i++)
+						ids[i] = orders[order][i];
+					scope.scope = SCOPE_DECL;
+					assert(is_id_enabled(name, &p,
+							     SYM_TYPES) ==
+					       !!(enabled & declared));
+					scope.scope = SCOPE_REQ;
+					assert(is_id_enabled(name, &p,
+							     SYM_TYPES) == 0);
+					cases += 2;
+				}
+			}
+	}
+	scope.scope = SCOPE_DECL;
+	for (unsigned int i = 0; i < 3; i++)
+		index[i] = NULL;
+	assert(is_id_enabled(name, &p, SYM_TYPES) == 0);
+	scope.decl_ids_len = 0;
+	assert(is_id_enabled(name, &p, SYM_TYPES) == 0);
+	assert(is_id_enabled("missing", &p, SYM_TYPES) == 0);
+	for (unsigned int i = 0; i < 3; i++)
+		ebitmap_destroy(&decls[i].declared.scope[SYM_TYPES]);
+	hashtab_destroy(p.scope[SYM_TYPES].table);
+	hashtab_destroy(p.p_types.table);
+	printf("PASS %u type enablement checks\n", cases + 3);
+	return 0;
+}
diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index 60f637ff..7293b6fc 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -164,7 +164,22 @@ int is_id_enabled(const char *id, const policydb_t *p, int symbol_table)
 		return 0;
 	}
 
-	if (symbol_table == SYM_ROLES || symbol_table == SYM_USERS) {
+	if (symbol_table == SYM_TYPES) {
+		const type_datum_t *type = hashtab_search(p->p_types.table, id);
+		uint32_t i;
+
+		if (!type)
+			return 0;
+		/* The scope list can also contain requirements. Only an enabled
+		 * declaration can make a multiply declared type available. */
+		for (i = 0; i < len; i++) {
+			decl = p->decl_val_to_struct[scope->decl_ids[i] - 1];
+			if (decl && decl->enabled &&
+			    ebitmap_get_bit(&decl->declared.scope[SYM_TYPES],
+					    type->s.value - 1))
+				return 1;
+		}
+	} else if (symbol_table == SYM_ROLES || symbol_table == SYM_USERS) {
 		uint32_t i;
 		for (i = 0; i < len; i++) {
 			decl = p->decl_val_to_struct[scope->decl_ids[i] - 1];
-- 
2.56.0

