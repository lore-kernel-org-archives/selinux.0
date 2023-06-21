Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ACEB64D8
	for <selinux@archiver.kernel.org>; Wed, 21 Jun 2023 14:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjFUO4D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jun 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjFUOx6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jun 2023 10:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7192680;
        Wed, 21 Jun 2023 07:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BCA7615C4;
        Wed, 21 Jun 2023 14:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB368C433C8;
        Wed, 21 Jun 2023 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358991;
        bh=BiaJ5jpIOWljnOkZ7WeAt5Z0pozvTMv5IciOmpdTiC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4lhUOxjgWZaORXhjiT0ymA4hLJhfJWZkvH4rxtLAEw7wqxOhE+e+W3lY1BYmWIyj
         2jtRj5IXXQgdB9uKvZhTlnGTXeqntH/1XA90X3V2bMQpa039ZaimPFCprbd/mz194p
         YBA3uCEd/FPISjPRQe2UUSYuk0djBw0An5PbAZbzJXgRmMa3oaJw2xHR5E0+Wo6KJ3
         LVuBck367fZw1ghK9JP2djxIM9pa8YsjoF8TB8PZCSpV1ORztGvWnk0v/FDAGm2nwJ
         PfpM9TYiqZxJo3oetNq4LH/DF07+/+eq6CTONLIHMwHuo20iJK5cU9lBzReGCRWhww
         rDpdl89Zqmj1w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 78/79] selinux: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:31 -0400
Message-ID: <20230621144735.55953-77-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index bad1f6b685fd..d3908baddb30 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1197,7 +1197,7 @@ static struct inode *sel_make_inode(struct super_block *sb, int mode)
 
 	if (ret) {
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
+		ret->i_atime = ret->i_mtime = inode_ctime_set_current(ret);
 	}
 	return ret;
 }
-- 
2.41.0

