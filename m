From: Stephen Smalley <sds@tycho.nsa.gov>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] timerfd: only check CAP_WAKE_ALARM when it is needed
Date: Fri, 17 Feb 2017 10:13:59 -0500
Message-Id: <1487344439-22293-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

timerfd_create() and do_timerfd_settime() presently always
call capable(CAP_WAKE_ALARM) although CAP_WAKE_ALARM is
only required for CLOCK_REALTIME_ALARM and CLOCK_BOOTTIME_ALARM.
This can cause extraneous audit messages when using a LSM such
as SELinux, incorrectly causes PF_SUPERPRIV to be set even when
no privilege was exercised, and is inefficient.  Flip the order
of the tests in both functions so that we only call capable() if
the capability is truly required for the operation.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 fs/timerfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 384fa75..c543cdb 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -400,9 +400,9 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 	     clockid != CLOCK_BOOTTIME_ALARM))
 		return -EINVAL;
 
-	if (!capable(CAP_WAKE_ALARM) &&
-	    (clockid == CLOCK_REALTIME_ALARM ||
-	     clockid == CLOCK_BOOTTIME_ALARM))
+	if ((clockid == CLOCK_REALTIME_ALARM ||
+	     clockid == CLOCK_BOOTTIME_ALARM) &&
+	    !capable(CAP_WAKE_ALARM))
 		return -EPERM;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -449,7 +449,7 @@ static int do_timerfd_settime(int ufd, int flags,
 		return ret;
 	ctx = f.file->private_data;
 
-	if (!capable(CAP_WAKE_ALARM) && isalarm(ctx)) {
+	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM)) {
 		fdput(f);
 		return -EPERM;
 	}
-- 
2.7.4
