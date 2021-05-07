Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA1C433ED
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F11A6144F
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhEGL62 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 07:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235605AbhEGL61 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 07:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620388647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YXvAn6PhmCpGYLW0QYPpJQEW72/FRvqimCSflbY0beM=;
        b=IScXL8azk/nILs9p3STiE/MO+2GH9VPrd1fl64vUOagS+YFFVbZ6rNzc5ZSNBCkMWOOSJ5
        pGewXPmfHUnqNuwbJoJu1Em5yCHxbNM/phoh9DJa2AAfU3kd/dWqfh4+e8LpFq+VhBkGcl
        ZKjcSyFlJ/F8ni86UCfq0R+sH4ueM4E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-so7wZHivPWWQOA-JLpiecg-1; Fri, 07 May 2021 07:57:25 -0400
X-MC-Unique: so7wZHivPWWQOA-JLpiecg-1
Received: by mail-ej1-f70.google.com with SMTP id k9-20020a17090646c9b029039d323bd239so2891362ejs.16
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 04:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXvAn6PhmCpGYLW0QYPpJQEW72/FRvqimCSflbY0beM=;
        b=Q7fxVnzKjjH0PGoWYIE99lWrHJkiSox962ereLNbSqKy0BLZFpnYWaMTrLrTlLFL3n
         XwLkixD6Mi7BELGNqRJRFuPzzjgwuri+R5eaLX+exKss65RAR0mzgUztXR1rQrJ9al8c
         Oqvfs5ZHSS6OSe9Kti9YO0SGSvfwSJZl5OCfFIJN7KR/gOg0FKRkwZ1AyCsOSenYwt1+
         LB21ofL1DmrhVhX7+XShJ8QXth9wvdCrQxHpjOwDqu8VrxhB3TJ8OKmOHUYO78t4P1pP
         5Bk16OqRW17czA66pyagXbWL0Qq9vl/QLSucmf3eg7qzoDQI/GnrDi1ICdTS2Ifc+Dcx
         8XeA==
X-Gm-Message-State: AOAM533LH+IC27zHg1RAb/mPSk8KS0GbUJBFoex6hZLpDHithsEpfumG
        6NYfltJRPaJqTqHvNP2oJ5GX5ZUKP0fuE+EViYrS6Zhpjq2nA2Vs2bxW+prNn1zINhGxe5cjuUT
        ZcyMEcO46QuMwpYiMwg==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr10961521edd.345.1620388644409;
        Fri, 07 May 2021 04:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0mUjelRd+5LBa+/SoDUEq7Qu7Gn0SmyPwD91nNDesN5xWttmUuZOfJ500zMk6FJ/yUea2gQ==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr10961502edd.345.1620388644218;
        Fri, 07 May 2021 04:57:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id l7sm3657324ejk.115.2021.05.07.04.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:57:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: fix suspicious security_locked_down() call
Date:   Fri,  7 May 2021 13:57:19 +0200
Message-Id: <20210507115719.140799-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The commit that added this check did so in a very strange way - first
security_locked_down() is called, its value stored into retval, and if
it's nonzero, then an additional check is made for (change_irq ||
change_port), and if this is true, the function returns. However, if
the goto exit branch is not taken, the code keeps the retval value and
continues executing the function. Then, depending on whether
uport->ops->verify_port is set, the retval value may or may not be reset
to zero and eventually the error value from security_locked_down() may
abort the function a few lines below.

I will go out on a limb and assume that this isn't the intended behavior
and that an error value from security_locked_down() was supposed to
abort the function only in case (change_irq || change_port) is true.

Note that security_locked_down() should be called last in any series of
checks, since the SELinux implementation of this hook will do a check
against the policy and generate an audit record in case of denial. If
the operation was to carry on after calling security_locked_down(), then
the SELinux denial record would be bogus.

See commit 59438b46471a ("security,lockdown,selinux: implement SELinux
lockdown") for how SELinux implements this hook.

Fixes: 794edf30ee6c ("lockdown: Lock down TIOCSSERIAL")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 drivers/tty/serial/serial_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ba31e97d3d96..d7d8e7dbda60 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -865,9 +865,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		goto check_and_exit;
 	}
 
-	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
-	if (retval && (change_irq || change_port))
-		goto exit;
+	if (change_irq || change_port) {
+		retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+		if (retval)
+			goto exit;
+	}
 
 	/*
 	 * Ask the low level driver to verify the settings.
-- 
2.31.1

