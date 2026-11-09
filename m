Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248656;
	b=NQZXHVIrqJqdPtB2GR1es1ImqD6dJ0C18NPtn6x9YZSvo2nBZA49XjAfqi25TSd24ZQb
	 6Uv2Cbar5/jduYyk8ITUbtS3AtOFxaSGL1+PRLMX/6wz6e5GRpywqHDEcahTGaZS0GOEq
	 +2h3+/2YwaWN5FjBRAgT0fYgk8BBc3jvmuHzwEx92M8sWMsLEw0Ih1EgABygStTIGPgSL
	 Drok6knKAuclfmAWxiJMYKu+3qxkqjP+BTD6GDRSV3baqd0X3qCzf90oY50wHjl4+51RN
	 FR2S1cVI3etsvOib+64w7/6wDHcIPWz4iYlZ2jfc92a0h8/CwamELfodm9bZ0qJ8vBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Pd8gk4PlU6RZGmk+PTGzur0UVGqkyXIM7O6Iuele8iQ=;
	b=nvPravW2KaVsWqPLSiFj98uLz4EkLWnZaR6rUtfqNksmXUdockAx5JlV5W+2EBIDcwZv
	 +HZhD/ZoDMZH/pBX7BQsaRxEkeju68xIYc8eMaDLjgYlnbRZPD3/sxTENc2SyZdp/hKaC
	 tIEn0LADoLp9A5Vy4zZPAiHuEm8vGdhjypRN7K57+1EkmHf3VimW8TtBHOneG/YWmVReo
	 pa1Dl6E3qu6Gp37IQkZwtxAsF5cK/i3njfKgp2pdZwB1PLt6bq9fUeoJpRp26imdFczv2
	 dw+U9qPczsUb9zo7+zVaXHJdKPScCyV//s7ayICDFsECFH3TAo5oQS+vOaZpc9ADYPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ldQpFQtR;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D379606A32A
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 18:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D379606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ldQpFQtR
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f30660e69so94463585a.0
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248655; x=1794853455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pd8gk4PlU6RZGmk+PTGzur0UVGqkyXIM7O6Iuele8iQ=;
        b=ldQpFQtRK6QjgmBLSgZUkqqKUtNyjKSvFp5SH5hck/vtMPl4frxAN3lqRTBRaRJvGb
         vFXotgJR7j029E22ghUGKDM8WVT8UsU/B4LuDv7691gnG5laZ3CuBEu6pPp5Vk4JdjEh
         iGN1IwJL4JDV84ifxO+AHpymU8ZfjLKs7HDN8Mk8IP9GOstH8sVCgX6Me+fnqSpFRRyd
         kz4Vg3UT7fo8V+ALnJJ/lktaqvyMYaxOQUhlCatzoDHcGJk8CEpbu/jbfDncKGMBQkDw
         RPNbQfM9g0lN3agIxPlDfkjkp2+k7qqoKa7fg79PcmcS5huiFkShKlFlzgxuPspGZZFC
         F85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248655; x=1794853455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pd8gk4PlU6RZGmk+PTGzur0UVGqkyXIM7O6Iuele8iQ=;
        b=RWqBGwxTvvORFo5afuT+MpuDynkWuMw5cA2NY8neX/TaUiYOGqoZT/6zIo3LfVhgqm
         Hgt/UTWEPpX7ziU0629hduM9NzZEEL+jAmQY9lSrEIgK8uEVxhWrGwckbSbq/QS+lJW6
         YauC5ba2yBuoPzSetTQzqF9545XQDlQZ/EAZmd7FlQH2avinDC821JS8HvVJ9OnUMNKE
         UzIfcPJISfXOZ3NsG9QV/WYsjKgdSZ/fnJfS8CsLnwG69axjC2a0cXf2Itv46AYgfxGS
         tNc0Z71U56GAypsGvpTIgT/zU7gjWlWK+jaBQqKN7YBu/916hMbid34vx+gfeq6tzanN
         nang==
X-Gm-Message-State: APuU4Z80TxzHef2fJwNiTkAI6r0z63XA6LqiBrheVzjl4bcT2BkCIaBw
	kFxLCdIECWNlE6tyZcHTdTAB8NETpB1l2HXWpRQDbc9TwGE12z1uwgDkOCU9GBUi
X-Gm-Gg: AYBFou2EE4FOHclbLLBOxUyi+Y+4Nsf2iqCOWWfUEpCbHtPMk6JtedpPPzseK1MZLQc
	FxmOwQt1MHjwwk8o9dCOqVZaJviYJAiyYDotdcTv8DPWcFL8iAe9oZ3kdg56M3B+5EkfbldZvxV
	JDzWOCq8+b9YR6r/za1F8y0ED/iLVeZ2m5XR6IkrJyUUbj52Tzv2+8GvB9KcOb7LzY1B7cE3Jo1
	86HOGG4pQY7qjD22tVJjbbxrfGiPqdBkTrI9E8UDo99qWWFin0PaZtdtq9Kj83mdmOaTMfCK8nc
	R2i6IY33gfESp00m+C9O0ZWvkpQYA4N3yhrpd0aLv9wU17KMYIWk6w+8tBi8IALWEUcKXb9PHg/
	aNN0wwFtuCeZYhmAk1NfN6FmwG3I8fV5nkzL6qXaw9wdR2opBdu/NUwg2BNDizgEIGMMpXLUUMx
	e2Sy4NCZa5ptKLDnj6p4CxSJ3rYeIOJ33hOaDMw6LREbjw22uOf9wYNMuWhSHCrwo0C1DX/btQa
	OwpH59OrBWngVrzbUY08Wr5hsd0wyDrCGqTVRxiz9Igs3528ccywZrnZyWhr2PHL1rDxXrSqybI
	3Ics/KOIVtZkEbtDbtiy8BxDLO9cQGGP70HLj2B5czcdfMkEazJ56l3bc7llSA0t7r+13WIwATs
	7cK7sfGI7OtKHTxT2OJzgw49Ux15tU5/7EECZUww2DxrvRQcY8FOQFRCQtEZi1Bx68jTZxUCrlN
	7uVAJ144ZH0WF0XaEyThbpoerqCO5Kk4ZzalHJRAJi3JcDEA==
X-Received: by 2002:a05:620a:8811:b0:93e:c12c:4412 with SMTP id af79cd13be357-9479f41744bmr44749385a.78.1794248654892;
        Mon, 09 Nov 2026 10:24:14 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04fe53asm1860336d6.27.2026.11.09.10.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:24:14 -0800 (PST)
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
Subject: [PATCH] libsepol: check all declaring blocks when enabling types
Date: Mon,  9 Nov 2026 13:24:00 -0500
Message-ID: <20261109182400.145911-1-stephen.smalley.work@gmail.com>
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
index 22c32a25..f160c992 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -51,9 +51,14 @@ lex.yy.c: policy_scan.l y.tab.c
 	$(LEX) policy_scan.l
 
 .PHONY: test
-test: checkpolicy checkmodule
+test: checkpolicy checkmodule tests/test-type-enabled
 	./tests/test_roundtrip.sh
 	./tests/test_checkmodule_negative.sh
+	./tests/test-type-enabled
+	sh ./tests/test_multiple_decls.sh
+
+tests/test-type-enabled: tests/test_type_enabled.c $(LIBSEPOLA)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 # helper target for fuzzing
 checkobjects: $(CHECKOBJS)
@@ -80,6 +85,7 @@ relabel: install
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

