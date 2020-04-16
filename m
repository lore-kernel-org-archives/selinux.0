Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A75C3815B
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAECD214AF
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCH/URW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408887AbgDPPoZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437796AbgDPPoV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063E5C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so1823386pgg.2
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udMYv4KCCPv1msDPSSZX+YXwuWEwFbaHQfw+epucwgs=;
        b=ZCH/URW+9Y4BxJna5er0cXu/lAygyAFkAjTIXcokdZ5Vt8WFc4BO98pKwBptnKjbHT
         Kn3tXSnrFK9ahp0PyxV3QaR3OvcczW4fG9MbtszHe0ZjBkJIBqphHvPBBaiP8p0NEbCK
         MX8CJbf953M6lLmvrY1ylFJ5jLK6Q4dV/RyfFrcbYEbnWgb2f/03Ke0toaZDmB8Yt1vr
         C/iYvXf6lit/e/fS+0S0IP2WauD0iA9xuqGZemy50E9B7R8za38J7uLoda6cFsla9X3V
         Sr5tR/ogVe7Fwrw+JyK/CTv0MMpt4No0rFcvY/KWqn7xEct9s9DUHvysjc4Nkndx4nJ/
         iejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udMYv4KCCPv1msDPSSZX+YXwuWEwFbaHQfw+epucwgs=;
        b=Yl+Yyk4KCzMAughOjlLhIyGB4+LW+jFZeWABSwtzU96ZLnd9nUSwSzKfubz605x+Tp
         v+NcFcqtOryWN3oGSuSgwYtWYkOezGX/WU0mOSHKGN8RGwmK/3laIWl6U7R+TGol5QCg
         fSb1RribWpfplYCjdMQ6WmkZr+/tmlJrIvV+u6Q1lCZA1w9F78xsMMPbF4IVGsCeAOEz
         hTVaoth5ThPi14mTRlxECgKZ24KSAQ/LXITmccmapDoWKT6XgsEYbZBnZ42Qz0BWdLq9
         7AQ6FztCrQX02tdfqnlf3WGImxsUNV1xPexYmV6eF/Gyaw5Lu2zJF3bLm69ktw49c4sn
         R6ug==
X-Gm-Message-State: AGi0Pub2cbBtw4aqxeHlITfQqpIYfi+w3LHlscbj36cf770A6kJbYuqI
        3DEKEMO2EVkCARS+NQ10kB0NfVXEUEM=
X-Google-Smtp-Source: APiQypIKpaSfHBP/C5DyvacwIdZAf+PwI/Zo6Y6Mu3QcTyvgBaykhka5A2aO44/4Tl6UbFGtTznspg==
X-Received: by 2002:a63:545:: with SMTP id 66mr24304423pgf.66.1587051860517;
        Thu, 16 Apr 2020 08:44:20 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:20 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 08/18] checkPasswdAccess: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:42 -0500
Message-Id: <20200416154352.21619-9-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 0b99850ad23d..2767daff17e7 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -607,7 +607,8 @@ extern int selinux_check_access(const char * scon, const char * tcon, const char
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
 extern int selinux_check_passwd_access(access_vector_t requested);
-extern int checkPasswdAccess(access_vector_t requested);
+extern int checkPasswdAccess(access_vector_t requested)
+   __attribute__ ((deprecated("Use selinux_check_access")));
 
 /* Check if the tty_context is defined as a securetty
    Return 0 if secure, < 0 otherwise. */
-- 
2.17.1

