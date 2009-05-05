MIME-Version: 1.0
Date: Tue, 5 May 2009 15:31:36 -0400
Message-ID: <150846cc0905051231w77e0eda2y52f72c382182226c@mail.gmail.com>
Subject: SETRANS + libavg = SIGSEGV on Hardy
From: Caleb Case <calebcase@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Kees Cook <kees@ubuntu.com>, jbrindle@tresys.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugs.launchpad.net/ubuntu/+source/libselinux/+bug/237156

Basically things are seg faulting during fini, but I don't see how
this could be happening.

There is a patch there:

diff --git a/libselinux-2.0.59/src/setrans_client.c
b/libselinux-2.0.59/src/setrans_client.c
index 1426e98..a2d0d34 100644
--- a/libselinux-2.0.59/src/setrans_client.c
+++ b/libselinux-2.0.59/src/setrans_client.c
@@ -217,6 +217,12 @@ hidden void fini_context_translations(void)
 hidden int init_context_translations(void)
 {
 	mls_enabled = is_selinux_mls_enabled();
+	// set initial values to work around crash from very late first
reference in fini.
+	// The "static __thread .. = NULL" initialization isn't working.
+	prev_r2t_trans = NULL;
+	prev_r2t_raw = NULL;
+	prev_t2r_trans = NULL;
+	prev_t2r_raw = NULL;
 	return 0;
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
