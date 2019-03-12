Return-Path: <SRS0=/sJJ=RP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256AFC43381
	for <selinux@archiver.kernel.org>; Tue, 12 Mar 2019 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E115F206BA
	for <selinux@archiver.kernel.org>; Tue, 12 Mar 2019 18:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jnbr.me header.i=@jnbr.me header.b="hirI8xAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfCLSyl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:54:41 -0400
Received: from mail.jnbr.me ([104.238.167.236]:58948 "EHLO jnbr.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfCLSyl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 12 Mar 2019 14:54:41 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 14:54:40 EDT
Received: from jnbr.me (localhost [127.0.0.1])
        by jnbr.me (OpenSMTPD) with ESMTP id 038819f9;
        Tue, 12 Mar 2019 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jnbr.me; h=date:from:to
        :subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=default; bh=ZaWRsaxVb3MJMKkrHrpBl0
        Ut4Uk=; b=hirI8xALzVz/shyh8aZq5ML0ofpb7IJhJXAZbOZxdh7WIMp309nlxN
        wzm9HWj8bGeF+n3x8e3oe5Rb6fX9fzvajQ+P9AHznaCYIqyhprHU14MTjZEhi0sj
        4gZdZJSjbC5nyJKx2aK158TWS0o8dAvw4K6HHVC5jHFE30EhA+bIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=jnbr.me; h=date:from:to
        :subject:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=default; b=CrPs/NJSjjQv3NZv
        d4j+xVBRyux/jJoVl14MkvSr2WEKzlswBL/9XoidvhZUMzCWkFRA4kblZWDGf/5u
        +hCZU2jHWYFbEQXXO6oAQ63pDyWZ3VICrrC1Qy6IQkaLbStHZTL7ThnKNtA+RCQc
        W0teYfoWQylU6TDYS8TvpvzWWGE=
Received: from t440s.fritz.box (2001:470:1f0b:19:8a02:e83:1af2:885d [IPv6:2001:470:1f0b:19:8a02:e83:1af2:885d])
        by mail.jnbr.me (OpenSMTPD) with ESMTPSA id 2cbaaa6d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 12 Mar 2019 18:48:02 +0000 (UTC)
Date:   Tue, 12 Mar 2019 19:47:58 +0100
From:   Johannes Brechtmann <johannes@jnbr.me>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: use kernel definition of PF_MAX in scripts
Message-ID: <20190312194758.6f411a8b@t440s.fritz.box>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-unknown-linux-musl)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

=46rom 1892b9ff8045bac6fe166802b2d8a8a3111c1e0c Mon Sep 17 00:00:00 2001
From: Johannes Brechtmann <johannes@jnbr.me>
Date: Tue, 12 Mar 2019 17:50:12 +0100
Subject: [PATCH] selinux: use kernel definition of PF_MAX in scripts

Building selinux scripts of old releases on a current host fails with:

    In file included from scripts/selinux/genheaders/genheaders.c:19:
    ./security/selinux/include/classmap.h:245:2: error: #error New
    address family defined, please update secclass_map.

Fix the issue by including linux/socket.h from kernel instead of
sys/socket.h from host.

Signed-off-by: Johannes Brechtmann <johannes@jnbr.me>
---
 scripts/selinux/genheaders/genheaders.c | 2 +-
 scripts/selinux/mdp/mdp.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genh=
eaders/genheaders.c
index 1ceedea847dd..6db7e07fbc4c 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/socket.h>
+#include <linux/socket.h>
=20
 struct security_class_mapping {
 	const char *name;
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 073fe7537f6c..744d9fc9c0bd 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -32,7 +32,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
-#include <sys/socket.h>
+#include <linux/socket.h>
=20
 static void usage(char *name)
 {
--=20
2.21.0

