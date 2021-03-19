Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D8C433C1
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 21:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8036661988
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 21:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCSVbh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230476AbhCSVbG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Mar 2021 17:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616189466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3r7wDSPW7gW5regwfKqsB4CZMzTy4wgfpfjq2KAF02M=;
        b=ZtgmBQHH6GXLax4PUOLqZ632barP+sE+DF0BHIKQQ6xh8ycsiqDIm6Bwl8GPOj0/+vg5HA
        L2L0gx2n0marVzQOWvaGKCaBgPkyLxNzKMaXAiRiyFXQ4WvwLJwcDBy6fRpn21oVreCkYb
        PwL5nGLb/Qz392rKeViqEy58Tpuzx4Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-NZWOpzOSPWST6-G08lEaNg-1; Fri, 19 Mar 2021 17:31:03 -0400
X-MC-Unique: NZWOpzOSPWST6-G08lEaNg-1
Received: by mail-ej1-f70.google.com with SMTP id h14so18844117ejg.7
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 14:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3r7wDSPW7gW5regwfKqsB4CZMzTy4wgfpfjq2KAF02M=;
        b=EfVx40/N87dWS7uxbotj8fi5FkChP5wwyarRAcHFzf6TzUZ+uISSDfcSP3li4vqOSK
         xWnmiyhk+cJRxkGny5kUcCuFenVoFeaWFWlyeTKbVGpduMgekkt06y4ciSirRrZBhm1C
         JF1/ePXljav68u+MT/TkxwsLyktIsLHgbcang7kV+xhP42w3h6QIwjlXCiGuIh0YEOaf
         0PzlcESHA6OlsWfCl2mrBhCdT4mEqzE+6LgKn4d8EUFZZsVG2So9B2fXTHBAbWoKNsZS
         nTbhQ9f+uQAkKZx8qBikh/VMNbjdVSxAZnhC3KjYvGFMTBx9A9uNGUVai0QngHYglN14
         utWg==
X-Gm-Message-State: AOAM533VNoL9Yk1HTcV1sRjsRq2+pREFJaqqIjc0LTaawLHy7mpaQfpV
        GG3HV4L0cYHsbO0Smp+MqaI5bn0Xfayl5exXhRthOz4luG4cBWVzj0nCYOOyO1QZ9/IVgh/Mxwh
        CmNoc3W/GcaBCmR+mpUfclj0hOk5T/SQ8W25cnaJMs7d+paiMVCX9PgtRR33SmF2fDEXcuA==
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr12258667edb.104.1616189462378;
        Fri, 19 Mar 2021 14:31:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYJnkFaG2d4ke+i6wUuWajiz0Kci0ZRi+ar5uZxn9z1MHrM2vlkPbve0VAlXl2pC4mGYfl0A==
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr12258655edb.104.1616189462238;
        Fri, 19 Mar 2021 14:31:02 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id d1sm4344289eje.26.2021.03.19.14.31.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:31:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] policycoreutils/setfiles: do not create useless setfiles.8.man file
Date:   Fri, 19 Mar 2021 22:30:59 +0100
Message-Id: <20210319213059.2779873-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Seems to have been there to allow for some sed substitution over the
text. Now that this is gone, the redundant intermediate file can be
removed, too.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/setfiles/.gitignore | 1 -
 policycoreutils/setfiles/Makefile   | 9 +++------
 2 files changed, 3 insertions(+), 7 deletions(-)
 delete mode 100644 policycoreutils/setfiles/.gitignore

diff --git a/policycoreutils/setfiles/.gitignore b/policycoreutils/setfiles/.gitignore
deleted file mode 100644
index 5e899c95..00000000
--- a/policycoreutils/setfiles/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-setfiles.8.man
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index a3bbbe11..63d81850 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -13,7 +13,7 @@ ifeq ($(AUDITH), y)
 	override LDLIBS += -laudit
 endif
 
-all: setfiles restorecon restorecon_xattr man
+all: setfiles restorecon restorecon_xattr
 
 setfiles: setfiles.o restore.o
 
@@ -22,16 +22,13 @@ restorecon: setfiles
 
 restorecon_xattr: restorecon_xattr.o restore.o
 
-man:
-	@cp -af setfiles.8 setfiles.8.man
-
 install: all
 	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
 	-mkdir -p $(DESTDIR)$(SBINDIR)
 	install -m 755 setfiles $(DESTDIR)$(SBINDIR)
 	(cd $(DESTDIR)$(SBINDIR) && ln -sf setfiles restorecon)
 	install -m 755 restorecon_xattr $(DESTDIR)$(SBINDIR)
-	install -m 644 setfiles.8.man $(DESTDIR)$(MANDIR)/man8/setfiles.8
+	install -m 644 setfiles.8 $(DESTDIR)$(MANDIR)/man8/setfiles.8
 	install -m 644 restorecon.8 $(DESTDIR)$(MANDIR)/man8/restorecon.8
 	install -m 644 restorecon_xattr.8 $(DESTDIR)$(MANDIR)/man8/restorecon_xattr.8
 	for lang in $(LINGUAS) ; do \
@@ -42,7 +39,7 @@ install: all
 	done
 
 clean:
-	rm -f setfiles restorecon restorecon_xattr *.o setfiles.8.man
+	rm -f setfiles restorecon restorecon_xattr *.o
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])
-- 
2.30.2

