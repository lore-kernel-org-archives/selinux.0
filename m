From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>
Subject: [PATCH] selinux: fix double free in selinux_parse_opts_str()
Date: Fri, 24 Mar 2017 20:40:59 +0900
Message-Id: <1490355659-13787-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Combination of memory allocation failure injection and syzkaller fuzzer
found a double free bug.

----------
BUG: Double free or freeing an invalid pointer
Unexpected shadow byte: 0xFB
CPU: 2 PID: 15269 Comm: syz-executor1 Not tainted 4.11.0-rc3+ #364
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x1b8/0x28d lib/dump_stack.c:52
 kasan_object_err+0x1c/0x70 mm/kasan/report.c:166
 kasan_report_double_free+0x5c/0x70 mm/kasan/report.c:193
 kasan_slab_free+0xab/0xc0 mm/kasan/kasan.c:584
 __cache_free mm/slab.c:3514 [inline]
 kfree+0xd7/0x250 mm/slab.c:3831
 security_free_mnt_opts include/linux/security.h:175 [inline]
 superblock_doinit+0x2a3/0x430 security/selinux/hooks.c:1165
 selinux_sb_kern_mount+0xb2/0x300 security/selinux/hooks.c:2783
 security_sb_kern_mount+0x7d/0xb0 security/security.c:331
 mount_fs+0x11b/0x2f0 fs/super.c:1233
 vfs_kern_mount.part.23+0xc6/0x4b0 fs/namespace.c:979
 vfs_kern_mount fs/namespace.c:3293 [inline]
 kern_mount_data+0x50/0xb0 fs/namespace.c:3293
 mq_init_ns+0x167/0x220 ipc/mqueue.c:1418
 create_ipc_ns ipc/namespace.c:57 [inline]
 copy_ipcs+0x39b/0x580 ipc/namespace.c:83
 create_new_namespaces+0x285/0x8c0 kernel/nsproxy.c:86
 unshare_nsproxy_namespaces+0xae/0x1e0 kernel/nsproxy.c:205
 SYSC_unshare kernel/fork.c:2319 [inline]
 SyS_unshare+0x664/0xf80 kernel/fork.c:2269
 entry_SYSCALL_64_fastpath+0x1f/0xc2
----------

selinux_parse_opts_str() calls kfree(opts->mnt_opts) when kcalloc() for
opts->mnt_opts_flags failed. But it should not have called it because
security_free_mnt_opts() will call kfree(opts->mnt_opts).

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
fixes: e0007529893c1c06 ("LSM/SELinux: Interfaces to allow FS to control mount options")
Cc: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d37a723..7f81d17 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1106,10 +1106,8 @@ static int selinux_parse_opts_str(char *options,
 
 	opts->mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
 				       GFP_KERNEL);
-	if (!opts->mnt_opts_flags) {
-		kfree(opts->mnt_opts);
+	if (!opts->mnt_opts_flags)
 		goto out_err;
-	}
 
 	if (fscontext) {
 		opts->mnt_opts[num_mnt_opts] = fscontext;
-- 
1.8.3.1
