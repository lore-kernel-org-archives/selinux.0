Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C62C15BF
	for <selinux@vger.kernel.org>; Wed, 13 Aug 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079260; cv=none; b=bwKgATBxDINpfhZEtunSvn5nkpylrfzdkYfd790BPSfvTbt/UaZn2jzIa98VU/cVC7yphkrhla95wfj61DQhmIJpQIUznHanYp8Tm7q/VPMD/BSEFcyM3ehiaY8szvQFh/sghBAl8lkxiwDXhS8xpLkEqWTDXJPNTuX8E14G5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079260; c=relaxed/simple;
	bh=lPbDKB+k3lVOg0NIqRZqCdG2ByUO9olATiDAqVwQH64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qaEW99DpOwc1a9jO7WWmxfjjay+8IhRvvcD/vOJ1rYuzBsgfSz4LQ5XWMVrBLmT+1fHGn/bjkemhDde7MYDLacsfJV0gvzGZw5rux5TY68FTAH0NuKSPDnV9sLlFBBbk+drb1U08gBN+1j+1Y3Gyl1g/FSYekJ3DKnVm3j2Zlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u5/WqcO2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u5/WqcO2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u5/WqcO2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u5/WqcO2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FCB91F455;
	Wed, 13 Aug 2025 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755079255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5UhIUEj2H0HZtJwL7CC3eT7YVhReTUM/dByrOfvrPPE=;
	b=u5/WqcO2Uv1NDP40/A6xjiDIpQkWZHygrA5J5mcApuysq8OZJ0ludDnKcT+Tt0HsjSlTRm
	ablbkn9wZZiTVR66cOY+OvXGAxeRmIwstLr+o1iSFXQZiecHadUpoa1oRYtzseWBcl7Btq
	rmqzn1Yud0PYLLV8YPNxe7ZMyIEdCgA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755079255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5UhIUEj2H0HZtJwL7CC3eT7YVhReTUM/dByrOfvrPPE=;
	b=u5/WqcO2Uv1NDP40/A6xjiDIpQkWZHygrA5J5mcApuysq8OZJ0ludDnKcT+Tt0HsjSlTRm
	ablbkn9wZZiTVR66cOY+OvXGAxeRmIwstLr+o1iSFXQZiecHadUpoa1oRYtzseWBcl7Btq
	rmqzn1Yud0PYLLV8YPNxe7ZMyIEdCgA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58B3F13929;
	Wed, 13 Aug 2025 10:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M5GhFVdinGj1IgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 13 Aug 2025 10:00:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH] docs: Remove remainders of reiserfs
Date: Wed, 13 Aug 2025 12:00:52 +0200
Message-ID: <20250813100053.1291961-1-dsterba@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

Reiserfs has been removed in 6.13, there are still some mentions in the
documentation about it and the tools. Remove those that don't seem
relevant anymore but keep references to reiserfs' r5 hash used by some
code.

There's one change in a script scripts/selinux/install_policy.sh but it
does not seem to be relevant either.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 Documentation/admin-guide/ext4.rst                 |  2 +-
 Documentation/admin-guide/laptops/laptop-mode.rst  |  8 ++++----
 .../arch/powerpc/eeh-pci-error-recovery.rst        |  1 -
 .../translations/it_IT/process/changes.rst         | 14 --------------
 fs/btrfs/tree-log.c                                |  2 +-
 scripts/selinux/install_policy.sh                  |  2 +-
 6 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index b857eb6ca1b620..ac0c709ea9e7c1 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -398,7 +398,7 @@ There are 3 different data modes:
 * writeback mode
 
   In data=writeback mode, ext4 does not journal data at all.  This mode provides
-  a similar level of journaling as that of XFS, JFS, and ReiserFS in its default
+  a similar level of journaling as that of XFS and JFS in its default
   mode - metadata journaling.  A crash+recovery can cause incorrect data to
   appear in files which were written shortly before the crash.  This mode will
   typically provide the best ext4 performance.
diff --git a/Documentation/admin-guide/laptops/laptop-mode.rst b/Documentation/admin-guide/laptops/laptop-mode.rst
index b61cc601d298a8..66eb9cd918b56d 100644
--- a/Documentation/admin-guide/laptops/laptop-mode.rst
+++ b/Documentation/admin-guide/laptops/laptop-mode.rst
@@ -61,7 +61,7 @@ Caveats
   Check your drive's rating, and don't wear down your drive's lifetime if you
   don't need to.
 
-* If you mount some of your ext3/reiserfs filesystems with the -n option, then
+* If you mount some of your ext3 filesystems with the -n option, then
   the control script will not be able to remount them correctly. You must set
   DO_REMOUNTS=0 in the control script, otherwise it will remount them with the
   wrong options -- or it will fail because it cannot write to /etc/mtab.
@@ -96,7 +96,7 @@ control script increases dirty_expire_centisecs and dirty_writeback_centisecs in
 dirtied are not forced to be written to disk as often. The control script also
 changes the dirty background ratio, so that background writeback of dirty pages
 is not done anymore. Combined with a higher commit value (also 10 minutes) for
-ext3 or ReiserFS filesystems (also done automatically by the control script),
+ext3 filesystem (also done automatically by the control script),
 this results in concentration of disk activity in a small time interval which
 occurs only once every 10 minutes, or whenever the disk is forced to spin up by
 a cache miss. The disk can then be spun down in the periods of inactivity.
@@ -587,7 +587,7 @@ Control script::
 					FST=$(deduce_fstype $MP)
 				fi
 				case "$FST" in
-					"ext3"|"reiserfs")
+					"ext3")
 						PARSEDOPTS="$(parse_mount_opts commit "$OPTS")"
 						mount $DEV -t $FST $MP -o remount,$PARSEDOPTS,commit=$MAX_AGE$NOATIME_OPT
 						;;
@@ -647,7 +647,7 @@ Control script::
 					FST=$(deduce_fstype $MP)
 				fi
 				case "$FST" in
-					"ext3"|"reiserfs")
+					"ext3")
 						PARSEDOPTS="$(parse_mount_opts_wfstab $DEV commit $OPTS)"
 						PARSEDOPTS="$(parse_yesno_opts_wfstab $DEV atime atime $PARSEDOPTS)"
 						mount $DEV -t $FST $MP -o remount,$PARSEDOPTS
diff --git a/Documentation/arch/powerpc/eeh-pci-error-recovery.rst b/Documentation/arch/powerpc/eeh-pci-error-recovery.rst
index d6643a91bdf871..153d0af055b6da 100644
--- a/Documentation/arch/powerpc/eeh-pci-error-recovery.rst
+++ b/Documentation/arch/powerpc/eeh-pci-error-recovery.rst
@@ -315,7 +315,6 @@ network daemons and file systems that didn't need to be disturbed.
    ideally, the reset should happen at or below the block layer,
    so that the file systems are not disturbed.
 
-   Reiserfs does not tolerate errors returned from the block device.
    Ext3fs seems to be tolerant, retrying reads/writes until it does
    succeed. Both have been only lightly tested in this scenario.
 
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 77db13c4022b46..7e93833b4511c0 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -46,7 +46,6 @@ util-linux             2.10o              mount --version
 kmod                   13                 depmod -V
 e2fsprogs              1.41.4             e2fsck -V
 jfsutils               1.1.3              fsck.jfs -V
-reiserfsprogs          3.6.3              reiserfsck -V
 xfsprogs               2.6.0              xfs_db -V
 squashfs-tools         4.0                mksquashfs -version
 btrfs-progs            0.18               btrfsck
@@ -260,14 +259,6 @@ Sono disponibili i seguenti strumenti:
 
 - sono disponibili altri strumenti per il file-system.
 
-Reiserfsprogs
--------------
-
-Il pacchetto reiserfsprogs dovrebbe essere usato con reiserfs-3.6.x (Linux
-kernel 2.4.x).  Questo è un pacchetto combinato che contiene versioni
-funzionanti di ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` e
-``reiserfsck``.  Questi programmi funzionano sulle piattaforme i386 e alpha.
-
 Xfsprogs
 --------
 
@@ -479,11 +470,6 @@ JFSutils
 
 - <https://jfs.sourceforge.net/>
 
-Reiserfsprogs
--------------
-
-- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
-
 Xfsprogs
 --------
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 69e11557fd13d8..b1a7cbc4fc73df 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5455,7 +5455,7 @@ struct btrfs_dir_list {
  * See process_dir_items_leaf() for details about why it is needed.
  * This is a recursive operation - if an existing dentry corresponds to a
  * directory, that directory's new entries are logged too (same behaviour as
- * ext3/4, xfs, f2fs, reiserfs, nilfs2). Note that when logging the inodes
+ * ext3/4, xfs, f2fs, nilfs2). Note that when logging the inodes
  * the dentries point to we do not acquire their VFS lock, otherwise lockdep
  * complains about the following circular lock dependency / possible deadlock:
  *
diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index db40237e60ce7e..77368a73f11171 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -74,7 +74,7 @@ cd /etc/selinux/dummy/contexts/files
 $SF -F file_contexts /
 
 mounts=`cat /proc/$$/mounts | \
-	grep -E "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
+	grep -E "ext[234]|jfs|xfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
 	awk '{ print $2 '}`
 $SF -F file_contexts $mounts
 
-- 
2.50.1

