Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA18C07545
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 13:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjJYNTy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjJYNTy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 09:19:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D401138
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 06:19:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6BEEF1FF5F;
        Wed, 25 Oct 2023 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698239990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiW5/CglpOXA6sgXiD/HK69gXDLb/mQ14jZQRHmlvns=;
        b=K0/f/crh2JYXWWiJZl0C7MAi8eYf4lLNbVUQVrZQ9oDnw+rHsV9T3Ju4TLv/5OWhksol9F
        2bgDGFRzlWha0KcrbydUXPEnFj1beEaPzrvy70yPYE+WVcw8xw8rxL+fceBfij6YHulYLK
        ZKWP93yshiSh72zvXYXrnCB7dPrUprU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698239990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiW5/CglpOXA6sgXiD/HK69gXDLb/mQ14jZQRHmlvns=;
        b=wak+vsH1ZxESkNv1U78sJMAMKGtRjyIHYyIRj4f1oKhmtX+IIAu0p6mZvr2Oe5YtuK5/HR
        MxR3KzfpzvEhFBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5208F13524;
        Wed, 25 Oct 2023 13:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1z8PE/YVOWU5dwAAMHmgww
        (envelope-from <cahu@suse.de>); Wed, 25 Oct 2023 13:19:50 +0000
From:   Cathy Hu <cahu@suse.de>
To:     selinux@vger.kernel.org
Cc:     selinux@suse.de, Cathy Hu <cahu@suse.de>
Subject: [PATCH v2] sepolicy/manpage.py: make output deterministic
Date:   Wed, 25 Oct 2023 15:18:58 +0200
Message-ID: <20231025131903.12044-1-cahu@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <8734xzhtvh.fsf@redhat.com>
References: <8734xzhtvh.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The list entries in the alphabetically grouped dict are
not sorted, which results in non-deterministic output for
index.html.

Sort entries of those lists to make the output deterministic
to be able to have reproducible builds.

See https://reproducible-builds.org/ for reasoning.
This patch was done while working on reproducible builds for openSUSE.

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 python/sepolicy/sepolicy/manpage.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index a488dcbf..62999019 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -156,7 +156,7 @@ def get_alphabet_manpages(manpage_list):
             if j.split("/")[-1][0] == i:
                 temp.append(j.split("/")[-1])
 
-        alphabet_manpages[i] = temp
+        alphabet_manpages[i] = sorted(temp)
 
     return alphabet_manpages
 
-- 
2.42.0

