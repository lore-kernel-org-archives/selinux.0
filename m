Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED943C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6732067B
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZ7IMSer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfKLPtg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:49:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48148 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbfKLPtg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 10:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573573774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m1Kbswzhphy94YbcG/X6jaK+6TAUZJlqYBgmH0qXxf4=;
        b=WZ7IMSerCAiF3jVV/WmWmvT5GZMfcJ8qREqh8Xi+Rv5/wOkJwsCu9jaYoOFZaeTwVPUxBx
        0nwQtVS6mQwZUcWrEUGUpfp81iUK4pgWrQWBCnfg/nIqVLS4fFwuFDSm/Mbx6Qtst5t10Y
        6v34gPDkrOtjbE8tsChppwa2FoWXdsw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-yHd54xiWNAesTg208YiyAA-1; Tue, 12 Nov 2019 10:49:33 -0500
Received: by mail-wm1-f70.google.com with SMTP id f21so1328539wmh.5
        for <selinux@vger.kernel.org>; Tue, 12 Nov 2019 07:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRUJ2iRYW5+1ehEcnvWfT7Hy9s9T6Ob8SxBFQjNWdqk=;
        b=ffsDAYhCCOiUOrS0VS/ODz3p7IeqoLIra00Ievkfpm85B9AYxnbHjaradTqBxXkCDY
         +NX61w1RsnUMr/1UJKlNCsZMeL3dKyS9u+9iJa9eqbvXroA2N8IyOwWYnqGjyhNYreNo
         v2P84UiMwKILv45+51t/3tks6EjeVI1iAp9rVS4IOTVdfpJhpEm3HjRjuqXYtOu/WL+S
         aoVwazXiJk0pER5T0WlhcXW11L/l1D5QmjNS7as7JFfL7oegINi3B4ll6ABwnSqgLlZ/
         9ybYEpe3XoYw352ftqiM4Aog71w+wnQHm2U0JkCX5C6yLmCiuX1UUqs3v8JXjeuK5UTZ
         4glQ==
X-Gm-Message-State: APjAAAUEcXSCgaH6EQPdi40GxCnWNQm0XwU53Jbg9f7geE1HWo0+FNf0
        VaxTteygwHce1wfyY6/pGS2MZ+kn05kTOaUI8ONmXn9hZyRUa5rjo3ZqeXeylF1B/4pHnbLmjJe
        N1atL6ZtU7L5KvMNISA==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr4783225wme.77.1573573771716;
        Tue, 12 Nov 2019 07:49:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyb6zYSWXNnS4ynpVgBz6790gUvdxp3oHI62gW+Hu3vf9hWuQGgHoww8KXHTdUVd0LwAUnkyw==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr4783202wme.77.1573573771445;
        Tue, 12 Nov 2019 07:49:31 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r15sm42535395wrc.5.2019.11.12.07.49.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 07:49:30 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/sctp: initialize addrlen for accept(2) properly
Date:   Tue, 12 Nov 2019 16:49:29 +0100
Message-Id: <20191112154929.24292-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: yHd54xiWNAesTg208YiyAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 'addrlen' argument of accept(2) must point to a variable containing
the size of the structure pointed to by 'addr'. In some cases it was
being left unitialized. Fix this.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/sctp/sctp_asconf_params_server.c | 1 +
 tests/sctp/sctp_set_peer_addr.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/sctp/sctp_asconf_params_server.c b/tests/sctp/sctp_ascon=
f_params_server.c
index 3333ba0..ff7473b 100644
--- a/tests/sctp/sctp_asconf_params_server.c
+++ b/tests/sctp/sctp_asconf_params_server.c
@@ -112,6 +112,7 @@ int main(int argc, char **argv)
 =09=09fclose(f);
 =09}
=20
+=09sinlen =3D sizeof(sin);
 =09new_sock =3D accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
 =09if (new_sock < 0) {
 =09=09perror("accept");
diff --git a/tests/sctp/sctp_set_peer_addr.c b/tests/sctp/sctp_set_peer_add=
r.c
index 61a3a44..c35b518 100644
--- a/tests/sctp/sctp_set_peer_addr.c
+++ b/tests/sctp/sctp_set_peer_addr.c
@@ -277,6 +277,7 @@ int main(int argc, char **argv)
 =09=09printf("Client peer address count: %d\n", peer_count);
=20
 =09/* Client and server now set so accept new socket on server side. */
+=09sinlen =3D sizeof(sin);
 =09new_sock =3D accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
 =09if (new_sock < 0) {
 =09=09perror("accept");
--=20
2.23.0

