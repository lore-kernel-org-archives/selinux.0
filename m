Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB837CDB47E
	for <selinux@archiver.kernel.org>; Fri, 13 Oct 2023 13:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjJMNwP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Oct 2023 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjJMNwP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Oct 2023 09:52:15 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4EC95
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 06:52:13 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d122f6294so11988436d6.0
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697205132; x=1697809932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gs7J4JMUOAJdsu2mujUJG6aTxmDgsVL9P7AwQ6Otnjg=;
        b=mEDPuitxLMfMliVJaNhq+2cEk4AfSBFmJT/M2slv5gBTr0O0uCT1fw/E+y8VWs9sid
         CxwknvBgIBHYjtyh7Xy2UFif5YEjnHpuIuZTYIAt97KDqlyQ4DBtBXFM0Uk0HeaKPVlo
         IuDTFmUYFJRyiD9I1gAuWbXhqeAt7EeiceLwRJsGLVIPRLy50Yv6OB7+mS+L05qPaoH0
         9gkPqKCuGpflm49vGO5wvtla9dyMJnz6sixpUWutE3Dt9RWThF85m00ud6WfEkP1lBdZ
         z04500grZi4GgXkb5CXvKT+uhoFr1HrzLD9aeBhNDt5PP8xLCHyCF1Ldo8CXyY7dH4Z3
         sb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697205132; x=1697809932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gs7J4JMUOAJdsu2mujUJG6aTxmDgsVL9P7AwQ6Otnjg=;
        b=F25052+tUQ/DXlREPuXHP4FfWYzNqg/pUp6RCXj/TqZEPSwNXSg/ZTxyhgZQSzBeuk
         T4nawht0zuy77JpupsciY4MXpdLwnl0rrGUsW8PHHtA1iBGaTprsYsn0WW/v+cjRP6Q6
         iDBS2TDsXCvU5rAzk+VzKGul5PETc05YSCZ8oQuJb4pgqEz7LUaBbLLldepsbJl7XZJ4
         mls3zn7AXEl6N3TuIIr6etMLuzcCS1zIntVB25LwE53nyb4rIRwRPz5Z8spW2aeppIcP
         zS00L6MrMIezYieYFT2Jdjdh10uzVWO7U81crTCizGAPlk+AnzvzsIrlchH+4k2H6Kg3
         5nTw==
X-Gm-Message-State: AOJu0YxrXLBn5ACRj9t73KBBunGKj+cDZndcikCBbVep/VMp8wA23hEi
        rwSI4d77FIQCCj3NIx9lGT0OOcdhvVg=
X-Google-Smtp-Source: AGHT+IETA8qhka1RZeryV7G26FUeku2zX4F1wPCKAC6AEKYVnnaz0qryY6I21zK24PR29JCDXQWHeA==
X-Received: by 2002:a05:6214:ccd:b0:66d:1b4c:e867 with SMTP id 13-20020a0562140ccd00b0066d1b4ce867mr5048313qvx.45.1697205132366;
        Fri, 13 Oct 2023 06:52:12 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id n12-20020a0ce48c000000b0065655bb349csm663832qvl.141.2023.10.13.06.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:52:11 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Do not allow classpermissionset to use anonymous classpermission
Date:   Fri, 13 Oct 2023 09:52:07 -0400
Message-ID: <20231013135207.1462729-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Macros can use classpermission arguments. These are used in two
different ways. Either a named classpermission is passed (which is
declared using a classpermisison rule) or an anonymous classpermission
is passed (something like "(CLASS (PERM))").

Usually this will look like either of the following:
Ex1/
(classpermission cp1)
(classpermisisonset cp1 (CLASS (PERM)))
(macro m1 ((classpermisison ARG1))
  (allow t1 self ARG1)
)
(call m1 (cp1))
or
Ex2/
(macro m2 ((classpermission ARG2))
  (allow t2 self ARG2)
)
(call m2 ((CLASS (PERM))))

The following would also be valid:
Ex3/
(classpermission cp3)
(macro m3 ((classpermission ARG3))
  (classpermissionset ARG3 (CLASS (PERM)))
  (allow t3 self ARG3)
)
(call m3 (cp3))

The oss-fuzzer did the equivalent of the following:

(classpermission cp4)
(macro m4 ((classpermission ARG4))
  (classpermissionset ARG4 (CLASS (PERM1)))
  (allow t4 self ARG4)
)
(call m4 (CLASS (PERM2)))

It passed an anonymous classpermission into a macro where there
was a classpermissionset rule. Suprisingly, everything worked well
until it was time to destroy the AST. There is no way to distinguish
between the anonymous classpermission being passed in which needs
to be destroyed and the classpermission in the classpermissionset
rule which is destroyed when the classpermissionset rule is
destroyed. This led to CIL trying to destroy the classpermission
in the classpermissionset rule twice.

To fix this, when resolving the classpermission name in the
classpermissionset rule, check if the datum returned is for
an anonymous classpermission (it has no name) and return an
error if it is.

This fixes oss-fuzz issue 60670.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 33b9d321..49de8618 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -254,6 +254,12 @@ int cil_resolve_classpermissionset(struct cil_tree_node *current, struct cil_cla
 		goto exit;
 	}
 
+	if (!datum->fqn) {
+		cil_tree_log(current, CIL_ERR, "Anonymous classpermission used in a classpermissionset");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 	rc = cil_resolve_classperms_list(current, cps->classperms, extra_args);
 	if (rc != SEPOL_OK) {
 		goto exit;
-- 
2.41.0

