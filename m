Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE01C8300B
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 11:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9FE20757
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 11:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhIL3w5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD3LIy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:08:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50440 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbgD3LIy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 07:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588244933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAObJN9z1K+j9lDUpqQHrmmHc+cXp4cnPTyO5W+ullk=;
        b=OhIL3w5jkqGs5gqXrgrdgDLhWzjIu0Htz+cNE7cnoJfkYUV0OSy/13UU6DdRZW1Ad5ZOTK
        oC+SI81P/O6Vzdq4N5XtDBTrcE14CdT9fAGSooqSGp+UiKRAPU2OXNOwKNyav8tSlwDDZG
        bmBskp+1ZxSjiMXqD9p5lsM4CKBfS1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-JX0TytxWNxCpn3eVw5pUNQ-1; Thu, 30 Apr 2020 07:08:51 -0400
X-MC-Unique: JX0TytxWNxCpn3eVw5pUNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 602BD100CD40;
        Thu, 30 Apr 2020 11:08:50 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.195.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9111001920;
        Thu, 30 Apr 2020 11:08:48 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Laurent Bigonville <bigon@bigon.be>
Subject: [PATCH 2/2] restorecond: Use pkg-config to get locations for systemd units
Date:   Thu, 30 Apr 2020 13:08:35 +0200
Message-Id: <20200430110835.138643-2-plautrba@redhat.com>
In-Reply-To: <20200430110835.138643-1-plautrba@redhat.com>
References: <20200430110835.138643-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The user systemd service file could be installed in an other location tha=
n the
system ones. In debian for example, the system files are installed
/lib/systemd/system and the user ones in /usr/lib/systemd/user.

Suggested-by: Laurent Bigonville <bigon@bigon.be>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 restorecond/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 4de9642b0f6a..8e9a5ef1cfa1 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -7,7 +7,8 @@ SBINDIR ?=3D $(PREFIX)/sbin
 MANDIR =3D $(PREFIX)/share/man
 AUTOSTARTDIR =3D /etc/xdg/autostart
 DBUSSERVICEDIR =3D $(PREFIX)/share/dbus-1/services
-SYSTEMDDIR ?=3D $(PREFIX)/lib/systemd
+SYSTEMDSYSTEMUNITDIR ?=3D $(shell $(PKG_CONFIG) --variable=3Dsystemdsyst=
emunitdir systemd)
+SYSTEMDUSERUNITDIR ?=3D $(shell $(PKG_CONFIG) --variable=3Dsystemduserun=
itdir systemd)
=20
 autostart_DATA =3D sealertauto.desktop
 INITDIR ?=3D /etc/rc.d/init.d
@@ -48,10 +49,10 @@ install: all
 	install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecon=
d.desktop
 	-mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
 	install -m 644 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICE=
DIR)/org.selinux.Restorecond.service
-	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
-	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
-	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/user
-	install -m 644 restorecond_user.service $(DESTDIR)$(SYSTEMDDIR)/user/
+	-mkdir -p $(DESTDIR)$(SYSTEMDSYSTEMUNITDIR)
+	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDSYSTEMUNITDIR)
+	-mkdir -p $(DESTDIR)$(SYSTEMDUSERUNITDIR)
+	install -m 644 restorecond_user.service $(DESTDIR)$(SYSTEMDUSERUNITDIR)
 relabel: install
 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond=20
=20
--=20
2.26.2

