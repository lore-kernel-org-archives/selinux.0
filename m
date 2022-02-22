Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A68AC433F5
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiBVNwR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBVNwP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:52:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C6C92D04
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:49 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s24so30650967edr.5
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=90zIJFuO45nVeH8CSv4OBlOjfOhXslmHI+dWeJ272lU=;
        b=JN/6mUVjbrNnPWgfPL0mo4CKEBEZm+3cQMmjIJHAKXS33FDXohNbzOo0M1PhI01B1X
         EbRNJrtoHXdXzF1nBH2ulLyoC2g6yVDfIEVduZVu7UoNP5Bir+9FNXqfyjI0iRn2eszB
         PVBd9tq4d7Z0CprAg7KJjotc3EWTl/ATltMv/xtbosDmZbaIbzw6vMVZTlSVPFhGfMmq
         qocFEr/owCuaxViDVVsmpRpdIK0j9vl9LrY04VcgDUPhaWqBNzSCIZvStNH25Ue97lMM
         2K3RKkN6GG8HNq+al8ekAHB/TyxJuiWm/ufeeMOlujLix529tYYUWjCgPExev43F/9ZL
         degA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90zIJFuO45nVeH8CSv4OBlOjfOhXslmHI+dWeJ272lU=;
        b=gqnDHu9OyCbOAC1zVJ0lY4UXa24lVMogPHaEZr1o4WLWggAKbz/RWch0aEvc1aJBew
         yuwPB63ks8Sfg1V5Ku43f/0e7tmXpjJSbpe0H03u1mygV8daVMRb1qhfjbGyIeRggycA
         8OTI50cDWoZ2UBuTtiwEgJzCBnAMJdA0QiGKFmg7sUiek5XkOYQjDd1Ksqdsj6yNGE+p
         d0+4LAG/LUUw3Gyc5tpbVHnudJEmalDdtR+oyyoPEX2HDyRDTL8l/V0p98xpOgWNm/A4
         7SnMJa0sk4Ic1yE2VJPeu0atlLAffc64R7fSJeN9jMjNx7CrQI9kGN3S1agm8KHi2W52
         1peA==
X-Gm-Message-State: AOAM531sEiZekAfkzF1ov7BC/GNBIilhDtrbgbrrgU7SE623pYrB181i
        5DboDSLRtgG0UQMq3w+DB5v0GbL1Xc4=
X-Google-Smtp-Source: ABdhPJxJ3U3MwnOlmhqGDA1RGEKb5boyvXaq7iHikJ9dbFy9FCPC/11aIrBhmwDypDQKyUYGOr+PtA==
X-Received: by 2002:a05:6402:520a:b0:412:8361:d11e with SMTP id s10-20020a056402520a00b004128361d11emr26265244edd.190.1645537907877;
        Tue, 22 Feb 2022 05:51:47 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id eg42sm8266916edb.79.2022.02.22.05.51.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:51:47 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] newrole: silence compiler warnings
Date:   Tue, 22 Feb 2022 14:51:41 +0100
Message-Id: <20220222135143.30602-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222135143.30602-1-cgzones@googlemail.com>
References: <20220222135143.30602-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    newrole.c:636:12: warning: function declaration isn’t a prototype [-Wstrict-prototypes]
      636 | static int transition_to_caller_uid()
          |            ^~~~~~~~~~~~~~~~~~~~~~~~

    newrole.c:103:9: warning: macro is not used [-Wunused-macros]
    #define DEFAULT_CONTEXT_SIZE 255        /* first guess at context size */
            ^

    newrole.c:862:4: warning: 'break' will never be executed [-Wunreachable-code-break]
                            break;
                            ^~~~~

    newrole.c:168:13: warning: no previous extern declaration for non-static variable 'service_name' [-Wmissing-variable-declarations]
    const char *service_name = "newrole";
                ^

    hashtab.c:53:11: warning: implicit conversion changes signedness: 'unsigned int' to 'int' [-Wsign-conversion]
            hvalue = h->hash_value(h, key);
                   ~ ^~~~~~~~~~~~~~~~~~~~~
    hashtab.c:92:11: warning: implicit conversion changes signedness: 'unsigned int' to 'int' [-Wsign-conversion]
            hvalue = h->hash_value(h, key);
                   ~ ^~~~~~~~~~~~~~~~~~~~~
    hashtab.c:124:11: warning: implicit conversion changes signedness: 'unsigned int' to 'int' [-Wsign-conversion]
            hvalue = h->hash_value(h, key);
                   ~ ^~~~~~~~~~~~~~~~~~~~~
    hashtab.c:172:10: warning: implicit conversion changes signedness: 'int' to 'unsigned int' [-Wsign-conversion]
                            ret = apply(cur->key, cur->datum, args);
                                ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    hashtab.c:174:12: warning: implicit conversion changes signedness: 'unsigned int' to 'int' [-Wsign-conversion]
                                    return ret;
                                    ~~~~~~ ^~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/hashtab.c |  9 +++++----
 policycoreutils/newrole/newrole.c | 15 ++++++---------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/policycoreutils/newrole/hashtab.c b/policycoreutils/newrole/hashtab.c
index bc502836..26d4f4c7 100644
--- a/policycoreutils/newrole/hashtab.c
+++ b/policycoreutils/newrole/hashtab.c
@@ -44,7 +44,7 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 
 int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
 {
-	int hvalue;
+	unsigned int hvalue;
 	hashtab_ptr_t prev, cur, newnode;
 
 	if (!h)
@@ -83,7 +83,7 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 		   void (*destroy) (hashtab_key_t k,
 				    hashtab_datum_t d, void *args), void *args)
 {
-	int hvalue;
+	unsigned int hvalue;
 	hashtab_ptr_t cur, last;
 
 	if (!h)
@@ -115,7 +115,7 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 {
 
-	int hvalue;
+	unsigned int hvalue;
 	hashtab_ptr_t cur;
 
 	if (!h)
@@ -160,8 +160,9 @@ int hashtab_map(hashtab_t h,
 		int (*apply) (hashtab_key_t k,
 			      hashtab_datum_t d, void *args), void *args)
 {
-	unsigned int i, ret;
+	unsigned int i;
 	hashtab_ptr_t cur;
+	int ret;
 
 	if (!h)
 		return HASHTAB_SUCCESS;
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 9d68b6ab..c9989863 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -100,7 +100,6 @@
 #endif
 
 #define DEFAULT_PATH "/usr/bin:/bin"
-#define DEFAULT_CONTEXT_SIZE 255	/* first guess at context size */
 
 extern char **environ;
 
@@ -115,7 +114,7 @@ extern char **environ;
  *
  * Returns malloc'd memory
  */
-static char *build_new_range(char *newlevel, const char *range)
+static char *build_new_range(const char *newlevel, const char *range)
 {
 	char *newrangep = NULL;
 	const char *tmpptr;
@@ -166,7 +165,7 @@ static char *build_new_range(char *newlevel, const char *range)
 #include <security/pam_appl.h>	/* for PAM functions */
 #include <security/pam_misc.h>	/* for misc_conv PAM utility function */
 
-const char *service_name = "newrole";
+static const char *service_name = "newrole";
 
 /* authenticate_via_pam()
  *
@@ -230,14 +229,13 @@ static int free_hashtab_entry(hashtab_key_t key, hashtab_datum_t d,
 
 static unsigned int reqsymhash(hashtab_t h, const_hashtab_key_t key)
 {
-	char *p, *keyp;
+	const char *p;
 	size_t size;
 	unsigned int val;
 
 	val = 0;
-	keyp = (char *)key;
-	size = strlen(keyp);
-	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
+	size = strlen(key);
+	for (p = key; ((size_t) (p - key)) < size; p++)
 		val =
 		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
 	return val & (h->size - 1);
@@ -623,7 +621,7 @@ static inline int drop_capabilities(__attribute__ ((__unused__)) int full)
  * This function will set the uid values to be that of caller's uid, and
  * will drop any privilege which may have been raised.
  */
-static int transition_to_caller_uid()
+static int transition_to_caller_uid(void)
 {
 	uid_t uid = getuid();
 
@@ -850,7 +848,6 @@ static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
 		case 'V':
 			printf("newrole: %s version %s\n", PACKAGE, VERSION);
 			exit(0);
-			break;
 		case 'p':
 			*preserve_environment = 1;
 			break;
-- 
2.35.1

