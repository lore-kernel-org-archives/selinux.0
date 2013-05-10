Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2PD015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:08 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 12/16] libsepol: Fix cases where hyphen were used as minus sign in manpages
Date: Fri, 10 May 2013 14:45:20 +0200
Message-Id: <1368189924-8501-13-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libsepol/man/man3/sepol_check_context.3 | 2 +-
 libsepol/man/man3/sepol_genbools.3      | 2 +-
 libsepol/man/man3/sepol_genusers.3      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/man/man3/sepol_check_context.3 b/libsepol/man/man3/sepol_check_context.3
index a63cd56..4a3c57d 100644
--- a/libsepol/man/man3/sepol_check_context.3
+++ b/libsepol/man/man3/sepol_check_context.3
@@ -22,4 +22,4 @@ policy on a SELinux system, use
 from libselinux instead.
 
 .SH "RETURN VALUE"
-Returns 0 on success or -1 with errno set otherwise.
+Returns 0 on success or \-1 with errno set otherwise.
diff --git a/libsepol/man/man3/sepol_genbools.3 b/libsepol/man/man3/sepol_genbools.3
index 0a30137..ca5b5a6 100644
--- a/libsepol/man/man3/sepol_genbools.3
+++ b/libsepol/man/man3/sepol_genbools.3
@@ -21,7 +21,7 @@ does likewise, but obtains the boolean settings from the parallel arrays
 (names, values) with nel elements each.
 
 .SH "RETURN VALUE"
-Returns 0 on success or -1 otherwise, with errno set appropriately.
+Returns 0 on success or \-1 otherwise, with errno set appropriately.
 An errno of ENOENT indicates that the boolean file did not exist.
 An errno of EINVAL indicates that one or more booleans listed in the
 boolean file was undefined in the policy or had an invalid value specified;
diff --git a/libsepol/man/man3/sepol_genusers.3 b/libsepol/man/man3/sepol_genusers.3
index 05dff00..1f820ff 100644
--- a/libsepol/man/man3/sepol_genusers.3
+++ b/libsepol/man/man3/sepol_genusers.3
@@ -44,7 +44,7 @@ set to 1 prior to calling
 in order to enable deletion of such users.
 
 .SH "RETURN VALUE"
-Returns 0 on success or -1 otherwise, with errno set appropriately.
+Returns 0 on success or \-1 otherwise, with errno set appropriately.
 An errno of ENOENT indicates that one or both of the user
 configuration files did not exist.  An errno of EINVAL indicates that
 either the original binary policy image or the generated one were
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
