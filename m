Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB829C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 15:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30C823A84
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 15:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbhAVP1g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 10:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728917AbhAVP1b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 10:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611329162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F91S2d4PgYVl6AKbGf65VCf284zFoEl1I6yfW7lnAKU=;
        b=LSh6ebijvtw7AYhdaOZAVxBVIhzOo+F/+L629ENFTIFT2tQB539/2gxrcgoLAX5rx87bSD
        tYWRztp1MV/S1N1dTKNNzrhCb8a2Wzw60PRXh46i1uaCjlDb8qaOJpEOvsa1LyXB94Pyw5
        9hXt8fAyKD9xoRH+XAKHmvlJUOCSaPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-GHPbOVX2Maa8lodiNcwBdw-1; Fri, 22 Jan 2021 10:25:59 -0500
X-MC-Unique: GHPbOVX2Maa8lodiNcwBdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FB76801817
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 15:25:58 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE89360BF3
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 15:25:57 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] python/sepolgen: allow any policy statement in if(n)def
Date:   Fri, 22 Jan 2021 16:25:52 +0100
Message-Id: <20210122152552.405237-1-vmojzis@redhat.com>
In-Reply-To: <CAFqZXNuE3CbwGDv7mvxh67iX3zeLKTu6AJC_VoeALb_o26+zOg@mail.gmail.com>
References: <CAFqZXNuE3CbwGDv7mvxh67iX3zeLKTu6AJC_VoeALb_o26+zOg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

"ifdef/ifndef" statements can be used to conditionally define
an interface, but this syntax is not recognised by sepolgen-ifgen.
Fix sepolgen-ifgen to allow any policy statement inside an
"fidef/ifndef" statement.

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
Thanks. Fixed. And I replaced "statement" with "statements" to allow
multiple statements (as was possible with interface_stmts).
I'm not all that sure about the last line since I didn't manage to find
it's meaning (but I assume IF-THEN-ELSE).

 python/sepolgen/src/sepolgen/refparser.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 9f850990..e611637f 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -433,9 +433,9 @@ def p_ifelse(p):
 
 
 def p_ifdef(p):
-    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
-             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
-             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
+             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
+             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
     '''
     x = refpolicy.IfDef(p[4])
     if p[1] == 'ifdef':
-- 
2.29.2

