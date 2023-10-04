Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794A8E7C4EE
	for <selinux@archiver.kernel.org>; Wed,  4 Oct 2023 19:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbjJDTIO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Oct 2023 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245510AbjJDTIC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Oct 2023 15:08:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC0110DA;
        Wed,  4 Oct 2023 11:55:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728E0C43391;
        Wed,  4 Oct 2023 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445729;
        bh=6tfj3HOEQmDgdX2NgSnu09djalPJMC2P1Uz+ScV29Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOM12QAHwzv8YtbPRSnMFATJw2O8jmXWKaQbiIXHQHnKWapStR+dO8VaY0Cw7vAkl
         v9frED7m+7uOtb9RbmUBZrqQ+XEsG+cIrl8JLShhdBRHTPdYSoBlATHHWGbl5za5MX
         zrr1NM9QjtN67oeU3v4tBsas2Gqa+L9fPB654KZfsl/yx3vVHkBuAote7xpM7Iy8Z4
         oZWwROe06YOh19VVA79qye7xTkkKrYRkiLrgs8oejGZPmVDGPsxgBYVakJ2fnARFOa
         egMW1d6bkFqPd+khH9FIAqr3fb6lG5P0yKJPRac+xWY0X8An8U7jBrvZ7Mtgk5nMFX
         uhLMb/z1sTHUw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: [PATCH v2 85/89] selinux: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:53:10 -0400
Message-ID: <20231004185347.80880-83-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6fa640263216..6c596ae7fef9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1198,7 +1198,7 @@ static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
 
 	if (ret) {
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
+		simple_inode_init_ts(ret);
 	}
 	return ret;
 }
-- 
2.41.0

