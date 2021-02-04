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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FDBC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B5F64F77
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 17:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhBDRHv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhBDRG4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 12:06:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F91C061788
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 09:06:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m1so3641827wml.2
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7e4XWo4JCocK9TTQXIbvDZgv+rZ6qwNx3Ts6Gpz/hQU=;
        b=U0Cessz+oUBc75ZKEgLpAAHiO9XsthB19Nk9cl/JLCcYNlh029OHiDu8buzNM6xyPG
         C0pnNYlBfWzEVPLUbQrgHOLxl9QkU9kDHHCJ2x3aBbB+UB3ozQpfr7McYJWT3pn7sHBd
         Ak+QPip5lMIY/KkGtGyvC0nRkhoH+H8jwrXSH8zczfFKWHBkpG2d3xkVXimA168hBbzo
         cKzNciBAK5NF6qa9SH80xcVqHknCcPSIV0kzYj1D6+ze7NtBM76U84B2SI+HFXFWoZ5y
         zi9pAL2NES4ZnseYONqkCizpU49I0Di86Tgpuvk8flFk0aQnULYBphs/7GUkrPZyG9YU
         xtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7e4XWo4JCocK9TTQXIbvDZgv+rZ6qwNx3Ts6Gpz/hQU=;
        b=Pzkw0zi9w3tYe1aVCymonAcIO07wvsuAgx22EONg0O/hu25XQ2UaMSrfJzo7Za9XIu
         OPI4HgE+AFwKlex6NgPxfILBCs5kWly5w8MQTEDt72bUs6h9HYwqEwkph3tPS1UNgrd+
         8xOqNvuZzJ44+CDKTXfAVIYx8kbPy2gp3DtBGy4lCUPc3812/DhMq4vHkJKE0xdBBwK/
         UqPJrqayLxUUTjXJF3mKLWQlsf6Whhbx0B6K3Q5BC9ECrBShptdJEvmUzAsX5khoXAoL
         uTLi8WUaUhBtsRl6v30iPrSaFDWloBmqQEX1b+vp9UtI/12GxZNN0SkNbVFPoSMHs/Dq
         qwCQ==
X-Gm-Message-State: AOAM53110fnP/3sjdiAWYsmTIFhV2/uycyGYoa3wbekl+bkT6r0kymU7
        Dmc5O9RWV19BNtE59QCly11HcDq9QCY=
X-Google-Smtp-Source: ABdhPJyAxqWSmd6L8kBa2vKcqY0CqugP4vHp0PA0cSNCX/Lkc61XUxbTM3GjQTj44bBYIYrQKibNtg==
X-Received: by 2002:a1c:2e83:: with SMTP id u125mr132800wmu.13.1612458374687;
        Thu, 04 Feb 2021 09:06:14 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id 9sm9689055wra.80.2021.02.04.09.06.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:06:14 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH 2/2] secilc/docs: add syntax highlighting for secil
To:     selinux@vger.kernel.org
Message-ID: <0f97e39d-5e20-0ee6-dbcb-39e27efe8f43@gmail.com>
Date:   Thu, 4 Feb 2021 18:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
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
 secilc/docs/secil.xml | 224 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+), 4 deletions(-)
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
index 00000000..e9f252f5
--- /dev/null
+++ b/secilc/docs/secil.xml
@@ -0,0 +1,224 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!-- https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format -->
+<!DOCTYPE language SYSTEM "language.dtd">
+<language name="secil" section="Sources" extensions="*.cil" version="1" kateversion="2.4">
+    <!-- The keywords where extracted from libsepol/cil/src/cil.c -->
+    <list name="keywords">
+        <item>auditallow</item>
+        <item>tunableif</item>
+        <item>allow</item>
+        <item>dontaudit</item>
+        <item>typetransition</item>
+        <item>typechange</item>
+        <item>tunable</item>
+        <item>type</item>
+        <item>role</item>
+        <item>user</item>
+        <item>userattribute</item>
+        <item>userattributeset</item>
+        <item>sensitivity</item>
+        <item>category</item>
+        <item>categoryset</item>
+        <item>level</item>
+        <item>levelrange</item>
+        <item>class</item>
+        <item>ipaddr</item>
+        <item>classmap</item>
+        <item>classpermission</item>
+        <item>boolean</item>
+        <item>string</item>
+        <item>name</item>
+        <item>handleunknown</item>
+        <item>block</item>
+        <item>blockabstract</item>
+        <item>classorder</item>
+        <item>classmapping</item>
+        <item>classpermissionset</item>
+        <item>common</item>
+        <item>classcommon</item>
+        <item>sid</item>
+        <item>sidcontext</item>
+        <item>sidorder</item>
+        <item>userlevel</item>
+        <item>userrange</item>
+        <item>userbounds</item>
+        <item>userprefix</item>
+        <item>selinuxuser</item>
+        <item>selinuxuserdefault</item>
+        <item>typeattribute</item>
+        <item>typeattributeset</item>
+        <item>expandtypeattribute</item>
+        <item>typealias</item>
+        <item>typealiasactual</item>
+        <item>typebounds</item>
+        <item>typepermissive</item>
+        <item>rangetransition</item>
+        <item>userrole</item>
+        <item>roletype</item>
+        <item>roletransition</item>
+        <item>roleallow</item>
+        <item>roleattribute</item>
+        <item>roleattributeset</item>
+        <item>rolebounds</item>
+        <item>booleanif</item>
+        <item>neverallow</item>
+        <item>typemember</item>
+        <item>sensitivityalias</item>
+        <item>sensitivityaliasactual</item>
+        <item>categoryalias</item>
+        <item>categoryaliasactual</item>
+        <item>categoryorder</item>
+        <item>sensitivityorder</item>
+        <item>sensitivitycategory</item>
+        <item>constrain</item>
+        <item>mlsconstrain</item>
+        <item>validatetrans</item>
+        <item>mlsvalidatetrans</item>
+        <item>context</item>
+        <item>filecon</item>
+        <item>ibpkeycon</item>
+        <item>ibendportcon</item>
+        <item>portcon</item>
+        <item>nodecon</item>
+        <item>genfscon</item>
+        <item>netifcon</item>
+        <item>pirqcon</item>
+        <item>iomemcon</item>
+        <item>ioportcon</item>
+        <item>pcidevicecon</item>
+        <item>devicetreecon</item>
+        <item>fsuse</item>
+        <item>policycap</item>
+        <item>optional</item>
+        <item>defaultuser</item>
+        <item>defaultrole</item>
+        <item>defaulttype</item>
+        <item>mls</item>
+        <item>defaultrange</item>
+            <!--
+            <item><root></item>
+            <item><node></item>
+            -->
+        <item>perm</item>
+        <item>allowx</item>
+        <item>auditallowx</item>
+        <item>dontauditx</item>
+        <item>neverallowx</item>
+        <item>permissionx</item>
+        <item>ioctl</item>
+        <item>unordered</item>
+            <!--
+                <item><src_info></item>
+                <item><src_cil></item>
+                <item><src_hll></item>
+            -->
+    </list>
+    <list name="function">
+        <item>call</item>
+        <item>macro</item>
+        <item>blockinherit</item>
+        <item>in</item>
+    </list>
+    <list name="operators">
+        <item>and</item>
+        <item>or</item>
+        <item>not</item>
+        <item>eq</item>
+        <item>neq</item>
+        <item>dom</item>
+        <item>domby</item>
+        <item>incomp</item>
+        <item>xor</item>
+        <item>range</item>
+    </list>
+
+    <!-- list of "magic" functions or values -->
+    <list name="builtins">
+        <item>t1</item>
+        <item>t2</item>
+        <item>t3</item>
+        <item>r1</item>
+        <item>r2</item>
+        <item>r3</item>
+        <item>u1</item>
+        <item>u2</item>
+        <item>u3</item>
+        <item>l1</item>
+        <item>l2</item>
+        <item>h1</item>
+        <item>h2</item>
+        <item>true</item>
+        <item>false</item>
+        <item>self</item>
+        <item>object_r</item>
+        <item>*</item>
+        <item>udp</item>
+        <item>tcp</item>
+        <item>dccp</item>
+        <item>sctp</item>
+        <item>all</item>
+        <item>allow</item>
+        <item>deny</item>
+        <item>reject</item>
+        <item>file</item>
+        <item>dir</item>
+        <item>char</item>
+        <item>socket</item>
+        <item>pipe</item>
+        <item>symlink</item>
+        <item>any</item>
+        <item>xattr</item>
+        <item>task</item>
+        <item>trans</item>
+        <item>source</item>
+        <item>target</item>
+        <item>low</item>
+        <item>high</item>
+        <item>low-high</item>
+        <item>glblub</item>
+    </list>
+    <highlighting>
+        <contexts>
+            <context name="Normal" attribute="Normal" lineEndContext="#stay">
+                <keyword attribute="Keyword" context="#stay" String="keywords"/>
+                <keyword attribute="Function" context="#stay" String="function"/>
+                <keyword attribute="Operator" context="#stay" String="operators"/>
+                <keyword attribute="Builtin" context="#stay" String="builtins"/>
+
+                <DetectChar attribute="Comment" context="Comment" char=";"/>
+                <DetectChar attribute="String" context="String" char="&quot;"/>
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
+        <keywords casesensitive="1"/>
+    </general>
+</language>
-- 
2.30.0

