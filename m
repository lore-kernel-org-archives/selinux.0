Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86765C433E1
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC052065D
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 12:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lostca.se header.i=@lostca.se header.b="pC2aPETU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGUMHF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:07:05 -0400
Received: from aloka.lostca.se ([178.63.46.202]:27205 "EHLO aloka.lostca.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgGUMHF (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 21 Jul 2020 08:07:05 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 08:07:01 EDT
Received: from aloka.lostca.se (aloka [127.0.0.1])
        by aloka.lostca.se (Postfix) with ESMTP id B97088844;
        Tue, 21 Jul 2020 11:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lostca.se; h=date:from:to
        :cc:subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=howrah; bh=lNfWc1xA5Qqt9Isk65bwrJ0
        HCTE=; b=pC2aPETUmTiODFhvrOsdG22vLY2rf+j1TBEKXFxeIb7slc0RBM1jEtV
        CaW0hBtUhWK5y7k2LwZwPYhhozHaDRcaV+MDZIUhtfM28lx+AG7PwdbcHZHX8ksp
        RpaVu23L6zrNTCC2ef99WHYarhaQLdKXyyX2NtkNwMsv0YcWWviM=
Received: from localhost (unknown [IPv6:2a01:4f8:120:624c::25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by aloka.lostca.se (Postfix) with ESMTPSA id 7DDB98843;
        Tue, 21 Jul 2020 11:57:34 +0000 (UTC)
Date:   Tue, 21 Jul 2020 11:57:34 +0000
From:   Arjun Shankar <arjun.is@lostca.se>
To:     selinux@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>
Subject: [RFC] Porting glibc away from deprecated libselinux APIs
Message-ID: <20200721115734.GA43979@aloka.lostca.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

glibc currently uses several recently deprecated libselinux APIs:

1. makedb uses matchpathcon:

https://sourceware.org/git/?p=glibc.git;a=blob;f=nss/makedb.c;h=8e389a1683747cf1047f4de8fe603f2b5ccc5f3f;hb=HEAD

2. nscd uses avc_init and multiple old style callbacks:

https://sourceware.org/git/?p=glibc.git;a=blob;f=nscd/selinux.c;h=a4ea8008e201b9397aa4274bb558de471b0573af;hb=HEAD

We are currently trying to replace these uses with the newer interfaces,
with a proposed makedb patch written by Aurelien Jarno attached with this
email, and being discussed here:
https://sourceware.org/pipermail/libc-alpha/2020-July/116504.html

Would you be able to help review this and any follow-ups?

Thank you, and Cheers,
Arjun

--HlL+5n6rz5pIUxbD
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Return-Path: <libc-alpha-bounces@sourceware.org>
Delivered-To: spectre@aloka.lostca.se
Received: from aloka.lostca.se
	by aloka with LMTP
	id 9fy8Lvt2Fl97lgAAjaz+9Q
	(envelope-from <libc-alpha-bounces@sourceware.org>)
	for <spectre@aloka.lostca.se>; Tue, 21 Jul 2020 05:02:51 +0000
Received: from aloka.lostca.se (aloka [127.0.0.1])
	by aloka.lostca.se (Postfix) with ESMTP id 39144853F
	for <arjun.is@lostca.se>; Tue, 21 Jul 2020 05:02:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on aloka.lostca.se
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.4
X-Envelope-From: <libc-alpha-bounces@sourceware.org>
Received: from sourceware.org (server2.sourceware.org [IPv6:2620:52:3:1:0:246e:9693:128c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aloka.lostca.se (Postfix) with ESMTPS
	for <arjun.is@lostca.se>; Tue, 21 Jul 2020 05:02:47 +0000 (UTC)
Received: from server2.sourceware.org (localhost [IPv6:::1])
	by sourceware.org (Postfix) with ESMTP id 1EE7F3861019;
	Tue, 21 Jul 2020 05:02:43 +0000 (GMT)
X-Original-To: libc-alpha@sourceware.org
Delivered-To: libc-alpha@sourceware.org
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 by sourceware.org (Postfix) with ESMTPS id 9AEC23857C4C
 for <libc-alpha@sourceware.org>; Tue, 21 Jul 2020 05:02:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9AEC23857C4C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:From:Reply-To:Subject:Content-ID:
 Content-Description:In-Reply-To:References:X-Debbugs-Cc;
 bh=WeIXW4Ys6iB9JjX1Y/NNFkfAkF9aCsOdk6SitmxR2MU=; b=vWBnH2uo4hZeGGJTs9U889/gmc
 MFhv8KFvN4HRbQPvGakq+X3IhbUxQ53DgME3NYJi4otM67MbbkpkqImxfF7mdiQlj2tD2fS0dxhTl
 UtCxXhhv64U4cRm0bAAeTMzYzTpWVnlP6D7Qv+ms8jqLCTs12PPjKGDl4XxjETGRYQNW7c1TlfuRF
 gTavTZlgXY9NrwLyDE5DIUJETt+6M+2Ll7i+1KlJdfLPIwnS3GNtAtUGqfp60jpV8L0qO7rB1jSIv
 BGUxUDFBdyJylIKxiNc2OS0O0WQMCXtLGQ6+aLdEC2qTKs2/NTbGjDJQhC1FpcQ9v522YjhuBweb6
 QO7hL90w==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jxkQJ-0005Nq-8u; Tue, 21 Jul 2020 07:02:39 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
 (envelope-from <aurelien@aurel32.net>)
 id 1jxkQI-000r8I-Lk; Tue, 21 Jul 2020 07:02:38 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: libc-alpha@sourceware.org
Subject: [PATCH] makedb: fix build with libselinux >= 3.1
Date: Tue, 21 Jul 2020 07:01:16 +0200
Message-Id: <20200721050115.204181-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-BeenThere: libc-alpha@sourceware.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Libc-alpha mailing list <libc-alpha.sourceware.org>
List-Unsubscribe: <http://sourceware.org/mailman/options/libc-alpha>,
 <mailto:libc-alpha-request@sourceware.org?subject=unsubscribe>
List-Archive: <https://sourceware.org/pipermail/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-request@sourceware.org?subject=help>
List-Subscribe: <http://sourceware.org/mailman/listinfo/libc-alpha>,
 <mailto:libc-alpha-request@sourceware.org?subject=subscribe>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Errors-To: libc-alpha-bounces@sourceware.org
Sender: "Libc-alpha" <libc-alpha-bounces@sourceware.org>
Content-Transfer-Encoding: quoted-printable

glibc doesn't build with libselinux 3.1 that has been released recently
due to new deprecations introduced in that version and the fact that
glibc is built with -Werror by default:

| makedb.c: In function =E2=80=98set_file_creation_context=E2=80=99:
| makedb.c:849:3: error: =E2=80=98security_context_t=E2=80=99 is deprecat=
ed [-Werror=3Ddeprecated-declarations]
|   849 |   security_context_t ctx;
|       |   ^~~~~~~~~~~~~~~~~~
| makedb.c:863:3: error: =E2=80=98matchpathcon=E2=80=99 is deprecated: Us=
e selabel_lookup instead [-Werror=3Ddeprecated-declarations]
|   863 |   if (matchpathcon (outname, S_IFREG | mode, &ctx) =3D=3D 0 && =
ctx !=3D NULL)
|       |   ^~
| In file included from makedb.c:50:
| /usr/include/selinux/selinux.h:500:12: note: declared here
|   500 | extern int matchpathcon(const char *path,
|       |            ^~~~~~~~~~~~
| cc1: all warnings being treated as errors

This patch is an attempt to fix that. It has only built tested, as I do
not have a system nor the knowledge to test that. I have checked that
the functions used as replacement are available since at least selinux
2.0.96, released more than 10 years ago, so we probably do not need any
version check in the configure script.
---
 nss/makedb.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

I believe this patch is not acceptable for glibc 2.32, I guess we should
just add a #pragma to ignore -Werror=3Ddeprecated-declarations in that
file.

Note: there is the same issue in nscd/selinux.c. I plan to have a look
once we settle on a strategy.

diff --git a/nss/makedb.c b/nss/makedb.c
index 8e389a16837..a5c4b521172 100644
--- a/nss/makedb.c
+++ b/nss/makedb.c
@@ -47,6 +47,7 @@
=20
 /* SELinux support.  */
 #ifdef HAVE_SELINUX
+# include <selinux/label.h>
 # include <selinux/selinux.h>
 #endif
=20
@@ -846,7 +847,8 @@ set_file_creation_context (const char *outname, mode_=
t mode)
 {
   static int enabled;
   static int enforcing;
-  security_context_t ctx;
+  struct selabel_handle *label_hnd =3D NULL;
+  char* ctx;
=20
   /* Check if SELinux is enabled, and remember. */
   if (enabled =3D=3D 0)
@@ -858,9 +860,16 @@ set_file_creation_context (const char *outname, mode=
_t mode)
   if (enforcing =3D=3D 0)
     enforcing =3D security_getenforce () ? 1 : -1;
=20
+  /* Open the file contexts backend. */
+  label_hnd =3D selabel_open(SELABEL_CTX_FILE, NULL, 0);
+  if (!label_hnd)
+    if (setfscreatecon (ctx) !=3D 0)
+      error (enforcing > 0 ? EXIT_FAILURE : 0, 0,
+	     gettext ("cannot initialize SELinux context"));
+
   /* Determine the context which the file should have. */
   ctx =3D NULL;
-  if (matchpathcon (outname, S_IFREG | mode, &ctx) =3D=3D 0 && ctx !=3D =
NULL)
+  if (selabel_lookup(label_hnd, &ctx, outname, S_IFREG | mode) =3D=3D 0 =
&& ctx !=3D NULL)
     {
       if (setfscreatecon (ctx) !=3D 0)
 	error (enforcing > 0 ? EXIT_FAILURE : 0, 0,
@@ -868,7 +877,11 @@ set_file_creation_context (const char *outname, mode=
_t mode)
 	       outname);
=20
       freecon (ctx);
+      selabel_close(label_hnd);
     }
+
+  /* Close the file contexts backend. */
+  selabel_close(label_hnd);
 }
=20
 static void
--=20
2.27.0

--HlL+5n6rz5pIUxbD--
