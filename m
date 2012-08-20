Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7KAFHMw001298
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2012 06:15:17 -0400
Message-Id: <201208201015.q7KAFDs5004339@vivaldi42.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH]: libselinux: improve the file_contexts.5 manual page
Date: Mon, 20 Aug 2012 12:15:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manual page improvements for the file_contexts and related policy
configuration files (section 5):

- create links to selabel_file.5 not only for file_contexts.5 but
  also for the other optional policy configuration files (including
  the so-called file contexts "substitution" files);
- clarify the above mentioned manual page(s), in particular relatively
  to the action performed by the so-called file contexts "substitution"
  policy configuration files (aliasing/equivalence versus substitution);
- improve the explanation of the form that the "substitution" files
  shall have.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 libselinux/man/man5/file_contexts.homedirs.5  |    1 +
 libselinux/man/man5/file_contexts.local.5     |    1 +
 libselinux/man/man5/file_contexts.subs.5      |    1 +
 libselinux/man/man5/file_contexts.subs_dist.5 |    1 +
 libselinux/man/man5/selabel_file.5            |   12 ++++++------
 5 files changed, 10 insertions(+), 6 deletions(-)

diff -pruN selinux-20072012/libselinux/man/man5/file_contexts.homedirs.5 selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.homedirs.5
--- selinux-20072012/libselinux/man/man5/file_contexts.homedirs.5	1970-01-01 01:00:00.000000000 +0100
+++ selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.homedirs.5	2012-08-20 13:35:38.305500851 +0200
@@ -0,0 +1 @@
+.so man5/selabel_file.5
diff -pruN selinux-20072012/libselinux/man/man5/file_contexts.local.5 selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.local.5
--- selinux-20072012/libselinux/man/man5/file_contexts.local.5	1970-01-01 01:00:00.000000000 +0100
+++ selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.local.5	2012-08-20 13:37:22.484434944 +0200
@@ -0,0 +1 @@
+.so man5/selabel_file.5
diff -pruN selinux-20072012/libselinux/man/man5/file_contexts.subs.5 selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.subs.5
--- selinux-20072012/libselinux/man/man5/file_contexts.subs.5	1970-01-01 01:00:00.000000000 +0100
+++ selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.subs.5	2012-08-20 13:39:24.705538673 +0200
@@ -0,0 +1 @@
+.so man5/selabel_file.5
diff -pruN selinux-20072012/libselinux/man/man5/file_contexts.subs_dist.5 selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.subs_dist.5
--- selinux-20072012/libselinux/man/man5/file_contexts.subs_dist.5	1970-01-01 01:00:00.000000000 +0100
+++ selinux-20072012-file_contexts-manual-page/libselinux/man/man5/file_contexts.subs_dist.5	2012-08-20 13:33:40.752437444 +0200
@@ -0,0 +1 @@
+.so man5/selabel_file.5
diff -pruN selinux-20072012/libselinux/man/man5/selabel_file.5 selinux-20072012-file_contexts-manual-page/libselinux/man/man5/selabel_file.5
--- selinux-20072012/libselinux/man/man5/selabel_file.5	2012-06-18 18:54:45.646499176 +0200
+++ selinux-20072012-file_contexts-manual-page/libselinux/man/man5/selabel_file.5	2012-08-20 13:44:35.395339044 +0200
@@ -63,7 +63,7 @@ If fBSELABEL_OPT_BASEONLYfR is set, th
 .IP "1." 4
 The mandatory file contexts file that is either the fully qualified file name from fISELABEL_OPT_PATH.valuefR or if fINULLfR, then the path returned by fBselinux_file_context_pathfR(3).
 .IP "2." 4
-The optional local and distribution substitution files that perform any substitutions on the 'in memory' version of the file contexts file.
+The optional local and distribution substitution files that perform path aliasing on the 'in memory' version of the file contexts file.
 .br
 These files have the same name as the mandatory file contexts file with the extensions fI.subsfR and fI.subs_distfR added.
 .RE
@@ -81,7 +81,7 @@ The optional user home directory customi
 .br
 fBselinux_file_context_homedir_pathfR(3) will return the default path to this file.
 .IP "4." 4
-The optional local and distribution substitution files that perform any substitutions on the 'in memory' version of the file contexts file (and the fI.localfR and/or fI.homedirsfR if present). These files have the same name as the mandatory file contexts file with the extensions fI.subsfR and fI.subs_distfR added.
+The optional local and distribution substitution files that perform path aliasing on the 'in memory' version of the file contexts file (and the fI.localfR and/or fI.homedirsfR if present). These files have the same name as the mandatory file contexts file with the extensions fI.subsfR and fI.subs_distfR added.
 .br
 fBselinux_file_context_subs_pathfR(3) and fBselinux_file_context_subs_dist_pathfR(3) will return the default paths to these files.
 .RE
@@ -163,20 +163,20 @@ Example:
 
 .SH "Substitution File Format"
 .sp
-Each line within the substitution files (fI.subsfR and fI.subs_distfR) is:
+Each line within the substitution files (fI.subsfR and fI.subs_distfR) has the form:
 .RS
-.I pathname subs_pathname
+.I subs_pathname pathname
 .RE
 .sp
 Where:
 .RS
 .I pathname
 .RS
-A path that matches an entry in one or more of the file contexts files.
+A path that matches an entry in one or more of the file contexts policy configuration file.
 .RE
 .I subs_pathname
 .RS
-The path that will be substituted for pathname by the look up process.
+The path that will be aliased (considered equivalent) with pathname by the look up process.
 .RE
 .RE
 .sp
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
