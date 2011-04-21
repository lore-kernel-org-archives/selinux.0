Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEUSgd016354
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:30:32 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEUVTB001122
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:30:31 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/9] TOMOYO: Fix tomoyo_dentry_open() to use the right creds
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:30:27 +0100
Message-ID: <20110421143027.31318.50517.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tomoyo_dentry_open() must use the credentials it is given, not current's
credentials.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/tomoyo/tomoyo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 95d3f95..9d3a828 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -187,7 +187,7 @@ static int tomoyo_dentry_open(struct file *f, const struct cred *cred)
 	/* Don't check read permission here if called from do_execve(). */
 	if (current->in_execve)
 		return 0;
-	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path, flags);
+	return tomoyo_check_open_permission(cred->security, &f->f_path, flags);
 }
 
 static int tomoyo_file_ioctl(struct file *file, unsigned int cmd,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
