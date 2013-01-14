Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0EHCdGq007890
	for <selinux@tycho.nsa.gov>; Mon, 14 Jan 2013 12:12:42 -0500
Subject: [PATCH 1/2] selinux: add the "attach_queue" permission to the
 "tun_socket" class
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: Eric Paris <eparis@parisplace.org>, Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Jan 2013 12:12:13 -0500
Message-ID: <20130114171212.31874.23795.stgit@localhost>
In-Reply-To: <20130114170837.31874.78897.stgit@localhost>
References: <20130114170837.31874.78897.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a new permission to align with the new TUN multiqueue support,
"tun_socket:attach_queue".

The corresponding SELinux reference policy patch is show below:

 diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
 index 28802c5..a0664a1 100644
 --- a/policy/flask/access_vectors
 +++ b/policy/flask/access_vectors
 @@ -827,6 +827,9 @@ class kernel_service

  class tun_socket
  inherits socket
 +{
 +       attach_queue
 +}

  class x_pointer
  inherits x_device

Signed-off-by: Paul Moore <pmoore@redhat.com>
Acked-by: Eric Paris <eparis@parisplace.org>
Tested-by: Jason Wang <jasowang@redhat.com>
---
 security/selinux/include/classmap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index df2de54..14d04e6 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -150,6 +150,6 @@ struct security_class_mapping secclass_map[] = {
 	    NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
+	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ NULL }
   };


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
