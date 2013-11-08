From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 08/08] Add message to tell user to install sandbox policy package.
Date: Fri,  8 Nov 2013 08:17:35 -0500
Message-Id: <1383916655-9354-9-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sandbox policy is huge do to macro expansion.  We do not install this by default
but sandbox command can fail without it installed.  This patch prints a message to the
user to install the package.

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/sandbox/sandbox | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index fb5a24c..3668abe 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -356,7 +356,7 @@ sandbox [-h] [-c] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile
                try:
                       sepolicy.info(sepolicy.TYPE, "sandbox_t")
                except RuntimeError:
-                      raise ValueError(_("Sandbox Policy is currently disabled.\nYou need to enable the policy by executing the following as root\n# semodule -e sandbox"))
+                      raise ValueError(_("Sandbox Policy is not currently installed.\nYou need to install the selinux-policy-sandbox package in order to run this command"))
                
         if self.__options.setype:
                self.setype = self.__options.setype
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
