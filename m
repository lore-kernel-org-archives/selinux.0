To: <tmraz@redhat.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Incorrect check in pam_rootok
Message-ID: <55CB511D.7020708@tresys.com>
Date: Wed, 12 Aug 2015 09:58:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: "SELinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Working an issue here, we uncovered that PAM is checking the wrong
SELinux permission in the pam_rootok module; it checks the passwd
permission instead of the rootok permission.  This issue was reported
earlier this year[1] but no action has been taken.

This has been around since early 2013, when the code was changed from
the old checkPasswdAccess() to selinux_check_access(), but an impact to
users would be rare since most domains that have the rootok permission
also have the passwd permission.

[1] https://fedorahosted.org/linux-pam/ticket/37

diff --git a/modules/pam_rootok/pam_rootok.c
b/modules/pam_rootok/pam_rootok.c
index 70579e5..88bed0c 100644
--- a/modules/pam_rootok/pam_rootok.c
+++ b/modules/pam_rootok/pam_rootok.c
@@ -106,7 +106,7 @@ selinux_check_root (void)
        return status;
     }

-    status = selinux_check_access(user_context, user_context, "passwd",
"passwd", NULL);
+    status = selinux_check_access(user_context, user_context, "passwd",
"rootok", NULL);

     selinux_set_callback(SELINUX_CB_LOG, old_callback);
     freecon(user_context);

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
