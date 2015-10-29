Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9TAIvaK012169
 for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2015 06:18:57 -0400
Received: by oiao187 with SMTP id o187so26013307oia.3
 for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2015 03:18:16 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 Oct 2015 19:18:16 +0900
Message-ID: <CADFhUBEkRoBL2Cazn67oCXjYAaELgjg5ReFSHWTQ7gj960_xSQ@mail.gmail.com>
Subject: [sandbox] init script of sandbox returns an improper return code in
 status function
From: Keigo Noha <knoha@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dear maintainers,

I'm Keigo Noha in Red Hat.
I made a patch for init script in sandbox.

===========================

Author: Keigo Noha <knoha@redhat.com>
Date:   Wed Oct 28 17:21:02 2015 +0900

    [sandbox] init script of sandbox returns an improper return code
in status function
    Previous sandbox's init script returns 0 only in status function.
    This return code causes wrong service status report in
system-config-services.

    This fix will change the return code to return a proper code for
system-config-services.

    Signed-off-by: Keigo Noha <knoha@redhat.com>

diff --git a/policycoreutils/sandbox/sandbox.init
b/policycoreutils/sandbox/sandbox.init
index 357a7b8..b3979bf 100644
--- a/policycoreutils/sandbox/sandbox.init
+++ b/policycoreutils/sandbox/sandbox.init
@@ -42,15 +42,12 @@ stop() {
 }

 status() {
-        EXIT_CODE=0
        if [ -f "$LOCKFILE" ]; then
            echo "$base is running"
-           EXIT_CODE=0
        else
            echo "$base is stopped"
-           EXIT_CODE=3
        fi
-       exit $EXIT_CODE
+       exit 0
 }

 case "$1" in
===========================

Could you evaluate my patch and consider to merge to master branch?

Best regards,
Keigo

=========================
Keigo Noha
Red Hat
Global Support Services
Senior Technical Support Engineer
==========================
