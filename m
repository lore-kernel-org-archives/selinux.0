Subject: [patch] Update selinux info in MAINTAINERS and Kconfig help text
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 11 Sep 2008 09:20:26 -0400
Message-Id: <1221139226.18396.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update the SELinux entry in MAINTAINERS and drop the obsolete information
from the selinux Kconfig help text.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 MAINTAINERS              |    3 ++-
 security/selinux/Kconfig |    3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ced3c20..795f4bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3650,7 +3650,8 @@ P:	Eric Paris
 M:	eparis@parisplace.org
 L:	linux-kernel@vger.kernel.org (kernel issues)
 L: 	selinux@tycho.nsa.gov (subscribers-only, general discussion)
-W:	http://www.nsa.gov/selinux
+W:	http://selinuxproject.org
+T:	git kernel.org:pub/scm/linux/kernel/git/jmorris/security-testing-2.6.git
 S:	Supported
 
 SENSABLE PHANTOM
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index a436d1c..26301dd 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -6,9 +6,6 @@ config SECURITY_SELINUX
 	help
 	  This selects NSA Security-Enhanced Linux (SELinux).
 	  You will also need a policy configuration and a labeled filesystem.
-	  You can obtain the policy compiler (checkpolicy), the utility for
-	  labeling filesystems (setfiles), and an example policy configuration
-	  from <http://www.nsa.gov/selinux/>.
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_SELINUX_BOOTPARAM

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
