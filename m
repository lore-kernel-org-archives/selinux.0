Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6LKaBOi023820
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 16:36:11 -0400
Received: by oibn4 with SMTP id n4so131467192oib.3
 for <selinux@tycho.nsa.gov>; Tue, 21 Jul 2015 13:35:52 -0700 (PDT)
Date: Tue, 21 Jul 2015 15:35:50 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150721203550.GA80838@ubuntu-hedt>
References: <87615k7pyu.fsf@x220.int.ebiederm.org>
 <20150716135947.GC77715@ubuntu-hedt>
 <55A7C920.7090206@schaufler-ca.com>
 <20150716185750.GB51751@ubuntu-hedt>
 <55A8253E.3000407@schaufler-ca.com>
 <CALCETrW6NpwY0CXNXWBcqx6JPyAqr6XP-BKexO1HFdpxnQUJrQ@mail.gmail.com>
 <55A8398A.3000802@schaufler-ca.com>
 <CALCETrXA94MBrJ7Dni7RW68Wn3MxcxSmr082hG=haWWncL=feg@mail.gmail.com>
 <55A85041.2070301@schaufler-ca.com>
 <CALCETrUTgfRzzdk3T0wZASSE+KC9S+kmyZbD6-xStS2RRaGiBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUTgfRzzdk3T0wZASSE+KC9S+kmyZbD6-xStS2RRaGiBw@mail.gmail.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 16, 2015 at 05:59:22PM -0700, Andy Lutomirski wrote:
> On Thu, Jul 16, 2015 at 5:45 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 7/16/2015 4:29 PM, Andy Lutomirski wrote:
> >> I really don't see the benefit of making up extra rules that apply to
> >> users outside a userns who try to access specifically a filesystem
> >> with backing store.  They wouldn't make sense for filesystems without
> >> backing store.
> >
> > Sure it would. For Smack, it would be the label a file would be
> > created with, which would be the label of the process creating
> > the memory based filesystem. For SELinux the rules are more a
> > touch more sophisticated, but I'm sure that Paul or Stephen could
> > come up with how to determine it.
> >
> > The point, looping all the way back to the beginning, where we
> > were talking about just ignoring the labels on the filesystem,
> > is that if you use the same Smack label on the files in the
> > filesystem as the backing store file has, we'll all be happy.
> > If that label isn't something user can write to, he won't be
> > able to write to the mounted objects, either. If there is no
> > backing store then use the label of the process creating the
> > filesystem, which will be the user, which will mean everything
> > will work hunky dory.
> >
> > Yes, there's work involved, but I doubt there's a lot. Getting
> > the label from the backing store or the creating process is
> > simple enough.
> >

So something like the diff below (untested)?

All I'm really doing is setting smk_default as you describe above and
then using it instead of smk_of_current() in
smack_inode_alloc_security() and instead of the label from the disk in
smack_d_instantiate(). Since a user currently needs CAP_MAC_ADMIN in
init_user_ns to store security labels it looks like this should be
sufficient. I'm not even sure that the inode_alloc_security hook changes
are needed.

We could allow privileged users in s_user_ns to write security labels to
disk since they already control the backing store, as long as Smack
didn't subsequently import them. I didn't do that here.

> So what if Smack used the label of the user creating the filesystem
> even for filesystems with backing store?  IMO this ought to be doable
> with the LSM hooks -- it certainly seems reasonable for the LSM to be
> aware of who created a filesystem.  In fact, I'd argue that if Smack
> can't do this with the proposed LSM hooks, then the hooks are
> insufficient.

It would be very simple to use the label of the task instead.

Seth

---

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 32f598db0b0d..4597420ab933 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1486,6 +1486,10 @@ static inline void sb_start_intwrite(struct super_block *sb)
 	__sb_start_write(sb, SB_FREEZE_FS, true);
 }
 
+static inline bool sb_in_userns(struct super_block *sb)
+{
+	return sb->s_user_ns != &init_user_ns;
+}
 
 extern bool inode_owner_or_capable(const struct inode *inode);
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a143328f75eb..591fd19294e7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -255,6 +255,10 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
 	char *buffer;
 	struct smack_known *skp = NULL;
 
+	/* Should never fetch xattrs from untrusted mounts */
+	if (WARN_ON(sb_in_userns(ip->i_sb)))
+		return ERR_PTR(-EPERM);
+
 	if (ip->i_op->getxattr == NULL)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -656,10 +660,14 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
 		 */
 		if (specified)
 			return -EPERM;
+
 		/*
-		 * Unprivileged mounts get root and default from the caller.
+		 * User namespace mounts get root and default from the backing
+		 * store, if there is one. Other unprivileged mounts get them
+		 * from the caller.
 		 */
-		skp = smk_of_current();
+		skp = (sb_in_userns(sb) && sb->s_bdev) ?
+			smk_of_inode(sb->s_bdev->bd_inode) : smk_of_current();
 		sp->smk_root = skp;
 		sp->smk_default = skp;
 	}
@@ -792,7 +800,12 @@ static int smack_bprm_secureexec(struct linux_binprm *bprm)
  */
 static int smack_inode_alloc_security(struct inode *inode)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp;
+
+	if (sb_in_userns(inode->i_sb))
+		skp = ((struct superblock_smack *)(inode->i_sb->s_security))->smk_default;
+	else
+		skp = smk_of_current();
 
 	inode->i_security = new_inode_smack(skp);
 	if (inode->i_security == NULL)
@@ -3175,6 +3188,11 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			break;
 		}
 		/*
+		 * Don't use labels from xattrs for unprivileged mounts.
+		 */
+		if (sb_in_userns(inode->i_sb))
+			break;
+		/*
 		 * No xattr support means, alas, no SMACK label.
 		 * Use the aforeapplied default.
 		 * It would be curious if the label of the task
