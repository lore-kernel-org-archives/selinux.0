Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C454BC433FE
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 14:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJKOgn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJKOgi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 10:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C85E33C
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665498993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nJOKUlPw4pQ1qqMDyZbANcshXutyeSid07MqiDfldd0=;
        b=T15lPGkx4V9SLNpw0uUj+tkBVO6glenJYfE9260TDYO9lGDanmmi0p2sAzNWrxZJzb+US0
        UX251M+XHUL9yZ1GukV4n3ihSBpXRuou1ATpIf3spcBu0+qJnm66eJ3erHrJUfFRc017Xr
        pfxFzpjqHzRgGMZ2m9WJ8j90K+nfENU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-8IstuRkOPMiC3ll-2D41Iw-1; Tue, 11 Oct 2022 10:36:26 -0400
X-MC-Unique: 8IstuRkOPMiC3ll-2D41Iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BE71101CC6B
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-194-111.brq.redhat.com [10.40.194.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 093EE112D415;
        Tue, 11 Oct 2022 14:36:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] gui: Fix export file chooser dialog
Date:   Tue, 11 Oct 2022 16:36:23 +0200
Message-Id: <20221011143623.208283-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It wasn't possible to choose a directory in filechooser dialog using
double-click - the dialog returned the directory name instead of
listing the directory.

Fixes:
Traceback (most recent call last):
  File "/usr/lib/python3.10/site-packages/sepolicy/gui.py", line 2593, in on_browse_select
    self.export_config(filename)
  File "/usr/lib/python3.10/site-packages/sepolicy/gui.py", line 2668, in export_config
    fd = open(filename, 'w')
IsADirectoryError: [Errno 21] Is a directory: '/root/Downloads'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/sepolicy.glade | 1 -
 1 file changed, 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
index 52407887fcfc..0724d6c8caa4 100644
--- a/python/sepolicy/sepolicy/sepolicy.glade
+++ b/python/sepolicy/sepolicy/sepolicy.glade
@@ -168,7 +168,6 @@
       <object class="GtkBox" id="filechooserdialog-vbox1">
         <property name="can_focus">False</property>
         <property name="orientation">vertical</property>
-        <signal name="button-press-event" handler="on_choose_file" swapped="no"/>
         <child internal-child="action_area">
           <object class="GtkButtonBox" id="filechooserdialog-action_area1">
             <property name="can_focus">False</property>
-- 
2.37.3

