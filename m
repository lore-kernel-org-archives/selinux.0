Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHKahZc011276
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 15:36:44 -0500
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAHKclbC021158
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 20:38:47 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: Manoj Srivastava <srivasta@debian.org>
Subject: [PATCH] libsemanage: Fix the format of the NAME lines
Date: Tue, 17 Nov 2009 14:28:43 -0600
Message-Id: <1258489723-15486-1-git-send-email-srivasta@golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Manoj Srivastava <srivasta@debian.org>

Each manual page should start with a "NAME" section, which lists the
name and a brief description of the page separated by "\-". These
sections are parsed by "mandb" and stored in a database for the use of
"apropos" and "whatis", so they must be in a certain format. These
manual pages apparently use the wrong format and cannot be parsed by
"mandb". This commit fixes that.

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 man/man3/semanage_bool.3            |    2 +-
 man/man3/semanage_bool_set_active.3 |    3 +--
 man/man3/semanage_count.3           |    2 +-
 man/man3/semanage_del.3             |    2 +-
 man/man3/semanage_exists.3          |    2 +-
 man/man3/semanage_fcontext.3        |    2 +-
 man/man3/semanage_iface.3           |    2 +-
 man/man3/semanage_iterate.3         |    2 +-
 man/man3/semanage_list.3            |    2 +-
 man/man3/semanage_modify.3          |    2 +-
 man/man3/semanage_node.3            |    2 +-
 man/man3/semanage_port.3            |    2 +-
 man/man3/semanage_query.3           |    2 +-
 man/man3/semanage_seuser.3          |    2 +-
 man/man3/semanage_user.3            |    2 +-
 15 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/man/man3/semanage_bool.3 b/man/man3/semanage_bool.3
index 3e38bf6..67da632 100644
--- a/man/man3/semanage_bool.3
+++ b/man/man3/semanage_bool.3
@@ -1,7 +1,7 @@
 .TH semanage_bool 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Policy Booleans Management API
+semanage_bool \- SELinux Policy Booleans Management API
 
 .SH "SYNOPSIS"
 .B #include <semanage/boolean_record.h>
diff --git a/man/man3/semanage_bool_set_active.3 b/man/man3/semanage_bool_set_active.3
index d5005cb..026e29d 100644
--- a/man/man3/semanage_bool_set_active.3
+++ b/man/man3/semanage_bool_set_active.3
@@ -1,7 +1,6 @@
 .TH semanage_bool_set_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 .SH "NAME"
-.B semanage_bool_set_active \- 
-update an existing SELinux boolean in the currently active policy
+semanage_bool_set_active \- update an existing SELinux boolean in the currently active policy
 
 .SH "SYNOPSIS"
 .B #include <semanage/booleans_active.h>
diff --git a/man/man3/semanage_count.3 b/man/man3/semanage_count.3
index 09894ac..b131cbe 100644
--- a/man/man3/semanage_count.3
+++ b/man/man3/semanage_count.3
@@ -1,7 +1,7 @@
 .TH semanage_count 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Management API
+semanage_count \- SELinux Management API
 
 .SH "SYNOPSIS"
 The following count function is supported for any semanage record.
diff --git a/man/man3/semanage_del.3 b/man/man3/semanage_del.3
index ce4b46f..5b11ce3 100644
--- a/man/man3/semanage_del.3
+++ b/man/man3/semanage_del.3
@@ -1,7 +1,7 @@
 .TH semanage_del 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Management API
+semanage_del \- SELinux Management API
 
 .SH "SYNOPSIS"
 The following delete function is supported for any semanage record.
diff --git a/man/man3/semanage_exists.3 b/man/man3/semanage_exists.3
index 15f164f..da401c2 100644
--- a/man/man3/semanage_exists.3
+++ b/man/man3/semanage_exists.3
@@ -1,7 +1,7 @@
 .TH semanage_exists 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Management API
+semanage_exists \- SELinux Management API
 
 .SH "SYNOPSIS"
 The following exists function is supported for any semanage record.
diff --git a/man/man3/semanage_fcontext.3 b/man/man3/semanage_fcontext.3
index c407899..1f0bf32 100644
--- a/man/man3/semanage_fcontext.3
+++ b/man/man3/semanage_fcontext.3
@@ -1,7 +1,7 @@
 .TH semanage_fcontext 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux File Context Management API
+semanage_fcontext \- SELinux File Context Management API
 
 .SH "SYNOPSIS"
 .B #include <semanage/fcontext_record.h>
diff --git a/man/man3/semanage_iface.3 b/man/man3/semanage_iface.3
index e4aa631..90af8b4 100644
--- a/man/man3/semanage_iface.3
+++ b/man/man3/semanage_iface.3
@@ -1,7 +1,7 @@
 .TH semanage_iface 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Network Interfaces Management API
+semanage_iface \- SELinux Network Interfaces Management API
 
 .SH "SYNOPSIS"
 .B #include <semanage/iface_record.h>
diff --git a/man/man3/semanage_iterate.3 b/man/man3/semanage_iterate.3
index 0c9d7d0..8773800 100644
--- a/man/man3/semanage_iterate.3
+++ b/man/man3/semanage_iterate.3
@@ -1,7 +1,7 @@
 .TH semanage_iterate 3 "15 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Management API
+semanage_iterate \- SELinux Management API
 
 .SH "SYNOPSIS"
 The following iterate function is supported for any semanage record.
diff --git a/man/man3/semanage_list.3 b/man/man3/semanage_list.3
index c4d68ba..9376702 100644
--- a/man/man3/semanage_list.3
+++ b/man/man3/semanage_list.3
@@ -1,7 +1,7 @@
 .TH semanage_list 3 "16 March 2006" "ivg2@cornell.edu" "SELinux managent API documentation"
 
 .SH "NAME" 
-SELinux Lists Management API
+semanage_list \- SELinux Lists Management API
 
 .SH "SYNOPSIS"
 The following list function is supported for any SELinux managent record.
diff --git a/man/man3/semanage_modify.3 b/man/man3/semanage_modify.3
index ddee386..04bd801 100644
--- a/man/man3/semanage_modify.3
+++ b/man/man3/semanage_modify.3
@@ -1,7 +1,7 @@
 .TH semanage_modify 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Management API
+semanage_modify \- SELinux Management API
 
 .SH "SYNOPSIS"
 The following modify function is supported for any semanage record.
diff --git a/man/man3/semanage_node.3 b/man/man3/semanage_node.3
index 1098be5..2df7a91 100644
--- a/man/man3/semanage_node.3
+++ b/man/man3/semanage_node.3
@@ -1,7 +1,7 @@
 .TH semanage_node 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Network Nodes Management API
+semanage_node \- SELinux Network Nodes Management API
 
 .SH "SYNOPSIS"
 .B #include <semanage/node_record.h>
diff --git a/man/man3/semanage_port.3 b/man/man3/semanage_port.3
index b5f3441..3a4e626 100644
--- a/man/man3/semanage_port.3
+++ b/man/man3/semanage_port.3
@@ -1,7 +1,7 @@
 .TH semanage_port 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Network Ports Management API
+semanage_port \- SELinux Network Ports Management API
 
 .SH "SYNOPSIS"
 .B #include <semanage/port_record.h>
diff --git a/man/man3/semanage_query.3 b/man/man3/semanage_query.3
index b899595..1a6cdb2 100644
--- a/man/man3/semanage_query.3
+++ b/man/man3/semanage_query.3
@@ -1,7 +1,7 @@
 .TH semanage_query 3 "15 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux Management API
+semanage_query \- SELinux Management API
 
 .SH "SYNOPSIS"
 The following query function is supported for any semanage record.
diff --git a/man/man3/semanage_seuser.3 b/man/man3/semanage_seuser.3
index 9011724..be0fa68 100644
--- a/man/man3/semanage_seuser.3
+++ b/man/man3/semanage_seuser.3
@@ -1,7 +1,7 @@
 .TH semanage_seuser 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-Linux UID to SELinux User Management API
+semanage_seuser \- Linux UID to SELinux User Management API
 
 .SH "SYNOPSIS"
 .B #include <semanage/seuser_record.h>
diff --git a/man/man3/semanage_user.3 b/man/man3/semanage_user.3
index 5ba60b2..6102dd5 100644
--- a/man/man3/semanage_user.3
+++ b/man/man3/semanage_user.3
@@ -1,7 +1,7 @@
 .TH semanage_user 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
 .SH "NAME" 
-SELinux User Management API
+semanage_user \- SELinux User Management API
 
 .SH "SYNOPSIS"
 .B #include <semanage/user_record.h>
-- 
1.6.5.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
