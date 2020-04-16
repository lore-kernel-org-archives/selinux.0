Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44127C2BB85
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2374720732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJl8yAag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395504AbgDPPoj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442510AbgDPPog (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81CFC061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c138so1852312pfc.0
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6g4lTpDJfVXb819MiCId1J60ZYOsQkaUzZp2uDWfNMA=;
        b=sJl8yAagBYU+K8Nf3LrprOYxUYCs6NAAenRQT8rDoKSPWmMTbcegrWMPO2jjNiyzpI
         4HxXgGCk/0fhSo7wBGjXWCBplXWwNDZ4YNav5q8Dwis+jmyz7Bu4qp8uAY/aF7I+k0lG
         82cSjozzGE2wxL7s+2CPkUXrQfoTGM+UjDfE3o0Xbk50tLgqWQw7BoQ338gzREstmytB
         evzjYXYhrciw4qdnzauMtKunXom1wK09JlP+7/VvHVYQJkrCN+15e62Ih6R80vJE4llW
         fP94xr15nLQaF3O2/QV/wHsTgCiwtK5llCXt+plWgh1lK5S5iYKDtfC8i1dyqycyfplw
         E9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6g4lTpDJfVXb819MiCId1J60ZYOsQkaUzZp2uDWfNMA=;
        b=A1Oc8B0gqLTSk43t1dSvCeJ5S6Z3sWcE9mGiNH1Qj9dH8tIz/Obbb8gyzA1BRk55mg
         PN26iCowdrXrP4EQ2EEjnRVkJYEIshZntIYCLXXhcw3woqVSScd6D8yFuaun+Rucpj7e
         5pvFXOUOZljEUbM4nthdXsIsIRoBKcaH5Fc9e2uIK7ehQYlWZ/gaKoHhml+5DoNzw/Rg
         uXfYbwCQloUQSpyN5HY9iAJ70MsAl4ukns4iuIyk3IROcTrYQ3XdZ1+oIPjCdTr7qgSD
         b4nGxUSMBTOHzXS8QRvCfmZDvDZdEjsNF3mSpovClfK7Kk6+GVriLa3sgwhc2mTLqf9s
         5mVA==
X-Gm-Message-State: AGi0PuY9NGTwtLgdEplAtPXnk2fmNgL2WGN668FcqwDB7sca4wBayFx9
        Zl2kyTGJty10glyioLHlgQM=
X-Google-Smtp-Source: APiQypIjh0MFrXKDmfdrCPQvfAiFFdU93RnF3eYTy5AMVEi3le9L3F2QIao2w3rvQ5OQEXLZyzMKIw==
X-Received: by 2002:aa7:9515:: with SMTP id b21mr12245582pfp.226.1587051875271;
        Thu, 16 Apr 2020 08:44:35 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:34 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 17/18] utils: matchpathcon to use interal interfaces
Date:   Thu, 16 Apr 2020 10:43:51 -0500
Message-Id: <20200416154352.21619-18-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Not that the matchpathcon library interfaces are deprecated,
matchpathcon needs to use the 2 variants and statically link.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/matchpathcon.c          | 6 +++++-
 libselinux/src/matchpathcon_internal.h | 2 ++
 libselinux/utils/Makefile              | 6 ++++++
 libselinux/utils/matchpathcon.c        | 9 ++++++---
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 88539e627f5d..d71e792c3f8e 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -352,10 +352,14 @@ int matchpathcon_init_prefix(const char *path, const char *subset)
 	return hnd ? 0 : -1;
 }
 
+int matchpathcon_init2(const char *path)
+{
+	return matchpathcon_init_prefix(path, NULL);
+}
 
 int matchpathcon_init(const char *path)
 {
-	return matchpathcon_init_prefix(path, NULL);
+	return matchpathcon_init2(path);
 }
 
 void matchpathcon_fini2(void)
diff --git a/libselinux/src/matchpathcon_internal.h b/libselinux/src/matchpathcon_internal.h
index c63bcecfec89..73f0c78fc9d0 100644
--- a/libselinux/src/matchpathcon_internal.h
+++ b/libselinux/src/matchpathcon_internal.h
@@ -1,6 +1,8 @@
 #ifndef SRC_MATCHPATHCON_INTERNAL_H_
 #define SRC_MATCHPATHCON_INTERNAL_H_
 
+int matchpathcon_init2(const char *path);
+
 void matchpathcon_fini2(void);
 
 int matchpathcon2(const char *path, mode_t mode, char ** con);
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index a5632b7c38ec..5f16ab957610 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -58,6 +58,12 @@ sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol
 
 sefcontext_compile: sefcontext_compile.o ../src/regex.o
 
+matchpathcon: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a
+
+matchpathcon: CFLAGS += -I../src
+
+matchpathcon: matchpathcon.o ../src/regex.o
+
 all: $(TARGETS)
 
 install: all
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index eb39a1881066..3d94af365071 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -11,6 +11,9 @@
 #include <limits.h>
 #include <stdlib.h>
 
+#include "matchpathcon_internal.h"
+
+
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
@@ -22,7 +25,7 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 static int printmatchpathcon(const char *path, int header, int mode)
 {
 	char *buf;
-	int rc = matchpathcon(path, mode, &buf);
+	int rc = matchpathcon2(path, mode, &buf);
 	if (rc < 0) {
 		if (errno == ENOENT) {
 			buf = strdup("<<none>>");
@@ -103,7 +106,7 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			init = 1;
-			if (matchpathcon_init(optarg)) {
+			if (matchpathcon_init2(optarg)) {
 				fprintf(stderr,
 					"Error while processing %s:  %s\n",
 					optarg,
@@ -195,6 +198,6 @@ int main(int argc, char **argv)
 			error |= printmatchpathcon(path, header, mode);
 		}
 	}
-	matchpathcon_fini();
+	matchpathcon_fini2();
 	return error;
 }
-- 
2.17.1

