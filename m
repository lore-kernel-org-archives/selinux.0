Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616F7C0502A
	for <selinux@archiver.kernel.org>; Sun, 28 Aug 2022 12:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiH1MO0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Aug 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH1MOZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Aug 2022 08:14:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B11C928
        for <selinux@vger.kernel.org>; Sun, 28 Aug 2022 05:14:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso1484331wmq.1
        for <selinux@vger.kernel.org>; Sun, 28 Aug 2022 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc;
        bh=FWOPtWEPXB8HV7+NiaCnk4VGrD2RIAQvaijhjOW/o1w=;
        b=Uq5QWJ2GjZwViFErddPU562eW8P4d7jRyRE4FOAGnW/XXYd+sCPOXzBXjeSM9ijyO1
         rcAlDIRtg5d9LJ/ZSYK+1DgQMRB/PDN6j6pokIrP6Uq5og5KTnZUiizGCAnz6y/t0FGK
         mI5urN/LRtHL0ib5irdGipAXCoI8CyeWTTZ/W7dLK9ptV3F3LqwldkE4FIZKL4A4cyxs
         0cJMUdi+oRrhy0kPbS6FtfCq89hmSl6ddTpcq+EUVYQmc9a9MIHYVQ9wrhd0aBQKSqkX
         N4wrBH4HxDq5DKJSO7hC6dDWm4H6i2QlI3jXmhXV5Wfrqk+T90w8aeW+ALp9N6Nx4A4r
         uhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc;
        bh=FWOPtWEPXB8HV7+NiaCnk4VGrD2RIAQvaijhjOW/o1w=;
        b=P7b0yPPZ5sAGUE6q1zj83dzh+hOkAx0T0HEp2S1pHwCIijn64wsjV+ONLpS4RHBt1l
         FfHGXA1nCc2v9J9Wrb3COWUYdZW6Gg1t09oCDtz0u2aDpupIfR1vCBgd8/MRW+H61DM+
         o8m2HEEwadKfCzReiWAqbNsxjRZUGp3d1y8MIfKlDECDV6b830MD5DdnX76eRBDLVYDy
         elbP4pzdPHVy+D8mniXs2086DtHMOgYSuIJzNWJYm1hKxSHQ3q5tndWLVYKWrCS7YAsY
         y/ez4KQWbHiG4AkdYNRvAT1ucUmhrRkm368Q1BR8e8Xl3G6bkPlz7sUOhQJJwrqz7s6F
         xoiQ==
X-Gm-Message-State: ACgBeo3IjqLACyy1qi+C/ggEvCqNdDHr+SuYHWLfwDyFAllDkoCBqKe8
        dV6XyagADiUF/35dZiMONjsZC7WrtHs=
X-Google-Smtp-Source: AA6agR4wKoJ+N9u3VJGBy8J63lDgssuFxiwsH1jx0hmgSjDbBEGhupAfCHWlIY5TBBNX637ALVTQfw==
X-Received: by 2002:a7b:c5d3:0:b0:3a8:3d5f:4562 with SMTP id n19-20020a7bc5d3000000b003a83d5f4562mr3357406wmk.78.1661688862603;
        Sun, 28 Aug 2022 05:14:22 -0700 (PDT)
Received: from ?IPV6:2001:a61:3450:ee01:9da9:8337:59d2:c8c4? ([2001:a61:3450:ee01:9da9:8337:59d2:c8c4])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b002253604bbefsm4498577wrb.75.2022.08.28.05.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:14:22 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <50b132b2-3adb-042b-647d-962baf228701@gmail.com>
Date:   Sun, 28 Aug 2022 14:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: [PATCH 2/3] secilc/docs: fix syntax highlighting
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@googlemail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It appears that a recent version of pandoc (or the library it uses)
changed where the lists are found in the XML or became more strict.

Move the lists to the right location in the document.

Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>
---
  secilc/docs/secil.xml | 344 +++++++++++++++++++++---------------------
  1 file changed, 172 insertions(+), 172 deletions(-)

diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
index b015490d..38d7b030 100644
--- a/secilc/docs/secil.xml
+++ b/secilc/docs/secil.xml
@@ -2,182 +2,182 @@
  <!-- https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format -->
  <!DOCTYPE language SYSTEM "language.dtd">
  <language name="secil" section="Sources" extensions="*.cil" version="1" kateversion="2.4">
-    <!--
-        The keywords where extracted from libsepol/cil/src/cil.c sorted into the
-        right lists and sorted alphabetically
-    -->
-    <list name="keywords_blockstart">
-        <item>allow</item>
-        <item>allowx</item>
-        <item>auditallow</item>
-        <item>auditallowx</item>
-        <item>block</item>
-        <item>blockabstract</item>
-        <item>boolean</item>
-        <item>booleanif</item>
-        <item>category</item>
-        <item>categoryalias</item>
-        <item>categoryaliasactual</item>
-        <item>categoryorder</item>
-        <item>categoryset</item>
-        <item>class</item>
-        <item>classcommon</item>
-        <item>classmap</item>
-        <item>classmapping</item>
-        <item>classorder</item>
-        <item>classpermission</item>
-        <item>classpermissionset</item>
-        <item>common</item>
-        <item>constrain</item>
-        <item>context</item>
-        <item>defaultrange</item>
-        <item>defaultrole</item>
-        <item>defaulttype</item>
-        <item>defaultuser</item>
-        <item>devicetreecon</item>
-        <item>dontaudit</item>
-        <item>dontauditx</item>
-        <item>expandtypeattribute</item>
-        <item>false</item>
-        <item>filecon</item>
-        <item>fsuse</item>
-        <item>genfscon</item>
-        <item>handleunknown</item>
-        <item>ibendportcon</item>
-        <item>ibpkeycon</item>
-        <item>ioctl</item>
-        <item>iomemcon</item>
-        <item>ioportcon</item>
-        <item>ipaddr</item>
-        <item>level</item>
-        <item>levelrange</item>
-        <item>mls</item>
-        <item>mlsconstrain</item>
-        <item>mlsvalidatetrans</item>
-        <item>netifcon</item>
-        <item>neverallow</item>
-        <item>neverallowx</item>
-        <item>nodecon</item>
-        <item>optional</item>
-        <item>pcidevicecon</item>
-        <item>perm</item>
-        <item>permissionx</item>
-        <item>pirqcon</item>
-        <item>policycap</item>
-        <item>portcon</item>
-        <item>rangetransition</item>
-        <item>role</item>
-        <item>roleallow</item>
-        <item>roleattribute</item>
-        <item>roleattributeset</item>
-        <item>rolebounds</item>
-        <item>roletransition</item>
-        <item>roletype</item>
-        <item>selinuxuser</item>
-        <item>selinuxuserdefault</item>
-        <item>sensitivity</item>
-        <item>sensitivityalias</item>
-        <item>sensitivityaliasactual</item>
-        <item>sensitivitycategory</item>
-        <item>sensitivityorder</item>
-        <item>sid</item>
-        <item>sidcontext</item>
-        <item>sidorder</item>
-        <item>true</item>
-        <item>tunable</item>
-        <item>tunableif</item>
-        <item>type</item>
-        <item>typealias</item>
-        <item>typealiasactual</item>
-        <item>typeattribute</item>
-        <item>typeattributeset</item>
-        <item>typebounds</item>
-        <item>typechange</item>
-        <item>typemember</item>
-        <item>typepermissive</item>
-        <item>typetransition</item>
-        <item>unordered</item>
-        <item>user</item>
-        <item>userattribute</item>
-        <item>userattributeset</item>
-        <item>userbounds</item>
-        <item>userlevel</item>
-        <item>userprefix</item>
-        <item>userrange</item>
-        <item>userrole</item>
-        <item>validatetrans</item>
-    </list>
+    <highlighting>
+        <!--
+            The keywords where extracted from libsepol/cil/src/cil.c sorted into the
+            right lists and sorted alphabetically
+        -->
+        <list name="keywords_blockstart">
+            <item>allow</item>
+            <item>allowx</item>
+            <item>auditallow</item>
+            <item>auditallowx</item>
+            <item>block</item>
+            <item>blockabstract</item>
+            <item>boolean</item>
+            <item>booleanif</item>
+            <item>category</item>
+            <item>categoryalias</item>
+            <item>categoryaliasactual</item>
+            <item>categoryorder</item>
+            <item>categoryset</item>
+            <item>class</item>
+            <item>classcommon</item>
+            <item>classmap</item>
+            <item>classmapping</item>
+            <item>classorder</item>
+            <item>classpermission</item>
+            <item>classpermissionset</item>
+            <item>common</item>
+            <item>constrain</item>
+            <item>context</item>
+            <item>defaultrange</item>
+            <item>defaultrole</item>
+            <item>defaulttype</item>
+            <item>defaultuser</item>
+            <item>devicetreecon</item>
+            <item>dontaudit</item>
+            <item>dontauditx</item>
+            <item>expandtypeattribute</item>
+            <item>false</item>
+            <item>filecon</item>
+            <item>fsuse</item>
+            <item>genfscon</item>
+            <item>handleunknown</item>
+            <item>ibendportcon</item>
+            <item>ibpkeycon</item>
+            <item>ioctl</item>
+            <item>iomemcon</item>
+            <item>ioportcon</item>
+            <item>ipaddr</item>
+            <item>level</item>
+            <item>levelrange</item>
+            <item>mls</item>
+            <item>mlsconstrain</item>
+            <item>mlsvalidatetrans</item>
+            <item>netifcon</item>
+            <item>neverallow</item>
+            <item>neverallowx</item>
+            <item>nodecon</item>
+            <item>optional</item>
+            <item>pcidevicecon</item>
+            <item>perm</item>
+            <item>permissionx</item>
+            <item>pirqcon</item>
+            <item>policycap</item>
+            <item>portcon</item>
+            <item>rangetransition</item>
+            <item>role</item>
+            <item>roleallow</item>
+            <item>roleattribute</item>
+            <item>roleattributeset</item>
+            <item>rolebounds</item>
+            <item>roletransition</item>
+            <item>roletype</item>
+            <item>selinuxuser</item>
+            <item>selinuxuserdefault</item>
+            <item>sensitivity</item>
+            <item>sensitivityalias</item>
+            <item>sensitivityaliasactual</item>
+            <item>sensitivitycategory</item>
+            <item>sensitivityorder</item>
+            <item>sid</item>
+            <item>sidcontext</item>
+            <item>sidorder</item>
+            <item>true</item>
+            <item>tunable</item>
+            <item>tunableif</item>
+            <item>type</item>
+            <item>typealias</item>
+            <item>typealiasactual</item>
+            <item>typeattribute</item>
+            <item>typeattributeset</item>
+            <item>typebounds</item>
+            <item>typechange</item>
+            <item>typemember</item>
+            <item>typepermissive</item>
+            <item>typetransition</item>
+            <item>unordered</item>
+            <item>user</item>
+            <item>userattribute</item>
+            <item>userattributeset</item>
+            <item>userbounds</item>
+            <item>userlevel</item>
+            <item>userprefix</item>
+            <item>userrange</item>
+            <item>userrole</item>
+            <item>validatetrans</item>
+        </list>
  
-    <list name="function">
-        <item>blockinherit</item>
-        <item>call</item>
-        <item>in</item>
-        <item>macro</item>
-    </list>
+        <list name="function">
+            <item>blockinherit</item>
+            <item>call</item>
+            <item>in</item>
+            <item>macro</item>
+        </list>
  
-    <list name="operators">
-        <item>and</item>
-        <item>dom</item>
-        <item>domby</item>
-        <item>eq</item>
-        <item>incomp</item>
-        <item>neq</item>
-        <item>not</item>
-        <item>or</item>
-        <item>range</item>
-        <item>xor</item>
-    </list>
+        <list name="operators">
+            <item>and</item>
+            <item>dom</item>
+            <item>domby</item>
+            <item>eq</item>
+            <item>incomp</item>
+            <item>neq</item>
+            <item>not</item>
+            <item>or</item>
+            <item>range</item>
+            <item>xor</item>
+        </list>
  
-    <!-- list of "magic" functions or values -->
-    <list name="builtins">
-        <item>*</item>
-        <item>all</item>
-        <item>dccp</item>
-        <item>false</item>
-        <item>h1</item>
-        <item>h2</item>
-        <item>l1</item>
-        <item>l2</item>
-        <item>object_r</item>
-        <item>r1</item>
-        <item>r2</item>
-        <item>r3</item>
-        <item>sctp</item>
-        <item>self</item>
-        <item>t1</item>
-        <item>t2</item>
-        <item>t3</item>
-        <item>tcp</item>
-        <item>true</item>
-        <item>u1</item>
-        <item>u2</item>
-        <item>u3</item>
-        <item>udp</item>
+        <!-- list of "magic" functions or values -->
+        <list name="builtins">
+            <item>*</item>
+            <item>all</item>
+            <item>dccp</item>
+            <item>false</item>
+            <item>h1</item>
+            <item>h2</item>
+            <item>l1</item>
+            <item>l2</item>
+            <item>object_r</item>
+            <item>r1</item>
+            <item>r2</item>
+            <item>r3</item>
+            <item>sctp</item>
+            <item>self</item>
+            <item>t1</item>
+            <item>t2</item>
+            <item>t3</item>
+            <item>tcp</item>
+            <item>true</item>
+            <item>u1</item>
+            <item>u2</item>
+            <item>u3</item>
+            <item>udp</item>
  
-        <!--
-            Excluded because they lead to a lot of false-positives
-        <item>allow</item>
-        <item>any</item>
-        <item>char</item>
-        <item>deny</item>
-        <item>dir</item>
-        <item>file</item>
-        <item>glblub</item>
-        <item>high</item>
-        <item>low-high</item>
-        <item>low</item>
-        <item>pipe</item>
-        <item>reject</item>
-        <item>socket</item>
-        <item>source</item>
-        <item>symlink</item>
-        <item>target</item>
-        <item>task</item>
-        <item>trans</item>
-        <item>xattr</item>
-        -->
-    </list>
-    <highlighting>
+            <!--
+                Excluded because they lead to a lot of false-positives
+            <item>allow</item>
+            <item>any</item>
+            <item>char</item>
+            <item>deny</item>
+            <item>dir</item>
+            <item>file</item>
+            <item>glblub</item>
+            <item>high</item>
+            <item>low-high</item>
+            <item>low</item>
+            <item>pipe</item>
+            <item>reject</item>
+            <item>socket</item>
+            <item>source</item>
+            <item>symlink</item>
+            <item>target</item>
+            <item>task</item>
+            <item>trans</item>
+            <item>xattr</item>
+            -->
+        </list>
          <contexts>
              <context name="Normal" attribute="Normal" lineEndContext="#stay">
                  <DetectChar attribute="Brackets" context="BlockStart" char="("/>
-- 
2.36.1

