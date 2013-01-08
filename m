Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0829iK3017901
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2013 21:09:44 -0500
Message-ID: <50EB7FD6.7070207@schaufler-ca.com>
Date: Mon, 07 Jan 2013 18:09:26 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v12 5/9] LSM: Multiple concurrent LSMs
References: <50EB7C50.3070605@schaufler-ca.com>
In-Reply-To: <50EB7C50.3070605@schaufler-ca.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v12 5/9] LSM: Multiple concurrent LSMs

Change the infrastructure for Linux Security Modules (LSM)s
from a single vector of hook handlers to a list based method
for handling multiple concurrent modules. 

Add per-LSM interfaces in /proc/*/attr as it is infeasible
to share them when more than one LSM is active.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 fs/proc/base.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9b43ff77..458422b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2216,12 +2216,28 @@ static const struct file_operations proc_pid_attr_operations = {
 };
 
 static const struct pid_entry attr_dir_stuff[] = {
-	REG("current",    S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("prev",       S_IRUGO,	   proc_pid_attr_operations),
-	REG("exec",       S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("fscreate",   S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("keycreate",  S_IRUGO|S_IWUGO, proc_pid_attr_operations),
-	REG("sockcreate", S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("current",            S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("prev",               S_IRUGO,	   proc_pid_attr_operations),
+	REG("exec",               S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("fscreate",           S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("keycreate",          S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("sockcreate",         S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+#ifdef CONFIG_SECURITY_SELINUX
+	REG("selinux.current",    S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("selinux.prev",       S_IRUGO,	   proc_pid_attr_operations),
+	REG("selinux.exec",       S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("selinux.fscreate",   S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("selinux.keycreate",  S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("selinux.sockcreate", S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	REG("smack.current",      S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR
+	REG("apparmor.current",   S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("apparmor.prev",      S_IRUGO,	   proc_pid_attr_operations),
+	REG("apparmor.exec",      S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+#endif
 };
 
 static int proc_attr_dir_readdir(struct file * filp,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
