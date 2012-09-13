Message-ID: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>
Subject: [PATCH] selinux-testsuite:  Allow test domains to read /etc/passwd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Serge Hallyn <serge@hallyn.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Date: Thu, 13 Sep 2012 10:08:45 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Several test cases require the ability to read /etc/passwd to look
up usernames.  Recent Fedora introduced a separate type on /etc/passwd
and therefore we need to add an interface call to test_global.te.  Fixes
three test failures on Fedora 17.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_global.te | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policy/test_global.te b/policy/test_global.te
index 77121ae..fdfd291 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -88,3 +88,5 @@ selinux_compute_access_vector(testdomain)
 selinux_compute_create_context(testdomain)
 selinux_compute_relabel_context(testdomain)
 selinux_compute_user_contexts(testdomain)
+
+auth_read_passwd(testdomain)
-- 
1.7.11.4


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
