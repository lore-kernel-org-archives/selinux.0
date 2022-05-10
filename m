Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B28C433F5
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 18:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiEJSYo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiEJSYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 14:24:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1130A31908
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bv19so34624197ejb.6
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBxXl34mzFXGfnMPFXnHl1QU7nCzfGccSj3Qld+7yeg=;
        b=AzDClVB+YPXdrBtEKcrhPsDD1IT3jYT18cAdFUzWrCx1ICQoclaQQuFyQdEuHpsB0M
         3Y3/6YsMgMnK5aN6S8v6xZyivzgKjpUbchDQaV18tGuf9Jqxh8QD3wf4rNZTtP/FW9EE
         9j7iYCYTLlwYRY5UbDJTNul2XIML5xQoVFGR1GrdhGgOq1gmCAqKqafoCV1xyMAnEg5h
         NCZ5PeSEXl37IPTLl0e/MvK+mT0zyOxVnt8qKsJ7DPvqzYh7Q4b9PHtPQOyNr0Xr7gEg
         fDgjKWTTKxyDRbRpG9J28xwY98E2sO5rRLIpzeprtrcwBz6mk8YZB9i2azI5xJIKuDbb
         kRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBxXl34mzFXGfnMPFXnHl1QU7nCzfGccSj3Qld+7yeg=;
        b=cMm/UroP8BYHy6mb8xN1GAf/TysOV5ZOHIMDlcSGj05r1Ma0LIJTrR7xJwnXEeYxH9
         VNqptuIwJ9HvqZQdXbL2PwE41zYGRhge0GsMYrDUuKRsTAP8hvx9CTmvGDul7+Tq8jnI
         B0rAujBCz+HKsK8g2EXzYrcq+SjzWvHnea2as8CJW0cJy8Y3RnPDeRMIj17EtcDXbfko
         ve79xpGP+r6cXSryvh6ruQrvBOa6qFRKixg8fo3ORHI8yAIMRbs0J441YdMflowQbMBQ
         5Hkegl2ZCaiPQR7NsvBNGDspFoN6K6j6P+ykao5mDSq9dpdnhWP/GVS/yFhTDUChbOsq
         T8iQ==
X-Gm-Message-State: AOAM5319ZvZ4JeY4crxkoFB13bz1aReW+mA/h7eIcRoPrTbGEX/Ff+jD
        joyMh6I+D1jAIFeKjP918ns9nS+C/Mw=
X-Google-Smtp-Source: ABdhPJx2a6vkaGW40P8wwOhEgID6/WRJw8RsIfYXJvx4FhG6aJcyCb8Nht0HtBrg0YVKfpLYJUAXSQ==
X-Received: by 2002:a17:906:99c4:b0:6f4:56d2:4bbd with SMTP id s4-20020a17090699c400b006f456d24bbdmr21229365ejn.754.1652206843578;
        Tue, 10 May 2022 11:20:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-078-050-241-079.78.50.pool.telefonica.de. [78.50.241.79])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402154300b0042877d166fdsm5339947edx.38.2022.05.10.11.20.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:20:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/4] libselinux: simplify policy path logic to avoid uninitialized read
Date:   Tue, 10 May 2022 20:20:36 +0200
Message-Id: <20220510182039.28771-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case the function __policy_init() gets called with a NULL pointer,
the stack variable path remains uninitialized (except at its last
index).  If parsing the binary policy fails in sepol_policydb_read() the
error branch would access those uninitialized memory.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index ca38e13c..44a9a341 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -192,25 +192,16 @@ static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args)
 static int __policy_init(const char *init_path)
 {
 	FILE *fp;
-	char path[PATH_MAX];
+	const char *curpolicy;
 	char errormsg[PATH_MAX+1024+20];
 	struct sepol_policy_file *pf = NULL;
 	int rc;
 	unsigned int cnt;
 
-	path[PATH_MAX-1] = '\0';
 	if (init_path) {
-		strncpy(path, init_path, PATH_MAX-1);
-		fp = fopen(path, "re");
-		if (!fp) {
-			snprintf(errormsg, sizeof(errormsg), 
-				 "unable to open %s:  %m\n",
-				 path);
-			PyErr_SetString( PyExc_ValueError, errormsg);
-			return 1;
-		}
+		curpolicy = init_path;
 	} else {
-		const char *curpolicy = selinux_current_policy_path();
+		curpolicy = selinux_current_policy_path();
 		if (!curpolicy) {
 			/* SELinux disabled, must use -p option. */
 			snprintf(errormsg, sizeof(errormsg),
@@ -218,14 +209,15 @@ static int __policy_init(const char *init_path)
 			PyErr_SetString( PyExc_ValueError, errormsg);
 			return 1;
 		}
-		fp = fopen(curpolicy, "re");
-		if (!fp) {
-			snprintf(errormsg, sizeof(errormsg), 
-				 "unable to open %s:  %m\n",
-				 curpolicy);
-			PyErr_SetString( PyExc_ValueError, errormsg);
-			return 1;
-		}
+	}
+
+	fp = fopen(curpolicy, "re");
+	if (!fp) {
+		snprintf(errormsg, sizeof(errormsg),
+			 "unable to open %s:  %m\n",
+			 curpolicy);
+		PyErr_SetString( PyExc_ValueError, errormsg);
+		return 1;
 	}
 
 	avc = calloc(sizeof(struct avc_t), 1);
@@ -249,7 +241,7 @@ static int __policy_init(const char *init_path)
 	sepol_policy_file_set_fp(pf, fp);	
 	if (sepol_policydb_read(avc->policydb, pf)) {
 		snprintf(errormsg, sizeof(errormsg), 
-			 "invalid binary policy %s\n", path);
+			 "invalid binary policy %s\n", curpolicy);
 		PyErr_SetString( PyExc_ValueError, errormsg);
 		fclose(fp);
 		return 1;
-- 
2.36.1

