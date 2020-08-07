Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E11FC433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2855F22CF8
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IHOlCsxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHGQvk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGQvk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 12:51:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C73C061756;
        Fri,  7 Aug 2020 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OBTWZQt5vODOTMK+QJG5w+DYxrngWnwJntqbpr+2+EE=; b=IHOlCsxtDgnyWWM8Etp7cnNBgu
        XcJgvO1LZUPXypIusCtqV1SdpjcXyU9j1cJlDD++rAiriS4539+wAe09OxLKMlD2GvMA4YAFpEhkn
        6FjQIqFQSGlYQzMowLC5rf7mEKb7wJlpETBS5L/4/U5Bxy0gWl80p7bBuFJUXlRZ2L6c2ZirMpx42
        ZFBnh2hTffCvjd0PjN2HPAp33n6JY/ZqepSEvjs4nWfdeO5tl9lTvFptRlywvyB5rHDaN4ItSnJzr
        JJB6GXywgdHVI8Qr39RvTFxn9DXx4EeTfRhO8TaHeJ39zIpB+xQQc5co94jMSPMePTH94sm6QqWgC
        RrOT9GjA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k45aj-0004G4-ST; Fri, 07 Aug 2020 16:51:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] security: selinux: delete repeated words in comments
Date:   Fri,  7 Aug 2020 09:51:34 -0700
Message-Id: <20200807165134.3913-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop a repeated word in comments.
{open, is, then}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>
Cc: selinux@vger.kernel.org
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/selinux/hooks.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200731.orig/security/selinux/hooks.c
+++ linux-next-20200731/security/selinux/hooks.c
@@ -1978,7 +1978,7 @@ static inline u32 file_to_av(struct file
 }
 
 /*
- * Convert a file to an access vector and include the correct open
+ * Convert a file to an access vector and include the correct
  * open permission.
  */
 static inline u32 open_file_to_av(struct file *file)
@@ -4444,7 +4444,7 @@ static int selinux_skb_peerlbl_sid(struc
  *
  * If @skb_sid is valid then the user:role:type information from @sk_sid is
  * combined with the MLS information from @skb_sid in order to create
- * @conn_sid.  If @skb_sid is not valid then then @conn_sid is simply a copy
+ * @conn_sid.  If @skb_sid is not valid then @conn_sid is simply a copy
  * of @sk_sid.  Returns zero on success, negative values on failure.
  *
  */
@@ -5314,7 +5314,7 @@ static int selinux_sctp_bind_connect(str
 
 			/* As selinux_sctp_bind_connect() is called by the
 			 * SCTP protocol layer, the socket is already locked,
-			 * therefore selinux_netlbl_socket_connect_locked() is
+			 * therefore selinux_netlbl_socket_connect_locked()
 			 * is called here. The situations handled are:
 			 * sctp_connectx(3), sctp_sendmsg(3), sendmsg(2),
 			 * whenever a new IP address is added or when a new
