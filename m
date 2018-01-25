Message-ID: <1516888283.9570.1.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Thu, 25 Jan 2018 08:51:23 -0500
References: <1516850875-25066-15-git-send-email-takondra@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: [Fwd: [PATCH v2 14/15] selinux: allow setxattr on rootfs so
 initramfs code can set them]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-------- Forwarded Message --------
From: Taras Kondratiuk <takondra@cisco.com>
To: H. Peter Anvin <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>, Mimi
Zohar <zohar@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>, li
nux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-m
odule@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v2 14/15] selinux: allow setxattr on
rootfs so initramfs code can set them
Date: Thu, 25 Jan 2018 03:27:54 +0000

From: Victor Kamensky <kamensky@cisco.com>

initramfs code supporting extended cpio format have ability to
fill extended attributes from cpio archive, but if SELinux enabled
and security server is not initialized yet, selinux callback would
refuse setxattr made by initramfs code.

Solution enable SBLABEL_MNT on rootfs even if secrurity server is
not initialized yet.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 security/selinux/hooks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8644d864e3c1..f3fe65589f02 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -706,6 +706,18 @@ static int selinux_set_mnt_opts(struct super_block
*sb,
 
 	if (!ss_initialized) {
 		if (!num_opts) {
+			/*
+			 * Special handling for rootfs. Is genfs but
supports
+			 * setting SELinux context on in-core inodes.
+			 *
+			 * Chicken and egg problem: policy may reside
in rootfs
+			 * but for initramfs code to fill in
attributes, it
+			 * needs selinux to allow that.
+			 */
+			if (!strncmp(sb->s_type->name, "rootfs",
+				     sizeof("rootfs")))
+				sbsec->flags |= SBLABEL_MNT;
+
 			/* Defer initialization until
selinux_complete_init,
 			   after the initial policy is loaded and the
security
 			   server is ready to handle calls. */
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-
security-module" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
