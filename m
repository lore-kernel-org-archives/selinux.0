Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B0AC04FE0
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjHNNVR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjHNNUs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558961733
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11107583a12.1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019243; x=1692624043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOtpLWp5tJrAK7/EmVMT3zyqfKWlAxfHM6ZvZqzUaig=;
        b=Tmb+fvt95tg9mljrweV72Uf9k/0Fys5NYf77qhqwCL18dlBMAie2FVhhmOKcE2dlO4
         YAR8YgfNTWInpCQomvR2Xb6+iMCZLvPK1ABL79AMhRE5V+4LwivEoMN660UgjaEPI++Q
         ER4P+luFd2uPKfRarCKi+GURsZ8jqStmKcPKlEycVA6/VCqDK9ojGQiOzDMUk4uaf3Qa
         gfqYCkSlg7MiJE2/vg6dgeieogSeZs9ZNNCepDZGjeJ8n17/h3g0VHm3bpkSrbd01VCN
         JoVvUknAgyDJddNm9tatBupcG1ZIc24BPyA5FrOqDSqAYEtkVYhfiuT+qqDwxRSR1KPP
         /fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019243; x=1692624043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOtpLWp5tJrAK7/EmVMT3zyqfKWlAxfHM6ZvZqzUaig=;
        b=f+53FF2gGzF4n0ar3KJUKww/29UMG20pPNo3XueTJbE/mZzUiAkDnqVYk9l8zlRFe+
         bzkvYkxqXLMWXbuJRu7VJof+jUMWC2Ul8b9++Gohce0hNs7xh1vU4vaYX3jz7Z0wk8N0
         ph0M75jgFcwGRh1jy2RydBspXABwlGt5XUOZiCWwDYUoXp4ZcBpgXjC7DcR94fi8GIMI
         rZq3yhujXFKkEmqBQX6uYcvzIsoDY4qEvfBDHq557YZl3yrjrDmJk7/zH0At2dLuvzW8
         uh6TWJQU9YlKi2mFGFq0J8fPK2eaW+x6x3MkQPzyXLR2lvJxbLPHK0fXrYhFGj/BEq1h
         Edww==
X-Gm-Message-State: AOJu0Yx1e8qSqGWblnphWnifvo93CTvm7lnTrkM+a8wxOgGMyxXWR1hz
        HgVtaQnAxcsC6oRhLiHWxDcKxxLnGBs3jbAq148=
X-Google-Smtp-Source: AGHT+IHQhyNUOTVnmEa75+C2DndcBwdOFDhpzL14HrHvsIknfekEcwLbY/Vwqc9pz1ktoiL7Fg/geQ==
X-Received: by 2002:a17:907:774e:b0:992:ef60:aadd with SMTP id kx14-20020a170907774e00b00992ef60aaddmr10495125ejc.13.1692019242766;
        Mon, 14 Aug 2023 06:20:42 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 05/27] setfiles: do not issue AUDIT_FS_RELABEL on dry run
Date:   Mon, 14 Aug 2023 15:20:03 +0200
Message-Id: <20230814132025.45364-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not issue an audit event of type AUDIT_FS_RELABEL in case of a
passive check.

Print the reason for an audit_open(3) failure.

Do not prematurely exit in case audit_open(3) fails, since all important
work is already done, but proceed with cleanup tasks.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/setfiles/setfiles.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 4dd0d0dc..88a27241 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -86,23 +86,20 @@ static int canoncon(char **contextp)
 }
 
 #ifndef USE_AUDIT
-static void maybe_audit_mass_relabel(int mass_relabel __attribute__((unused)),
-				int mass_relabel_errs __attribute__((unused)))
+static void audit_mass_relabel(int mass_relabel_errs __attribute__((unused)))
 {
 #else
-static void maybe_audit_mass_relabel(int mass_relabel, int mass_relabel_errs)
+static void audit_mass_relabel(int mass_relabel_errs)
 {
 	int audit_fd = -1;
 	int rc = 0;
 
-	if (!mass_relabel)		/* only audit a forced full relabel */
-		return;
-
 	audit_fd = audit_open();
 
 	if (audit_fd < 0) {
-		fprintf(stderr, "Error connecting to audit system.\n");
-		exit(-1);
+		fprintf(stderr, "Error connecting to audit system: %s.\n",
+			strerror(errno));
+		return;
 	}
 
 	rc = audit_log_user_message(audit_fd, AUDIT_FS_RELABEL,
@@ -463,7 +460,8 @@ int main(int argc, char **argv)
 					       &skipped_errors) < 0;
 	}
 
-	maybe_audit_mass_relabel(r_opts.mass_relabel, errors);
+	if (r_opts.mass_relabel && !r_opts.nochange)
+		audit_mass_relabel(errors);
 
 	if (warn_no_match)
 		selabel_stats(r_opts.hnd);
-- 
2.40.1

