From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Fabian Frederick <fabf@skynet.be>, Greg KH <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jiri Slaby <jslaby@suse.com>,
 Joe Perches <joe@perches.com>, John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Oleg Nesterov <oleg@redhat.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Zefan Li <lizefan@huawei.com>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH v3 06/11] smack: don't use implicit star to display
 smackfs/syslog
Date: Fri, 24 Jul 2015 12:04:40 +0200
Message-id: <1437732285-11524-7-git-send-email-l.pawelczyk@samsung.com>
In-reply-to: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
Cc: havner@gmail.com
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
---
 security/smack/smackfs.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 81a2888..89f847bba 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2362,23 +2362,20 @@ static const struct file_operations smk_change_rule_ops = {
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
@@ -2406,16 +2403,31 @@ static ssize_t smk_write_syslog(struct file *file, const char __user *buf,
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
