Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2PA015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:04 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 09/16] libselinux: Fix various minor manpage issues and correct section numbering.
Date: Fri, 10 May 2013 14:45:17 +0200
Message-Id: <1368189924-8501-10-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libselinux/man/man3/security_disable.3     | 4 ++--
 libselinux/man/man3/security_load_policy.3 | 4 ++--
 libselinux/man/man8/getenforce.8           | 2 +-
 libselinux/man/man8/selinuxenabled.8       | 2 +-
 libselinux/man/man8/selinuxexeccon.8       | 2 +-
 libselinux/man/man8/setenforce.8           | 2 +-
 libselinux/man/man8/togglesebool.8         | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/man3/security_disable.3
index aeb78da..c75ce0d 100644
--- a/libselinux/man/man3/security_disable.3
+++ b/libselinux/man/man3/security_disable.3
@@ -17,7 +17,7 @@ and then unmounts
 This function can only be called at runtime and prior to the initial policy
 load. After the initial policy load, the SELinux kernel code cannot be disabled,
 but only placed in "permissive" mode by using
-.BR setenforce (1).
+.BR security_setenforce(3).
 .
 .SH "RETURN VALUE"
 .BR security_disable ()
@@ -27,4 +27,4 @@ returns zero on success or \-1 on error.
 This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
 .
 .SH "SEE ALSO"
-.BR selinux (8), " setenforce "(3)
+.BR selinux (8), " setenforce "(8)
diff --git a/libselinux/man/man3/security_load_policy.3 b/libselinux/man/man3/security_load_policy.3
index c4439bf..af56163 100644
--- a/libselinux/man/man3/security_load_policy.3
+++ b/libselinux/man/man3/security_load_policy.3
@@ -43,7 +43,7 @@ unmounted using a call to
 .BR security_disable (3).
 Therefore, after the initial policy load, the only operational changes
 are those permitted by
-.BR setenforce (3)
+.BR security_setenforce (3)
 (i.e. eventually setting the framework in permissive mode rather than
 in enforcing one).
 .
@@ -54,4 +54,4 @@ Returns zero on success or \-1 on error.
 This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
 .
 .SH "SEE ALSO"
-.BR selinux "(8), " security_disable "(3), " setenforce "(1)
+.BR selinux "(8), " security_disable "(3), " setenforce "(8)
diff --git a/libselinux/man/man8/getenforce.8 b/libselinux/man/man8/getenforce.8
index 906279f..e0924d8 100644
--- a/libselinux/man/man8/getenforce.8
+++ b/libselinux/man/man8/getenforce.8
@@ -1,4 +1,4 @@
-.TH "getenforce" "1" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "getenforce" "8" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 getenforce \- get the current mode of SELinux
 .
diff --git a/libselinux/man/man8/selinuxenabled.8 b/libselinux/man/man8/selinuxenabled.8
index e0b5201..ac20587 100644
--- a/libselinux/man/man8/selinuxenabled.8
+++ b/libselinux/man/man8/selinuxenabled.8
@@ -1,4 +1,4 @@
-.TH "selinuxenabled" "1" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "selinuxenabled" "8" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 selinuxenabled \- tool to be used within shell scripts to determine if selinux is enabled
 .
diff --git a/libselinux/man/man8/selinuxexeccon.8 b/libselinux/man/man8/selinuxexeccon.8
index 765cf8c..30c20ed 100644
--- a/libselinux/man/man8/selinuxexeccon.8
+++ b/libselinux/man/man8/selinuxexeccon.8
@@ -1,4 +1,4 @@
-.TH "selinuxexeccon" "1" "14 May 2011" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "selinuxexeccon" "8" "14 May 2011" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 selinuxexeccon \- report SELinux context used for this executable
 .
diff --git a/libselinux/man/man8/setenforce.8 b/libselinux/man/man8/setenforce.8
index b038da0..8a24f1c 100644
--- a/libselinux/man/man8/setenforce.8
+++ b/libselinux/man/man8/setenforce.8
@@ -1,4 +1,4 @@
-.TH "setenforce" "1" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "setenforce" "8" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 setenforce \- modify the mode SELinux is running in
 .
diff --git a/libselinux/man/man8/togglesebool.8 b/libselinux/man/man8/togglesebool.8
index 948aff1..598dc94 100644
--- a/libselinux/man/man8/togglesebool.8
+++ b/libselinux/man/man8/togglesebool.8
@@ -1,4 +1,4 @@
-.TH "togglesebool" "1" "26 Oct 2004" "sgrubb@redhat.com" "SELinux Command Line documentation"
+.TH "togglesebool" "8" "26 Oct 2004" "sgrubb@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 togglesebool \- flip the current value of a SELinux boolean
 .
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
