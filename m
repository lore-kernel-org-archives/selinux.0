Subject: Re: Adding audit messge to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Chris Wright <chrisw@osdl.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051220221439.16245.qmail@web51505.mail.yahoo.com>
References: <20051220221439.16245.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 11:10:25 -0500
Message-Id: <1135181425.18223.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-12-20 at 14:14 -0800, Steve G wrote:
> Hi,
> 
> I am attaching a patch that lets newrole send messages to the audit system. This
> patch needs review as it changes newrole to be setuid root. The patch drops
> capabilities very soon after startup. 
> 
> You will need recent audit package in order to compile newrole since it uses the
> USER_ROLE_CHANGE message type. It is available in version 1.1.2.

cc'd Chris for review/discussion of the capability dropping code.

diff -urp policycoreutils-1.29.2.orig/newrole/newrole.c policycoreutils-1.29.2/newrole/newrole.c
--- policycoreutils-1.29.2.orig/newrole/newrole.c	2005-12-20 15:29:44.000000000 -0500
+++ policycoreutils-1.29.2/newrole/newrole.c	2005-12-20 17:06:12.000000000 -0500
@@ -332,6 +335,48 @@ static int verify_shell(const char *shel
   return found;
 }
 
+/*
+ * This function will drop the capabilities so that we are left
+ * only with access to the audit system. If the user is root, we leave
+ * the capabilities alone since they already should have access to the
+ * audit netlink socket.
+ */
+static void drop_capabilities(void)
+{
+  uid_t uid = getuid();
+
+  if (uid) { /* Non-root path */
+    cap_t new_caps;
+    cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
+
+    /* Keep capabilities across uid change */
+    prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+
+    /* Change uid */
+    if (setuid(uid)) {
+      fprintf(stderr, _("Error changing uid, aborting.\n"));
+      exit(-1);
+    }
+
+    /* Now get rid of this ability */
+    prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0);
+
+    /* We should still have root's caps, so let drop them. */
+    new_caps = cap_init();
+    if (!new_caps) {
+      fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+      exit(-1);
+    }
+    cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
+    cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
+    if (cap_set_proc(new_caps)) {
+      fprintf(stderr, _("Error dropping capabilities, aborting"));
+      exit(-1);
+    }
+    cap_free(new_caps);
+  }
+}

Why don't you drop capabilities first, then switch to the real uid?
Otherwise, you have a task with the caller's uid and full capabilities
for an interval of time, right?

@@ -401,6 +446,8 @@ int main( int argc, char *argv[] ) {
     exit(-1);
   }
 
+  drop_capabilities();
+
   while (1) {
     clflag=getopt_long(argc,argv,"r:t:l:",long_options,&flag_index);
     if (clflag == -1)

Any reason we can't move this up earlier in main()?  Ideally, it should
be the first thing in main() to ensure that everything else runs under
the caller's uid as before.

@@ -753,6 +799,23 @@ int main( int argc, char *argv[] ) {
        fprintf(stderr, _("Could not set exec context to %s.\n"), new_context);
        exit(-1);
   }
+  /* Send audit message */
+  {
+    char msg[128];  /* This number is a guess */
+    int audit_fd = audit_open();
+    if (audit_fd < 0) {
+       fprintf(stderr, _("Error connecting to audit system.\n"));
+       exit(-1);
+    }
+    snprintf(msg, sizeof(msg), "newrole: old-context=%s new-context=%s",
+             old_context, new_context);

Why not just dynamically allocate the msg buffer to be of the right
size?  There is the potential for memory allocation failure, but we
should just abort in that case, and audit_log_user_message can fail
anyway.

+    if (audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
+                               msg, NULL, NULL, ttyn, 1) <= 0) {
+       fprintf(stderr, _("Error sending audit message.\n"));
+       exit(-1);
+    }
+    close(audit_fd);
+  }
   execv(argv[optind-1],argv+optind-1);
 
   /* If we reach here, then we failed to exec the new shell. */

Also, I think that the audit-related code should be separately #ifdef'd
and made optional (and newrole shouldn't be made setuid unless building
with that option).  At the very least, it needs to be optional because
not every distro that uses SELinux has audit integrated yet, and some
people may specifically not want to require a setuid newrole (despite
the capability dropping measures).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
