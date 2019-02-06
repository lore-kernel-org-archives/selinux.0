Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D8C169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BB92080D
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 19:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfBFTmB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:42:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfBFTmB (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Feb 2019 14:42:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25EF8C079C5B
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 19:42:01 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BBD67C821;
        Wed,  6 Feb 2019 19:42:00 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Vit Mojzis <vmojzis@redhat.com>
Subject: [PATCH] gui: Make all polgen button labels translatable
Date:   Wed,  6 Feb 2019 20:41:56 +0100
Message-Id: <20190206194156.24804-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 06 Feb 2019 19:42:01 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Vit Mojzis <vmojzis@redhat.com>

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 gui/polgen.ui | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gui/polgen.ui b/gui/polgen.ui
index aa4c70af..6a8c0672 100644
--- a/gui/polgen.ui
+++ b/gui/polgen.ui
@@ -1975,7 +1975,7 @@ Tab</property>
                                       <object class="GtkLabel" id="label17">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
-                                        <property name="label">Add File</property>
+                                        <property name="label" translatable="yes">Add File</property>
                                         <property name="use_underline">True</property>
                                       </object>
                                       <packing>
@@ -2028,7 +2028,7 @@ Tab</property>
                                       <object class="GtkLabel" id="label16">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
-                                        <property name="label">Add Directory</property>
+                                        <property name="label" translatable="yes">Add Directory</property>
                                         <property name="use_underline">True</property>
                                       </object>
                                       <packing>
@@ -2176,7 +2176,7 @@ Tab</property>
                                       <object class="GtkLabel" id="label3">
                                         <property name="visible">True</property>
                                         <property name="can_focus">False</property>
-                                        <property name="label">Add Boolean</property>
+                                        <property name="label" translatable="yes">Add Boolean</property>
                                         <property name="use_underline">True</property>
                                       </object>
                                       <packing>
-- 
2.20.1

