Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3622CC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D69761108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhKEPsy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhKEPsr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644FBC06120F
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m14so33820726edd.0
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cLA1/U6XziBz1FJ6AcM0NZKdpo+L/CFD2Wbacs5se8g=;
        b=G8t5sDTR5lnUdSggofmUJcn/BPpvPLqv1umjHpDlzCDdBaAatD/Kuxsc7NtWTyCFu+
         8I8yfp8iRFMeOrchffVwnjFpTuDOFYv51L3klgEZPR76zzOIyMSCL7DavSXB/+mrfgYp
         i5hLmqBSs0fUlFaI/AH8W6k0CWPKxliC2bIpolwQJLRbbrP/30LhqeHLKr+AKkSPZr7L
         JIqdowxMaOCigsVHZt94B3wZYJQylsG8V6aQWPXvwX9n0Vi+Lp8angi2Zsv7yaCtBvGT
         pwBNLF5UEPtgiT5rylvRRZ99knpEaoasW4StJxGRq+4QR9kh/ukmcqKkoV6fw6M3n/K0
         yvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLA1/U6XziBz1FJ6AcM0NZKdpo+L/CFD2Wbacs5se8g=;
        b=5atf4ptEOZMmMmP7cszdvB5aOAIXtS0U7kpcmpcEj/Q5zJDpfQktPJkkM04u0M2C+K
         J7e0HWy58lXxyV4eHnwVrRWgfgeDtZ4caqRBW/Onx9lFDrc56JZD/xaCoP1M42HNtCA0
         9OZoeBOfbYu1E0DYL/1YOJxixon1G7ui1kOF3ATmpSVZTEYHY5ARRfPyMRzb+8nEKUdI
         VhM/yj1C8WXumfzaRvRsYgJlhenhFERNNnE067BiD0IE90Y01lIB9o+f4Su077je91d9
         PlYvCCjwARAmZBY1F9a+BKnSddQXt2dx2nVVCl5B+w2ipht2Dc/qcK4uslqTVT9P0aSM
         58ew==
X-Gm-Message-State: AOAM5307yf49T7nue/PkGXTr8Mz+PzijHGKSq+n1KTKrjwvT2koK6AtA
        MIhdTTgSt4mCAvFb2s4vQNx4O4/z4YI=
X-Google-Smtp-Source: ABdhPJwVfnPC3d8ByzamLkr+f44iQIsd3m0ssAR7U4dC91VlHo3klNH+UrjVtYEu3fegi6zBhjgXMQ==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr24173570edc.328.1636127164993;
        Fri, 05 Nov 2021 08:46:04 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 30/36] libsepol: validate ocontexts
Date:   Fri,  5 Nov 2021 16:45:32 +0100
Message-Id: <20211105154542.38434-31-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
v2:
   also check in base modules

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 57eb2550..96f133c9 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -736,6 +736,47 @@ static int validate_filename_trans_hashtab(sepol_handle_t *handle, hashtab_t fil
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
+			switch (i) {
+			case OCON_FS:
+			case OCON_NETIF:
+				if (validate_context(&octx->context[1], flavors, p->mls))
+					goto bad;
+				break;
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
@@ -936,6 +977,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 			goto bad;
 	}
 
+	if (validate_ocontexts(handle, p, flavors))
+		goto bad;
+
 	if (validate_scopes(handle, p->scope, p->global))
 		goto bad;
 
-- 
2.33.1

