Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0uVRN002004
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:56:31 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e5fb34e1-43ee-bee1-2751-065e8b2b083a@schaufler-ca.com>
Date: Thu, 10 May 2018 17:56:10 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 22/23] LSM: Fix setting of the IMA data in inode init
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 16:23:47 -0700
Subject: [PATCH 22/23] LSM: Fix setting of the IMA data in inode init

Fix a missing assignment in the inode security initialization.
The EVM entry was not being set correctly.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index ef51783e967e..571643cc7256 100644
--- a/security/security.c
+++ b/security/security.c
@@ -941,6 +941,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 							&lsm_xattr->value_len);
 		if (rc == 0) {
 			lsm_xattr++;
+			evm_xattr = lsm_xattr;
 			if (ret == -EOPNOTSUPP)
 				ret = 0;
 		} else if (rc != -EOPNOTSUPP) {
@@ -950,7 +951,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	if (ret == 0) {
-		rc = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+		rc = evm_inode_init_security(inode, new_xattrs, evm_xattr);
 		if (rc == 0)
 			rc = initxattrs(inode, new_xattrs, fs_data);
 	}
-- 
2.14.3
