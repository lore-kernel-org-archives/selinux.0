Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8161C433E0
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A456A64D99
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBFVFf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Feb 2021 16:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBFVFf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Feb 2021 16:05:35 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585BC061756
        for <selinux@vger.kernel.org>; Sat,  6 Feb 2021 13:04:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hs11so18671392ejc.1
        for <selinux@vger.kernel.org>; Sat, 06 Feb 2021 13:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w7pKNTc34nd4m220XD4sSGo2v7uZGqRxKl0+PekX09A=;
        b=pUUkhdm7LKUA5rpI26Yx2veHQTKj8DPaEozUa2hBhLyYYyY6bDFKWhcck75Y/7Tc71
         zrfCqNHZ/++G9CB2XCgc4+9FL8Vxtnef7TFXRfpGqWnNVJ0aApb7UtPariiXpRXfPst4
         vpEI/pw8JXDkuEkv88oYnqXHpA1wxJgCT024jFXTvVUOtt1GsPaFUCnMmTAS1cLDrq/F
         1BmiVCOO/A7HLT74JFqszjo+gEfUTthyPQNp26EdYdwmVI7zUmcJPEepRN+9Oh6d2Lre
         gUNfR470dbuHJfuG1aT/fv/hLirUQ1rTgiMZaYWdWtzA15gicPes5VHuVqeBHGwjTJKW
         laVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w7pKNTc34nd4m220XD4sSGo2v7uZGqRxKl0+PekX09A=;
        b=XzdpTlHzXwDk1r/iMlQPZs/xOXLZYKS0bGeYoOF8wYzZeeiRTjUPmSbjEvMsYdZVMV
         Wk4nJt2sDZoi1fhJtvylPJUQyWBhAFj8Q01UN0FgX5R0j1ruoui0s2VQXfYJihAl3RLn
         L7e4IUWo5ibZwPVRT5keJkvpkZQI49Lsu9EVNNGeP4SlhBCnjnq61sk0/RAcqHXZDSH/
         F5FZe8u/f8zzKsuKo8uj7Oll/DKRUQLANUxkELKjtgbTY3E8BmTna8BcqjZ+I4BxC/LI
         83/CndDElXd9Q+v4fXMfmdUdrC9cdF/OpJ7gI70eP6W5+wAe7trWC2atC58t9vu1Zt5D
         7Zig==
X-Gm-Message-State: AOAM531jwU2wkjT9s/QRCD/MA7/gGTdQydDt844ikzF08wchJFkyJHsu
        yyX4qoJL+qWQvHVihzOapl4=
X-Google-Smtp-Source: ABdhPJxY8f5OyzUQte63xMyl4ird5Jp2RN0AKVW3XysQX9ab4jjX9nrMJRcVrF21fhn9p/RkD3NRJg==
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr10186816eje.149.1612645493178;
        Sat, 06 Feb 2021 13:04:53 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id y1sm6025378edq.26.2021.02.06.13.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 13:04:52 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v2 2/3] secilc/docs: add syntax highlighting for secil
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
Message-ID: <90473e07-fe79-18d8-4772-52deb4f8e1bd@gmail.com>
Date:   Sat, 6 Feb 2021 22:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is done by creating a somewhat rudimentary KDE syntax xml for
pandoc.

The default styles provided by pandoc don't look very good and don't
highlight e.g. the strings marked as builtin.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---
 secilc/docs/Makefile  |  10 +-
 secilc/docs/secil.xml | 236 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+), 4 deletions(-)
 create mode 100644 secilc/docs/secil.xml

diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
index 79a165ba..a91bcde0 100644
--- a/secilc/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -28,6 +28,8 @@ FILE_LIST ?= cil_introduction.md \
 
 PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
 
+PANDOC_HIGHLIGHT_STYLE="pygments"
+
 PDF_OUT=CIL_Reference_Guide.pdf
 HTML_OUT=CIL_Reference_Guide.html
 PANDOC = pandoc
@@ -54,13 +56,13 @@ $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
 	$(SED) -i '1i Example Policy\n=========\n```secil' $@
 	echo '```' >> $@
 
-html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
+html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
 	mkdir -p $(HTMLDIR)
-	$(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
+	$(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --metadata title="CIL Reference Guide" -t html $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil  -o $(HTMLDIR)/$(HTML_OUT)
 
-pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
+pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
 	mkdir -p $(PDFDIR)
-	$(PANDOC) --standalone --toc $^ -o $(PDFDIR)/$(PDF_OUT)
+	$(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --toc $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil -o $(PDFDIR)/$(PDF_OUT)
 
 clean:
 	rm -rf $(HTMLDIR)
diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
new file mode 100644
index 00000000..daa80ded
--- /dev/null
+++ b/secilc/docs/secil.xml
@@ -0,0 +1,236 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!-- https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format -->
+<!DOCTYPE language SYSTEM "language.dtd">
+<language name="secil" section="Sources" extensions="*.cil" version="1" kateversion="2.4">
+    <!--
+        The keywords where extracted from libsepol/cil/src/cil.c sorted into the
+        right lists and sorted alphabetically
+    -->
+    <list name="keywords_blockstart">
+        <item>allow</item>
+        <item>allowx</item>
+        <item>auditallow</item>
+        <item>auditallowx</item>
+        <item>block</item>
+        <item>blockabstract</item>
+        <item>boolean</item>
+        <item>booleanif</item>
+        <item>category</item>
+        <item>categoryalias</item>
+        <item>categoryaliasactual</item>
+        <item>categoryorder</item>
+        <item>categoryset</item>
+        <item>class</item>
+        <item>classcommon</item>
+        <item>classmap</item>
+        <item>classmapping</item>
+        <item>classorder</item>
+        <item>classpermission</item>
+        <item>classpermissionset</item>
+        <item>common</item>
+        <item>constrain</item>
+        <item>context</item>
+        <item>defaultrange</item>
+        <item>defaultrole</item>
+        <item>defaulttype</item>
+        <item>defaultuser</item>
+        <item>devicetreecon</item>
+        <item>dontaudit</item>
+        <item>dontauditx</item>
+        <item>expandtypeattribute</item>
+        <item>false</item>
+        <item>filecon</item>
+        <item>fsuse</item>
+        <item>genfscon</item>
+        <item>handleunknown</item>
+        <item>ibendportcon</item>
+        <item>ibpkeycon</item>
+        <item>ioctl</item>
+        <item>iomemcon</item>
+        <item>ioportcon</item>
+        <item>ipaddr</item>
+        <item>level</item>
+        <item>levelrange</item>
+        <item>mls</item>
+        <item>mlsconstrain</item>
+        <item>mlsvalidatetrans</item>
+        <item>netifcon</item>
+        <item>neverallow</item>
+        <item>neverallowx</item>
+        <item>nodecon</item>
+        <item>optional</item>
+        <item>pcidevicecon</item>
+        <item>perm</item>
+        <item>permissionx</item>
+        <item>pirqcon</item>
+        <item>policycap</item>
+        <item>portcon</item>
+        <item>rangetransition</item>
+        <item>role</item>
+        <item>roleallow</item>
+        <item>roleattribute</item>
+        <item>roleattributeset</item>
+        <item>rolebounds</item>
+        <item>roletransition</item>
+        <item>roletype</item>
+        <item>selinuxuser</item>
+        <item>selinuxuserdefault</item>
+        <item>sensitivity</item>
+        <item>sensitivityalias</item>
+        <item>sensitivityaliasactual</item>
+        <item>sensitivitycategory</item>
+        <item>sensitivityorder</item>
+        <item>sid</item>
+        <item>sidcontext</item>
+        <item>sidorder</item>
+        <item>true</item>
+        <item>tunable</item>
+        <item>tunableif</item>
+        <item>type</item>
+        <item>typealias</item>
+        <item>typealiasactual</item>
+        <item>typeattribute</item>
+        <item>typeattributeset</item>
+        <item>typebounds</item>
+        <item>typechange</item>
+        <item>typemember</item>
+        <item>typepermissive</item>
+        <item>typetransition</item>
+        <item>unordered</item>
+        <item>user</item>
+        <item>userattribute</item>
+        <item>userattributeset</item>
+        <item>userbounds</item>
+        <item>userlevel</item>
+        <item>userprefix</item>
+        <item>userrange</item>
+        <item>userrole</item>
+        <item>validatetrans</item>
+    </list>
+
+    <list name="function">
+        <item>blockinherit</item>
+        <item>call</item>
+        <item>in</item>
+        <item>macro</item>
+    </list>
+
+    <list name="operators">
+        <item>and</item>
+        <item>dom</item>
+        <item>domby</item>
+        <item>eq</item>
+        <item>incomp</item>
+        <item>neq</item>
+        <item>not</item>
+        <item>or</item>
+        <item>range</item>
+        <item>xor</item>
+    </list>
+
+    <!-- list of "magic" functions or values -->
+    <list name="builtins">
+        <item>*</item>
+        <item>all</item>
+        <item>dccp</item>
+        <item>false</item>
+        <item>h1</item>
+        <item>h2</item>
+        <item>l1</item>
+        <item>l2</item>
+        <item>object_r</item>
+        <item>r1</item>
+        <item>r2</item>
+        <item>r3</item>
+        <item>sctp</item>
+        <item>self</item>
+        <item>t1</item>
+        <item>t2</item>
+        <item>t3</item>
+        <item>tcp</item>
+        <item>true</item>
+        <item>u1</item>
+        <item>u2</item>
+        <item>u3</item>
+        <item>udp</item>
+
+        <!--
+            Excluded because they lead to a lot of false-positives
+        <item>allow</item>
+        <item>any</item>
+        <item>char</item>
+        <item>deny</item>
+        <item>dir</item>
+        <item>file</item>
+        <item>glblub</item>
+        <item>high</item>
+        <item>low-high</item>
+        <item>low</item>
+        <item>pipe</item>
+        <item>reject</item>
+        <item>socket</item>
+        <item>source</item>
+        <item>symlink</item>
+        <item>target</item>
+        <item>task</item>
+        <item>trans</item>
+        <item>xattr</item>
+        -->
+    </list>
+    <highlighting>
+        <contexts>
+            <context name="Normal" attribute="Normal" lineEndContext="#stay">
+                <DetectChar attribute="Brackets" context="BlockStart" char="("/>
+
+                <DetectChar attribute="Comment" context="Comment" char=";"/>
+            </context>
+            <context name="BlockStart" attribute="Normal" lineEndContext="#stay">
+                <keyword attribute="Keyword" context="Block" String="keywords_blockstart"/>
+                <keyword attribute="Function" context="Block" String="function"/>
+                <keyword attribute="Operator" context="Block" String="operators"/>
+
+                <DetectChar attribute="Comment" context="Comment" char=";"/>
+            </context>
+            <context name="Block" attribute="Normal" lineEndContext="#stay">
+                <keyword attribute="Builtin" context="#stay" String="builtins"/>
+
+                <DetectChar attribute="Comment" context="Comment" char=";"/>
+                <DetectChar attribute="String" context="String" char="&quot;"/>
+
+                <DetectChar attribute="Brackets" context="BlockStart" char="("/>
+                <DetectChar attribute="Brackets" context="#pop" char=")"/>
+            </context>
+
+            <!-- single line comment -->
+            <context name="Comment" attribute="Comment" lineEndContext="#pop"></context>
+
+            <!-- string / name -->
+            <context name="String" attribute="String" lineEndContext="#stay">
+                <RegExpr attribute="Char" context="#stay" String="#\\."/>
+
+                <!-- allow escaping " or similiar -->
+                <HlCStringChar attribute="String Char" context="#stay"/>
+
+                <DetectChar attribute="String" context="#pop" char="&quot;"/>
+            </context>
+        </contexts>
+        <itemDatas>
+            <itemData name="Normal" defStyleNum="dsNormal" />
+            <itemData name="Keyword" defStyleNum="dsKeyword"/>
+            <itemData name="Function" defStyleNum="dsFunction"/>
+            <itemData name="Operator" defStyleNum="dsOperator"/>
+            <itemData name="Builtin" defStyleNum="dsBuiltIn"/>
+
+            <itemData name="Comment" defStyleNum="dsComment"/>
+
+            <itemData name="String" defStyleNum="dsString"/>
+            <itemData name="String Char" defStyleNum="dsSpecialChar"/>
+        </itemDatas>
+    </highlighting>
+    <general>
+        <comments>
+            <comment name="singleLine" start=";"/>
+        </comments>
+        <keywords casesensitive="1" weakDeliminator="."/>
+    </general>
+</language>
-- 
2.30.0

