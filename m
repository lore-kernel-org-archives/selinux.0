From: =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigbrady.com>
To: SELinux@tycho.nsa.gov
Cc: =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigbrady.com>
Subject: [PATCH] doc: context_new(3): fix the return value description
Date: Tue,  4 Dec 2012 02:33:02 +0000
Message-Id: <1354588382-19083-1-git-send-email-P@draigBrady.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libselinux/man/man3/context_new.3 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man3/context_new.3 b/libselinux/man/man3/context_new.3
index 820f927..ca7140e 100644
--- a/libselinux/man/man3/context_new.3
+++ b/libselinux/man/man3/context_new.3
@@ -54,8 +54,8 @@ context_type_set, context_range_set, context_role_set, context_user_set
  Set a context component
 
 .SH "RETURN VALUE"
-On success, zero is returned. On failure, -1 is returned and errno is
-set appropriately.
+On failure, the context_*_set functions return non-zero, while other
+functions return zero or NULL.  errno is set appropriately.
 
 .SH "SEE ALSO"
 .BR selinux "(8)"
-- 
1.7.6.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
