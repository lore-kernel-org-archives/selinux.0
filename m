Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484465;
	b=HnTuyZSAUez2+u1VJZWxWBOgANUtf87YsJ709ZuOLuemAhPR4TZBukQKZqBgwYgcl4iD
	 BryVyNgS/9p3PtipLSWuW8iwRL2qpAUhAjL6hAls76fnb+UdMYjubg4cZ/aqK6MKfqdF1
	 ZBU7J1gwGaSzYqa5ZK+gNWwf2W+yp5vDul2OG11N0YILH4Sq7YxYPI2Z3vlJwWWZVW6yC
	 fn+spKmGMB8XwbLgyew1gu7th4Wr282xUWsNYtRLoHkscpOe0P4sHeqlOXnzBy83j7wE0
	 OlFmb0p0OzYeKpnsKxx81z9bPbTyXxSGuTkF+sOgOJv5vzf8pdZvfxkNGJa31oWUJQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484465;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=Jxrlw+8Y3BG0pobZzphXVsf8hxE6Wy2weILXDH8H3rc=;
	b=ixaEehUuBKUQH/ImS9K7uEeZpiCj3T50tuW4CSpuZ3GTsNdI4bW1X6PG1cGG4Zb6eNgX
	 uCh7Q4rUThXA5aw6OOjm//t+2/ECzk3pdu3j+JbTF5ptjPIafGNtq127xnaiY/PecBQ2Q
	 q0m5JiMN19BWcV3HpF3EEYDveIU8kZL4D45PM1rEcxb7RSL6hE9b4g1L58BYBXDBjvIei
	 M4amuS6MKN7QbtLRn6DlOBC50DxEgitPBzOgvobUZbwsXrMEoP/XekkcO49ecR8Fm0BSd
	 HXYzzsjbilkCe88x8v4bP8RlqsZldNHhVorGBRcOBNP3lgH+A5x7iQPICX7OSLxhRog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vj4SrPmV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F1606A89E
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 11:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10F1606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vj4SrPmV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794484463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jxrlw+8Y3BG0pobZzphXVsf8hxE6Wy2weILXDH8H3rc=;
	b=Vj4SrPmVaFl85ql+BWKJYT327oA7wXau7BlWzHr+HfqQwi+S7N550TY2IJF+1PHAGSqTnZ
	lvfputAE1pNIJqEYNr+JGinElGQMdLpsMe6SCLuyoFDGU4G2Wl2iEKoOBsMJrN38Myw79K
	pmDUpfS0e+dv1+EGgU/k9D3a28bV20A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-uoFxDBFeOE2-lqiwwYxm1w-1; Thu,
 12 Nov 2026 06:54:19 -0500
X-MC-Unique: uoFxDBFeOE2-lqiwwYxm1w-1
X-Mimecast-MFC-AGG-ID: uoFxDBFeOE2-lqiwwYxm1w_1794484458
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F20C18005AA;
	Thu, 12 Nov 2026 11:54:17 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E21F1956087;
	Thu, 12 Nov 2026 11:54:14 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jason@perfinion.com, jwcart2@gmail.com,
 cahu@suse.de, jsegitz@suse.de, tweek@google.com, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] libsepol: check all declaring blocks when enabling
 types
In-Reply-To: <20261110135404.9965-1-stephen.smalley.work@gmail.com>
References: <20261110135404.9965-1-stephen.smalley.work@gmail.com>
Date: Thu, 12 Nov 2026 12:54:11 +0100
Message-ID: <pjdqzgq9sf0.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> The multiple-decls option permits repeated type and attribute
> declarations, but is_id_enabled() still checks only the last scope
> entry for types. A declaration in a disabled optional block can
> therefore hide a globally declared symbol or one declared in another
> enabled optional block.
>
> Besides removing types and positive rules, this can broaden
> permissions: dropping an attribute used in a negative type set removes
> the exclusion from the compiled allow rule.
>
> Check all scope entries for types, requiring an enabled block whose
> declared bitmap contains the symbol. Scope entries can also represent
> requirements, so an enabled requiring block must not enable an
> otherwise disabled declaration. Preserve the handling of other symbol
> classes.
>
> Add direct scope-order and requirement controls and native compiler
> regressions for positive rules, source and target exclusions, aliases,
> repeated types, optional ordering, and disabled dependent optionals.
>
> Fixes: 392e42a8eb29 ("libsepol,checkpolicy: add --multiple-decls option")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.



> ---
>  checkpolicy/.gitignore                   |  1 +
>  checkpolicy/Makefile                     |  8 ++-
>  checkpolicy/tests/test_multiple_decls.sh | 83 ++++++++++++++++++++++++
>  checkpolicy/tests/test_type_enabled.c    | 72 ++++++++++++++++++++
>  libsepol/src/avrule_block.c              | 17 ++++-
>  5 files changed, 179 insertions(+), 2 deletions(-)
>  create mode 100644 checkpolicy/tests/test_multiple_decls.sh
>  create mode 100644 checkpolicy/tests/test_type_enabled.c
>
> diff --git a/checkpolicy/.gitignore b/checkpolicy/.gitignore
> index 01a694d4..401747df 100644
> --- a/checkpolicy/.gitignore
> +++ b/checkpolicy/.gitignore
> @@ -5,3 +5,4 @@ y.tab.c
>  y.tab.h
>  tests/testpol.bin
>  tests/testpol.conf
> +tests/test-type-enabled
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index d974d156..9d5b7123 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -51,10 +51,15 @@ lex.yy.c: policy_scan.l y.tab.c
>  	$(LEX) policy_scan.l
>  
>  .PHONY: test
> -test: checkpolicy checkmodule
> +test: checkpolicy checkmodule tests/test-type-enabled
>  	./tests/test_roundtrip.sh
>  	./tests/test_checkmodule_negative.sh
>  	sh ./tests/test_conditional_count.sh
> +	./tests/test-type-enabled
> +	sh ./tests/test_multiple_decls.sh
> +
> +tests/test-type-enabled: tests/test_type_enabled.c $(LIBSEPOLA)
> +	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
>  
>  # helper target for fuzzing
>  checkobjects: $(CHECKOBJS)
> @@ -81,6 +86,7 @@ relabel: install
>  	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
>  
>  clean:
> +	-rm -f tests/test-type-enabled
>  	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
>  	$(MAKE) -C test clean
>  	$(MAKE) -C fuzz clean
> diff --git a/checkpolicy/tests/test_multiple_decls.sh b/checkpolicy/tests/test_multiple_decls.sh
> new file mode 100644
> index 00000000..6863c6fd
> --- /dev/null
> +++ b/checkpolicy/tests/test_multiple_decls.sh
> @@ -0,0 +1,83 @@
> +#!/bin/sh
> +set -eu
> +
> +CHECKPOLICY=${CHECKPOLICY:-./checkpolicy}
> +tmp=$(mktemp -d)
> +trap 'rm -rf "$tmp"' EXIT HUP INT TERM
> +
> +cat > "$tmp/prefix" <<'EOF'
> +class file
> +sid kernel
> +class file { read write }
> +attribute excluded;
> +attribute domain;
> +type source_t, domain;
> +type excluded_t, excluded, domain;
> +type ordinary_t, domain;
> +typealias source_t alias source_alias_t;
> +EOF
> +cat > "$tmp/suffix" <<'EOF'
> +user user_u roles role_r;
> +sid kernel user_u:role_r:source_t
> +EOF
> +
> +count=0
> +for side in source target positive; do
> +    case $side in
> +        source) rule='allow { domain -excluded } ordinary_t:file write;' ;;
> +        target) rule='allow source_t { domain -excluded }:file write;' ;;
> +        positive) rule='allow excluded self:file write;' ;;
> +    esac
> +    for variant in control enabled disabled last_enabled last_disabled repeated_type require_only optional_only; do
> +        cat "$tmp/prefix" > "$tmp/input.conf"
> +        printf '%s\n' "$rule" \
> +            'allow source_alias_t self:file read;' \
> +            'role role_r;' 'role role_r types domain;' >> "$tmp/input.conf"
> +        enabled='optional { require { class file { read }; } attribute excluded; }'
> +        disabled='optional { require { type missing_t; } attribute excluded; }'
> +        case $variant in
> +            control) ;;
> +            enabled) printf '%s\n' "$enabled" >> "$tmp/input.conf" ;;
> +            disabled) printf '%s\n' "$disabled" >> "$tmp/input.conf" ;;
> +            last_enabled) printf '%s\n' "$disabled" "$enabled" >> "$tmp/input.conf" ;;
> +            last_disabled) printf '%s\n' "$enabled" "$disabled" >> "$tmp/input.conf" ;;
> +            repeated_type)
> +                printf '%s\n' 'optional { require { type missing_t; } type excluded_t; }' >> "$tmp/input.conf" ;;
> +            require_only)
> +                printf '%s\n' 'optional { require { attribute excluded; } allow source_t self:file read; }' >> "$tmp/input.conf" ;;
> +            optional_only)
> +                printf '%s\n' \
> +                    'optional { require { type missing_t; } type absent_t; }' \
> +                    'optional { require { type absent_t; } allow ordinary_t self:file write; }' >> "$tmp/input.conf" ;;
> +        esac
> +        cat "$tmp/suffix" >> "$tmp/input.conf"
> +        "$CHECKPOLICY" -m -o "$tmp/policy.bin" "$tmp/input.conf"
> +        "$CHECKPOLICY" -b -F -o "$tmp/output.conf" "$tmp/policy.bin"
> +        # Full binary round-trip equality covers types, aliases, role membership,
> +        # and rules, including exclusions on either side of an allow rule.
> +        if [ "$variant" = control ]; then
> +	    # System cp may link libselinux without the sanitizer runtime.
> +            LD_LIBRARY_PATH= cp "$tmp/output.conf" "$tmp/expected.conf"
> +        else
> +            diff -u "$tmp/expected.conf" "$tmp/output.conf"
> +        fi
> +        count=$((count + 1))
> +    done
> +done
> +
> +for decl in \
> +    'type excluded_t;' \
> +    'typealias source_t alias source_alias_t;' \
> +    'attribute source_t;' \
> +    'type excluded;'; do
> +    cat "$tmp/prefix" > "$tmp/input.conf"
> +    printf '%s\n' "$decl" 'allow source_t self:file read;' \
> +        'role role_r;' 'role role_r types domain;' >> "$tmp/input.conf"
> +    cat "$tmp/suffix" >> "$tmp/input.conf"
> +    if "$CHECKPOLICY" -o "$tmp/policy.bin" "$tmp/input.conf" 2> "$tmp/error"; then
> +        echo 'unexpected duplicate declaration acceptance' >&2
> +        exit 1
> +    fi
> +    count=$((count + 1))
> +done
> +printf 'PASS %s multiple-declaration compiler cases\n' "$count"
> diff --git a/checkpolicy/tests/test_type_enabled.c b/checkpolicy/tests/test_type_enabled.c
> new file mode 100644
> index 00000000..c05feb13
> --- /dev/null
> +++ b/checkpolicy/tests/test_type_enabled.c
> @@ -0,0 +1,72 @@
> +#include <assert.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <sepol/policydb/avrule_block.h>
> +#include <sepol/policydb/policydb.h>
> +
> +int main(void)
> +{
> +	policydb_t p = { 0 };
> +	avrule_decl_t decls[3] = { 0 };
> +	avrule_decl_t *index[] = { &decls[0], &decls[1], &decls[2] };
> +	uint32_t ids[3];
> +	scope_datum_t scope = { .scope = SCOPE_DECL,
> +				.decl_ids = ids,
> +				.decl_ids_len = 3 };
> +	type_datum_t type = { .s.value = 1, .primary = 1 };
> +	char name[] = "test_type";
> +	const uint32_t orders[][3] = { { 1, 2, 3 }, { 1, 3, 2 }, { 2, 1, 3 },
> +				       { 2, 3, 1 }, { 3, 1, 2 }, { 3, 2, 1 } };
> +	unsigned int cases = 0;
> +
> +	assert(symtab_init(&p.scope[SYM_TYPES], 16) == 0);
> +	assert(symtab_init(&p.p_types, 16) == 0);
> +	assert(hashtab_insert(p.scope[SYM_TYPES].table, name, &scope) == 0);
> +	assert(hashtab_insert(p.p_types.table, name, &type) == 0);
> +	p.decl_val_to_struct = index;
> +	/* Types, attributes, and aliases use the declared bitmap, not merely
> +	 * the presence of an enabled block in the mixed scope list. */
> +	for (unsigned int flavor = TYPE_TYPE; flavor <= TYPE_ALIAS; flavor++) {
> +		type.flavor = flavor;
> +		for (unsigned int enabled = 0; enabled < 8; enabled++)
> +			for (unsigned int declared = 0; declared < 8;
> +			     declared++) {
> +				for (unsigned int i = 0; i < 3; i++) {
> +					decls[i].enabled =
> +						!!(enabled & (1U << i));
> +					assert(ebitmap_set_bit(
> +						       &decls[i].declared
> +								.scope[SYM_TYPES],
> +						       0,
> +						       !!(declared &
> +							  (1U << i))) == 0);
> +				}
> +				for (unsigned int order = 0; order < 6;
> +				     order++) {
> +					for (unsigned int i = 0; i < 3; i++)
> +						ids[i] = orders[order][i];
> +					scope.scope = SCOPE_DECL;
> +					assert(is_id_enabled(name, &p,
> +							     SYM_TYPES) ==
> +					       !!(enabled & declared));
> +					scope.scope = SCOPE_REQ;
> +					assert(is_id_enabled(name, &p,
> +							     SYM_TYPES) == 0);
> +					cases += 2;
> +				}
> +			}
> +	}
> +	scope.scope = SCOPE_DECL;
> +	for (unsigned int i = 0; i < 3; i++)
> +		index[i] = NULL;
> +	assert(is_id_enabled(name, &p, SYM_TYPES) == 0);
> +	scope.decl_ids_len = 0;
> +	assert(is_id_enabled(name, &p, SYM_TYPES) == 0);
> +	assert(is_id_enabled("missing", &p, SYM_TYPES) == 0);
> +	for (unsigned int i = 0; i < 3; i++)
> +		ebitmap_destroy(&decls[i].declared.scope[SYM_TYPES]);
> +	hashtab_destroy(p.scope[SYM_TYPES].table);
> +	hashtab_destroy(p.p_types.table);
> +	printf("PASS %u type enablement checks\n", cases + 3);
> +	return 0;
> +}
> diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
> index 60f637ff..7293b6fc 100644
> --- a/libsepol/src/avrule_block.c
> +++ b/libsepol/src/avrule_block.c
> @@ -164,7 +164,22 @@ int is_id_enabled(const char *id, const policydb_t *p, int symbol_table)
>  		return 0;
>  	}
>  
> -	if (symbol_table == SYM_ROLES || symbol_table == SYM_USERS) {
> +	if (symbol_table == SYM_TYPES) {
> +		const type_datum_t *type = hashtab_search(p->p_types.table, id);
> +		uint32_t i;
> +
> +		if (!type)
> +			return 0;
> +		/* The scope list can also contain requirements. Only an enabled
> +		 * declaration can make a multiply declared type available. */
> +		for (i = 0; i < len; i++) {
> +			decl = p->decl_val_to_struct[scope->decl_ids[i] - 1];
> +			if (decl && decl->enabled &&
> +			    ebitmap_get_bit(&decl->declared.scope[SYM_TYPES],
> +					    type->s.value - 1))
> +				return 1;
> +		}
> +	} else if (symbol_table == SYM_ROLES || symbol_table == SYM_USERS) {
>  		uint32_t i;
>  		for (i = 0; i < len; i++) {
>  			decl = p->decl_val_to_struct[scope->decl_ids[i] - 1];
> -- 
> 2.56.0

