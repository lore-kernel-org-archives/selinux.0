Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u04EOKDA024768
 for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2016 09:24:20 -0500
Received: by mail-qg0-f44.google.com with SMTP id b35so124804915qge.0
 for <selinux@tycho.nsa.gov>; Mon, 04 Jan 2016 06:24:06 -0800 (PST)
From: Joshua Brindle <brindle@quarksecurity.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] update deps and change yum to dnf
Date: Mon,  4 Jan 2016 09:23:54 -0500
Message-Id: <1451917434-40069-1-git-send-email-brindle@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index dae1eb9..2497485 100644
--- a/README
+++ b/README
@@ -2,7 +2,7 @@ Please submit all bug reports and patches to selinux@tycho.nsa.gov.
 Subscribe via selinux-join@tycho.nsa.gov.
 
 Build dependencies on Fedora:
-yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel
+dnf install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel gcc redhat-rpm-config xmlto
 
 To build and install everything under a private directory, run:
 make DESTDIR=~/obj install install-pywrap
-- 
2.5.0
