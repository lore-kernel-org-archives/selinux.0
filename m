Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26606C28CF5
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 14:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbiAZO4y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiAZO4y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 09:56:54 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2206C06161C
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 06:56:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m4so39705308ejb.9
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhpOtw4vmLk5jSFN2duLbcfXTSphF1wdDNS9+EHWrR8=;
        b=Z+BVKSyevLG9v5BVBEc6Hk8quABmVBiImB1oV7mcbu0JiYSPpm5rCoxZRv3MJL+jLw
         Xdds7qIdCXA+MGEuK1n37lmOvOtEyIdZqjpO/53l1gPug2YGjNf7FzAWMukPjvq60cGk
         5Pn3mVJ5fIB1mlSDHiDTvCgqeUxcyOi9TmyqXj5f88yCM/5MwmeJV7Zl1N7oo85OBPua
         dXua55WMQ04aOPyXjucDAQ7xZEKN+5T1O9vvONy3R5uvOuqdovzLVs5npzCC/Tjmbw7t
         SyXn6IBL+5IrLvKeMzW+9VPhl0RWARoneW58XeuHRXxUUtSqEJCM9UeDVU2eP+3PNpMn
         ww0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhpOtw4vmLk5jSFN2duLbcfXTSphF1wdDNS9+EHWrR8=;
        b=cLK3/sUUmj+MPdsz2jPu27YosyYE5o1Ey50GhUijlfBVoGOdVDIpOpwRKSCN7hG/p1
         afqNHfTGnaYBtZmficiRWve7jbJ+e6dXtpeYxN0DGmuXvzu4+a7o/RWA1CGTuUVLTgt4
         9Ac4bOBkRvx6HSkFJ/23pWUla80TBULwk19n/dtbOc3+HO5Ztjz4sjSj3Wm6i9IzKr3x
         NO7CioCSfD85AChbiiOkTtyKD5JRQSIqzkNxSrD1oDGZY0uglXRvWwLlJ91o57YBdtob
         95LruKv4/HcasKt2Iz5hpeMqeeT/zkvwfk7ObdVWMAYOySXXLlVGMWliH6FUgX38jm0z
         3ecg==
X-Gm-Message-State: AOAM530DVoAXDoWILDt4n/CgzvR3LzqkQ34AZPWWRnAFiLP53J8f4jtI
        k5wa2LfkXNOeyoaqwtHfag0+6zBVFoGNGg==
X-Google-Smtp-Source: ABdhPJyPTFUwSly/0nTnKEW+D88dBofGQIU4UduFA2wXFEeOkoFYow5yamjc+1RQYFcpdN8fuu1J/g==
X-Received: by 2002:a17:906:5042:: with SMTP id e2mr21155558ejk.647.1643209012413;
        Wed, 26 Jan 2022 06:56:52 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-175.77.1.pool.telefonica.de. [77.1.66.175])
        by smtp.gmail.com with ESMTPSA id m22sm5981093ejn.194.2022.01.26.06.56.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:56:51 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] policycoreutils: handle argument counter of zero
Date:   Wed, 26 Jan 2022 15:56:45 +0100
Message-Id: <20220126145645.5236-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The number of arguments passed to main(), argc, can be zero if the
pathname passed to execve(2) is NULL, e.g. via:

    execve("/path/to/exe", {NULL}, {NULL});

Also avoid NULL pointer dereferences on the argument value.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/run_init/open_init_pty.c | 2 +-
 policycoreutils/secon/secon.c            | 3 +++
 policycoreutils/setfiles/setfiles.c      | 6 +++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
index 150cb45e..19101c50 100644
--- a/policycoreutils/run_init/open_init_pty.c
+++ b/policycoreutils/run_init/open_init_pty.c
@@ -244,7 +244,7 @@ int main(int argc, char *argv[])
 	rb_init(&inbuf, inbuf_mem, sizeof(inbuf_mem));
 	rb_init(&outbuf, outbuf_mem, sizeof(outbuf_mem));
 
-	if (argc == 1) {
+	if (argc < 2) {
 		printf("usage: %s PROGRAM [ARGS]...\n", argv[0]);
 		exit(1);
 	}
diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index a0957d09..d624fa13 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -333,6 +333,9 @@ static void cmd_line(int argc, char *argv[])
 		opts->from_type = OPTS_FROM_CUR;
 
 	if (opts->from_type == OPTS_FROM_ARG) {
+		if (!argv[0])
+			errx(EXIT_FAILURE, "No argument given");
+
 		opts->f.arg = argv[0];
 
 		if (xstreq(argv[0], "-"))
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 44cab46d..ab7016ac 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -163,6 +163,10 @@ int main(int argc, char **argv)
 	policyfile = NULL;
 
 	r_opts.abort_on_error = 0;
+	if (!argv[0]) {
+		fprintf(stderr, "Called without required program name!\n");
+		exit(-1);
+	}
 	r_opts.progname = strdup(argv[0]);
 	if (!r_opts.progname) {
 		fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
@@ -423,7 +427,7 @@ int main(int argc, char **argv)
 
 		altpath = argv[optind];
 		optind++;
-	} else if (argc == 1)
+	} else if (argc < 2)
 		usage(argv[0]);
 
 	/* Set selabel_open options. */
-- 
2.34.1

