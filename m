Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DB7C433DB
	for <selinux@archiver.kernel.org>; Mon, 11 Jan 2021 21:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3F722CA2
	for <selinux@archiver.kernel.org>; Mon, 11 Jan 2021 21:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbhAKVPj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Jan 2021 16:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbhAKVPj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Jan 2021 16:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610399652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nemz2MZGVPaPPtm8nhgxeMoAU7SsJlDDePgSvlJWhUc=;
        b=g+zXWEY+lcLVv5OT/gEgbBgNQlQytmXpRRhX//Iz8rO1wjf6JOon2FWc4aVh4dgvfp4UtT
        EzpEbtnwdZ8HHK9+AigVXtTr9e0Vr5sLmNA00lv/UQk2KtTR7t44qra2ZuddAkztjIhId+
        Ip1JYvUptxCXEmzciSiCWW8sOZpFZN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-0rpxmkayMW-D3A51YIUvag-1; Mon, 11 Jan 2021 16:14:10 -0500
X-MC-Unique: 0rpxmkayMW-D3A51YIUvag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 944C71842152
        for <selinux@vger.kernel.org>; Mon, 11 Jan 2021 21:14:09 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE7850F7D
        for <selinux@vger.kernel.org>; Mon, 11 Jan 2021 21:14:08 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolgen: allow any policy statement in ifndef
Date:   Mon, 11 Jan 2021 22:14:05 +0100
Message-Id: <20210111211405.2215410-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

"ifndef" statements can be used to conditionally define an interface,
but this syntax is not recognised by sepolgen-ifgen.
Fix sepolgen-ifgen to allow any policy statement inside an "ifndef"
statement.

Fixes:
        $ cat <<EOF > i.if
ifndef(`apache_manage_pid_files',`
        interface(`apache_manage_pid_files',`
                manage_files_pattern($1, httpd_var_run_t, httpd_var_run_t)
        ')
')

        #sepolgen-ifgen --interface=i.if
        i.if: Syntax error on line 2 interface [type=INTERFACE]
        i.if: Syntax error on line 4 ' [type=SQUOTE]

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 9f850990..3c69904a 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -434,7 +434,7 @@ def p_ifelse(p):
 
 def p_ifdef(p):
     '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
-             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statement SQUOTE CPAREN optional_semi
              | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
     '''
     x = refpolicy.IfDef(p[4])
-- 
2.29.2

