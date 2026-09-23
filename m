Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464A440A36
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178994; cv=none; b=acdXp5085hMonUZslpeACsE1BU8U8igX+z2vvVNPGsJtq/HCxiwZcsM8U+L4kDz+0FurJDCXnaWANcAz5fLE8EClFlaYSwEbtTb/YiCK1YgjrJUzc599wFm+OTJ6enw26z7nUt1C0kR5MggWZBZRRvptHQWvmi3EYED+eMGJsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178994; c=relaxed/simple;
	bh=vB6GJFdwql68RM1PKIceGuIg74BCpjTom9ZOPMzhYw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mo6Y02uN3oiyjI+dko+NnV96afWLxJH59QYxGoN++VA4nakDMHcrRsYqBzHdnpjOslmnS/K5qFKFrfH9Vk/HIekl+X7yMp7hv/NO4iqB0hcvwaaDDtQ5jmDLNqKdH2Gi6qUyPTftxD+lWaxMstSm/kyNONSPd/Gd/DjAepDivqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKJSNR9N; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKJSNR9N"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd3208so8082956d6.2
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178992; x=1790783792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N4EmViNijCm/c2/L5lt/BvXtO9snM83HWYeL8IUbWGQ=;
        b=gKJSNR9Ny1YEKBUnoSNoUS4KKEzMggPdKxApnbhsMI7JUS9FncELIn2L0EGtegLq7+
         HWen95t5A7MgROHDh8bAmZByeN2yg4jifiXY4KohOmcONzL38V7B0qiYl2bRkva7zGvK
         oq27VGYkHg4CBJ4uG3704Dn/9SfAL7b6FKX0qtMiYsArIJPUjq3hrELjEh4trfCVJXah
         XGE1W9HMgqbGQsFMQzIOkerpZcjwdwKFt9QW4f++ibpaKFRw3Q5rBvOj4Ca4wZgNmD3T
         rrTDAu1Y67nnun+Zq4wzlsIrCnUHeRrVKqJ7u7C+HLnPyovagU66F0J5D3ZEEnUv8hD+
         vKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178992; x=1790783792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N4EmViNijCm/c2/L5lt/BvXtO9snM83HWYeL8IUbWGQ=;
        b=STjSd1f07gpMAuiMjkFsSQ6D1IDikhhTanEjEH1rQepkzNbYofN7krL+tIOwaQQQ23
         of9l4F+/Z3LDkwpmwVbE/mquTvOeUsHHAmXTfbhsGbzm7ZKcvuUcSNNEn/p2fMaN5odB
         ESjN7FiE/OPq1YMyz8t/DZNAW4I2MNPhNWouXMWNuo4OpKsWfxntfK+/Ux6bfJcxnaw4
         bVgjY3ewYYAYcnWr8cLnHfxHAtII68JqUHoyUiQ+RnaFkQWP4GDh6Uh16QgpW7AmVyFG
         NvEH9wGXy2D03jU+J3Ct5rS0gxSo6/MLanaJtgdRuTdl0X3vg0R8frRiuQD0NlLaCfF7
         pNgg==
X-Gm-Message-State: AFuF++lwI5eCpBSL8uRX9oZU0CBRDQJfrz6WQ1AZbi13AE4Z0XriD7FB
	vJVpQ9zP1hAJa/0YHIe+OwStIP+4GvA47Gs+p6+++JekgbsrQ7+N6mljFk8Yuw==
X-Gm-Gg: AYBFou1vtaok4WzjQa4Uerh5+w2qGVaGsywmj35zuQ7wt69cnCXMnFYu2IaaWvjVBiu
	jM5pdLSIpGdgwD7IxU1VxiK6EOW8wO1buq+wlk0/wAxQIoDtbDaJum3vhO7Vo4zA7Bobg00U975
	BZhHO8w9bcwlZYSHA/cf/G66uyQ1HHQ1AitLf5oLrsrwn5xO5HNLX4+ui42Ctdl+mk2dmP8Aq2G
	1elxhOOTgwLmDSscem2xRVrPmsR//EHPiEsvU17xlIP7khSqXEPR6jBrPM6+tGLupwUMeoCCFO9
	VFn9oWc8pBQSOyAWsS6zlanBYkhBqybqkJ8bSy3svWc0VvdbFs9LA1lZFFmVucw/iwuwZWBD1+O
	iCE2CUhD4vg8F2pjCmTNC2RDq0Lqt5/CygcZLpPrEi19LTSb/lgY6YIKfTNDlDDYJLMId/K7SiV
	A72rWn4ecoxJ6uc0t4Gz7we7QRx3AQtAMm0qeN/znddemXSC8C2hu0YB82aQcSURBVYJ3TNcKO7
	R50dEYv5N/QcvccCEYQECzdQVJbk76/qKefdLWhbTR17cCVguoOErv1hIzuHSTpbPpcP9wxwpU=
X-Received: by 2002:a05:620a:468c:b0:93b:fbf0:8791 with SMTP id af79cd13be357-93c2513e1cemr469508585a.29.1790178991913;
        Wed, 23 Sep 2026 08:56:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2488ff98sm255515285a.33.2026.09.23.08.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:56:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/scripts/fixfiles: search fallback configuration roots
Date: Wed, 23 Sep 2026 11:56:17 -0400
Message-ID: <20260923155617.56593-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fixfiles reads /etc/selinux/config,
/etc/selinux/fixfiles_exclude_dirs, and constructs
FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
directly. On a system where the SELinux configuration is shipped under
/usr/lib/selinux and /etc/selinux is empty, config is not found so
SELINUXTYPE defaults to "targeted" regardless of what the vendor
shipped, and FC points at a non-existent path. setfiles takes an
explicit SELABEL_OPT_PATH literally (only the no-path-given case in
label_file.c goes through the search list), so the setfiles
invocations fail.

Add a small selinux_resolve() that mirrors the /etc/selinux then
/usr/lib/selinux search that libselinux applies, and use it for
config, fixfiles_exclude_dirs, and FC. FC is resolved independently of
config: a vendor config under /usr/lib can still be paired with a
libsemanage-written file_contexts under /etc.

While here, move the two mktemp calls in diff_filecontext() to $TMPDIR
instead of alongside FC/PREFC. The scratch files are diff
intermediates whose location does not matter, and when FC resolves
under /usr/lib the directory is read-only. Creating and using the
intermediate files in $TMPDIR is safe because the caller of fixfiles
is trusted, mktemp usage is race-free by construction and creates the
new file with mode 0600, and the sticky bit on /tmp (plus
fs.protected_regular=1 on systems that enable it) prevents an attacker
from replacing the file between mktemp and the shell redirections.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/scripts/fixfiles   | 52 ++++++++++++++++++------------
 policycoreutils/scripts/fixfiles.8 |  9 ++++--
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 6e93d2ba..45f2d5ce 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -66,22 +66,32 @@ for i in $FS; do
 done
 }
 
+SELINUX_CONFDIRS="/etc/selinux /usr/lib/selinux"
+selinux_resolve() {
+    for d in $SELINUX_CONFDIRS; do
+	if [ -e "$d/$1" ]; then
+	    echo "$d/$1"
+	    return 0
+	fi
+    done
+    return 1
+}
+
 exclude_dirs_from_relabelling() {
+    local f
     exclude_from_relabelling=
-    if [ -e /etc/selinux/fixfiles_exclude_dirs ]
-    then
-	while read i
-	do
-	  # skip blank line and comment
-	  # skip not absolute path
-	  # skip not directory
-	  [ -z "${i}" ] && continue
-	  [[ "${i}" =~ ^[[:blank:]]*# ]] && continue
-	  [[ ! "${i}" =~ ^/.* ]] && continue
-	  [[ ! -d "${i}" ]] && continue
-	  exclude_from_relabelling="$exclude_from_relabelling -e $i"
-	done < /etc/selinux/fixfiles_exclude_dirs
-    fi
+    f=$(selinux_resolve fixfiles_exclude_dirs) || return 0
+    while read i
+    do
+	# skip blank line and comment
+	# skip not absolute path
+	# skip not directory
+	[ -z "${i}" ] && continue
+	[[ "${i}" =~ ^[[:blank:]]*# ]] && continue
+	[[ ! "${i}" =~ ^/.* ]] && continue
+	[[ ! -d "${i}" ]] && continue
+	exclude_from_relabelling="$exclude_from_relabelling -e $i"
+    done < "$f"
     echo "$exclude_from_relabelling"
 }
 
@@ -103,10 +113,12 @@ RESTORECON=/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
 FILESYSTEMSRO=`get_ro_labeled_mounts`
 SELINUXTYPE="targeted"
-if [ -e /etc/selinux/config ]; then
-    . /etc/selinux/config
-    FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
-else
+SELINUXCONFIG=$(selinux_resolve config)
+if [ -n "$SELINUXCONFIG" ]; then
+    . "$SELINUXCONFIG"
+fi
+FC=$(selinux_resolve "${SELINUXTYPE}/contexts/files/file_contexts")
+if [ -z "$FC" ]; then
     FC=/etc/security/selinux/file_contexts
 fi
 
@@ -153,9 +165,9 @@ done
 LogExcluded
 
 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
-	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
+	TEMPFILE=`mktemp`
 	test -z "$TEMPFILE" && exit
-	PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
+	PREFCTEMPFILE=`mktemp`
 	sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
 	sed -r -e 's,:s0, ,g' $FC | sort -u |
 	/usr/bin/diff -b ${PREFCTEMPFILE} - |
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index f5b5d9ac..00cfd3e7 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -38,8 +38,9 @@ new policy, or  just check whether the file contexts are all
 as you expect.  By default it will relabel all mounted ext2, ext3, ext4, gfs2, xfs,
 jfs and btrfs file systems as long as they do not have a security context mount
 option.  You can use the \-R flag to use rpmpackages as an alternative.
-The file /etc/selinux/fixfiles_exclude_dirs can contain a list of directories
-excluded from relabeling.
+The file /etc/selinux/fixfiles_exclude_dirs (or
+/usr/lib/selinux/fixfiles_exclude_dirs if that does not exist) can
+contain a list of directories excluded from relabeling.
 .P
 .B fixfiles onboot
 will setup the machine to relabel on the next reboot.
@@ -114,7 +115,9 @@ List of files or directories trees that you wish to check file context on.
 
 .SH EXAMPLE
 .nf
-Relabel the whole filesystem, except paths listed in /etc/selinux/fixfiles_exclude_dirs
+Relabel the whole filesystem, except paths listed in
+/etc/selinux/fixfiles_exclude_dirs (or
+/usr/lib/selinux/fixfiles_exclude_dirs if the former does not exist)
 # fixfiles relabel
 Schedule the machine to relabel on the next boot and force relabeling of customizable types
 # fixfiles -F onboot
-- 
2.55.0

