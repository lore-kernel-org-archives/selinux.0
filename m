Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FFBEB64DC
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjGNSul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjGNSuk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:50:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224830E5
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:50:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e011f45ffso277746466b.3
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689360636; x=1691952636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u58iDhGZHJf8SeTJ2/k/0W5bUMZY/Jx2TceCHLNaosg=;
        b=QS/A50X0OtZzhQDegXJw1qzeKT9hW66FZ3CFEQ/4hQe4LFMW2c6Xeh6RsBlOOBfq+a
         3fMVI9kkufYw5DXfYP7YM/bkgukvHmOJmIqShm2loTLLc4ygRz1Yp9JPGf50enQmcnlE
         0oF54VpMFcy6Xk4EijZWRotQy06Anr9/gAzUPTEzHCmL9IQ9zR0ajETx7PRR5iziVWdc
         JZSZSlvJeZfpIOY8NBazkLzQcT6fl81kepPnyaKjneUUJSM0nbugfGipuknQDgqdOQGe
         os3uXYjJCKRUoEwTnWeynpeHRudbjtY9DkmaCk2Yu6V2SsadxQyisGumuTA+aqdbXu2d
         JFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360636; x=1691952636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u58iDhGZHJf8SeTJ2/k/0W5bUMZY/Jx2TceCHLNaosg=;
        b=XfAPsPs6jaI+ZGU+qWeSgwDqwzG1cJIg6644DqM0cKNDpccf+JqUmAsNnTEa2n7O0m
         nTGoLwsDTtUoIHtJNtT4gIOxkYYrLEGgYmA5oqRx+EQ50jDS/FExLyaY4ptg0aAWYoDN
         iMUYMVVxyOdNBURxjVAyqFSb5mjMzqBAqs4Hgje1dSwf4BQyQ2fNne5XyxIwniI3RgmE
         zsVeQcdzWDtc7W/cVOMCNZnAbSbFYLKChT212VG/fkJ6cnL9LTjMtzmqYcB6ixVLuOXU
         9Cuhydu5xWbojEcuc8AjKKfDPqGOT/mpcHKrF2/SvdvKN8KbvW/Szhtnxvqb4NsI+gkQ
         L+yg==
X-Gm-Message-State: ABy/qLbb3aFHHElEkAD24JMcqCSTfDPh/6eUqFoAWrtxG+iTe1u3p51z
        /x4tJsE1qISavhKFPV/F1586tfWEeXA3Cg==
X-Google-Smtp-Source: APBJJlHMlmjHWFhwm0jt2h122yzDLKWqJyakjGgunEDG6I+qoXZSXW+WxuL9SA/FqX3l0V6ID0iUFw==
X-Received: by 2002:a17:906:289:b0:993:d536:3cb8 with SMTP id 9-20020a170906028900b00993d5363cb8mr4951897ejf.2.1689360636093;
        Fri, 14 Jul 2023 11:50:36 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id lf15-20020a170907174f00b00992025654c4sm5711715ejc.182.2023.07.14.11.50.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:50:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux/utils: introduce getpolicyload
Date:   Fri, 14 Jul 2023 20:50:33 +0200
Message-Id: <20230714185033.45471-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Introduce a helper binary to print the number of policy reloads on the
running system.
Print only a single number to ease the usage by scripts.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - use main() prototype with arguments
  - use argv[0] instead of hard coding program name
  - fix indentation and spacing issues
  - add binary to .gitignore file
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/.gitignore      |  1 +
 libselinux/utils/getpolicyload.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 libselinux/utils/getpolicyload.c

diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index b19b94a8..b3311360 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -10,6 +10,7 @@ getenforce
 getfilecon
 getpidcon
 getpidprevcon
+getpolicyload
 getsebool
 getseuser
 matchpathcon
diff --git a/libselinux/utils/getpolicyload.c b/libselinux/utils/getpolicyload.c
new file mode 100644
index 00000000..ce06bb78
--- /dev/null
+++ b/libselinux/utils/getpolicyload.c
@@ -0,0 +1,30 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <selinux/avc.h>
+
+
+int main(int argc __attribute__ ((unused)),
+         char* argv[] __attribute__ ((unused))) {
+	int rc;
+
+	/*
+	* Do not use netlink as fallback, since selinux_status_policyload(3)
+	* works only after a first message has been received.
+	*/
+	rc = selinux_status_open(/*fallback=*/0);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  failed to open SELinux status map:  %m\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	rc = selinux_status_policyload();
+	if (rc < 0)
+		fprintf(stderr, "%s:  failed to read policyload from SELinux status page:  %m\n", argv[0]);
+	else
+		printf("%d\n", rc);
+
+	selinux_status_close();
+
+	return (rc < 0) ? EXIT_FAILURE : EXIT_SUCCESS;
+}
-- 
2.40.1

