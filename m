Return-Path: <SRS0=g6KH=TG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481DC04A6B
	for <selinux@archiver.kernel.org>; Mon,  6 May 2019 13:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373E3206A3
	for <selinux@archiver.kernel.org>; Mon,  6 May 2019 13:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfEFNMT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 May 2019 09:12:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44626 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFNMT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 May 2019 09:12:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so17174889wrs.11
        for <selinux@vger.kernel.org>; Mon, 06 May 2019 06:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhnDYFwsuFo11WKrlm9NqywqbSW+98+WIoYvqkp7wSk=;
        b=oPbyl5S55OARNxTlbgIVF6EdBRrt9mtp3lYlVjeyhJap/9Adko5RrHwdnyvVPiGk97
         YJ+k7sXJuev+o4RgWJqjG6yW5WukgDv6j9wkWthZV56k1aTq/MuEIko4QH8/WZ6Yr9u8
         7KTBhQs8MnRutS+49Y9xDRcUrr0il+662vMGR+CXOO33LrhrYNyTU51DYeg8ezPC0lMX
         Ywx2KOxwXYBTcNI/KOJoLIt8W/YuRW2HAj/56qgIKGV58NdFqHNviVOyqlo4FLuPyyi7
         tfSkWIE+LdaEKKDpWJvIOfJUTB1xf3hBU8aOKQtUED2g/dQWQT1h0R7eGfXnme9uQCbQ
         TSjg==
X-Gm-Message-State: APjAAAWXGFkvuWe6CnCYjTHNxjwdpT9jPwy9kObIZRoW2skG7jkE8jfW
        VPDNTbTpB+/Ct6OZVUXaOHPCj4cWmfI=
X-Google-Smtp-Source: APXvYqxdDdQTiOgKs4TnNodhzxujvZ1Xd3L99Tr21BcP0inCT30NlNJDY0b6UZN07XxS5rgXweO70A==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr11019981wrj.66.1557148336428;
        Mon, 06 May 2019 06:12:16 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o4sm4513171wmc.38.2019.05.06.06.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 06:12:15 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Steve Lawrence <slawrence@tresys.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] selinux: support attributes in type transitions
Date:   Mon,  6 May 2019 15:12:13 +0200
Message-Id: <20190506131213.31044-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The amount of filename transition rules used in Fedora has grown a lot
due to many domains needing rules for correct /dev file labeling. This
has in turn caused the binary policy to increase in size a lot, too.

To mitigate this, start properly handling type attributes in type
transitions so that userspace can avoid always expanding them and
generate smaller policies. (Note: adding attribute support only for
named transition rules would be enough, but this patch adds it to all
type transition rules to keep better consistency.)

As an illustration, this change will reduce Fedora 31 binary policy from
~8.4 MiB to only ~2.8 MiB (~250K type transition rules to ~28K). These
numbers only take into account named file transition rules; the
reduction from basic type transition rules is likely going to be much
less radical.

The fact whether the kernel supports this feature is signaled to
userspace by an increment in policy version. With older policies the
transition computation is handled as before to avoid performance
regression.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Very mildly tested by applying a proof-of-concept patch against
libsepol [1], which disables type attribute expansion on src/target of
named file transition rules, and running the following on Fedora Rawhide
(from an unconfined root shell):

    mknod /dev/ram0 b 252 16
    ls -lZ /dev/ram0
    rm -f /dev/ram0

Without this patch, the corresponding transition rule (which happens to
have an attribute specified as the source type) didn't apply and the
file got label device_t (as expected). With this patch (+ the policy
version fallback condition disabled), the rule applied as it should and
the file got labeled correctly as fixed_disk_device_t.

We don't have a proper corresponding userspace patch yet, but I'd like
to have this patch out and get some feedback before moving on further.

See RHBZ 1660142 [2] for original discussion leading to this patch.

[1] https://github.com/WOnder93/selinux/commit/26283729657ec33b6743e929e1b5b40a54294043
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1660142

 security/selinux/include/security.h |  33 +++---
 security/selinux/ss/services.c      | 177 ++++++++++++++++++++--------
 2 files changed, 147 insertions(+), 63 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 111121281c47..aa6b5a689cb7 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -22,28 +22,29 @@
 #define SECCLASS_NULL			0x0000 /* no class */
 
 /* Identify specific policy version changes */
-#define POLICYDB_VERSION_BASE		15
-#define POLICYDB_VERSION_BOOL		16
-#define POLICYDB_VERSION_IPV6		17
-#define POLICYDB_VERSION_NLCLASS	18
-#define POLICYDB_VERSION_VALIDATETRANS	19
-#define POLICYDB_VERSION_MLS		19
-#define POLICYDB_VERSION_AVTAB		20
-#define POLICYDB_VERSION_RANGETRANS	21
-#define POLICYDB_VERSION_POLCAP		22
-#define POLICYDB_VERSION_PERMISSIVE	23
-#define POLICYDB_VERSION_BOUNDARY	24
-#define POLICYDB_VERSION_FILENAME_TRANS	25
-#define POLICYDB_VERSION_ROLETRANS	26
+#define POLICYDB_VERSION_BASE			15
+#define POLICYDB_VERSION_BOOL			16
+#define POLICYDB_VERSION_IPV6			17
+#define POLICYDB_VERSION_NLCLASS		18
+#define POLICYDB_VERSION_VALIDATETRANS		19
+#define POLICYDB_VERSION_MLS			19
+#define POLICYDB_VERSION_AVTAB			20
+#define POLICYDB_VERSION_RANGETRANS		21
+#define POLICYDB_VERSION_POLCAP			22
+#define POLICYDB_VERSION_PERMISSIVE		23
+#define POLICYDB_VERSION_BOUNDARY		24
+#define POLICYDB_VERSION_FILENAME_TRANS		25
+#define POLICYDB_VERSION_ROLETRANS		26
 #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
-#define POLICYDB_VERSION_DEFAULT_TYPE	28
+#define POLICYDB_VERSION_DEFAULT_TYPE		28
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
-#define POLICYDB_VERSION_XPERMS_IOCTL	30
+#define POLICYDB_VERSION_XPERMS_IOCTL		30
 #define POLICYDB_VERSION_INFINIBAND		31
+#define POLICYDB_VERSION_TYPE_TRANS_ATTR	32
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_INFINIBAND
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_TYPE_TRANS_ATTR
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cc043bc8fd4c..1e8293201184 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1610,30 +1610,137 @@ out:
 	return -EACCES;
 }
 
-static void filename_compute_type(struct policydb *policydb,
-				  struct context *newcontext,
-				  u32 stype, u32 ttype, u16 tclass,
-				  const char *objname)
+static void compute_type_noattr(struct policydb *policydb,
+				struct context *newcontext,
+				u32 stype, u32 ttype,
+				u16 tclass, u32 specified,
+				const char *objname)
 {
-	struct filename_trans ft;
-	struct filename_trans_datum *otype;
+	struct avtab_key avkey;
+	struct avtab_datum *avdatum = NULL;
+	struct avtab_node *node;
 
 	/*
-	 * Most filename trans rules are going to live in specific directories
-	 * like /dev or /var/run.  This bitmap will quickly skip rule searches
-	 * if the ttype does not contain any rules.
+	 * if we have a objname this is a file trans check so check those
+	 * rules
 	 */
-	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
+	if (objname) {
+		struct filename_trans ft;
+		struct filename_trans_datum *otype;
+
+		/*
+		 * Most filename trans rules are going to live in specific
+		 * directories like /dev or /var/run.  This bitmap will quickly
+		 * skip rule searches if the ttype does not contain any rules.
+		 */
+		if (ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype)) {
+			ft.stype = stype;
+			ft.ttype = ttype;
+			ft.tclass = tclass;
+			ft.name = objname;
+
+			otype = hashtab_search(policydb->filename_trans, &ft);
+			if (otype) {
+				newcontext->type = otype->otype;
+				return;
+			}
+		}
+	}
+
+	/* Look for a type transition/member/change rule. */
+	avkey.source_type = stype;
+	avkey.target_type = ttype;
+	avkey.target_class = tclass;
+	avkey.specified = specified;
+	avdatum = avtab_search(&policydb->te_avtab, &avkey);
+	if (avdatum) {
+		newcontext->type = avdatum->u.data;
 		return;
+	}
+
+	/* If no permanent rule, also check for enabled conditional rules */
+	node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
+	for (; node; node = avtab_search_node_next(node, specified)) {
+		if (node->key.specified & AVTAB_ENABLED) {
+			newcontext->type = node->datum.u.data;
+			return;
+		}
+	}
+}
 
-	ft.stype = stype;
-	ft.ttype = ttype;
-	ft.tclass = tclass;
-	ft.name = objname;
+static void compute_type(struct policydb *policydb, struct context *newcontext,
+			 u32 stype, u32 ttype, u16 tclass, u32 specified,
+			 const char *objname)
+{
+	struct avtab_key avkey;
+	struct avtab_datum *avdatum = NULL;
+	struct avtab_node *node;
+	struct ebitmap *sattr, *tattr;
+	struct ebitmap_node *snode, *tnode;
+	unsigned int i, j;
+
+	sattr = &policydb->type_attr_map_array[stype - 1];
+	tattr = &policydb->type_attr_map_array[ttype - 1];
+
+	if (objname) {
+		struct filename_trans ft;
+		struct filename_trans_datum *otype;
+
+		ebitmap_for_each_positive_bit(tattr, tnode, j) {
+			/*
+			 * Most filename trans rules are going to live in
+			 * specific directories like /dev or /var/run.  This
+			 * bitmap will quickly skip rule searches if the ttype
+			 * does not contain any rules.
+			 */
+			if (!ebitmap_get_bit(&policydb->filename_trans_ttypes,
+					     j + 1))
+				continue;
 
-	otype = hashtab_search(policydb->filename_trans, &ft);
-	if (otype)
-		newcontext->type = otype->otype;
+			ebitmap_for_each_positive_bit(sattr, snode, i) {
+				ft.stype = i + 1;
+				ft.ttype = j + 1;
+				ft.tclass = tclass;
+				ft.name = objname;
+
+				otype = hashtab_search(policydb->filename_trans,
+						       &ft);
+				if (otype) {
+					newcontext->type = otype->otype;
+					return;
+				}
+			}
+		}
+	}
+
+	/* Look for a type transition/member/change rule. */
+	avkey.target_class = tclass;
+	avkey.specified = specified;
+	ebitmap_for_each_positive_bit(sattr, snode, i) {
+		ebitmap_for_each_positive_bit(tattr, tnode, j) {
+			avkey.source_type = i + 1;
+			avkey.target_type = j + 1;
+			avdatum = avtab_search(&policydb->te_avtab, &avkey);
+			if (avdatum) {
+				newcontext->type = avdatum->u.data;
+				return;
+			}
+
+			/*
+			 * If no permanent rule, also check for enabled
+			 * conditional rules
+			 */
+			node = avtab_search_node(&policydb->te_cond_avtab,
+						 &avkey);
+			for (; node;
+			     node = avtab_search_node_next(node, specified)) {
+				if (node->key.specified & AVTAB_ENABLED) {
+					newcontext->type = node->datum.u.data;
+					return;
+				}
+			}
+		}
+	}
 }
 
 static int security_compute_sid(struct selinux_state *state,
@@ -1650,9 +1757,6 @@ static int security_compute_sid(struct selinux_state *state,
 	struct class_datum *cladatum = NULL;
 	struct context *scontext = NULL, *tcontext = NULL, newcontext;
 	struct role_trans *roletr = NULL;
-	struct avtab_key avkey;
-	struct avtab_datum *avdatum;
-	struct avtab_node *node;
 	u16 tclass;
 	int rc = 0;
 	bool sock;
@@ -1748,33 +1852,12 @@ static int security_compute_sid(struct selinux_state *state,
 		}
 	}
 
-	/* Look for a type transition/member/change rule. */
-	avkey.source_type = scontext->type;
-	avkey.target_type = tcontext->type;
-	avkey.target_class = tclass;
-	avkey.specified = specified;
-	avdatum = avtab_search(&policydb->te_avtab, &avkey);
-
-	/* If no permanent rule, also check for enabled conditional rules */
-	if (!avdatum) {
-		node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
-		for (; node; node = avtab_search_node_next(node, specified)) {
-			if (node->key.specified & AVTAB_ENABLED) {
-				avdatum = &node->datum;
-				break;
-			}
-		}
-	}
-
-	if (avdatum) {
-		/* Use the type from the type transition/member/change rule. */
-		newcontext.type = avdatum->u.data;
-	}
-
-	/* if we have a objname this is a file trans check so check those rules */
-	if (objname)
-		filename_compute_type(policydb, &newcontext, scontext->type,
-				      tcontext->type, tclass, objname);
+	if (policydb->policyvers < POLICYDB_VERSION_TYPE_TRANS_ATTR)
+		compute_type_noattr(policydb, &newcontext, scontext->type,
+				    tcontext->type, tclass, specified, objname);
+	else
+		compute_type(policydb, &newcontext, scontext->type,
+			     tcontext->type, tclass, specified, objname);
 
 	/* Check for class-specific changes. */
 	if (specified & AVTAB_TRANSITION) {
-- 
2.20.1

