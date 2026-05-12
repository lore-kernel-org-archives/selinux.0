Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F22D7380;
	Tue, 12 May 2026 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588013; cv=none; b=LEmlmdB17FvmfJP/DIErcZZLr37PVfWhShw4MK0jCMPT+9U2yhBJoUBE5YWlvoQe4/iKC8bCizMYM5mlUFLHOrfTRd4gFNeefyxb/JzcLLWqPyWnTl560sYDJUq3MMgxEYko7kAnDw+39ijq2qu8L8dl2eSQJiPSPYnG3wZtkng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588013; c=relaxed/simple;
	bh=k+0O39k849OgmKFDhM+U2vgVRccqaN1Td2VS0Y3WD/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdSUzVE7HCzPtF/ZcKujgUodB3rta40dkLn5glJ8NtRh5rEaFBv0AUkxJohXP2GIlPZmdUdqLW9H46gTbSVH4EDvpCqlaQNvznxSygruocKDZ3lHzYsGGQtLYp06wP+WbSWGW/ZfGwQR7ZOMXZS3IruGQNcsRmcNxZjrMq2Fp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64CB1pc5064961;
	Tue, 12 May 2026 20:01:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64CB1oa0064953
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 12 May 2026 20:01:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp>
Date: Tue, 12 May 2026 20:01:49 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] tomoyo: Convert from sb_mount to granular mount
 hooks
To: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        john.johansen@canonical.com, stephen.smalley.work@gmail.com,
        omosnace@redhat.com, mic@digikod.net, gnoack@google.com,
        takedakn@nttdata.co.jp, herton@canonical.com, kernel-team@meta.com,
        selinux@vger.kernel.org, apparmor@lists.ubuntu.com
References: <20260509015208.3853132-1-song@kernel.org>
 <20260509015208.3853132-7-song@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260509015208.3853132-7-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

On 2026/05/09 10:52, Song Liu wrote:
> Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> reconstructs the MS_* flags expected by tomoyo_mount_permission()
> using the original flags parameter where available.

Please fold below diff into this patch. Then,

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/tomoyo.c | 60 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index ac84e1f03d5e..c93d000acc95 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -400,6 +400,15 @@ static int tomoyo_path_chroot(const struct path *path)
 	return tomoyo_path_perm(TOMOYO_TYPE_CHROOT, path, NULL);
 }
 
+/**
+ * tomoyo_mount_bind - Target for security_mount_bind().
+ *
+ * @from:    Pointer to "struct path".
+ * @to:      Pointer to "struct path".
+ * @recurse: Whether recursive bind mount or not.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
 static int tomoyo_mount_bind(const struct path *from, const struct path *to,
 			     bool recurse)
 {
@@ -408,6 +417,17 @@ static int tomoyo_mount_bind(const struct path *from, const struct path *to,
 	return tomoyo_mount_permission(NULL, to, NULL, flags, from);
 }
 
+/**
+ * tomoyo_mount_new - Target for security_mount_new().
+ *
+ * @fc:        Pointer to "struct fs_context".
+ * @mp:        Pointer to "struct path".
+ * @mnt_flags: Mount options.
+ * @flags:     Original mount options.
+ * @data:      Optional data. Maybe NULL.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
 static int tomoyo_mount_new(struct fs_context *fc, const struct path *mp,
 			    int mnt_flags, unsigned long flags, void *data)
 {
@@ -416,6 +436,17 @@ static int tomoyo_mount_new(struct fs_context *fc, const struct path *mp,
 				       flags, NULL);
 }
 
+/**
+ * tomoyo_mount_remount - Target for security_mount_remount().
+ *
+ * @fc:        Pointer to "struct fs_context".
+ * @mp:        Pointer to "struct path".
+ * @mnt_flags: Mount options.
+ * @flags:     Original mount options.
+ * @data:      Optional data. Maybe NULL.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
 static int tomoyo_mount_remount(struct fs_context *fc, const struct path *mp,
 				int mnt_flags, unsigned long flags, void *data)
 {
@@ -423,6 +454,15 @@ static int tomoyo_mount_remount(struct fs_context *fc, const struct path *mp,
 	return tomoyo_mount_permission(NULL, mp, NULL, flags, NULL);
 }
 
+/**
+ * tomoyo_mount_reconfigure - Target for security_mount_reconfigure().
+ *
+ * @mp:        Pointer to "struct path".
+ * @mnt_flags: Mount options.
+ * @flags:     Original mount options.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
 static int tomoyo_mount_reconfigure(const struct path *mp,
 				    unsigned int mnt_flags,
 				    unsigned long flags)
@@ -431,12 +471,28 @@ static int tomoyo_mount_reconfigure(const struct path *mp,
 	return tomoyo_mount_permission(NULL, mp, NULL, flags, NULL);
 }
 
+/**
+ * tomoyo_mount_change_type - Target for security_mount_change_type().
+ *
+ * @mp:       Pointer to "struct path".
+ * @ms_flags: Mount options.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
 static int tomoyo_mount_change_type(const struct path *mp, int ms_flags)
 {
 	return tomoyo_mount_permission(NULL, mp, NULL, ms_flags, NULL);
 }
 
-static int tomoyo_move_mount(const struct path *from_path,
+/**
+ * tomoyo_mount_move - Target for security_mount_move().
+ *
+ * @from_path: Pointer to "struct path".
+ * @to_path:   Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_mount_move(const struct path *from_path,
 			     const struct path *to_path)
 {
 	return tomoyo_mount_permission(NULL, to_path, NULL, MS_MOVE,
@@ -609,7 +665,7 @@ static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(mount_remount, tomoyo_mount_remount),
 	LSM_HOOK_INIT(mount_reconfigure, tomoyo_mount_reconfigure),
 	LSM_HOOK_INIT(mount_change_type, tomoyo_mount_change_type),
-	LSM_HOOK_INIT(mount_move, tomoyo_move_mount),
+	LSM_HOOK_INIT(mount_move, tomoyo_mount_move),
 	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),
 	LSM_HOOK_INIT(socket_bind, tomoyo_socket_bind),
-- 
2.47.3


