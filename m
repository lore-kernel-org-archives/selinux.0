Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBH4i1a7010219
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 23:44:02 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so16922129pfz.3
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 20:44:01 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, Android Kernel Team <kernel-team@android.com>,
 Rom Lemarchand <romlem@android.com>, Colin Cross <ccross@android.com>,
 Dmitry Shmidt <dimitrysh@google.com>, Todd Kjos <tkjos@google.com>,
 Christian Poetzsch <christian.potzsch@imgtec.com>,
 Amit Pundir <amit.pundir@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Kees Cook <keescook@chromium.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-api@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Jeff Vander Stoep <jeffv@google.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH] cgroup: Add new capability to allow a process to migrate
 other tasks between cgroups
Date: Fri, 16 Dec 2016 20:43:46 -0800
Message-Id: <1481949827-23613-1-git-send-email-john.stultz@linaro.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch adds CAP_GROUP and logic to allows a process to
migrate other tasks between cgroups.

In Android (where this feature originated), the ActivityManager
tracks various application states (TOP_APP, FOREGROUND,
BACKGROUND, SYSTEM, etc), and then as applications change
states, the SchedPolicy logic will migrate the application tasks
between different cgroups used to control the different
application states (for example, there is a background cpuset
cgroup which can limit background tasks to stay on one low-power
cpu, and the bg_non_interactive cpuctrl cgroup can then further
limit those background tasks to a small percentage of that one
cpu's cpu time).

However, for security reasons, Android doesn't want to make the
system_server (the process that runs the ActivityManager and
SchedPolicy logic), run as root. So in the Android common.git
kernel, they have some logic to allow cgroups to loosen their
permissions so CAP_SYS_NICE tasks can migrate other tasks between
cgroups.

I feel the approach taken there overloads CAP_SYS_NICE a bit much
for non-android environments. Efforts to re-use CAP_SYS_RESOURCE
for this purpose (which Android has since adopted) was also
stymied by concerns about risks from future cgroups that could be
considered "dangerous" by how they might change system semantics.

So to avoid overlapping usage, this patch adds a brand new
process capability flag (CAP_CGROUP), and uses it when checking
if a task can migrate other tasks between cgroups.

I've tested this with AOSP master (though its a bit hacked in as
I still need to properly get the selinux userspace bits aware of
the new capability bit) with selinux set to permissive and it
seems to be working well.

Thoughts and feedback would be appreciated!

(Note, I'm going on holiday break after today, so I may not
respond to feedback immediately, but I figured it would be
better to give folks the chance to review this rather then sit
it for two weeks. I'll resend after the new-year, addressing any
feedback I do get.)

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org
Cc: Android Kernel Team <kernel-team@android.com>
Cc: Rom Lemarchand <romlem@android.com>
Cc: Colin Cross <ccross@android.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Christian Poetzsch <christian.potzsch@imgtec.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: linux-api@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: linux-security-module@vger.kernel.org
Cc: selinux@tycho.nsa.gov
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Renamed to just CAP_CGROUP_MIGRATE as reccomended by Tejun
v3: Switched to just using CAP_SYS_RESOURCE as suggested by Michael
v4: Send out properly folded down version of the patch. :P
v5: Switch back to CAP_CGROUP_MIGRATE due to concerns from Andy
v6: Rename to CAP_CGROUP, as it might be used for other purposes
    in the future. Also added selinux mappings for the new cap.
---
 include/uapi/linux/capability.h     | 5 ++++-
 kernel/cgroup.c                     | 3 ++-
 security/selinux/include/classmap.h | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 49bc062..726f767 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -349,8 +349,11 @@ struct vfs_cap_data {
 
 #define CAP_AUDIT_READ		37
 
+/* Allow migration of other tasks between cgroups */
 
-#define CAP_LAST_CAP         CAP_AUDIT_READ
+#define CAP_CGROUP		38
+
+#define CAP_LAST_CAP         CAP_CGROUP
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index 2ee9ec3..8b42ae3 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -2856,7 +2856,8 @@ static int cgroup_procs_write_permission(struct task_struct *task,
 	 */
 	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
 	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid))
+	    !uid_eq(cred->euid, tcred->suid) &&
+	    !ns_capable(tcred->user_ns, CAP_CGROUP))
 		ret = -EACCES;
 
 	if (!ret && cgroup_on_dfl(dst_cgrp)) {
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index e2d4ad3a..ee8c1ed 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -22,9 +22,9 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read"
+		"wake_alarm", "block_suspend", "audit_read", "cgroup"
 
-#if CAP_LAST_CAP > CAP_AUDIT_READ
+#if CAP_LAST_CAP > CAP_CGROUP
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.7.4
