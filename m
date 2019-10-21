Return-Path: <SRS0=hnB7=YO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36215CA9EAF
	for <selinux@archiver.kernel.org>; Mon, 21 Oct 2019 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55A20640
	for <selinux@archiver.kernel.org>; Mon, 21 Oct 2019 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSduiGnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfJUOhu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:37:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727309AbfJUOhu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Oct 2019 10:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571668669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MGx2UYNX59Bws5RB50GvVm5Q9ljARn3FCT+sfG5ziNQ=;
        b=HSduiGnnUpl5tjzNC9VFXykikT4Mx9/5b+rOR2wAf1mYLWbUOnlMZhJ7OYnmTESA76w7KP
        P2yDDEtqlQsk5nizZFoMSFUhXMOsrhpRLH00GBYbYTT6XoOi5VHV1gnMSo0RNN+qDx2jvq
        bbHYNpfFhwEZ02LrzC5QlvWpA00zolE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-lAxixlvaMG-tK_XKk_cGew-1; Mon, 21 Oct 2019 10:37:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DA8107AD31
        for <selinux@vger.kernel.org>; Mon, 21 Oct 2019 14:37:45 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F19995D9E5
        for <selinux@vger.kernel.org>; Mon, 21 Oct 2019 14:37:44 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/semanage: Document DCCP and SCTP support
Date:   Mon, 21 Oct 2019 16:37:36 +0200
Message-Id: <20191021143736.13456-1-vmojzis@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lAxixlvaMG-tK_XKk_cGew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add DCCP and SCTP protocols in semanage port man page and --help
message.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/semanage        | 5 +----
 python/semanage/semanage-port.8 | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 864f9212..b2fabea6 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -73,9 +73,6 @@ usage_interface_dict =3D {' --add': ('-t TYPE', '-r RANGE=
', 'interface'), ' --modi
 usage_boolean =3D "semanage boolean [-h] [-n] [-N] [-S STORE] ["
 usage_boolean_dict =3D {' --modify': ('(', '--on', '|', '--off', ')', 'boo=
lean'), ' --list': ('-C',), '  --extract': ('',), ' --deleteall': ('',)}
=20
-
-
-
 class CheckRole(argparse.Action):
=20
     def __call__(self, parser, namespace, value, option_string=3DNone):
@@ -248,7 +245,7 @@ SELinux Range for SELinux user defaults to s0.
=20
 def parser_add_proto(parser, name):
     parser.add_argument('-p', '--proto', help=3D_('''
-    Protocol  for  the specified port (tcp|udp) or internet protocol
+    Protocol  for  the specified port (tcp|udp|dccp|sctp) or internet prot=
ocol
     version for the specified node (ipv4|ipv6).
 '''))
=20
diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-por=
t.8
index a21287c0..12ec14c2 100644
--- a/python/semanage/semanage-port.8
+++ b/python/semanage/semanage-port.8
@@ -49,7 +49,7 @@ SELinux type for the object
 MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux lo=
gin mapping defaults to the SELinux user record range. SELinux Range for SE=
Linux user defaults to s0.
 .TP
 .I   \-p PROTO, \-\-proto PROTO
-Protocol for the specified port (tcp|udp) or internet protocol version for=
 the specified node (ipv4|ipv6).
+Protocol for the specified port (tcp|udp|dccp|sctp) or internet protocol v=
ersion for the specified node (ipv4|ipv6).
=20
 .SH EXAMPLE
 .nf
--=20
2.21.0

