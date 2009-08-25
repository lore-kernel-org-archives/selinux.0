Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7PLCZ59017957
	for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2009 17:12:35 -0400
Received: from g1t0026.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7PLC11W010621
	for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2009 21:12:01 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v1 1/2] refpol: Add the "tun_socket" object class flask
	definitions
To: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Date: Tue, 25 Aug 2009 17:12:32 -0400
Message-ID: <20090825211232.6250.84117.stgit@flek.lan>
In-Reply-To: <20090825210647.6250.56266.stgit@flek.lan>
References: <20090825210647.6250.56266.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add the new "tun_socket" class to the flask definitions.  The "tun_socket"
object class is used by the new TUN driver hooks which allow policy to control
access to TUN/TAP devices.
---

 policy/flask/access_vectors   |    2 ++
 policy/flask/security_classes |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index ef4c063..6292db5 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -251,6 +251,8 @@ inherits socket
 class unix_dgram_socket
 inherits socket
 
+class tun_socket
+inherits socket
 
 #
 # Define the access vector interpretation for process-related objects
diff --git a/policy/flask/security_classes b/policy/flask/security_classes
index 9e1bf1a..2bd1bf6 100644
--- a/policy/flask/security_classes
+++ b/policy/flask/security_classes
@@ -119,4 +119,6 @@ class x_application_data	# userspace
 # kernel services that need to override task security, e.g. cachefiles
 class kernel_service 
 
+class tun_socket
+
 # FLASK


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
