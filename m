Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QLvHtn011286
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 17:57:20 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <44210861-2830-2321-911d-8783f5f0b172@schaufler-ca.com>
Date: Wed, 26 Sep 2018 14:57:03 -0700
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v4 20/19] LSM: Correct file blob free empty blob
 check
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Instead of checking if the kmem_cache for file blobs
has been initialized check if the blob is NULL. This
allows non-blob using modules to do other kinds of
clean up in the security_file_free hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index e7c8506041f1..76f7dc49b63c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1202,14 +1202,13 @@ void security_file_free(struct file *file)
 {
 	void *blob;
 
-	if (!lsm_file_cache)
-		return;
-
 	call_void_hook(file_free_security, file);
 
 	blob = file->f_security;
-	file->f_security = NULL;
-	kmem_cache_free(lsm_file_cache, blob);
+	if (blob) {
+		file->f_security = NULL;
+		kmem_cache_free(lsm_file_cache, blob);
+	}
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-- 
2.17.1
