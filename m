Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0ED101DA
	for <selinux@vger.kernel.org>; Wed,  8 May 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187880; cv=none; b=EjuzBmX2TU7neCN2vMwz4pltbqE7w0pXqRkyReh9KNN1EtDTq+5Z/m8kHwBPqHrEQxHV8LAjNsW/K5GOEGPFhHxvBzTJL0g+NVoo3K6nJz3gZNzsNbenfBl7XgB3jvdN/TfA7MH92oVhlPRjHNN86axcuUQ/NjT/z9m9/4tHZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187880; c=relaxed/simple;
	bh=0Ux/B4SIAqvqIBw4gPUQxeyLv1EHBhj+5RjSI52rJXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AP6sW83s4PKL0ioiktoq5/uH+Kh3+PrTpcciNvDO0tt6BqlAaSHFyn1GUSYuigeLxxMVEHeZP5wXRhWv/a51/C9UF8GAM30OuEgu8SrJJ2FGHp4X5Kcd/TyokO4imvPPyQHEonRPR9sSDDaRceDCL25uIp4dMGqBoEdYczPFc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HuHAls4q; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HuHAls4q"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1715187869;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgcHIa49w5PSsGzARtodkK+LLzsbw0+xt424T+CUXds=;
	b=HuHAls4qWqWEdVoDhe1ytSiZnRHuV8BTVVcjC+eBtqNFQrIFmilGGivZBXoUQIUZdNmmRK
	eu4Hg2gAyyBZ1NSUYtr0x+d39eEZ8y7cId1J/3F6RmeiVI9TKuQu4txyLH64d9PqBILu9i
	RFtq/xePe2ZqYKPGk7elz3zFORufp3awMUms/oOAk1mJcy9PJxQiu2mHNIO22ciIIraO8B
	rmKVGK08c8ll6HZOYc2YD1pwKtpz/MI+jHBL2tWaEJL6Fah7UADpnnT+8xLWa/v2++Y0Dm
	aeZPnfEdNzwtwFq4PH0xB/5/Wa5LTV6P/YjKLqFuNk+FXVGKLt2wVNypEWKyAw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] checkpolicy: support CIDR notation for nodecon statements
Date: Wed,  8 May 2024 19:04:22 +0200
Message-ID: <20240508170422.1396740-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240508170422.1396740-1-cgoettsche@seltendoof.de>
References: <20240508170422.1396740-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Support the Classless Inter-Domain Routing (CIDR) notation for IP
addresses with their associated network masks in nodecon statements.
The two following statements are equivalent:

    nodecon 10.8.0.0 255.255.0.0 USER1:ROLE1:TYPE1
    nodecon 10.8.0.0/16          USER1:ROLE1:TYPE1

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c                   | 207 ++++++++++++++++++
 checkpolicy/policy_define.h                   |   2 +
 checkpolicy/policy_parse.y                    |  12 +
 checkpolicy/policy_scan.l                     |   2 +
 checkpolicy/tests/policy_allonce.conf         |   2 +
 .../tests/policy_allonce.expected.conf        |   2 +
 .../tests/policy_allonce.expected_opt.conf    |   2 +
 7 files changed, 229 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 9671906f..1d17f73d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5335,6 +5335,100 @@ out:
 	return rc;
 }
 
+int define_ipv4_cidr_node_context(void)
+{
+	char *endptr, *id, *split;
+	unsigned long mask_bits;
+	uint32_t mask;
+	struct in_addr addr;
+	ocontext_t *newc, *c, *l, *head;
+	int rc;
+
+	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
+		yyerror("nodecon not supported for target");
+		return -1;
+	}
+
+	if (pass == 1) {
+		free(queue_remove(id_queue));
+		parse_security_context(NULL);
+		return 0;
+	}
+
+	id = queue_remove(id_queue);
+	if (!id) {
+		yyerror("failed to read IPv4 address");
+		return -1;
+	}
+
+	split = strchr(id, '/');
+	if (!split) {
+		yyerror2("invalid IPv4 CIDR notation: %s", id);
+		free(id);
+		return -1;
+	}
+	*split = '\0';
+
+	rc = inet_pton(AF_INET, id, &addr);
+	if (rc < 1) {
+		yyerror2("failed to parse IPv4 address %s", id);
+		free(id);
+		return -1;
+	}
+
+	errno = 0;
+	mask_bits = strtoul(split + 1, &endptr, 10);
+	if (errno || *endptr != '\0' || mask_bits > 32) {
+		yyerror2("invalid mask in IPv4 CIDR notation: %s", split + 1);
+		free(id);
+		return -1;
+	}
+
+	free(id);
+
+	if (mask_bits == 0) {
+		yywarn("IPv4 CIDR mask of 0, matching all IPs");
+		mask = 0;
+	} else {
+		mask = ~((UINT32_C(1) << (32 - mask_bits)) - 1);
+		mask = htobe32(mask);
+	}
+
+	if ((~mask & addr.s_addr) != 0)
+		yywarn("host bits in IPv4 address set");
+
+	newc = calloc(1, sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+
+	newc->u.node.addr = addr.s_addr & mask;
+	newc->u.node.mask = mask;
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc);
+		return -1;
+	}
+
+	/* Create order of most specific to least retaining
+	   the order specified in the configuration. */
+	head = policydbp->ocontexts[OCON_NODE];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		if (newc->u.node.mask > c->u.node.mask)
+			break;
+	}
+
+	newc->next = c;
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_NODE] = newc;
+
+	return 0;
+}
+
 static int ipv6_is_mask_contiguous(const struct in6_addr *mask)
 {
 	int filled = 1;
@@ -5369,6 +5463,26 @@ static int ipv6_has_host_bits_set(const struct in6_addr *addr, const struct in6_
 	return 0;
 }
 
+static void ipv6_cidr_bits_to_mask(unsigned long cidr_bits, struct in6_addr *mask)
+{
+	unsigned i;
+
+	for (i = 0; i < 4; i++) {
+		if (cidr_bits == 0) {
+			mask->s6_addr32[i] = 0;
+		} else if (cidr_bits >= 32) {
+			mask->s6_addr32[i] = ~UINT32_C(0);
+		} else {
+			mask->s6_addr32[i] = htobe32(~((UINT32_C(1) << (32 - cidr_bits)) - 1));
+		}
+
+		if (cidr_bits >= 32)
+			cidr_bits -= 32;
+		else
+			cidr_bits = 0;
+	}
+}
+
 int define_ipv6_node_context(void)
 {
 	char *id;
@@ -5469,6 +5583,99 @@ int define_ipv6_node_context(void)
 	return rc;
 }
 
+int define_ipv6_cidr_node_context(void)
+{
+	char *endptr, *id, *split;
+	unsigned long mask_bits;
+	int rc;
+	struct in6_addr addr, mask;
+	ocontext_t *newc, *c, *l, *head;
+
+	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
+		yyerror("nodecon not supported for target");
+		return -1;
+	}
+
+	if (pass == 1) {
+		free(queue_remove(id_queue));
+		free(queue_remove(id_queue));
+		parse_security_context(NULL);
+		return 0;
+	}
+
+	id = queue_remove(id_queue);
+	if (!id) {
+		yyerror("failed to read IPv6 address");
+		return -1;
+	}
+
+	split = strchr(id, '/');
+	if (!split) {
+		yyerror2("invalid IPv6 CIDR notation: %s", id);
+		free(id);
+		return -1;
+	}
+	*split = '\0';
+
+	rc = inet_pton(AF_INET6, id, &addr);
+	if (rc < 1) {
+		yyerror2("failed to parse IPv6 address %s", id);
+		free(id);
+		return -1;
+	}
+
+	errno = 0;
+	mask_bits = strtoul(split + 1, &endptr, 10);
+	if (errno || *endptr != '\0' || mask_bits > 128) {
+		yyerror2("invalid mask in IPv6 CIDR notation: %s", split + 1);
+		free(id);
+		return -1;
+	}
+
+	if (mask_bits == 0) {
+		yywarn("IPv6 CIDR mask of 0, matching all IPs");
+	}
+
+	ipv6_cidr_bits_to_mask(mask_bits, &mask);
+
+	if (ipv6_has_host_bits_set(&addr, &mask)) {
+		yywarn("host bits in ipv6 address set");
+	}
+
+	free(id);
+
+	newc = calloc(1, sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+
+	memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
+	memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc);
+		return -1;
+	}
+
+	/* Create order of most specific to least retaining
+	   the order specified in the configuration. */
+	head = policydbp->ocontexts[OCON_NODE6];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) > 0)
+			break;
+	}
+
+	newc->next = c;
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_NODE6] = newc;
+
+	return 0;
+}
+
 int define_fs_use(int behavior)
 {
 	ocontext_t *newc, *c, *head;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index bcbfe4f3..ef74f616 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -38,7 +38,9 @@ int define_genfs_context(int has_type);
 int define_initial_sid_context(void);
 int define_initial_sid(void);
 int define_ipv4_node_context(void);
+int define_ipv4_cidr_node_context(void);
 int define_ipv6_node_context(void);
+int define_ipv6_cidr_node_context(void);
 int define_level(void);
 int define_netif_context(void);
 int define_permissive(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index c57a988a..ed1786d8 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -145,7 +145,9 @@ typedef int (* require_func_t)(int pass);
 %token EQUALS
 %token NOTEQUAL
 %token IPV4_ADDR
+%token IPV4_CIDR
 %token IPV6_ADDR
+%token IPV6_CIDR
 %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
 %token POLICYCAP
 %token PERMISSIVE
@@ -739,8 +741,12 @@ node_contexts		: node_context_def
 			;
 node_context_def	: NODECON ipv4_addr_def ipv4_addr_def security_context_def
 			{if (define_ipv4_node_context()) YYABORT;}
+			| NODECON ipv4_cidr_def security_context_def
+			{if (define_ipv4_cidr_node_context()) YYABORT;}
 			| NODECON ipv6_addr ipv6_addr security_context_def
 			{if (define_ipv6_node_context()) YYABORT;}
+			| NODECON ipv6_cidr security_context_def
+			{if (define_ipv6_cidr_node_context()) YYABORT;}
 			;
 opt_fs_uses             : fs_uses
                         |
@@ -771,6 +777,9 @@ genfs_context_def	: GENFSCON filesystem path '-' identifier security_context_def
 ipv4_addr_def		: IPV4_ADDR
 			{ if (insert_id(yytext,0)) YYABORT; }
 			;
+ipv4_cidr_def		: IPV4_CIDR
+			{ if (insert_id(yytext,0)) YYABORT; }
+			;
 xperms		: xperm
 			{ if (insert_separator(0)) YYABORT; }
 			| nested_xperm_set
@@ -899,6 +908,9 @@ number64		: NUMBER
 ipv6_addr		: IPV6_ADDR
 			{ if (insert_id(yytext,0)) YYABORT; }
 			;
+ipv6_cidr		: IPV6_CIDR
+			{ if (insert_id(yytext,0)) YYABORT; }
+			;
 policycap_def		: POLICYCAP identifier ';'
 			{if (define_polcap()) YYABORT;}
 			;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index e46677a8..5fb9ff37 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -292,8 +292,10 @@ GLBLUB				{ return(GLBLUB); }
 {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
 {digit}+|0x{hexval}+            { return(NUMBER); }
 {alnum}*{letter}{alnum}*        { return(FILESYSTEM); }
+{digit}{1,3}(\.{digit}{1,3}){3}"/"{digit}{1,2}	{ return(IPV4_CIDR); }
 {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
+{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}	{ return(IPV6_CIDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
 #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
 #line[ ]{digit}+	        {
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 54a4c811..2cfbb772 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -71,7 +71,9 @@ portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
+nodecon 127.0.0.0/24 USER1:ROLE1:TYPE1
 nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
+nodecon ff80::/16 USER1:ROLE1:TYPE1
 # hex numbers will be turned in decimal ones
 ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index aff6bfa3..26d56438 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -71,7 +71,9 @@ portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
+nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
+nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
 ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index 335486d1..769be2b3 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -71,7 +71,9 @@ portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
+nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
+nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
 ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
-- 
2.43.0

