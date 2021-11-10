Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613FDC433EF
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 11:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB5A610CB
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 11:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKJLP0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhKJLPZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 06:15:25 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1974C061764
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 03:12:37 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 67-20020a1c0046000000b0032cd88916e5so954190wma.6
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 03:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1/5nAHdx7stQzloLDDMeLR6imy0hpUh1bEBk+JYK/7I=;
        b=LjRt41VvnIPFmhSW38wiakB0A+6+1i/GpICSLd553PGBS9IxJQnTG5G4I2vOD6HBKP
         CJeulYw7s6eBa9+v+VEO/Uk6ELzMIrEqXpBn/FyC/WSPBu6QAcu5pLkLi011GGVGp1je
         CxEOZOVDSlCCBP8SGNxJDQQpwXTjRTmSspEmQ1fgoZFewiOY7QhlhVIgsDXctLI2fcMm
         pLribhJuucr4qHGVXDgLchSCdKHufGdaN20dc8+gqu6cd9I2+gsokbjdmcyIiELuXZCl
         rZ3kbKRMNEWAdg+GvFNUF+IEsTbmXXnGoKy3MG0zvetPg4FwDpM35THYEG49pNU9aavb
         10WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1/5nAHdx7stQzloLDDMeLR6imy0hpUh1bEBk+JYK/7I=;
        b=FvNaBJ0W9GLSsW2SptIOcepYeeHjgUPZ8M1F5ancmtKLAZcY00Dj7bzAyBmP2qxk1c
         ilyZEMOAN/k0phkaSg7X0/Qm+loiEWDFRqklSZkNhaoYSwyuQN6dIKYJ0DVlhV4IjFcO
         Pq4N+908tPfl1okgkfuV5+PVtk28JjAuFCNt9ivrSvW/4BkF7dPRn4wwpgzPLFWNWu8Y
         vLuRTi4NwkP+/F2sxtcnnKmO2Gf96cvU2tRmrx4o0n+o/QvVfoAQiY/FA5C0klGSq/sj
         rRYJseK7jTwBkUdJsH6wd8kuv2ZbbqcKCuhBBv9/NlQeMC7KaMFgLBFjCZUNaNt5fziF
         KF/w==
X-Gm-Message-State: AOAM531k87rHWzHBTrAPiibCTVFtanp8HY3hn5J3YbV7sa6sigdVnWny
        E/4UignppMpVmtrHLkHFshttES9lkEBlknlxYuSyb+mW+Hoa61Oz6TXLQuptZeBCRfoEA4nMCbd
        l51MrMSTmTepuL0XY5Ej6COeatbBZhFNsBkCcDvMLzNWqDoEAgG58nEtJ9qJy2XSXI95lkfo=
X-Google-Smtp-Source: ABdhPJwOtbqyK8jn95SY8bCDgxYXKaWkLHHfgyzPgCmbMGWHDpVVzYDSMhLxuumJHGWzDYcOqAKmQkfhLu9KBAM=
X-Received: from bram1.zrh.corp.google.com ([2a00:79e0:61:301:5d20:cb30:3da8:7932])
 (user=brambonne job=sendgmr) by 2002:a5d:64c3:: with SMTP id
 f3mr18087110wri.321.1636542756095; Wed, 10 Nov 2021 03:12:36 -0800 (PST)
Date:   Wed, 10 Nov 2021 12:11:47 +0100
Message-Id: <20211110111146.3461631-1-brambonne@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH] libsepol,checkpolicy: Add netlink xperm support
From:   Bram Bonne <brambonne@google.com>
To:     selinux@vger.kernel.org
Cc:     jeffv@google.com, paul@paul-moore.com, sds@tycho.nsa.gov,
        Bram Bonne <brambonne@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reuse the existing extended permissions infrastructure to support
sepolicy for different netlink message types.

When individual netlink message types are omitted only the existing
permissions are checked. As is the case for ioctl xperms, this feature
is intended to provide finer granularity for nlmsg_read and nlmsg_write
permissions, as they may be too imprecise. For example, a single
NETLINK_ROUTE socket may provide access to both an interface's IP
address and to its ARP table, which might have different privacy
implications. In addition, the set of message types has grown over time,
so even if the current list is acceptable, future additions might not be.
It was suggested before on the mailing list [1] that extended permissions
would be a good fit for this purpose.

Existing policy using the nlmsg_read and nlmsg_write permissions will
continue to work as-is. Similar to ioctl xperms, netlink xperms allow
for a more fine-grained policy where needed.

Example policy on Android, preventing regular apps from accessing the
device's MAC address and ARP table, but allowing this access to
privileged apps, looks as follows:

allow netdomain self:netlink_route_socket {
        create read getattr write setattr lock append connect getopt
        setopt shutdown nlmsg_read
};
allowxperm netdomain self:netlink_route_socket nlmsg ~{
        RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
};
allowxperm priv_app self:netlink_route_socket nlmsg {
        RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
};

Android currently uses code similar to [1] as a temporary workaround to
limit access to certain netlink message types; our hope is that this patch
will allow us to move back to upstream code with an approach that works for
everyone.

[1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com/

Signed-off-by: Bram Bonne <brambonne@google.com>
---
 checkpolicy/policy_define.c                | 124 +++++++++++------
 checkpolicy/test/dismod.c                  |   2 +
 libsepol/cil/src/cil.c                     |   2 +
 libsepol/cil/src/cil_binary.c              | 154 ++++++++++++++++++---
 libsepol/cil/src/cil_build_ast.c           |   4 +-
 libsepol/cil/src/cil_internal.h            |   2 +
 libsepol/cil/src/cil_policy.c              |   2 +
 libsepol/cil/src/cil_verify.c              |   3 +
 libsepol/cil/src/cil_write_ast.c           |  16 ++-
 libsepol/include/sepol/policydb/avtab.h    |   1 +
 libsepol/include/sepol/policydb/policydb.h |   1 +
 libsepol/src/assertion.c                   |  15 +-
 libsepol/src/expand.c                      |   3 +
 libsepol/src/kernel_to_cil.c               |  23 ++-
 libsepol/src/module_to_cil.c               |  29 +++-
 libsepol/src/optimize.c                    |   6 +
 libsepol/src/util.c                        |  11 +-
 17 files changed, 321 insertions(+), 77 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d3eb6111..8ca22993 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1818,27 +1818,27 @@ avrule_t *define_cond_pol_list(avrule_t * avlist, avrule_t * sl)
 	return sl;
 }
 
-typedef struct av_ioctl_range {
+typedef struct av_xperm_range {
 	uint16_t low;
 	uint16_t high;
-} av_ioctl_range_t;
+} av_xperm_range_t;
 
-struct av_ioctl_range_list {
+struct av_xperm_range_list {
 	uint8_t omit;
-	av_ioctl_range_t range;
-	struct av_ioctl_range_list *next;
+	av_xperm_range_t range;
+	struct av_xperm_range_list *next;
 };
 
-static int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_sort_xperms(struct av_xperm_range_list **rangehead)
 {
-	struct av_ioctl_range_list *r, *r2, *sorted, *sortedhead = NULL;
+	struct av_xperm_range_list *r, *r2, *sorted, *sortedhead = NULL;
 
 	/* order list by range.low */
 	for (r = *rangehead; r != NULL; r = r->next) {
-		sorted = malloc(sizeof(struct av_ioctl_range_list));
+		sorted = malloc(sizeof(struct av_xperm_range_list));
 		if (sorted == NULL)
 			goto error;
-		memcpy(sorted, r, sizeof(struct av_ioctl_range_list));
+		memcpy(sorted, r, sizeof(struct av_xperm_range_list));
 		sorted->next = NULL;
 		if (sortedhead == NULL) {
 			sortedhead = sorted;
@@ -1877,9 +1877,9 @@ error:
 	return -1;
 }
 
-static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_merge_xperms(struct av_xperm_range_list **rangehead)
 {
-	struct av_ioctl_range_list *r, *tmp;
+	struct av_xperm_range_list *r, *tmp;
 	r = *rangehead;
 	while (r != NULL && r->next != NULL) {
 		/* merge */
@@ -1897,15 +1897,15 @@ static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
 	return 0;
 }
 
-static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_read_xperm_ranges(struct av_xperm_range_list **rangehead)
 {
 	char *id;
-	struct av_ioctl_range_list *rnew, *r = NULL;
+	struct av_xperm_range_list *rnew, *r = NULL;
 	uint8_t omit = 0;
 
 	*rangehead = NULL;
 
-	/* read in all the ioctl commands */
+	/* read in all the netlink ranges / ioctl commands */
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id,"~") == 0) {
 			/* these are values to be omitted */
@@ -1917,13 +1917,13 @@ static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
 			id = queue_remove(id_queue);
 			r->range.high = (uint16_t) strtoul(id,NULL,0);
 			if (r->range.high < r->range.low) {
-				yyerror("Ioctl ranges must be in ascending order.");
+				yyerror("xperm ranges must be in ascending order.");
 				return -1;
 			}
 			free(id);
 		} else {
 			/* read in new low value */
-			rnew = malloc(sizeof(struct av_ioctl_range_list));
+			rnew = malloc(sizeof(struct av_xperm_range_list));
 			if (rnew == NULL)
 				goto error;
 			rnew->next = NULL;
@@ -1950,11 +1950,11 @@ error:
 }
 
 /* flip to included ranges */
-static int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_omit_xperms(struct av_xperm_range_list **rangehead)
 {
-	struct av_ioctl_range_list *rnew, *r, *newhead, *r2;
+	struct av_xperm_range_list *rnew, *r, *newhead, *r2;
 
-	rnew = calloc(1, sizeof(struct av_ioctl_range_list));
+	rnew = calloc(1, sizeof(struct av_xperm_range_list));
 	if (!rnew)
 		goto error;
 
@@ -1972,7 +1972,7 @@ static int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
 
 	while (r) {
 		r2->range.high = r->range.low - 1;
-		rnew = calloc(1, sizeof(struct av_ioctl_range_list));
+		rnew = calloc(1, sizeof(struct av_xperm_range_list));
 		if (!rnew)
 			goto error;
 		r2->next = rnew;
@@ -1998,27 +1998,27 @@ error:
 	return -1;
 }
 
-static int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
+static int avrule_xperm_ranges(struct av_xperm_range_list **rangelist)
 {
-	struct av_ioctl_range_list *rangehead;
+	struct av_xperm_range_list *rangehead;
 	uint8_t omit;
 
 	/* read in ranges to include and omit */
-	if (avrule_read_ioctls(&rangehead))
+	if (avrule_read_xperm_ranges(&rangehead))
 		return -1;
 	if (rangehead == NULL) {
-		yyerror("error processing ioctl commands");
+		yyerror("error processing ioctl/netlink commands");
 		return -1;
 	}
 	omit = rangehead->omit;
-	/* sort and merge the input ioctls */
-	if (avrule_sort_ioctls(&rangehead))
+	/* sort and merge the input ranges */
+	if (avrule_sort_xperms(&rangehead))
 		return -1;
-	if (avrule_merge_ioctls(&rangehead))
+	if (avrule_merge_xperms(&rangehead))
 		return -1;
 	/* flip ranges if these are omitted */
 	if (omit) {
-		if (avrule_omit_ioctls(&rangehead))
+		if (avrule_omit_xperms(&rangehead))
 			return -1;
 	}
 
@@ -2189,11 +2189,11 @@ static int avrule_xperms_used(const av_extended_perms_t *xperms)
 #define IOC_DRIV(x) ((x) >> 8)
 #define IOC_FUNC(x) ((x) & 0xff)
 #define IOC_CMD(driver, func) (((driver) << 8) + (func))
-static int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelist,
+static int avrule_ioctl_partialdriver(struct av_xperm_range_list *rangelist,
 				av_extended_perms_t *complete_driver,
 				av_extended_perms_t **extended_perms)
 {
-	struct av_ioctl_range_list *r;
+	struct av_xperm_range_list *r;
 	av_extended_perms_t *xperms;
 	uint8_t low, high;
 
@@ -2228,10 +2228,10 @@ static int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelist,
 
 }
 
-static int avrule_ioctl_completedriver(struct av_ioctl_range_list *rangelist,
+static int avrule_ioctl_completedriver(struct av_xperm_range_list *rangelist,
 			av_extended_perms_t **extended_perms)
 {
-	struct av_ioctl_range_list *r;
+	struct av_xperm_range_list *r;
 	av_extended_perms_t *xperms;
 	uint16_t low, high;
 	xperms = calloc(1, sizeof(av_extended_perms_t));
@@ -2270,10 +2270,10 @@ static int avrule_ioctl_completedriver(struct av_ioctl_range_list *rangelist,
 	return 0;
 }
 
-static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
+static int avrule_xperms_single_driver(struct av_xperm_range_list *rangelist,
 		av_extended_perms_t **extended_perms, unsigned int driver)
 {
-	struct av_ioctl_range_list *r;
+	struct av_xperm_range_list *r;
 	av_extended_perms_t *xperms;
 	uint16_t low, high;
 
@@ -2307,7 +2307,6 @@ static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
 		high = IOC_FUNC(high);
 		avrule_xperm_setrangebits(low, high, xperms);
 		xperms->driver = driver;
-		xperms->specified = AVRULE_XPERMS_IOCTLFUNCTION;
 		r = r->next;
 	}
 
@@ -2320,6 +2319,18 @@ static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
 	return 0;
 }
 
+void avrule_ioctl_freeranges(struct av_xperm_range_list *rangelist)
+{
+	struct av_xperm_range_list *r, *tmp;
+	
+	r = rangelist;
+	while (r) {
+		tmp = r;
+		r = r->next;
+		free(tmp);
+	}
+}
+
 static unsigned int xperms_for_each_bit(unsigned int *bit, av_extended_perms_t *xperms)
 {
 	unsigned int i;
@@ -2384,13 +2395,13 @@ static int avrule_cpy(avrule_t *dest, const avrule_t *src)
 static int define_te_avtab_ioctl(const avrule_t *avrule_template)
 {
 	avrule_t *avrule;
-	struct av_ioctl_range_list *rangelist, *r;
+	struct av_xperm_range_list *rangelist, *r;
 	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
 	unsigned int i;
 
 
 	/* organize ioctl ranges */
-	if (avrule_ioctl_ranges(&rangelist))
+	if (avrule_xperm_ranges(&rangelist))
 		return -1;
 
 	/* create rule for ioctl driver types that are entirely enabled */
@@ -2422,10 +2433,11 @@ static int define_te_avtab_ioctl(const avrule_t *avrule_template)
 	 */
 	i = 0;
 	while (xperms_for_each_bit(&i, partial_driver)) {
-		if (avrule_ioctl_func(rangelist, &xperms, i))
+		if (avrule_xperms_single_driver(rangelist, &xperms, i))
 			return -1;
 
 		if (xperms) {
+			xperms->specified = AVRULE_XPERMS_IOCTLFUNCTION;
 			avrule = (avrule_t *) calloc(1, sizeof(avrule_t));
 			if (!avrule) {
 				yyerror("out of memory");
@@ -2451,6 +2463,38 @@ done:
 	return 0;
 }
 
+int define_te_avtab_netlink(avrule_t *avrule_template)
+{
+	avrule_t *avrule;
+	struct av_xperm_range_list *range_list;
+	av_extended_perms_t *xperms = NULL;
+
+	/* organize message ranges */
+	if (avrule_xperm_ranges(&range_list))
+		return -1;
+
+	/* Netlink message types comfortably fit into a single driver
+	 * (see RTM_MAX in uapi/linux/rtnetlink.h)
+	 */
+	avrule_xperms_single_driver(range_list, &xperms, 0);
+
+	if (xperms && avrule_xperms_used(xperms)) {
+		xperms->specified = AVRULE_XPERMS_NLMSG;
+		avrule = (avrule_t *) calloc(1, sizeof(avrule_t));
+		if (!avrule) {
+			yyerror("out of memory");
+			return -1;
+		}
+		if (avrule_cpy(avrule, avrule_template))
+			return -1;
+		avrule->xperms = xperms;
+		append_avrule(avrule);
+	} else {
+		free(xperms);
+	}
+	return 0;
+}
+
 int define_te_avtab_extended_perms(int which)
 {
 	char *id;
@@ -2473,8 +2517,10 @@ int define_te_avtab_extended_perms(int which)
 	id = queue_remove(id_queue);
 	if (strcmp(id,"ioctl") == 0) {
 		rc = define_te_avtab_ioctl(avrule_template);
+	} else if (strcmp(id, "nlmsg") == 0) {
+		rc = define_te_avtab_netlink(avrule_template);
 	} else {
-		yyerror("only ioctl extended permissions are supported");
+		yyerror("only ioctl / nlmsg extended permissions are supported");
 		rc = -1;
 	}
 
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index ec2a3e9a..f8652ec5 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -296,6 +296,8 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 			xperms.specified = AVTAB_XPERMS_IOCTLFUNCTION;
 		else if (avrule->xperms->specified == AVRULE_XPERMS_IOCTLDRIVER)
 			xperms.specified = AVTAB_XPERMS_IOCTLDRIVER;
+		else if (avrule->xperms->specified == AVRULE_XPERMS_NLMSG)
+			xperms.specified = AVTAB_XPERMS_NLMSG;
 		else {
 			fprintf(fp, "     ERROR: no valid xperms specified\n");
 			return -1;
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 4cc7f87f..fbdb005a 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -219,6 +219,7 @@ char *CIL_KEY_DONTAUDITX;
 char *CIL_KEY_NEVERALLOWX;
 char *CIL_KEY_PERMISSIONX;
 char *CIL_KEY_IOCTL;
+char *CIL_KEY_NLMSG;
 char *CIL_KEY_UNORDERED;
 char *CIL_KEY_SRC_INFO;
 char *CIL_KEY_SRC_CIL;
@@ -388,6 +389,7 @@ static void cil_init_keys(void)
 	CIL_KEY_NEVERALLOWX = cil_strpool_add("neverallowx");
 	CIL_KEY_PERMISSIONX = cil_strpool_add("permissionx");
 	CIL_KEY_IOCTL = cil_strpool_add("ioctl");
+	CIL_KEY_NLMSG = cil_strpool_add("nlmsg");
 	CIL_KEY_UNORDERED = cil_strpool_add("unordered");
 	CIL_KEY_SRC_INFO = cil_strpool_add("<src_info>");
 	CIL_KEY_SRC_CIL = cil_strpool_add("cil");
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index d8aa495a..f9938d66 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -66,6 +66,7 @@ struct cil_args_binary {
 	int pass;
 	hashtab_t role_trans_table;
 	hashtab_t avrulex_ioctl_table;
+	hashtab_t avrulex_nlmsg_table;
 	void **type_value_to_cil;
 };
 
@@ -1553,7 +1554,7 @@ void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, struct avtab_exten
 #define IOC_DRIV(x) (x >> 8)
 #define IOC_FUNC(x) (x & 0xff)
 
-int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list **xperms_list)
+int __cil_permx_ioctl_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list **xperms_list)
 {
 	ebitmap_node_t *node;
 	unsigned int i;
@@ -1618,13 +1619,53 @@ int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list *
 	return SEPOL_OK;
 }
 
-int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
+int __cil_permx_nlmsg_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list **xperms_list)
+{
+	ebitmap_node_t *node;
+	uint16_t i;
+	uint16_t low;
+	struct avtab_extended_perms *avtab = NULL;
+	int start_new_range = 1;
+
+	cil_list_init(xperms_list, CIL_NONE);
+
+	ebitmap_for_each_positive_bit(xperms, node, i) {
+		if (start_new_range) {
+			low = i;
+			start_new_range = 0;
+		}
+
+		// Continue if the current bit isn't the end of the driver range
+		// or the next bit is set
+		if (ebitmap_get_bit(xperms, i + 1)) {
+			continue;
+		}
+
+		start_new_range = 1;
+
+		if (!avtab) {
+			avtab = cil_calloc(1, sizeof(*avtab));
+			// Netlink message types all fit in driver 0
+			avtab->driver = 0;
+			avtab->specified = AVTAB_XPERMS_NLMSG;
+		}
+
+		__avrule_xperm_setrangebits(low, i, avtab);
+	}
+
+	if (avtab) {
+		cil_list_append(*xperms_list, CIL_NONE, avtab);
+	}
+
+	return SEPOL_OK;
+}
+
+int __cil_avrulex_to_policydb(hashtab_key_t k, struct cil_list* xperms_list, char* cil_key, void *args)
 {
 	int rc = SEPOL_OK;
 	struct policydb *pdb;
 	avtab_key_t *avtab_key;
 	avtab_datum_t avtab_datum;
-	struct cil_list *xperms_list = NULL;
 	struct cil_list_item *item;
 	class_datum_t *sepol_obj;
 	uint32_t data = 0;
@@ -1637,17 +1678,12 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
 	// setting the data for an extended avtab isn't really necessary because
 	// it is ignored by the kernel. However, neverallow checking requires that
 	// the data value be set, so set it for that to work.
-	rc = __perm_str_to_datum(CIL_KEY_IOCTL, sepol_obj, &data);
+	rc = __perm_str_to_datum(cil_key, sepol_obj, &data);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
 	avtab_datum.data = data;
 
-	rc = __cil_permx_bitmap_to_sepol_xperms_list(datum, &xperms_list);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	cil_list_for_each(item, xperms_list) {
 		avtab_datum.xperms = item->data;
 		rc = avtab_insert(&pdb->te_avtab, avtab_key, &avtab_datum);
@@ -1659,16 +1695,57 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
 	rc = SEPOL_OK;
 
 exit:
+	return rc;
+}
+
+void __cil_cleanup_xperms(struct cil_list *xperms_list)
+{
+	struct cil_list_item *item;
+
 	if (xperms_list != NULL) {
 		cil_list_for_each(item, xperms_list) {
 			free(item->data);
+			item->data = NULL;
 		}
 		cil_list_destroy(&xperms_list, CIL_FALSE);
 	}
+}
+
+int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
+{
+	struct cil_list *xperms_list = NULL;
+	int rc;
+
+	rc = __cil_permx_ioctl_bitmap_to_sepol_xperms_list(datum, &xperms_list);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	rc = __cil_avrulex_to_policydb(k, xperms_list, CIL_KEY_IOCTL, args);
+
+exit:
+	__cil_cleanup_xperms(xperms_list);
+
 	return rc;
 }
 
-int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, uint32_t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
+int __cil_avrulex_nlmsg_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
+{
+	struct cil_list *xperms_list = NULL;
+	int rc;
+
+	rc = __cil_permx_nlmsg_bitmap_to_sepol_xperms_list(datum, &xperms_list);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	rc = __cil_avrulex_to_policydb(k, xperms_list, CIL_KEY_NLMSG, args);
+
+exit:
+	__cil_cleanup_xperms(xperms_list);
+
+	return rc;
+}
+
+int __cil_avrulex_to_hashtable(hashtab_t h, uint16_t kind, uint32_t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
 {
 	uint16_t specified;
 	avtab_key_t *avtab_key;
@@ -1747,8 +1824,12 @@ int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t kind, struct cil
 		if (rc != SEPOL_OK) goto exit;
 
 		switch (permx->kind) {
-		case  CIL_PERMX_KIND_IOCTL:
-			rc = __cil_avrulex_ioctl_to_hashtable(args->avrulex_ioctl_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx->perms);
+		case CIL_PERMX_KIND_IOCTL:
+			rc = __cil_avrulex_to_hashtable(args->avrulex_ioctl_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx->perms);
+			if (rc != SEPOL_OK) goto exit;
+			break;
+		case CIL_PERMX_KIND_NLMSG:
+			rc = __cil_avrulex_to_hashtable(args->avrulex_nlmsg_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx->perms);
 			if (rc != SEPOL_OK) goto exit;
 			break;
 		default:
@@ -4417,6 +4498,9 @@ static int __cil_permx_to_sepol_class_perms(policydb_t *pdb, struct cil_permissi
 			case CIL_PERMX_KIND_IOCTL:
 				perm_str = CIL_KEY_IOCTL;
 				break;
+			case CIL_PERMX_KIND_NLMSG:
+				perm_str = CIL_KEY_NLMSG;
+				break;
 			default:
 				rc = SEPOL_ERR;
 				goto exit;
@@ -4563,6 +4647,9 @@ static void __cil_print_permissionx(struct cil_permissionx *px)
 		case CIL_PERMX_KIND_IOCTL:
 			kind_str = CIL_KEY_IOCTL;
 			break;
+		case CIL_PERMX_KIND_NLMSG:
+			kind_str = CIL_KEY_NLMSG;
+			break;
 		default:
 			kind_str = "unknown";
 			break;
@@ -4696,8 +4783,21 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 			goto exit;
 		}
 
-		rc = __cil_permx_bitmap_to_sepol_xperms_list(cil_rule->perms.x.permx->perms, &xperms);
-		if (rc != SEPOL_OK) {
+		switch (cil_rule->perms.x.permx->kind) {
+		case CIL_PERMX_KIND_IOCTL:
+			rc = __cil_permx_ioctl_bitmap_to_sepol_xperms_list(cil_rule->perms.x.permx->perms, &xperms);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+			break;
+		case CIL_PERMX_KIND_NLMSG:
+			rc = __cil_permx_nlmsg_bitmap_to_sepol_xperms_list(cil_rule->perms.x.permx->perms, &xperms);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+			break;
+		default:
+			rc = SEPOL_ERR;
 			goto exit;
 		}
 
@@ -4715,13 +4815,7 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 	}
 
 exit:
-	if (xperms != NULL) {
-		cil_list_for_each(item, xperms) {
-			free(item->data);
-			item->data = NULL;
-		}
-		cil_list_destroy(&xperms, CIL_FALSE);
-	}
+	__cil_cleanup_xperms(xperms);
 
 	rule->xperms = NULL;
 	__cil_destroy_sepol_avrules(rule);
@@ -4904,6 +4998,7 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	struct cil_list *neverallows = NULL;
 	hashtab_t role_trans_table = NULL;
 	hashtab_t avrulex_ioctl_table = NULL;
+	hashtab_t avrulex_nlmsg_table = NULL;
 	void **type_value_to_cil = NULL;
 	struct cil_class **class_value_to_cil = NULL;
 	struct cil_perm ***perm_value_to_cil = NULL;
@@ -4947,7 +5042,13 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 
 	avrulex_ioctl_table = hashtab_create(avrulex_hash, avrulex_compare, AVRULEX_TABLE_SIZE);
 	if (!avrulex_ioctl_table) {
-		cil_log(CIL_INFO, "Failure to create hashtab for avrulex\n");
+		cil_log(CIL_INFO, "Failure to create hashtab for ioctl\n");
+		goto exit;
+	}
+
+	avrulex_nlmsg_table = hashtab_create(avrulex_hash, avrulex_compare, AVRULEX_TABLE_SIZE);
+	if (!avrulex_nlmsg_table) {
+		cil_log(CIL_INFO, "Failure to create hashtab for nlmsg\n");
 		goto exit;
 	}
 
@@ -4958,6 +5059,7 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	extra_args.neverallows = neverallows;
 	extra_args.role_trans_table = role_trans_table;
 	extra_args.avrulex_ioctl_table = avrulex_ioctl_table;
+	extra_args.avrulex_nlmsg_table = avrulex_nlmsg_table;
 	extra_args.type_value_to_cil = type_value_to_cil;
 
 	for (i = 1; i <= 3; i++) {
@@ -4980,7 +5082,12 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 		if (i == 3) {
 			rc = hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_to_policydb, pdb);
 			if (rc != SEPOL_OK) {
-				cil_log(CIL_INFO, "Failure creating avrulex rules\n");
+				cil_log(CIL_INFO, "Failure creating ioctl avrulex rules\n");
+				goto exit;
+			}
+			rc = hashtab_map(avrulex_nlmsg_table, __cil_avrulex_nlmsg_to_policydb, pdb);
+			if (rc != SEPOL_OK) {
+				cil_log(CIL_INFO, "Failure creating nlmsg avrulex rules\n");
 				goto exit;
 			}
 		}
@@ -5056,6 +5163,7 @@ exit:
 	hashtab_destroy(role_trans_table);
 	hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy, NULL);
 	hashtab_destroy(avrulex_ioctl_table);
+	hashtab_destroy(avrulex_nlmsg_table);
 	free(type_value_to_cil);
 	free(class_value_to_cil);
 	if (perm_value_to_cil != NULL) {
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 9c34be23..b1cfb4f0 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2159,8 +2159,10 @@ int cil_fill_permissionx(struct cil_tree_node *parse_current, struct cil_permiss
 
 	if (parse_current->data == CIL_KEY_IOCTL) {
 		permx->kind = CIL_PERMX_KIND_IOCTL;
+	} else if (parse_current->data == CIL_KEY_NLMSG) {
+		permx->kind = CIL_PERMX_KIND_NLMSG;
 	} else {
-		cil_log(CIL_ERR, "Unknown permissionx kind, %s. Must be \"ioctl\"\n", (char *)parse_current->data);
+		cil_log(CIL_ERR, "Unknown permissionx kind, %s. Must be one of [%s, %s]\n", (char *)parse_current->data, CIL_KEY_IOCTL, CIL_KEY_NLMSG);
 		rc = SEPOL_ERR;
 		goto exit;
 	}
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 6f1d3cb5..c968cf1e 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -236,6 +236,7 @@ extern char *CIL_KEY_DONTAUDITX;
 extern char *CIL_KEY_NEVERALLOWX;
 extern char *CIL_KEY_PERMISSIONX;
 extern char *CIL_KEY_IOCTL;
+extern char *CIL_KEY_NLMSG;
 extern char *CIL_KEY_UNORDERED;
 extern char *CIL_KEY_SRC_INFO;
 extern char *CIL_KEY_SRC_CIL;
@@ -623,6 +624,7 @@ struct cil_avrule {
 };
 
 #define CIL_PERMX_KIND_IOCTL 1
+#define CIL_PERMX_KIND_NLMSG 2
 struct cil_permissionx {
 	struct cil_symtab_datum datum;
 	uint32_t kind;
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 7c543c47..2703d764 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1112,6 +1112,8 @@ static void cil_xperms_to_policy(FILE *out, struct cil_permissionx *permx)
 
 	if (permx->kind == CIL_PERMX_KIND_IOCTL) {
 		kind = "ioctl";
+	} else if (permx->kind == CIL_PERMX_KIND_NLMSG) {
+		kind = CIL_KEY_NLMSG;
 	} else {
 		kind = "???";
 	}
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index d994d717..67bdb0e9 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1427,6 +1427,9 @@ int __cil_verify_permissionx(struct cil_permissionx *permx, struct cil_tree_node
 		case CIL_PERMX_KIND_IOCTL:
 			kind_str = CIL_KEY_IOCTL;
 			break;
+		case CIL_PERMX_KIND_NLMSG:
+			kind_str = CIL_KEY_NLMSG;
+			break;
 		default:
 			cil_tree_log(node, CIL_ERR, "Invalid permissionx kind (%d)", permx->kind);
 			rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index d7f00bcc..b93a4fa1 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -303,7 +303,13 @@ static void write_permx(FILE *out, struct cil_permissionx *permx)
 		fprintf(out, "%s", datum_to_str(DATUM(permx)));
 	} else {
 		fprintf(out, "(");
-		fprintf(out, "%s ", permx->kind == CIL_PERMX_KIND_IOCTL ? "ioctl" : "<?KIND>");
+		if (permx->kind == CIL_PERMX_KIND_IOCTL) {
+			fprintf(out, "%s ", "ioctl");
+		} else if (permx->kind == CIL_PERMX_KIND_NLMSG) {
+			fprintf(out, "%s ", "nlmsg");
+		} else {
+			fprintf(out, "%s ", "<?KIND>");
+		}
 		fprintf(out, "%s ", datum_or_str(DATUM(permx->obj), permx->obj_str));
 		write_expr(out, permx->expr_str);
 		fprintf(out, ")");
@@ -812,7 +818,13 @@ void cil_write_ast_node(FILE *out, struct cil_tree_node *node)
 	case CIL_PERMISSIONX: {
 		struct cil_permissionx *permx = node->data;
 		fprintf(out, "(permissionx %s (", datum_to_str(DATUM(permx)));
-		fprintf(out, "%s ", permx->kind == CIL_PERMX_KIND_IOCTL ? "ioctl" : "<?KIND>");
+		if (permx->kind == CIL_PERMX_KIND_IOCTL) {
+			fprintf(out, "%s ", "ioctl");
+		} else if (permx->kind == CIL_PERMX_KIND_NLMSG) {
+			fprintf(out, "%s ", "nlmsg");
+		} else {
+			fprintf(out, "%s ", "<?KIND>");
+		}
 		fprintf(out, "%s ", datum_or_str(DATUM(permx->obj), permx->obj_str));
 		write_expr(out, permx->expr_str);
 		fprintf(out, "))\n");
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 10ecde9a..aa7481d3 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -74,6 +74,7 @@ typedef struct avtab_extended_perms {
 
 #define AVTAB_XPERMS_IOCTLFUNCTION	0x01
 #define AVTAB_XPERMS_IOCTLDRIVER	0x02
+#define AVTAB_XPERMS_NLMSG		0x03
 	/* extension of the avtab_key specified */
 	uint8_t specified;
 	uint8_t driver;
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 4bf9f05d..55918e1d 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -259,6 +259,7 @@ typedef struct class_perm_node {
 typedef struct av_extended_perms {
 #define AVRULE_XPERMS_IOCTLFUNCTION	0x01
 #define AVRULE_XPERMS_IOCTLDRIVER	0x02
+#define AVRULE_XPERMS_NLMSG		0x03
 	uint8_t specified;
 	uint8_t driver;
 	/* 256 bits of permissions */
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index dd2749a0..47e45713 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -101,6 +101,9 @@ static int check_extended_permissions(av_extended_perms_t *neverallow, avtab_ext
 	} else if ((neverallow->specified == AVRULE_XPERMS_IOCTLDRIVER)
 			&& (allow->specified == AVTAB_XPERMS_IOCTLDRIVER)) {
 		rc = extended_permissions_and(neverallow->perms, allow->perms);
+	} else if ((neverallow->specified == AVRULE_XPERMS_NLMSG)
+			&& (allow->specified == AVTAB_XPERMS_NLMSG)) {
+		rc = extended_permissions_and(neverallow->perms, allow->perms);
 	}
 
 	return rc;
@@ -133,6 +136,12 @@ static void extended_permissions_violated(avtab_extended_perms_t *result,
 		result->specified = AVTAB_XPERMS_IOCTLDRIVER;
 		for (i = 0; i < EXTENDED_PERMS_LEN; i++)
 			result->perms[i] = neverallow->perms[i] & allow->perms[i];
+	} else if ((neverallow->specified == AVRULE_XPERMS_NLMSG)
+			&& (allow->specified == AVTAB_XPERMS_NLMSG)) {
+		result->specified = AVTAB_XPERMS_NLMSG;
+		result->driver = 0;
+		for (i = 0; i < EXTENDED_PERMS_LEN; i++)
+			result->perms[i] = neverallow->perms[i] & allow->perms[i];
 	}
 }
 
@@ -166,7 +175,8 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 			     node = avtab_search_node_next(node, tmp_key.specified)) {
 				xperms = node->datum.xperms;
 				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
-						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
+						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
+						&& (xperms->specified != AVTAB_XPERMS_NLMSG))
 					continue;
 
 				rc = check_extended_permissions(avrule->xperms, xperms);
@@ -346,7 +356,8 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 				xperms = node->datum.xperms;
 
 				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
-						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
+						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
+						&& (xperms->specified != AVTAB_XPERMS_NLMSG))
 					continue;
 				rc = check_extended_permissions(neverallow_xperms, xperms);
 				if (rc)
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index a6a466f7..959e6eb2 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1796,6 +1796,9 @@ static int allocate_xperms(sepol_handle_t * handle, avtab_datum_t * avdatump,
 	case AVRULE_XPERMS_IOCTLDRIVER:
 		xperms->specified = AVTAB_XPERMS_IOCTLDRIVER;
 		break;
+	case AVRULE_XPERMS_NLMSG:
+		xperms->specified = AVTAB_XPERMS_NLMSG;
+		break;
 	default:
 		return -1;
 	}
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 305567a5..090d4e43 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1617,7 +1617,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 	remaining = sizeof(xpermsbuf);
 
 	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
-		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)) {
+		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
+		&& (xperms->specified != AVTAB_XPERMS_NLMSG)) {
 		return NULL;
 	}
 
@@ -1637,7 +1638,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 			continue;
 		}
 
-		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
+		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION
+			|| xperms->specified & AVTAB_XPERMS_NLMSG) {
 			value = xperms->driver<<8 | bit;
 			if (in_range) {
 				low_value = xperms->driver<<8 | low_bit;
@@ -1679,7 +1681,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 {
 	uint32_t data = datum->data;
 	type_datum_t *type;
-	const char *flavor, *tgt;
+	const char *flavor, *tgt, *func;
 	char *src, *class, *perms, *new;
 	char *rule = NULL;
 
@@ -1742,8 +1744,21 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 			goto exit;
 		}
 
+		switch (datum->xperms->specified) {
+		case AVRULE_XPERMS_IOCTLDRIVER:
+		case AVRULE_XPERMS_IOCTLFUNCTION:
+			func = "ioctl";
+			break;
+		case AVRULE_XPERMS_NLMSG:
+			func = "nlmsg";
+			break;
+		default:
+			sepol_log_err("Unexpected xperm spec: %hhu", datum->xperms->specified);
+			goto exit;
+		}
+
 		rule = create_str("(%s %s %s (%s %s (%s)))", 6,
-				  flavor, src, tgt, "ioctl", class, perms);
+				  flavor, src, tgt, func, class, perms);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 16e4004e..47d9b171 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -627,14 +627,15 @@ exit:
 static int xperms_to_cil(const av_extended_perms_t *xperms)
 {
 	uint16_t value;
-	uint16_t low_bit;
+	uint16_t low_bit = 0;
 	uint16_t low_value;
 	unsigned int bit;
 	unsigned int in_range = 0;
 	int first = 1;
 
 	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
-		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
+		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
+		&& (xperms->specified != AVTAB_XPERMS_NLMSG))
 		return -1;
 
 	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
@@ -674,6 +675,13 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
 			} else {
 				cil_printf("(range 0x%hx 0x%hx)", value, (uint16_t) (value|0xff));
 			}
+		} else if (xperms->specified & AVTAB_XPERMS_NLMSG) {
+			if (in_range) {
+				cil_printf("(range 0x%hx 0x%hx)", low_bit, (uint16_t) bit);
+				in_range = 0;
+			} else {
+				cil_printf("0x%hx", (uint16_t) bit);
+			}
 		}
 	}
 
@@ -683,7 +691,7 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
 static int avrulex_to_cil(int indent, struct policydb *pdb, uint32_t type, const char *src, const char *tgt, const class_perm_node_t *classperms, const av_extended_perms_t *xperms)
 {
 	int rc = -1;
-	const char *rule;
+	const char *rule, *func;
 	const struct class_perm_node *classperm;
 
 	switch (type) {
@@ -705,10 +713,23 @@ static int avrulex_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 		goto exit;
 	}
 
+	switch (xperms->specified) {
+	case AVRULE_XPERMS_IOCTLDRIVER:
+	case AVRULE_XPERMS_IOCTLFUNCTION:
+		func = "ioctl";
+		break;
+	case AVRULE_XPERMS_NLMSG:
+		func = "nlmsg";
+		break;
+	default:
+		log_err("Unexpected xperm spec for %s, %s, %s: %hhu", rule, src, tgt, xperms->specified);
+		goto exit;
+	}
+
 	for (classperm = classperms; classperm != NULL; classperm = classperm->next) {
 		cil_indent(indent);
 		cil_printf("(%s %s %s (%s %s (", rule, src, tgt,
-			   "ioctl", pdb->p_class_val_to_name[classperm->tclass - 1]);
+			   func, pdb->p_class_val_to_name[classperm->tclass - 1]);
 		xperms_to_cil(xperms);
 		cil_printf(")))\n");
 	}
diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 6826155c..f23cfd17 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -180,6 +180,12 @@ static int process_avtab_datum(uint16_t specified,
 
 			if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
 				return process_xperms(x1->perms, x2->perms);
+		} else if (x1->specified == AVTAB_XPERMS_NLMSG) {
+			if (x2->specified == AVTAB_XPERMS_NLMSG) {
+				if (x1->driver != x2->driver)
+					return 0;
+				return process_xperms(x1->perms, x2->perms);
+			}
 		}
 		return 0;
 	}
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 902c63c5..b5b41f87 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -124,7 +124,7 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 {
 	uint16_t value;
-	uint16_t low_bit;
+	uint16_t low_bit = 0;
 	uint16_t low_value;
 	unsigned int bit;
 	unsigned int in_range = 0;
@@ -135,7 +135,8 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 	p = xpermsbuf;
 
 	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
-		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
+		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)
+		&& (xperms->specified != AVTAB_XPERMS_NLMSG))
 		return NULL;
 
 	len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "ioctl { ");
@@ -173,6 +174,12 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
 			}
 
+		} else if (xperms->specified & AVTAB_XPERMS_NLMSG) {
+			if (in_range) {
+				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_bit, (uint16_t) bit);
+			} else {
+				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx ", (uint16_t) bit);
+			}
 		}
 
 		if (len < 0 || (size_t) len >= (sizeof(xpermsbuf) - xpermslen))
-- 
2.34.0.rc0.344.g81b53c2807-goog

