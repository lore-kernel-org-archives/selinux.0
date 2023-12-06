Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WRC5Pup1"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6931D65
	for <selinux@vger.kernel.org>; Tue,  5 Dec 2023 22:06:37 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbe716b511so5041150b3a.3
        for <selinux@vger.kernel.org>; Tue, 05 Dec 2023 22:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842796; x=1702447596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5knnzQ7H9RqqOrEz7MpDyWFgjQJLgH2xlCY/qpCSH0=;
        b=WRC5Pup1W54aB1wX0TS1oKMY8iXKQ7renKUg3EaIjcdddFQTBl0J2xPaKVkyrH4JH1
         00sGA6PqVUMoOsst9w74KM96Ggye8Cn2b3rpDh56TOAUyJ91XuLkOwgztgz9Tif4VgDR
         UN4d8muVEGfjpEUtO8EFQvytujoy2uQdy5zZ3PXRG+sq03TBVOs9sflwPhlC2ODGs6z/
         IQDHYGnPzMBhhN8ks/EiG+HUeh+/wYsFp7lF2o68WBszJTZqbJElVHFDchnKQNhmdSTS
         knbPNVS+dlmczQZEHu621+wg+efZD/F5y0EZBTuKVW6Cb8ErbLjdpRBkGO4m8CCuZy/r
         KL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842796; x=1702447596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5knnzQ7H9RqqOrEz7MpDyWFgjQJLgH2xlCY/qpCSH0=;
        b=sT79JthuokRD3vljUNkNsm10e8aAlq9EYTEZ7MKeeWdO3avY1UZT5nFKL51YGci68v
         snidu4r9ugMIdINgiz57Ml27PtdPjddZXaTFoh3R6+x6aqglBfy0457SduckdZpZxvNP
         QeUGXDra559q/uxUSGjL6mwrCT6EMlRwNBnxy4x0vL+h2aezsU12saeaHCczd8bJbM9g
         KkeHBTJ5WyQ6xTHC6GVn+7+ONNObUNUXjecyRy3y+Quf2+90/tB16bjx9Vbo3bjqeY+F
         ikM00P+h8IPYkJFZL4VKTlwxmDxLaigQHL9KYKtRBcO3/Wl5qCRJ6VJdH6PbroXmwEs9
         AM8Q==
X-Gm-Message-State: AOJu0YxgNsY1vmWpDZTt5DVG62U0gzmVKQi7BWhMV5Z8W2Svo88Xp4r3
	mOjsOVJJRZMcYZbxypJUNVkCaA==
X-Google-Smtp-Source: AGHT+IEC+/MrsOvuE6i0CgCG0TesUC0cdSm1kn1x3Hx9DDsJihW+ZIWufpD3X15hw1A7K4SDG85yUg==
X-Received: by 2002:a05:6a00:194f:b0:6ce:2731:d5b7 with SMTP id s15-20020a056a00194f00b006ce2731d5b7mr286716pfk.40.1701842796562;
        Tue, 05 Dec 2023 22:06:36 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78b88000000b006889511ab14sm10382099pfd.37.2023.12.05.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:34 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3H-004VOd-2q;
	Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrV6-1sZg;
	Wed, 06 Dec 2023 17:06:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-cachefs@redhat.com,
	dhowells@redhat.com,
	gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] vfs: Remove unnecessary list_for_each_entry_safe() variants
Date: Wed,  6 Dec 2023 17:05:31 +1100
Message-ID: <20231206060629.2827226-3-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

evict_inodes() and invalidate_inodes() use list_for_each_entry_safe()
to iterate sb->s_inodes list. However, since we use i_lru list entry for
our local temporary list of inodes to destroy, the inode is guaranteed
to stay in sb->s_inodes list while we hold sb->s_inode_list_lock. So
there is no real need for safe iteration variant and we can use
list_for_each_entry() just fine.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f238d987dec9..17c50a75514f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -712,12 +712,12 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *next;
+	struct inode *inode;
 	LIST_HEAD(dispose);
 
 again:
 	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		if (atomic_read(&inode->i_count))
 			continue;
 
@@ -758,12 +758,12 @@ EXPORT_SYMBOL_GPL(evict_inodes);
  */
 void invalidate_inodes(struct super_block *sb)
 {
-	struct inode *inode, *next;
+	struct inode *inode;
 	LIST_HEAD(dispose);
 
 again:
 	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
-- 
2.42.0

