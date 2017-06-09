From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: bigon@debian.org, cgzones@googlemail.com, 864479-forwarded@bugs.debian.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: always unmount selinuxfs for SELINUX=disabled
Date: Fri,  9 Jun 2017 10:29:51 -0400
Message-Id: <20170609142951.31563-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As reported in:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=864479
using a kernel configuration with CONFIG_SECURITY_SELINUX_DISABLE=n
and a /etc/selinux/config with SELINUX=disabled leads to a boot
failure.

Fix this by always unmounting selinuxfs if /etc/selinux/config has
SELINUX=disabled even if unable to successfully disable SELinux.
This will ensure that subsequent is_selinux_enabled() tests will
return 0 (disabled) and userspace will therefore skip any SELinux
processing.

Reported-by: Christian Göttsche <cgzones@googlemail.com>
Reported-by: Laurent Bigonville <bigon@debian.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/load_policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 7f08311..e9f1264 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -449,8 +449,11 @@ int selinux_init_load_policy(int *enforce)
 		}
 	}
 
-	if (seconfig == -1)
+	if (seconfig == -1) {
+		umount(selinux_mnt);
+		fini_selinuxmnt();
 		goto noload;
+	}
 
 	/* Load the policy. */
 	return selinux_mkload_policy(0);
-- 
2.9.4
