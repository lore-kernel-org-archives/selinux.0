Return-Path: <SRS0=Dt1u=7N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC380C433E0
	for <selinux@archiver.kernel.org>; Sun, 31 May 2020 20:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C28206DA
	for <selinux@archiver.kernel.org>; Sun, 31 May 2020 20:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0ecNWIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgEaUSm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 May 2020 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgEaUSl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 May 2020 16:18:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2BC061A0E
        for <selinux@vger.kernel.org>; Sun, 31 May 2020 13:18:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so2698577lfe.11
        for <selinux@vger.kernel.org>; Sun, 31 May 2020 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NmFJ3n9mZRNgm9atjRVvJVN8yPhCvXmiYFco0BC9tE=;
        b=I0ecNWIlKMu8DyvOqrYtzo30ysIKiy6zSb55lxKI7apIKCBYQsJdhlJZtNENMqL9TE
         bsX6OV8zt6rNFudebZJPcG2u+9GP9sQpT70GA59qeRPT1SN3sotWrgKXCo+7nyjmmC09
         yYMc86/LFupAVIYHsO4dGcEPoEG7FAavM9oZNIlD0PEYVgbi1P3wF1ZDz+iqWU+wx+tJ
         Xl23PMbE1e4W4aAvLB/9e/Yew5U16yMn6eBxHBVS3VztAZycSZVynz6s0U8WDjMQHtEA
         vPyRqg2jrHW5CzMBzzL6j0Ln4TzKlpSDmV0MdZGHi/NmzggjHTsGKmjF+0TJnIH4V9+n
         c8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NmFJ3n9mZRNgm9atjRVvJVN8yPhCvXmiYFco0BC9tE=;
        b=AU0Xfq4MjQP435J7Ykw6lNQcT6mRjQSyDjRt+BbsERh2exT65rZrj0LslRHICX6EXR
         pLj99Vo3NAPaqwS8VfPvDcpBFXCq0AJFoPha+/fUOJ2bXEcXfc0L0r/NguOX6JjtFGJa
         ZyqEZeufsHgrrphVDjUzVZZ+nXlzyTDQcRGxLv9xEHEWCiC2bUmVzEjl7QMWs21nLX8/
         zjyYH+yjgbtpHCNqPyTqkcX1CBva0yKueCt/sr4T5ZlKYMuVEjLY3yxiZhOimWRoi6FU
         xs9XPkBOXADqq4IyXri6lyLdv4hCO7NezEL3o1e1b9IWt6kOi9JclUGReihMZNx5/4Yw
         iTQA==
X-Gm-Message-State: AOAM531QtyHsq1g2mmhPm0qDTqpnkCXCldCI97ZFDP64Pfa2+oKUlVNj
        n6f8Irk9/afXs5gueei/ur1Atqqd
X-Google-Smtp-Source: ABdhPJxprJwnNuDCduE/uPT1YJN2NdZzElz8Jbx5gGazbI301KvyrLI1Qtj9eulKkSQJ4GpjduOEcQ==
X-Received: by 2002:a05:6512:108f:: with SMTP id j15mr9534534lfg.19.1590956319189;
        Sun, 31 May 2020 13:18:39 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id 201sm1736392ljf.130.2020.05.31.13.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 13:18:38 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] semanage bash completion: handle semanage module
Date:   Sun, 31 May 2020 23:18:34 +0300
Message-Id: <20200531201834.4295-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

List modules for bash completion of `semanage module`.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

--
v2: removed -a or --add as they expect a file, not existing module
---
 python/semanage/semanage-bash-completion.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
index 2d811c98..d0dd139f 100644
--- a/python/semanage/semanage-bash-completion.sh
+++ b/python/semanage/semanage-bash-completion.sh
@@ -54,6 +54,9 @@ __get_all_roles () {
 __get_all_stores () {
     dir -1 -F /etc/selinux/ | grep '/' | cut -d'/' -f 1
 }
+__get_all_modules () {
+    semodule -l
+}
 __get_import_opts () { echo '$ALL_OPTS --f --input_file' ; }
 __get_export_opts () { echo '$ALL_OPTS --f --output_file' ; }
 __get_boolean_opts () { echo '$ALL_OPTS --on -off -1 -0' ; }
@@ -88,6 +91,13 @@ _semanage () {
 	if   [ "$prev" = "-a" -a "$command" = "permissive" ]; then
 	        COMPREPLY=( $(compgen -W "$( __get_all_domains ) " -- "$cur") )
 		return 0
+	elif [ "$command" = "module" ]; then
+		if [ "$prev" = "-d" ] || [ "$prev" = "--disable" ] \
+		    || [ "$prev" = "-e" ] || [ "$prev" = "--enable" ] \
+		    || [ "$prev" = "-r" ] || [ "$prev" = "--remove" ]; then
+	            COMPREPLY=( $(compgen -W "$( __get_all_modules ) " -- "$cur") )
+		    return 0
+		fi
 	fi
 	if   [ "$verb" = "" -a "$prev" = "semanage" ]; then
                 comps="${VERBS[*]}"
-- 
2.26.2

