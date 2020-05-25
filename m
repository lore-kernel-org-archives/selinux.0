Return-Path: <SRS0=axcH=7H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C175AC433E0
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 19:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985D12068D
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAgAMrz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbgEYTr7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 May 2020 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYTr6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 May 2020 15:47:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF05C061A0E
        for <selinux@vger.kernel.org>; Mon, 25 May 2020 12:47:58 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so11060937lfd.7
        for <selinux@vger.kernel.org>; Mon, 25 May 2020 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDsKJ4jCeiWp/uqSKP9MxxOVtKtsVGA9GhHXsZqa+38=;
        b=JAgAMrz9zDqpXQEVv2G3CuKHu7+oPeqNsO4dkk2zmCWECtbuBO0d/9P6AZ14yM/XQ2
         O43klZy4rQhEyBf1womxZPt1Kfv5+Qmg2JyrgwRU6Zk4pAmIxU+V5joKh8fEDdQImK/K
         jMuJNbkYfaBdBVEgfUFr+UagYcfqFAYkoLiMs0pBRAjWerjzxo/Fyl94qTXHuCUfxte1
         hexuFVNf3I2wgn8oOi2sfWIsSzx4Oe2gFCakJEeG/y1TzgY7dAtBwAog5XESMAobXN52
         STJFwYBlT2Cc73XHmLeLiCvKP/KuBjGOys2+LMKxAGY5MbzB/AqG4HOnfem4QE9JWqny
         EAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDsKJ4jCeiWp/uqSKP9MxxOVtKtsVGA9GhHXsZqa+38=;
        b=Ad96VNKpgdCh5fYJSqQcw1RjTs16FmwROVBsF/EC6vDSzkzSnBgjKQORArSubF+Ivw
         V0NzAYy1/RdcifAZ8lG0gJP/qnOdAHNNfqdblncrFVKA578am+CuRS066qO4R4VE4nib
         bZx64HTrwUHt7e92cI/axjbyPFHU8IiscqWeOgt85UrM/Oew836bKu2CtIrNuKhLBr0w
         d6gacDLptroc7MxGqIRN/frV6o3yub1+wyW17/tjIEkQVZJ4RQk8b+Zmqh2X5AUGqoEI
         ldK79+ULL020yBOOIMYKn1CQYwxNtZ2mAtryjnpj7wBj1k+wRRZsqW4FLsn9KdblnjEW
         SuEQ==
X-Gm-Message-State: AOAM533s22PKhj0hwWluyUOGSdj38lMjHAyDtgAWYIYIlpyQmlacSnq7
        GC2j4fWkYdYV5kCYB+MOUKB9TrJs
X-Google-Smtp-Source: ABdhPJwTlx00w6Vh/TObfGO6FreStg3bw71bjYNqXHkh8XKgG6BS+UXyeEYGHKAD/Wql3bBVHaBcsQ==
X-Received: by 2002:a19:5d44:: with SMTP id p4mr14964983lfj.56.1590436076242;
        Mon, 25 May 2020 12:47:56 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id z2sm5937744lfg.45.2020.05.25.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 12:47:55 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] semanage bash completion: handle semanage module #246
Date:   Mon, 25 May 2020 22:47:50 +0300
Message-Id: <20200525194750.17309-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

List modules for bash completion of `semanage module`.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/semanage/semanage-bash-completion.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
index 2d811c98..a3993c58 100644
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
@@ -88,6 +91,14 @@ _semanage () {
 	if   [ "$prev" = "-a" -a "$command" = "permissive" ]; then
 	        COMPREPLY=( $(compgen -W "$( __get_all_domains ) " -- "$cur") )
 		return 0
+	elif [ "$command" = "module" ]; then
+		if [ "$prev" = "-a" ] || [ "$prev" = "--add" ] \
+		    || [ "$prev" = "-d" ] || [ "$prev" = "--disable" ] \
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

