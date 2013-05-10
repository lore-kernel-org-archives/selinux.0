Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACkCI7015981
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:12 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 15/16] policycoreutils: init_policy() takes no arguments
Date: Fri, 10 May 2013 14:45:23 +0200
Message-Id: <1368189924-8501-16-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

Fix "function declaration isn't a prototype" error when
-Werror=strict-prototypes is set
---
 policycoreutils/sepolicy/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sepolicy/policy.c b/policycoreutils/sepolicy/policy.c
index 4eca22d..e454e75 100644
--- a/policycoreutils/sepolicy/policy.c
+++ b/policycoreutils/sepolicy/policy.c
@@ -87,7 +87,7 @@ static PyMethodDef methods[] = {
 	{NULL, NULL, 0, NULL}	/* sentinel */
 };
 
-void init_policy() {
+void init_policy(void) {
 PyObject *m;
 m = Py_InitModule("_policy", methods);
 init_info(m);
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
