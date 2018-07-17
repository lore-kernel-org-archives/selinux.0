Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6HHk8cP030344
 for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2018 13:46:08 -0400
Received: by mail-yw0-f202.google.com with SMTP id 133-v6so929633ywq.4
 for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2018 10:45:27 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Jul 2018 10:43:56 -0700
Message-Id: <20180717174356.116660-1-ebiggers@google.com>
From: Eric Biggers <ebiggers@google.com>
To: selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Cc: Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [PATCH] selinux: constify write_op[]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

write_op[] is never modified, so make it 'const'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ab77da649b77..fb25396d2966 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -767,7 +767,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size);
 
-static ssize_t (*write_op[])(struct file *, char *, size_t) = {
+static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[SEL_ACCESS] = sel_write_access,
 	[SEL_CREATE] = sel_write_create,
 	[SEL_RELABEL] = sel_write_relabel,
-- 
2.18.0.203.gfac676dfb9-goog
