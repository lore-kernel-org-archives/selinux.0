Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GX0IU017441
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:33:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 9C4071AAED
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:35 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvIUqv4y_PBW for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:34 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 30C451A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:33 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 10/15] libselinux: Fix various minor manpage issues and correct section numbering.
Date: Mon,  1 Oct 2012 18:31:52 +0200
Message-Id: <1349109117-593-11-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libselinux/man/man3/security_disable.3     |    4 ++--
 libselinux/man/man3/security_load_policy.3 |    4 ++--
 libselinux/man/man8/getenforce.8           |    2 +-
 libselinux/man/man8/selinuxenabled.8       |    2 +-
 libselinux/man/man8/selinuxexeccon.8       |    2 +-
 libselinux/man/man8/setenforce.8           |    2 +-
 libselinux/man/man8/togglesebool.8         |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/man3/security_disable.3
index 6725bde..818fc5d 100644
--- a/libselinux/man/man3/security_disable.3
+++ b/libselinux/man/man3/security_disable.3
@@ -15,7 +15,7 @@ and then unmounts /selinux.
 This function can only be called at runtime and prior to the initial policy
 load. After the initial policy load, the SELinux kernel code cannot be disabled,
 but only placed in "permissive" mode by using
-.B setenforce(1).
+.B security_setenforce(3).
 
 .SH "RETURN VALUE"
 .B security_disable
@@ -25,4 +25,4 @@ returns zero on success or \-1 on error.
 This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
 
 .SH "SEE ALSO"
-.BR selinux (8), " setenforce "(3)
+.BR selinux (8), " setenforce "(8)
diff --git a/libselinux/man/man3/security_load_policy.3 b/libselinux/man/man3/security_load_policy.3
index 163503e..f76baf9 100644
--- a/libselinux/man/man3/security_load_policy.3
+++ b/libselinux/man/man3/security_load_policy.3
@@ -43,7 +43,7 @@ unmounted using a call to
 .B security_disable(3).
 Therefore, after the initial policy load, the only operational changes
 are those permitted by
-.B setenforce(3)
+.B security_setenforce(3)
 (i.e. eventually setting the framework in permissive mode rather than
 in enforcing one).
 
@@ -54,5 +54,5 @@ returns zero on success or \-1 on error.
 This manual page has been written by Guido Trentalancia <guido@trentalancia.com>
 
 .SH "SEE ALSO"
-.BR selinux "(8), " security_disable "(3), " setenforce "(1)
+.BR selinux "(8), " security_disable "(3), " setenforce "(8)
 
diff --git a/libselinux/man/man8/getenforce.8 b/libselinux/man/man8/getenforce.8
index 8dc63c8..beaf52e 100644
--- a/libselinux/man/man8/getenforce.8
+++ b/libselinux/man/man8/getenforce.8
@@ -1,4 +1,4 @@
-.TH "getenforce" "1" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "getenforce" "8" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 getenforce \- get the current mode of SELinux
 .SH "SYNOPSIS"
diff --git a/libselinux/man/man8/selinuxenabled.8 b/libselinux/man/man8/selinuxenabled.8
index b25431f..72afb5a 100644
--- a/libselinux/man/man8/selinuxenabled.8
+++ b/libselinux/man/man8/selinuxenabled.8
@@ -1,4 +1,4 @@
-.TH "selinuxenabled" "1" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "selinuxenabled" "8" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 selinuxenabled \- tool to be used within shell scripts to determine if selinux is enabled
 .SH "SYNOPSIS"
diff --git a/libselinux/man/man8/selinuxexeccon.8 b/libselinux/man/man8/selinuxexeccon.8
index 6482d74..5054557 100644
--- a/libselinux/man/man8/selinuxexeccon.8
+++ b/libselinux/man/man8/selinuxexeccon.8
@@ -1,4 +1,4 @@
-.TH "selinuxexeccon" "1" "14 May 2011" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "selinuxexeccon" "8" "14 May 2011" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 selinuxexeccon \- report SELinux context used for this executable
 
diff --git a/libselinux/man/man8/setenforce.8 b/libselinux/man/man8/setenforce.8
index 639883e..251a88f 100644
--- a/libselinux/man/man8/setenforce.8
+++ b/libselinux/man/man8/setenforce.8
@@ -1,4 +1,4 @@
-.TH "setenforce" "1" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.TH "setenforce" "8" "7 April 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 setenforce \- modify the mode SELinux is running in.
 .SH "SYNOPSIS"
diff --git a/libselinux/man/man8/togglesebool.8 b/libselinux/man/man8/togglesebool.8
index ae21175..793b027 100644
--- a/libselinux/man/man8/togglesebool.8
+++ b/libselinux/man/man8/togglesebool.8
@@ -1,4 +1,4 @@
-.TH "togglesebool" "1" "26 Oct 2004" "sgrubb@redhat.com" "SELinux Command Line documentation"
+.TH "togglesebool" "8" "26 Oct 2004" "sgrubb@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
 togglesebool \- flip the current value of a SELinux boolean
 .SH "SYNOPSIS"
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
