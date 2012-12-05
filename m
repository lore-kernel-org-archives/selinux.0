Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB5KQPHF011854
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2012 15:26:36 -0500
Subject: [RFC PATCH v2 2/3] selinux: add the "create_queue" permission to
 the "tun_socket" class
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com
Date: Wed, 05 Dec 2012 15:26:11 -0500
Message-ID: <20121205202611.18626.46545.stgit@localhost>
In-Reply-To: <20121205202144.18626.61966.stgit@localhost>
References: <20121205202144.18626.61966.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a new permission to align with the new TUN multiqueue support,
"tun_socket:create_queue".

The corresponding SELinux reference policy patch is show below:

 diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
 index 28802c5..a0664a1 100644
 --- a/policy/flask/access_vectors
 +++ b/policy/flask/access_vectors
 @@ -827,6 +827,9 @@ class kernel_service

  class tun_socket
  inherits socket
 +{
 +       create_queue
 +}

  class x_pointer
  inherits x_device

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/include/classmap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index df2de54..7e9a3d1 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -150,6 +150,6 @@ struct security_class_mapping secclass_map[] = {
 	    NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	  { COMMON_SOCK_PERMS, "create_queue", NULL } },
 	{ NULL }
   };


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
