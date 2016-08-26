Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7QHf4I6016571
 for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2016 13:41:04 -0400
Message-ID: <1472233238.14055.0.camel@trentalancia.net>
Subject: [PATCH v3] Build the SELinux testsuite on systems using the
 Reference Policy
From: Guido Trentalancia <guido@trentalancia.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Fri, 26 Aug 2016 19:40:38 +0200
In-Reply-To: <ea82b422-2aa4-9bbb-dc56-d1cfb05bff20@tycho.nsa.gov>
References: <1472042396.4446.4.camel@trentalancia.net>
 <1472047913.4446.7.camel@trentalancia.net>
 <ea82b422-2aa4-9bbb-dc56-d1cfb05bff20@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the Makefile in the policy subdirectory of the SELinux testsuite
so that it builds correctly on the standard Reference Policy which
does not have the same booleans available on Red Hat.

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 policy/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- selinux-testsuite-git-23082016-orig/policy/Makefile	2016-08-23 20:50:08.527633728 +0200
+++ selinux-testsuite-git-23082016/policy/Makefile	2016-08-26 19:37:13.195088500 +0200
@@ -68,7 +69,7 @@ load_rhel: all
 
 load_general: all
 	# General policy load
-	/usr/sbin/setsebool allow_domain_fd_use=0
+	/usr/sbin/getsebool allow_domain_fd_use > /dev/null && /usr/sbin/setsebool allow_domain_fd_use=0 || :
 	$(SEMODULE) -i test_policy/test_policy.pp
 
 unload_rhel:
@@ -77,7 +78,7 @@ unload_rhel:
 
 unload_general:
 	# General policy unload
-	/usr/sbin/setsebool allow_domain_fd_use=1
+	/usr/sbin/getsebool allow_domain_fd_use > /dev/null && /usr/sbin/setsebool allow_domain_fd_use=1 || :
 	$(SEMODULE) -r test_policy
 
 clean:
