Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77A3E122F
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330741; cv=none; b=tzAfP+866f0uaUgBQY7pjzKDz4NlgRWOSUee/qdFaEnBjtuklOs5qQ7FoNrMQPjVrr+69i5K8Qu3lJmn2WlmpIFwxvzS99LPq789IywiYaN99zdkXh21INYgSU+h8LBX4HfsomFouGkddo32CYVmLPbG0Z/i2gOSU21QsKIhJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330741; c=relaxed/simple;
	bh=5lXXya3jqIk6nL81AUKkA23UEwgt81+83BzuBzi+Wk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kHFsTaDFdGY43drcAtAEe8eUVnYVl7u8J9YS8e9hNCf0Vjf27c0KpIGuXdmnEJ6FMbRX91v/C9rJwQeaSS9gNeP3pRjiUB2py62zHtgNbA1SCZ6hmrDshYNOpzPOKid5rVNM20OipmexfZL1GcfmEaU4Hpn/pVzA5hta99nkz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9QN1YiJ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9QN1YiJ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8edda5d56a5so8290646d6.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330739; x=1785935539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZOlJQBJSrwwew5psZSTBLv631ArDgu34WxM+FCpcZKE=;
        b=A9QN1YiJ0MscZsziMfTyAU+CalUKIme3AsZVSmh88Sgh1bUs2GWp+yZiBy+9RLnUwd
         rvd4B9swBGng7Qs/LgMLv9ScftZGjNYXClJ/LcjQXf9TQ5Od8Q5cFpYlDb2EXAn9vsPI
         EzOzxi4RlkxDjBEHdJ+7491tagEp2FICuy8Uaa5jx9ZHiuOYutjpXDk1B+3zUione25f
         dJ6X635qTk5+YR8AWZFRkZmeTRvQpWngF3EQUi4a/MS3VZW4eH1i0Za8MHRCllLZtCir
         C6GZQSNT7QrcCQ0y8hY7J1C1LF+fEpRK96sCVccbwz55ql1Pk3ae3g3CswRDtXQA8/Js
         3wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330739; x=1785935539;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZOlJQBJSrwwew5psZSTBLv631ArDgu34WxM+FCpcZKE=;
        b=hAKODaJ19Ekrcp4ToQzUOz2FCtAF1qZ9E332byHcqxa16tmoieA+DJ7llS//9JIaSC
         WgrPZI1VOp9jMFOe0TcK02jh5yIb02fEkOCQO1qDFRKDLMB7lhyqXSyBH5w2H6VT9q9K
         jKtOHldNULWvHXczYa6GC4sqfUgwQ9fZOQt76ZEP5gt3+PvRUHRPnTM0xfj5lt7g0QLG
         isHR94IFycV5reaSiOZBKcWk/pWm+mODZQeG8RlSxGxI2u/5ToaDGJs0B3uBsVB8WDZD
         MN7cdFhk1A6b819ZkS7xk0SvjO7MDUaXL/uk9JIuhbHjodJHN4dsgQ7m3y4mostEI6/5
         7tyg==
X-Gm-Message-State: AOJu0YyMOTiSpBpC0w/t0dHAEC/StqVYAWD+qiZ9Zsho26WnXeFml0aM
	cpf5dbGUIp6nRyYT9FfCkBZi6QP6bQZBocCkv8GBJyumLg7BF4CKHe9J1Q1uJw==
X-Gm-Gg: AR+sD12qLfJjgyqCKFHLGZxdRZ2xxIWYHgT5TUfo61koWJ5syReXlYeax/J7RtqZKRE
	XZxXabOmsPQswiLGJrXdjqWDV7nESNa6imWzRt5Sd8TghizDhLLUIchU4PljI+XZViFILZgRvzj
	nhbc3Y+abPzbH4S8ABaaGpIUwUqbcX1j2hA/pkosn+xjfGFLH/6LSoEx0ZuhaJ3+I2u94yb4Thy
	/wRYqvbeKJQBIccbU71lpcYpqfS5Cj3HM8NcnIXa6ZuGsqTtTmOQfnC2neehyCsxCEaW9zfFB2v
	+jjW4HquyyPvybRZsiHIDOLTNRGqlLvDf1ARdemajnJ129cO5Kkwg/jy/JYGq4piq9EQdPQ7fFM
	cbZzLu8aGSw/SmZVcbKhq3B6b7CkR1y8ikVel6TZjKQyc4C+WQYvw+Au9ewj3F3/fA7tQDvZBUM
	vk5sf2riazyqByyxZ6gEXy7HBEm0nAvh40E7zWdB/RF4FxcsNEMM+sVOFl4a4V16TpyfUI/tC8v
	frbtTBPDzaEep36+o+54Oput9lCkOHJAMxScExD9zVrvOMFWD2FzHrpG+MH8vvZ43j9o8qRJ7c=
X-Received: by 2002:a05:6214:5509:b0:8f0:41d4:f6b4 with SMTP id 6a1803df08f44-90817002dd0mr69610226d6.19.1785330738557;
        Wed, 29 Jul 2026 06:12:18 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd3a817sm23958486d6.29.2026.07.29.06.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:12:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?F=C3=A9lix-Antoine=20Fortin?= <felix-antoine.fortin@calculquebec.ca>
Subject: [PATCH] libselinux: selinux_restorecon: avoid triggering auto-mounts unnecessarily
Date: Wed, 29 Jul 2026 09:12:03 -0400
Message-ID: <20260729131203.53945-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Félix-Antoine Fortin <felix-antoine.fortin@calculquebec.ca> reported
the following bug report, quoted verbatim:
---<snip>---
I encountered an unexpected side effect in restorecon: processing a
single local file triggers unrelated automounts.

Command (called during ipa-client-install):

  $ restorecon /etc/krb5.conf.d/freeipa

Although the target is under /etc, this causes all of the following
NFS automounts to activate:

  nfs-home.automount
  nfs-project.automount
  nfs-scratch.automount

The journal identifies restorecon as the process that triggered each automount:

  systemd[1]: nfs-home.automount: Got automount request for /nfs/home,
triggered by 10521 (restorecon)
  systemd[1]: Mounting /nfs/home...
  nfsrahead[10530]: setting /nfs/home readahead to 128
  systemd[1]: Mounted /nfs/home.
  systemd[1]: nfs-project.automount: Got automount request for
/nfs/project, triggered by 10521 (restorecon)
  systemd[1]: Mounting /nfs/project...
  nfsrahead[10533]: setting /nfs/project readahead to 128
  systemd[1]: Mounted /nfs/project.
  systemd[1]: nfs-scratch.automount: Got automount request for
/nfs/scratch, triggered by 10521 (restorecon)
  systemd[1]: Mounting /nfs/scratch...
  nfsrahead[10536]: setting /nfs/scratch readahead to 128
  systemd[1]: Mounted /nfs/scratch.

The fstab entries are:

  nfs_server:/home /nfs/home nfs4
proto=tcp,nosuid,nolock,noatime,actimeo=3,nfsvers=4.2,seclabel,_netdev,x-systemd.automount,x-systemd.mount-timeout=30
0 0
  nfs_server:/project /nfs/project nfs4
proto=tcp,nosuid,nolock,noatime,actimeo=3,nfsvers=4.2,seclabel,_netdev,x-systemd.automount,x-systemd.mount-timeout=30
0 0
  nfs_server:/scratch /nfs/scratch nfs4
proto=tcp,nosuid,nolock,noatime,actimeo=3,nfsvers=4.2,seclabel,_netdev,x-systemd.automount,x-systemd.mount-timeout=30
0 0

An strace shows restorecon probing these mountpoints:

  $ strace -f restorecon /etc/krb5.conf/freeipa 2>&1 | grep /nfs

  statfs("/nfs/home", {f_type=NFS_SUPER_MAGIC, f_bsize=1048576,
f_blocks=10172, f_bfree=10069, f_bavail=10069, f_files=5240832,
f_ffree=5240755, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576,
f_flags=ST_VALID|ST_NOSUID|ST_NOATIME}) = 0
  statfs("/nfs/project", {f_type=NFS_SUPER_MAGIC, f_bsize=1048576,
f_blocks=10172, f_bfree=10069, f_bavail=10069, f_files=5240832,
f_ffree=5240816, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576,
f_flags=ST_VALID|ST_NOSUID|ST_NOATIME}) = 0
  statfs("/nfs/scratch", {f_type=NFS_SUPER_MAGIC, f_bsize=1048576,
f_blocks=10172, f_bfree=10069, f_bavail=10069, f_files=5240832,
f_ffree=5240818, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576,
f_flags=ST_VALID|ST_NOSUID|ST_NOATIME}) = 0

My understanding is:

1. When restorecon is called without ignore mount (-m) flag, it reads
the mount table to construct the exclusion list for filesystems
without SELinux labeling support.
https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinux_restorecon.c#L146C14-L146C28
2. exclude_non_seclabel_mounts() calls file_system_count() for mounts that
advertise the seclabel option. file_system_count() calls statvfs() on
the mountpoint.
https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinux_restorecon.c#L343
https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinux_restorecon.c#L282
3. Calling statvfs() on a autofs mountpoint activates the underlying mount.
4. The resulting file count appears to be used only for progress reporting, but
it is calculated even when neither progress nor mass-relabel reporting
was requested.

So a non-recursive restorecon operation on one local file can mount
unrelated remote filesystems.

I would expect restorecon to not activate unrelated systemd automount
filesystems when progress reporting is not requested and the target
does not traverse those filesystems.

I think the best minimal patch would to skip calling file_system_count on
mounts which type is autofs (mount_info[2]).

---<snip>---

Fix this issue as the original reporter suggested.

Reported-by: Félix-Antoine Fortin <felix-antoine.fortin@calculquebec.ca>
Suggested-by: Félix-Antoine Fortin <felix-antoine.fortin@calculquebec.ca>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 30f1b836..8bae1464 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -301,6 +301,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
 	uint64_t nfile = 0;
 	char *mount_info[4];
 	char *buf = NULL, *item, *saveptr;
+	bool autofs = false;
 
 	/* Check to see if the kernel supports seclabel */
 	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
@@ -335,12 +336,19 @@ static uint64_t exclude_non_seclabel_mounts(void)
 		/* Remove pre-existing entry */
 		remove_exclude(mount_info[1]);
 
+		autofs = !strcmp(mount_info[2], "autofs");
 		saveptr = NULL;
 		item = strtok_r(mount_info[3], ",", &saveptr);
 		while (item != NULL) {
 			if (strcmp(item, "seclabel") == 0) {
 				found = 1;
-				nfile += file_system_count(mount_info[1]);
+				/*
+				 * Avoid triggering an auto-mount just to
+				 * count files for progress tracking.
+				 */
+				if (!autofs)
+					nfile += file_system_count(
+						mount_info[1]);
 				break;
 			}
 			item = strtok_r(NULL, ",", &saveptr);
-- 
2.55.0

