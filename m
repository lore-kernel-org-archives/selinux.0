From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/2] selinux: allow seek operations on the file exposing policy
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Date: Wed, 15 Feb 2012 15:48:39 -0500
Message-ID: <20120215204838.5705.61883.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

sesearch uses:
lseek(3, 0, SEEK_SET)                   = -1 ESPIPE (Illegal seek)

Make that work.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/selinuxfs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c13a8e3..91e29cf 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -496,6 +496,7 @@ static const struct file_operations sel_policy_ops = {
 	.read		= sel_read_policy,
 	.mmap		= sel_mmap_policy,
 	.release	= sel_release_policy,
+	.llseek		= generic_file_llseek,
 };
 
 static ssize_t sel_write_load(struct file *file, const char __user *buf,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
