Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02156C47247
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58A321841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKsOTI6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEHPm0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgEHPmX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE2C05BD09
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:23 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 23so961252qkf.0
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rJwx93OFnDwmRjTOOTJKIahXg1v9ScGf+JlIuR9dgI=;
        b=vKsOTI6VnZGIBJbd8GdaUnOct+9P421t4DQ2Rn0dJhfFOMBn7S4gqMEwtdQ1+d+YwU
         2ddt06oy8BoJmtOJQkHUNlsbD3ZMlffll/kQgxAmWPzMEfgl0TIgW+wWWYNyrhVhOerC
         /Wmdyew0bIunsHAoQTXfe5nu/vVj/C0GbEmLdzYNMFDkcTBLVG7PLxxTusk4+VQHtLzG
         Z08Pr6i4BEq7UI4A2CvMuzyJ/apN0nkrjQkXsh9/ffPi5IMTCt4pZ8QBKu+JKstLfgEa
         Qx2PBKrpQuvQxjLW3ryiOGVop1wUzJQeSbnQ9N6kEPMG8BfDcCcYNbkeoIJ/UYiFvJrw
         ncPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rJwx93OFnDwmRjTOOTJKIahXg1v9ScGf+JlIuR9dgI=;
        b=abVczGE+bE6k5DddpL8xEs0ZIRnrz40ZFdeRbX8/d+t251Fdar0eauS91gC/6Z21uI
         Lzg/UJYlh11euEO2bM1W0vPXPrx8/aHLn80DsMlUmX/BKYf/HapAZC7IcsmY8XHU8LLu
         7T8oVb3MfIokXm4s614ZhtxX+QuD2ye2J5rYkmJAnzLwDTE9Vbxm5v/bx+kyp5SZ7s/H
         oNiFlSbAB+aRAmS493lzQW2FnoXUeVjhEexp84cy03pvNxWx1837DXA0+5k5FSQURFpt
         9/Iq40BTyobV//igVrv5UwUy4ri26XDxd0bCmLIZNgENuskap+IrGF1OAKWHMMnWD+Uk
         0wGA==
X-Gm-Message-State: AGi0Pubnje0D/xitvFM61TOnoe3KD1SFE96UBTchInAz3zkOzHQXl6hI
        /XHtRYshogqsHJ4ddoKTe5BAc3A4
X-Google-Smtp-Source: APiQypKZc7HGOR/jt1eyVF+4y+huRVrY7lQcSW0BSJMDkzgG5enXQRD3i9+vLQRVBkqLsGDOsn9HNg==
X-Received: by 2002:a37:c08:: with SMTP id 8mr3363535qkm.47.1588952542069;
        Fri, 08 May 2020 08:42:22 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:21 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 06/15] test_sctp.te: make netlabel_peer_t a MCS-constrained type
Date:   Fri,  8 May 2020 11:41:29 -0400
Message-Id: <20200508154138.24217-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The sctp tests were relying on netlabel_peer_t being subject to
MCS constraints in order to deny access.  refpolicy/Debian do not
currently make netlabel_peer_t a MCS-constrained type, so make it
so in the test policy to provide consistent behavior for testing.
Alternatively (or in addition) we could make test_sctp_server_t
a MCS-constrained type similar to test_inet_server_t.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_sctp.te | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index df8606e..3b16db1 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -25,6 +25,7 @@ allow nfsd_t netlabel_sctp_peer_t:peer recv;
 gen_require(`
 	type netlabel_peer_t;
 ')
+mcs_constrained(netlabel_peer_t)
 
 #
 ############### Declare an attribute that will hold all peers ###############
-- 
2.23.1

