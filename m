Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GlkWZ018614
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:47:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 2E7CD1AAED
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:44 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGrgq6zHyqTy for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:42 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id A04351A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:40 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 13/15] libsemanage: Fix cases where hyphen were used as minus sign in manpages
Date: Mon,  1 Oct 2012 18:31:55 +0200
Message-Id: <1349109117-593-14-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libsemanage/man/man3/semanage_bool_set_active.3 |    2 +-
 libsemanage/man/man3/semanage_count.3           |    2 +-
 libsemanage/man/man3/semanage_del.3             |    2 +-
 libsemanage/man/man3/semanage_exists.3          |    2 +-
 libsemanage/man/man3/semanage_iterate.3         |    4 ++--
 libsemanage/man/man3/semanage_list.3            |    2 +-
 libsemanage/man/man3/semanage_modify.3          |    2 +-
 libsemanage/man/man3/semanage_query.3           |    2 +-
 libsemanage/man/man3/semanage_set_root.3        |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libsemanage/man/man3/semanage_bool_set_active.3 b/libsemanage/man/man3/semanage_bool_set_active.3
index 026e29d..d868fe8 100644
--- a/libsemanage/man/man3/semanage_bool_set_active.3
+++ b/libsemanage/man/man3/semanage_bool_set_active.3
@@ -40,7 +40,7 @@ This function requires an semanage connection to be established (see
 ).
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise 0 is returned.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_count.3 b/libsemanage/man/man3/semanage_count.3
index b131cbe..b865a21 100644
--- a/libsemanage/man/man3/semanage_count.3
+++ b/libsemanage/man/man3/semanage_count.3
@@ -33,7 +33,7 @@ This function requires an semanage connection to be established (see
 )
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_del.3 b/libsemanage/man/man3/semanage_del.3
index 5b11ce3..4dd0a77 100644
--- a/libsemanage/man/man3/semanage_del.3
+++ b/libsemanage/man/man3/semanage_del.3
@@ -40,7 +40,7 @@ This function requires an semanage connection to be established (see
 ).
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise 0 is returned.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_exists.3 b/libsemanage/man/man3/semanage_exists.3
index da401c2..6d68c76 100644
--- a/libsemanage/man/man3/semanage_exists.3
+++ b/libsemanage/man/man3/semanage_exists.3
@@ -38,7 +38,7 @@ This function requires an semanage connection to be established (see
 )
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other read calls to the semanage database until the next commit.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_iterate.3 b/libsemanage/man/man3/semanage_iterate.3
index 8773800..5c32695 100644
--- a/libsemanage/man/man3/semanage_iterate.3
+++ b/libsemanage/man/man3/semanage_iterate.3
@@ -31,7 +31,7 @@ if that is necessary.
 
 The handler code may not invoke any semanage write requests for the same object type (i.e. modifying the underlying store is not allowed). The iterate function is reentrant only while inside a transaction (see
 .B semanage_begin_transaction
-). It is not safe to execute other semanage read or write requests within iterate if not inside a transaction. The handler may return -1 to signal error exit, 0 to signal continue, and 1 to signal successful exit early (the iterate function will stop accordingly). 
+). It is not safe to execute other semanage read or write requests within iterate if not inside a transaction. The handler may return \-1 to signal error exit, 0 to signal continue, and 1 to signal successful exit early (the iterate function will stop accordingly). 
 
 .TP
 .B Parameters:
@@ -50,7 +50,7 @@ This function requires an semanage connection to be established (see
 )
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_list.3 b/libsemanage/man/man3/semanage_list.3
index 9376702..acc161f 100644
--- a/libsemanage/man/man3/semanage_list.3
+++ b/libsemanage/man/man3/semanage_list.3
@@ -39,7 +39,7 @@ This function requires an semanage connection to be established (see
 )
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_modify.3 b/libsemanage/man/man3/semanage_modify.3
index 04bd801..ee23900 100644
--- a/libsemanage/man/man3/semanage_modify.3
+++ b/libsemanage/man/man3/semanage_modify.3
@@ -42,7 +42,7 @@ This function requires an semanage connection to be established (see
 ).
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise 0 is returned.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_query.3 b/libsemanage/man/man3/semanage_query.3
index 1a6cdb2..e61c8b8 100644
--- a/libsemanage/man/man3/semanage_query.3
+++ b/libsemanage/man/man3/semanage_query.3
@@ -39,7 +39,7 @@ This function requires an semanage connection to be established (see
 )
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+In case of failure, \-1 is returned, and the semanage error callback is invoked, describing the error.
 Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
 
 .SH "SEE ALSO"
diff --git a/libsemanage/man/man3/semanage_set_root.3 b/libsemanage/man/man3/semanage_set_root.3
index 2ae0f17..664822e 100644
--- a/libsemanage/man/man3/semanage_set_root.3
+++ b/libsemanage/man/man3/semanage_set_root.3
@@ -15,7 +15,7 @@ Set the alternate root directory for SELinux configuration directory.
 This function sets an alternate root directory to for SELinux configuration paths to be used by the semanage library.
 
 .SH "RETURN VALUE"
-In case of failure, -1 is returned.
+In case of failure, \-1 is returned.
 Otherwise 0 is returned.
 
 .SH "SEE ALSO"
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
