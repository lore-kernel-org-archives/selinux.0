Subject: [PATCH -v3] SELinux: /proc/mounts should show what it can
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, marc.c.dionne@gmail.com,
        mszeredi@suse.cz
Content-Type: text/plain
Date: Tue, 29 Jul 2008 17:07:26 -0400
Message-Id: <1217365646.2902.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Given a hosed SELinux config in which a system never loads policy or
disables SELinux we currently just return -EINVAL for anyone trying to
read /proc/mounts.  This is a configuration problem but we can certainly
be more graceful.  This patch just ignores -EINVAL when displaying LSM
options and causes /proc/mounts display everything else it can.  If
policy isn't loaded the obviously there are no options, so we aren't
really loosing any information here.

This is safe as the only other return of EINVAL comes from
security_sid_to_context_core() in the case of an invalid sid.  Even if a
FS was mounted with a now invalidated context that sid should have been
remapped to unlabeled and so we won't hit the EINVAL and will work like
we should.  (yes, I tested to make sure it worked like I thought)

Signed-off-by: Eric Paris <eparis@redhat.com>
Tested-by: Marc Dionne <marc.c.dionne@gmail.com>

---

James you should probably push this to linus since it is a regression...

 security/selinux/hooks.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 40d06c5..3ae9bec 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -998,8 +998,12 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 	int rc;
 
 	rc = selinux_get_mnt_opts(sb, &opts);
-	if (rc)
+	if (rc) {
+		/* before policy load we may get EINVAL, don't show anything */
+		if (rc == -EINVAL)
+			rc = 0;
 		return rc;
+	}
 
 	selinux_write_opts(m, &opts);
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
