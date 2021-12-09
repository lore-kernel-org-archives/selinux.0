Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019CC433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhLIQ4M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhLIQ4L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6EC0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so21073334edq.7
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VeRmAuCub5fuZp0iMHv1yhOPR2CxmZfxobeuGOyK8+c=;
        b=Vn9je/G6/EZioOxvIBp8klbTwc1TwtNIj4h6KBH9EnZwANA/9HjdUz7z1zbO2SdUNq
         CFHyULjZPkxkLy+vhAST3Hhuv571LC2uhZIC7U5jcgU6vX9OLEq/tTpgwEnyeatvDhwh
         DtbDAuiI3kofgzpo+sM/XG/soQKxtt8ZF8V/8GQyUgAK/0qmqyfaBBR9+YOxYKLS5c6n
         jXBPq8vHppr+/5Es7WMMrYL2u81Wq1OvmEfKz8BeqERxxRUra5OCdSm0bv/d8KCv2oYp
         RdXE6Mx7lPnd2qpPU8M6cjrfWI+GT3MnjwTWZ2m9j236V1oxOZJosZjiZ3+O+EwbOXha
         nPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeRmAuCub5fuZp0iMHv1yhOPR2CxmZfxobeuGOyK8+c=;
        b=fNEinyjHPvZvJ7/UBQnsvran+MXfaLrWhFhe46Z3tFXNP986aGN6gzlEV9iut6wjDj
         Q+Xt44caE3/cKQHF5k/AQenMhQIdjoKFkPHSzjhtDw9Egnua/gY40Bp7rSwAgnfnSrFK
         R6qSOHuSEFmB3dSucmGN9cAJZriavk3ZO8n2QFt7J/rLzy5qoNlclm5Ktz7UyU9af9R/
         TauRizjdAdIBF3tn/iE0/QoV3bQ6zPWBpkw9AfNwxmprdZaZOXUDwjOW+NKJjCWWB3Fi
         eARhAORQ0gWcasqinqRwh3XeRDhugPixO3BWsvpAc5Rbn6u121Cm7NZrSABaCvW8Bwgm
         ypUA==
X-Gm-Message-State: AOAM5320FnZ5pMWsFAZ5UL18ot1mOH3kl0nFSjiansh6+M7W77LhyEIh
        WC9l7dHKJPSJlH7WP25aOD/p1lumDTM=
X-Google-Smtp-Source: ABdhPJxv/diGCDb3KllxC4tgbTsjf/KjnCKsjKcvbKjzAWShRVuNrXnQ2W+IDDzYt8tpBWDEJWeAbg==
X-Received: by 2002:a50:d74e:: with SMTP id i14mr29947942edj.243.1639068595603;
        Thu, 09 Dec 2021 08:49:55 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:55 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 30/36] libsepol: validate ocontexts
Date:   Thu,  9 Dec 2021 17:49:22 +0100
Message-Id: <20211209164928.87459-31-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the literal contexts in ocontext statements are defined.

    ==91274==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x7f60b0afe8c6 bp 0x7ffd42edc990 sp 0x7ffd42edc148 T0)
    ==91274==The signal is caused by a READ memory access.
    ==91274==Hint: address points to the zero page.
        #0 0x7f60b0afe8c6  string/../sysdeps/x86_64/multiarch/../strlen.S:120
        #1 0x4bd128 in __interceptor_strlen (./out/binpolicy-fuzzer+0x4bd128)
        #2 0x5eb387 in create_str_helper ./libsepol/src/kernel_to_common.c:69:10
        #3 0x5eb11e in create_str ./libsepol/src/kernel_to_common.c:99:8
        #4 0x56ad7b in context_to_str ./libsepol/src/kernel_to_conf.c:2408:9
        #5 0x56a717 in write_sid_context_rules_to_conf ./libsepol/src/kernel_to_conf.c:2441:9
        #6 0x55b26c in write_selinux_isid_rules_to_conf ./libsepol/src/kernel_to_conf.c:2476:9
        #7 0x55b26c in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3206:8
        #8 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #9 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #10 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #11 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #12 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #13 0x7f60b0a887ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #14 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v3:
   only check FS and NETIF ocons in selinux policies (not xen)
v2:
   also check in base modules
---
 libsepol/src/policydb_validate.c | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 57eb2550..bedf3b90 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -736,6 +736,49 @@ static int validate_filename_trans_hashtab(sepol_handle_t *handle, hashtab_t fil
 	return 0;
 }
 
+static int validate_context(context_struct_t *con, validate_t flavors[], int mls)
+{
+	if (validate_value(con->user, &flavors[SYM_USERS]))
+		return -1;
+	if (validate_value(con->role, &flavors[SYM_ROLES]))
+		return -1;
+	if (validate_value(con->type, &flavors[SYM_TYPES]))
+		return -1;
+	if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		return -1;
+
+	return 0;
+}
+
+static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	ocontext_t *octx;
+	unsigned int i;
+
+	for (i = 0; i < OCON_NUM; i++) {
+		for (octx = p->ocontexts[i]; octx; octx = octx->next) {
+			if (validate_context(&octx->context[0], flavors, p->mls))
+				goto bad;
+
+			if (p->target_platform == SEPOL_TARGET_SELINUX) {
+				switch (i) {
+				case OCON_FS:
+				case OCON_NETIF:
+					if (validate_context(&octx->context[1], flavors, p->mls))
+						goto bad;
+					break;
+				}
+			}
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid ocontext");
+	return -1;
+}
+
 /*
  * Functions to validate a module policydb
  */
@@ -936,6 +979,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 			goto bad;
 	}
 
+	if (validate_ocontexts(handle, p, flavors))
+		goto bad;
+
 	if (validate_scopes(handle, p->scope, p->global))
 		goto bad;
 
-- 
2.34.1

