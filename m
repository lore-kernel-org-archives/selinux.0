From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: add .gitignore files for dynamic classes
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Thu, 22 Oct 2009 11:08:59 -0400
Message-ID: <20091022150859.20503.17193.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux dynamic class work in c6d3aaa4e35c71a32a86ececacd4eea7ecfc316c
creates a number of dynamic header files and scripts.  Add .gitignore files
so git doesn't complain about these.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 scripts/selinux/genheaders/.gitignore |    1 +
 security/selinux/.gitignore           |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 scripts/selinux/genheaders/.gitignore
 create mode 100644 security/selinux/.gitignore

diff --git a/scripts/selinux/genheaders/.gitignore b/scripts/selinux/genheaders/.gitignore
new file mode 100644
index 0000000..4c0b646
--- /dev/null
+++ b/scripts/selinux/genheaders/.gitignore
@@ -0,0 +1 @@
+genheaders
diff --git a/security/selinux/.gitignore b/security/selinux/.gitignore
new file mode 100644
index 0000000..2e5040a
--- /dev/null
+++ b/security/selinux/.gitignore
@@ -0,0 +1,2 @@
+av_permissions.h
+flask.h


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
