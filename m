To: bot+015afdb01dbf2abb6a6bfdd5430b72e5503fca6d@syzkaller.appspotmail.com,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 syzkaller-bugs@googlegroups.com
Cc: danielj@mellanox.com, dledford@redhat.com, eparis@parisplace.org,
 james.l.morris@oracle.com, junil0814.lee@lge.com,
 kyeongdon.kim@lge.com, linux-kernel@vger.kernel.org, mka@chromium.org,
 paul@paul-moore.com, sds@tycho.nsa.gov, serge@hallyn.com,
 penguin-kernel@i-love.sakura.ne.jp
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <001a113f711a721c58055f052200@google.com>
 <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
In-Reply-To: <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
Message-Id: <201712032227.JCH90603.HQOOtVFMJOFLSF@I-love.SAKURA.ne.jp>
Date: Sun, 3 Dec 2017 22:27:50 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: KASAN: slab-out-of-bounds Read in strcmp
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tetsuo Handa wrote:
> which will allow strcmp() to trigger out of bound read when "size" is
> larger than strlen(initial_sid_to_string[i]).

Oops. "smaller" than.

> 
> Thus, I guess the simplest fix is to use strncmp() instead of strcmp().

Can somebody test below patch? (My CentOS 7 environment does not support
enabling SELinux in linux.git . Userspace tool is too old to support?)
----------
>From 3efab617f7c22360361a2bd89a0ccaf3bcd47951 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 3 Dec 2017 22:12:17 +0900
Subject: [PATCH] selinux: Fix out of bounds read at
 security_context_to_sid_core()

Syzbot caught an out of bounds read at security_context_to_sid_core()
because security_context_to_sid_core() assumed that the value written to
/proc/pid/attr interface is terminated with either '\0' or '\n'.
When the value is not terminated with either '\0' or '\n' and
scontext_len < strlen(initial_sid_to_string[i]) is true, strcmp() will
trigger out of bounds read.

----------
BUG: KASAN: slab-out-of-bounds in strcmp+0x96/0xb0 lib/string.c:328
Read of size 1 at addr ffff8801cd99d2c1 by task syzkaller242593/3087

CPU: 0 PID: 3087 Comm: syzkaller242593 Not tainted 4.15.0-rc1-next-20171201+ #57
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x194/0x257 lib/dump_stack.c:53
 print_address_description+0x73/0x250 mm/kasan/report.c:252
 kasan_report_error mm/kasan/report.c:351 [inline]
 kasan_report+0x25b/0x340 mm/kasan/report.c:409
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:427
 strcmp+0x96/0xb0 lib/string.c:328
 security_context_to_sid_core+0x437/0x620 security/selinux/ss/services.c:1420
 security_context_to_sid+0x32/0x40 security/selinux/ss/services.c:1479
 selinux_setprocattr+0x51c/0xb50 security/selinux/hooks.c:5986
 security_setprocattr+0x85/0xc0 security/security.c:1264
 proc_pid_attr_write+0x1e6/0x280 fs/proc/base.c:2574
 __vfs_write+0xef/0x970 fs/read_write.c:480
 __kernel_write+0xfe/0x350 fs/read_write.c:501
 write_pipe_buf+0x175/0x220 fs/splice.c:797
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x328/0x730 fs/splice.c:626
 splice_from_pipe+0x1e9/0x330 fs/splice.c:661
 default_file_splice_write+0x40/0x90 fs/splice.c:809
 do_splice_from fs/splice.c:851 [inline]
 direct_splice_actor+0x125/0x180 fs/splice.c:1018
 splice_direct_to_actor+0x2c1/0x820 fs/splice.c:973
 do_splice_direct+0x2a7/0x3d0 fs/splice.c:1061
 do_sendfile+0x5d5/0xe90 fs/read_write.c:1413
 SYSC_sendfile64 fs/read_write.c:1468 [inline]
 SyS_sendfile64+0xbd/0x160 fs/read_write.c:1460
 entry_SYSCALL_64_fastpath+0x1f/0x96
----------

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 security/selinux/ss/services.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 33cfe5d..2b2ce3e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1417,7 +1417,9 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext)) {
+			if (!strncmp(initial_sid_to_string[i], scontext,
+				     scontext_len) &&
+			    !initial_sid_to_string[i][scontext_len]) {
 				*sid = i;
 				return 0;
 			}
-- 
1.8.3.1
