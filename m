From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "David S. Miller" <davem@davemloft.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Calvin Owens <calvinowens@fb.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
 Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
 John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 containers@lists.linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Lukasz Pawelczyk <havner@gmail.com>
Subject: [PATCH v4 06/11] smack: don't use implicit star to display
 smackfs/syslog
Date: Wed, 14 Oct 2015 14:42:00 +0200
Message-id: <1444826525-9758-7-git-send-email-l.pawelczyk@samsung.com>
In-reply-to: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
References: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Smackfs/syslog is analogous to onlycap and unconfined. When not filled
they don't do anything. In such cases onlycap and unconfined displayed
nothing when read, but syslog unconditionally displayed star. This
doesn't work well with namespaces where the star could have been
unmapped. Besides the meaning of this star was different then a star
that could be written to this file. This was misleading.

This also brings syslog read/write functions on par with onlycap and
unconfined where it is possible to reset the value to NULL as should be
possible according to comment in smackfs.c describing smack_syslog_label
variable.

Before that the initial state was to allow (smack_syslog_label was
NULL), but after writing star to it the current had to be labeled star
as well to have an access, even thought reading the smackfs/syslog
returned the same result in both cases.

Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 security/smack/smackfs.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index ce8d503..05e09ee2 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2634,23 +2634,20 @@ static const struct file_operations smk_change_rule_ops = {
 static ssize_t smk_read_syslog(struct file *filp, char __user *buf,
 				size_t cn, loff_t *ppos)
 {
-	struct smack_known *skp;
+	char *smack = "";
 	ssize_t rc = -EINVAL;
 	int asize;
 
 	if (*ppos != 0)
 		return 0;
 
-	if (smack_syslog_label == NULL)
-		skp = &smack_known_star;
-	else
-		skp = smack_syslog_label;
+	if (smack_syslog_label != NULL)
+		smack = smack_syslog_label->smk_known;
 
-	asize = strlen(skp->smk_known) + 1;
+	asize = strlen(smack) + 1;
 
 	if (cn >= asize)
-		rc = simple_read_from_buffer(buf, cn, ppos, skp->smk_known,
-						asize);
+		rc = simple_read_from_buffer(buf, cn, ppos, smack, asize);
 
 	return rc;
 }
@@ -2678,16 +2675,31 @@ static ssize_t smk_write_syslog(struct file *file, const char __user *buf,
 	if (data == NULL)
 		return -ENOMEM;
 
-	if (copy_from_user(data, buf, count) != 0)
+	if (copy_from_user(data, buf, count) != 0) {
 		rc = -EFAULT;
-	else {
-		skp = smk_import_entry(data, count);
-		if (IS_ERR(skp))
-			rc = PTR_ERR(skp);
-		else
-			smack_syslog_label = skp;
+		goto freeout;
 	}
 
+	/*
+	 * Clear the smack_syslog_label on invalid label errors. This means
+	 * that we can pass a null string to unset the syslog value.
+	 *
+	 * Importing will also reject a label beginning with '-',
+	 * so "-syslog" will also work.
+	 *
+	 * But do so only on invalid label, not on system errors.
+	 */
+	skp = smk_import_entry(data, count);
+	if (PTR_ERR(skp) == -EINVAL)
+		skp = NULL;
+	else if (IS_ERR(skp)) {
+		rc = PTR_ERR(skp);
+		goto freeout;
+	}
+
+	smack_syslog_label = skp;
+
+freeout:
 	kfree(data);
 	return rc;
 }
-- 
2.4.3
