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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A0BC433DB
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E6464D99
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 16:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhBJQAF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhBJP74 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 10:59:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DFC0613D6
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 07:59:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q2so3575883eds.11
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLxDS/ma+Dj4gpXB2GJ6Z+Xuj5PCOWT/jOJ94llx7bs=;
        b=OzxOBgQkpjWZ5nweHesJ4r3bnVqV7ezEQcF02zo4TUWfqyGSnGfmuf6z3ekjF/S/hG
         j6qBTuwbx5jk7nzxNZbR211BKVjQziHrS8DSFSl1FHZ6J2YRq08LT5SrUNF8/c1Oavb+
         gmRtOFcp6rGbBKmFGxU9n/w2qY9jUkBM30Run1Ew6po+KWAKQa9OiuFRhl0o2csYniq8
         0AY/1T2MkeYcmvTxDGUW/+5ZJ1FeAUwjw22Y05sDNdOqanLx7bueepwnGOUPKmgRkapJ
         CRaerLigMCKZNhJZ/0No2rMJkcw8/RYA8mZ6Zs2Hd8DCkGQ1BHY1ZsYBu4u6Zy58QREm
         OFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLxDS/ma+Dj4gpXB2GJ6Z+Xuj5PCOWT/jOJ94llx7bs=;
        b=eJOPaBL8hA0hEkCEBlm3iB//lT4N7KI18mdvALfQZYo4TarjWbybGiYdJChEv3nfIJ
         ZCi1M04wsSjyNUCsM90642DwQ3Thk0gFc6YQVQrQ8tklIBjAUJtt2iMlmWq1anELLQdY
         DeF6PQcuOoIO8fcfMFitBJTs5fqr87w+VL/8657zvMJi4t+FIeGjHQAQz9hUI49YhTmI
         0/kArIoXuyYO1xZJUpp1/orLnQwcLmBePtZwJ4hLIxqMlyfKztJvWJ605qyz0CwfjvgE
         WqyyUuMr9seaQ3FrAbh77ccBs6GZtmqCDrmonuSt7mvZekV9KOtoDHrWxHjf5Kxp17/r
         6/CQ==
X-Gm-Message-State: AOAM531H2m39OYvpXYvX54YfKNgYMcZQOzB6iKzbfXPza5O3E+Gd7HTo
        xvoqrGkkdQntW1cEzDcbMkg=
X-Google-Smtp-Source: ABdhPJxp6IROOMZ6kWfrzotMSOFRgcIxxmDB3GbAwwx42+Bzx9C3Bvz0PpyydjNMZy1ogz7riMO3Ig==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr3678428edd.49.1612972754649;
        Wed, 10 Feb 2021 07:59:14 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id a6sm1530618ejs.79.2021.02.10.07.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:59:14 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v3 2/3] secilc/docs: add syntax highlighting for secil
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
Message-ID: <cd04be3b-1253-69d0-573f-ab24ebb78b06@gmail.com>
Date:   Wed, 10 Feb 2021 16:59:13 +0100
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

v3:
    No changes

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

