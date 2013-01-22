Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MGLk50024549
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 11:21:46 -0500
Subject: [PATCH] flask: add the attach_queue permission to the tun_socket
 object class
To: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 22 Jan 2013 11:21:40 -0500
Message-ID: <20130122162140.9865.13012.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

New permission added to Linux 3.8 via the new multiqueue TUN device.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 policy/flask/access_vectors |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index 28802c5..a94b169 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -827,6 +827,9 @@ class kernel_service
 
 class tun_socket
 inherits socket
+{
+	attach_queue
+}
 
 class x_pointer
 inherits x_device


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
