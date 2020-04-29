Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB7C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 17:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBD020787
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 17:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMk68YDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2RTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2RTn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 13:19:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F0C03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 10:19:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so3457692ljn.7
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eInYuXv9TVeiyijcjYqvIHw5mmnGEy97J1uJ8hMlwF4=;
        b=OMk68YDFRryHJRVaI48mPNqmTBUSgwdyON/3fcZEL4nGQ9B/bg0A8sBd3+rMkBHjBG
         JdAbiTL4erqPMELNMFiGEbxgjtaPEM7kr2grzcxofJQAaMRAR2OXvR41iP/VGwluJHTg
         4hL4/PlJM2Odiclk+pv70VORX20qiGeKiuEDIGQJDEyUr2aGYCWF1es7EyjFtcneoJIl
         /aPjbJCNdJcrzbBBwmtSXqJaOvjBuc2875hys3MR/M2vWT/ykGGs/4MVz3bws0NrNYMS
         shiMY0mTR7XlHXTEUFFfhjvWpMqNTli+dMs55aM6vJquyOTSC/by8go06AXvo9sR1Aor
         mnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eInYuXv9TVeiyijcjYqvIHw5mmnGEy97J1uJ8hMlwF4=;
        b=egbnoYBb3Klsmo/ZNVgDTflt28IasRncbykt2eijNbk2WRATLW3gGOJxfjJSKpA7aa
         wM6OHYSkZtYd4u+xNV8Z7w0CoR3TOFxkhC/Ozb1UJl6W8TXuKRFHFIKON8g8Am+8RHlm
         OOAQSDEGX4J8YDgOf2dWC7gCHrLNiApwb1Iw2cG+n1/NkzrVJUE2XlQhoRLWquWErNrH
         n9imUJu3RTJLdlJ4ccdxL6zLcrydZToidPRWbLK1rUc/abT5VWBsPLtq1xWnY9g0OFWp
         QKdiiB9O1ceqEqdnYD8ZX7OiQ6AgbCD3iBdksd3NZvedNE1mBoXTgHqBsWqo4gcE4/zZ
         19bQ==
X-Gm-Message-State: AGi0Pub5/aRfia7RK9YW/oFytYq1/ECONwhLriklB+ofWNdsf9sjuUwe
        5s8XJXJjPLWEkDii4yYy7PERL/VI
X-Google-Smtp-Source: APiQypLHCa9eHaBxyyWydbfc+fy6YsfRJoV8snvo2CTMYBoZetzBZletbyo4bZqW+Y5ovTQ33vQQUw==
X-Received: by 2002:a2e:6a08:: with SMTP id f8mr22588737ljc.8.1588180781288;
        Wed, 29 Apr 2020 10:19:41 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id i14sm3027780lfl.21.2020.04.29.10.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:19:40 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] sepolicy-gui: fix columns in transitions view #232
Date:   Wed, 29 Apr 2020 20:19:35 +0300
Message-Id: <20200429171935.8619-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Delete an unused column from view "Application Transitions From". The
second column displays names of the executable files instead of
booleans.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/sepolicy/sepolicy/sepolicy.glade | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
index 8f6ad650..52407887 100644
--- a/python/sepolicy/sepolicy/sepolicy.glade
+++ b/python/sepolicy/sepolicy/sepolicy.glade
@@ -2876,20 +2876,10 @@ Enabled</property>
                                             </child>
                                           </object>
                                         </child>
-                                        <child>
-                                          <object class="GtkTreeViewColumn" id="treeviewcolumn27">
-                                            <child>
-                                              <object class="GtkCellRendererText" id="cellrenderertext34"/>
-                                              <attributes>
-                                                <attribute name="text">1</attribute>
-                                              </attributes>
-                                            </child>
-                                          </object>
-                                        </child>
                                         <child>
                                           <object class="GtkTreeViewColumn" id="executable_file_from">
                                             <property name="resizable">True</property>
-                                            <property name="title" translatable="yes">Boolean name</property>
+                                            <property name="title" translatable="yes">Executable File</property>
                                             <property name="expand">True</property>
                                             <property name="clickable">True</property>
                                             <property name="reorderable">True</property>
-- 
2.26.2

