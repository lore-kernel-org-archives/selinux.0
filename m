From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: add .gitignore files for dynamic classes
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Thu, 22 Oct 2009 15:38:26 -0400
Message-ID: <20091022193826.22879.95307.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux dynamic class work in c6d3aaa4e35c71a32a86ececacd4eea7ecfc316c
creates a number of dynamic header files and scripts.  Add .gitignore files
so git doesn't complain about these.

Signed-off-by: Eric Paris <eparis@redhat.com>
Acked-by: Stephen D. Smalley <sds@tycho.nsa.gov>
---

 Documentation/dontdiff                |    3 +++
 scripts/selinux/genheaders/.gitignore |    1 +
 security/selinux/.gitignore           |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 scripts/selinux/genheaders/.gitignore
 create mode 100644 security/selinux/.gitignore

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index bc01a5a..e38ae14 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -65,6 +65,7 @@ aicdb.h*
 asm-offsets.h
 asm_offsets.h
 autoconf.h*
+av_permissions.h
 bbootsect
 bin2c
 binkernel.spec
@@ -94,12 +95,14 @@ docproc
 elf2ecoff
 elfconfig.h*
 fixdep
+flask.h
 fore200e_mkfirm
 fore200e_pca_fw.c*
 gconf
 gen-devlist
 gen_crc32table
 gen_init_cpio
+genheaders
 genksyms
 *_gray256.c
 ihex2fw
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
