Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5237BE75
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680880; cv=none; b=Lkhpywclkh8S88bqd8YL18j5tocKpn/1Zia0jmnwuCvK/H8Fji2gegMQqkoar7bNeTJz4xH0WV+zIgbB6x/Bzotlk3b1qYs1M0tPTuJkwWUoKqwJ6PIEwSaF647+kQAbRxso/IG9Kc6EwzZZ2jX3FFbrYetWquX6opGPDgh9/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680880; c=relaxed/simple;
	bh=KgaZDSOjP9qfKejYqGNExib9PBJkw8/isBHlR4kdKgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIpTkm8ypHlM1JMbXDzZVB0UX6CcrrCsSXjnw18U3LbL63flx2QC2fe/DrxnJ04ix3V31N4mgrX9lT8Rof4Ik1O1ppVwzJccKZ3uU6nTaC60mf/JUUBjW7JuIS6A43HWIIu6eGEI5B185F5/bFl6/F+DRzlPdtsOaYlku6q2OH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pei4JksT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pei4JksT"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ce9d444173so26355896d6.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780680876; x=1781285676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoUS6hoMZFxJCrSAt+VbnZRG9VME5AIc1aW81XrkQJo=;
        b=Pei4JksTC8clZDzv8oJOolPkZ4QNyxbC7+lC7yJuD+IBRlbTs2PBHmeLDRal2iPaRp
         tskWjUpzRkmYQU+Tp4+TYxlpIw0pDmY175kLyE2utmSqWL5MWEz6jriF4ZR6dXRcs+Y9
         LaD48bi7aDLRSLLQ0IhxqIvgAlkgZOLOz6sy87V9U/JpZWDk0ZQ/GA+Bq+WOaBjCE+R7
         6uoxlvharClN3U/pgYlW7e3abJhTqIeWCzHTmm0TF8JJ7P2CijspQqbBlTrs7i2mxyw+
         ZWvF3SEDy4lHFi9QaeMMHibybbAjo7hUcHD76Jl7RIelnBb/Jeukl1Bt1Y2UuAhyiTTA
         jIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780680876; x=1781285676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoUS6hoMZFxJCrSAt+VbnZRG9VME5AIc1aW81XrkQJo=;
        b=UzEylwEQ2nwEGqv6AY0ocWXJjBSbQhYI1pLM1LS5mxEPT/VoAHENc7W4NtHASi2ij9
         r68YLfPgYHWOJx9bMrnSi5MCgfLnvTXxSizmaWokXRRvXs/x3aWN+E7a5/CBeOYVTz/0
         3qJ+Efof8pS3druph1UQglAiQWdi7Pz5ESRCYYZ+NnsdDvG5rknS4sdBJSJnTtUD6Pwi
         mi+6by4FWrRRj45A0W32/3SnMb0L27ICE7HGPhsebMH5et6lVfHFUECoCx1xpyZ/wvwR
         0adM1hJb79+pFk6fKu9WMu4AkHJfNX3TXbjjqkTfmVnaVAJB6DI0KnL+3O3YUGla41RA
         f9DQ==
X-Gm-Message-State: AOJu0YzIPzPrQOIpO1GSq5PMmre0RasOl3UlUOFMd8NZdsmAFbUvtDo7
	lRSqNuBTWrreucpL30cC81wSpJrQQ7yPztj/VS00mGThxDcXD8Ff0OT1g2INtA==
X-Gm-Gg: Acq92OFJU1wFU3gG8q41/4eEXWLEeT1cYXMSkW0a/r8pAQ/cAAp8Ebc7K4/oSeTCo0o
	v8MxMasCo6IXQO7gGRGC3swbom4p+ttKNGrrAe6r4DDHx7xYa4P1b/ZJibKXLix6sUqSyd7o5Xs
	r1dVDDvX+PYOurAYBjxF9NkOh/3lKme2wyMYRExIGDGsyLYr8yVu7eXdxx1/h5sPnzy51IK/Et3
	P9zvNORw9piu2+o5V01uDQSJmqd8W1iC4t3WhAVxV1/PWW5JTEUo9tfErnO9vV1woEED34ys9nv
	E9ZqQqHfQaeADy2qV3oxy1wGzHWM5s1JozGyrHeFCrjz5aeGBjeZn5grtSSp1SqYNPUuzFwZHq+
	se3mgaSaivShfmGAcKRqURH60d63i7v2jriC66gapqXLkHAIndwCXHF7B5C6OSe9gr7Vx6CXJV7
	zu0gKLzzyJwtvxHNKIJsrowbmSXPcrXQS9DYsgI4ubxzJaNHTau3GXQtt8ObsYa3xsMAw7SeL/p
	F743BHU4hP5/UHGPTDZK/tX5P83339Orl2yag==
X-Received: by 2002:a05:6214:124c:b0:8cc:ed49:bdc9 with SMTP id 6a1803df08f44-8cee5f95e0bmr82746906d6.5.1780680876332;
        Fri, 05 Jun 2026 10:34:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06f5eesm89018966d6.37.2026.06.05.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:34:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] checkpolicy: drop fscon statement support
Date: Fri,  5 Jun 2026 13:34:21 -0400
Message-ID: <20260605173421.279607-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fscon statements predate the upstreaming of SELinux and were never
used in any mainline Linux kernel version to my knowledge. CIL never
appears to have supported them so they are "lost" on conversion to
CIL. The kernel still accepts the entries in the binary policy but
doesn't use them for anything. This has come up previously but never
been addressed and given that there is a potential heap buffer
overflow in define_fs_context(), let's just get rid of checkpolicy
fscon support altogether.

Link: https://lore.kernel.org/selinux/CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com/
Link: https://lore.kernel.org/selinux/CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com/
Fixes: https://github.com/SELinuxProject/selinux/pull/518

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.dict  |  1 -
 checkpolicy/policy_define.c               | 60 -----------------------
 checkpolicy/policy_define.h               |  1 -
 checkpolicy/policy_parse.y                | 13 +----
 checkpolicy/policy_scan.l                 |  2 -
 checkpolicy/tests/policy_allonce.conf     |  2 -
 checkpolicy/tests/policy_allonce_mls.conf |  2 -
 7 files changed, 2 insertions(+), 79 deletions(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.dict b/checkpolicy/fuzz/checkpolicy-fuzzer.dict
index fb7e66c0..80f92c8e 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.dict
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.dict
@@ -61,7 +61,6 @@
 "dom"
 "domby"
 "incomp"
-"fscon"
 "ibpkeycon"
 "ibendportcon"
 "portcon"
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7be7b21a..e36b97c9 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4871,66 +4871,6 @@ int define_initial_sid_context(void)
 	return 0;
 }
 
-int define_fs_context(unsigned int major, unsigned int minor)
-{
-	ocontext_t *newc, *c, *head;
-
-	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
-		yyerror("fscon not supported for target");
-		return -1;
-	}
-
-	if (pass == 1) {
-		parse_security_context(NULL);
-		parse_security_context(NULL);
-		return 0;
-	}
-
-	newc = calloc(1, sizeof(ocontext_t));
-	if (!newc) {
-		yyerror("out of memory");
-		return -1;
-	}
-
-	newc->u.name = malloc(6);
-	if (!newc->u.name) {
-		yyerror("out of memory");
-		free(newc);
-		return -1;
-	}
-	sprintf(newc->u.name, "%02x:%02x", major, minor);
-
-	if (parse_security_context(&newc->context[0])) {
-		free(newc->u.name);
-		free(newc);
-		return -1;
-	}
-	if (parse_security_context(&newc->context[1])) {
-		context_destroy(&newc->context[0]);
-		free(newc->u.name);
-		free(newc);
-		return -1;
-	}
-	head = policydbp->ocontexts[OCON_FS];
-
-	for (c = head; c; c = c->next) {
-		if (!strcmp(newc->u.name, c->u.name)) {
-			yyerror2("duplicate entry for file system %s",
-				 newc->u.name);
-			context_destroy(&newc->context[0]);
-			context_destroy(&newc->context[1]);
-			free(newc->u.name);
-			free(newc);
-			return -1;
-		}
-	}
-
-	newc->next = head;
-	policydbp->ocontexts[OCON_FS] = newc;
-
-	return 0;
-}
-
 int define_pirq_context(unsigned int pirq)
 {
 	ocontext_t *newc, *c, *l, *head;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 6e1788a2..55292464 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -33,7 +33,6 @@ int define_compute_type(int which);
 int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_list);
 int define_constraint(constraint_expr_t *expr);
 int define_dominance(void);
-int define_fs_context(unsigned int major, unsigned int minor);
 int define_fs_use(int behavior);
 int define_genfs_context(int has_type);
 int define_initial_sid_context(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 0089e541..27e52d05 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -132,7 +132,7 @@ typedef int (* require_func_t)(int pass);
 %token SOURCE
 %token TARGET
 %token SAMEUSER
-%token FSCON PORTCON NETIFCON NODECON 
+%token PORTCON NETIFCON NODECON
 %token IBPKEYCON
 %token IBENDPORTCON
 %token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON DEVICETREECON
@@ -175,7 +175,7 @@ base_policy             : { if (define_policy(pass, 0) == -1) YYABORT; }
 			  opt_default_rules opt_mls te_rbac users opt_constraints 
                          { if (pass == 1) { if (policydb_index_bools(policydbp)) YYABORT; }
 			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) YYABORT; }}
-			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts opt_ibendport_contexts
+			  initial_sid_contexts opt_fs_uses opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts opt_ibendport_contexts
 			;
 classes			: class_def 
 			| classes class_def
@@ -703,15 +703,6 @@ pci_context_def  	: PCIDEVICECON number security_context_def
 dtree_context_def	: DEVICETREECON path security_context_def
 		        {if (define_devicetree_context()) YYABORT;}
 		        ;
-opt_fs_contexts         : fs_contexts 
-                        |
-                        ;
-fs_contexts		: fs_context_def
-			| fs_contexts fs_context_def
-			;
-fs_context_def		: FSCON number number security_context_def security_context_def
-			{if (define_fs_context($2,$3)) YYABORT;}
-			;
 net_contexts		: opt_port_contexts opt_netif_contexts opt_node_contexts
 			;
 opt_port_contexts       : port_contexts
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 8f9d73d6..6e59e9db 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -211,8 +211,6 @@ domby |
 DOMBY				{ return(DOMBY);}
 INCOMP |
 incomp				{ return(INCOMP);}
-fscon |
-FSCON                           { return(FSCON);}
 ibpkeycon |
 IBPKEYCON			{ return(IBPKEYCON);}
 ibendportcon |
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 5e09f74b..4115dea2 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -67,8 +67,6 @@ constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 validatetrans CLASS2 sameuser and t3 == ATTR1;
 sid kernel USER1:ROLE1:TYPE1
 sid unlabeled USER1:ROLE1:TYPE1
-# fscon statements are not dumped
-fscon 2 3 USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 fs_use_xattr btrfs USER1:ROLE1:TYPE1;
 fs_use_trans devpts USER1:ROLE1:TYPE1;
 fs_use_task pipefs USER1:ROLE1:TYPE1;
diff --git a/checkpolicy/tests/policy_allonce_mls.conf b/checkpolicy/tests/policy_allonce_mls.conf
index fa182906..fb742086 100644
--- a/checkpolicy/tests/policy_allonce_mls.conf
+++ b/checkpolicy/tests/policy_allonce_mls.conf
@@ -71,8 +71,6 @@ constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
 # sameuser will be turned into (u1 == u2)
 validatetrans CLASS2 sameuser and t3 == ATTR1;
 sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0.c1
-# fscon statements are not dumped
-fscon 2 3 USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
 fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0.CATALIAS;
 fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
 fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
-- 
2.54.0

