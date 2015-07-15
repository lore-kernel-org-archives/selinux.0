Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FJlHZj029319
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 15:47:24 -0400
Received: by obbgp5 with SMTP id gp5so33480640obb.0
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 12:47:23 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Subject: [PATCH 6/7] selinux: Ignore security labels on user namespace mounts
Date: Wed, 15 Jul 2015 14:46:07 -0500
Message-Id: <1436989569-69582-7-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Unprivileged users should not be able to supply security labels
in filesystems, nor should they be able to supply security
contexts in unprivileged mounts. For any mount where s_user_ns is
not init_user_ns, force the use of SECURITY_FS_USE_NONE behavior
and return EPERM if any contexts are supplied in the mount
options.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 security/selinux/hooks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 459e71ddbc9d..eeb71e45ab82 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -732,6 +732,19 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "pstore"))
 		sbsec->flags |= SE_SBGENFS;
 
+	/*
+	 * If this is a user namespace mount, no contexts are allowed
+	 * on the command line and security labels mus be ignored.
+	 */
+	if (sb->s_user_ns != &init_user_ns) {
+		if (context_sid || fscontext_sid || rootcontext_sid ||
+		    defcontext_sid)
+			return -EPERM;
+		sbsec->behavior = SECURITY_FS_USE_NONE;
+		goto out_set_opts;
+	}
+
+
 	if (!sbsec->behavior) {
 		/*
 		 * Determine the labeling behavior to use for this
@@ -813,6 +826,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		sbsec->def_sid = defcontext_sid;
 	}
 
+out_set_opts:
 	rc = sb_finish_set_opts(sb);
 out:
 	mutex_unlock(&sbsec->lock);
-- 
1.9.1
