Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3NG4gaR016230
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2013 12:04:42 -0400
Message-ID: <5176B119.5090308@schaufler-ca.com>
Date: Tue, 23 Apr 2013 09:04:41 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
CC: John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v13 6/9] LSM: Additional interfaces in /proc/pid/attr
References: <5176ABB7.5080300@schaufler-ca.com>
In-Reply-To: <5176ABB7.5080300@schaufler-ca.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v13 6/9] LSM: Additional interfaces in /proc/pid/attr

SELinux, Smack and AppArmor share the files to /proc/<pid>/attr.
This is fine when only one LSM is allowed, but not so good
when there is more than one of those LSMs active. For backward
compatability the old interfaces are left as is. New interfaces
specific to the LSMs have been added. There is also a new entry
"context", which is the combined security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 fs/proc/base.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 69078c7..51435ba 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2217,12 +2217,29 @@ static const struct file_operations proc_pid_attr_operations = {
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
+	REG("context",            S_IRUGO|S_IWUGO, proc_pid_attr_operations),
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
