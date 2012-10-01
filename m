Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWubi017392
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 75B5D1A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:45 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x9ZT3Bs0svxv for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:44 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 5E3AC1AAEC
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:43 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 14/15] libsepol: Fix cases where hyphen were used as minus sign in manpages
Date: Mon,  1 Oct 2012 18:31:56 +0200
Message-Id: <1349109117-593-15-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libsepol/man/man3/sepol_check_context.3 |    2 +-
 libsepol/man/man3/sepol_genbools.3      |    2 +-
 libsepol/man/man3/sepol_genusers.3      |    2 +-
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
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
