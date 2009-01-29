From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 17/18] selinux: remove secondary ops call to unix_stream_connect
Date: Wed, 28 Jan 2009 19:55:46 -0800
Message-Id: <1233201347-17568-19-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-18-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
 <1233201347-17568-2-git-send-email-jmorris@namei.org>
 <1233201347-17568-3-git-send-email-jmorris@namei.org>
 <1233201347-17568-4-git-send-email-jmorris@namei.org>
 <1233201347-17568-5-git-send-email-jmorris@namei.org>
 <1233201347-17568-6-git-send-email-jmorris@namei.org>
 <1233201347-17568-7-git-send-email-jmorris@namei.org>
 <1233201347-17568-8-git-send-email-jmorris@namei.org>
 <1233201347-17568-9-git-send-email-jmorris@namei.org>
 <1233201347-17568-10-git-send-email-jmorris@namei.org>
 <1233201347-17568-11-git-send-email-jmorris@namei.org>
 <1233201347-17568-12-git-send-email-jmorris@namei.org>
 <1233201347-17568-13-git-send-email-jmorris@namei.org>
 <1233201347-17568-14-git-send-email-jmorris@namei.org>
 <1233201347-17568-15-git-send-email-jmorris@namei.org>
 <1233201347-17568-16-git-send-email-jmorris@namei.org>
 <1233201347-17568-17-git-send-email-jmorris@namei.org>
 <1233201347-17568-18-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove secondary ops call to unix_stream_connect, which is
a noop in capabilities.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e8f616a..086eb14 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3997,10 +3997,6 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 	struct avc_audit_data ad;
 	int err;
 
-	err = secondary_ops->unix_stream_connect(sock, other, newsk);
-	if (err)
-		return err;
-
 	isec = SOCK_INODE(sock)->i_security;
 	other_isec = SOCK_INODE(other)->i_security;
 
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
