Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6SKeXJ6030618
 for <selinux@tycho.nsa.gov>; Tue, 28 Jul 2015 16:40:34 -0400
Received: by obre1 with SMTP id e1so93775719obr.1
 for <selinux@tycho.nsa.gov>; Tue, 28 Jul 2015 13:40:25 -0700 (PDT)
Date: Tue, 28 Jul 2015 15:40:09 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150728204009.GF83521@ubuntu-hedt>
References: <55A8398A.3000802@schaufler-ca.com>
 <CALCETrXA94MBrJ7Dni7RW68Wn3MxcxSmr082hG=haWWncL=feg@mail.gmail.com>
 <55A85041.2070301@schaufler-ca.com>
 <CALCETrUTgfRzzdk3T0wZASSE+KC9S+kmyZbD6-xStS2RRaGiBw@mail.gmail.com>
 <20150721203550.GA80838@ubuntu-hedt>
 <55AEF75F.9010703@schaufler-ca.com>
 <20150722155634.GB124342@ubuntu-hedt>
 <55AFDCA6.10201@schaufler-ca.com>
 <20150722193223.GD124342@ubuntu-hedt>
 <55B02FBD.4040606@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B02FBD.4040606@schaufler-ca.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 22, 2015 at 05:05:17PM -0700, Casey Schaufler wrote:
> > This is what I currently think you want for user ns mounts:
> >
> >  1. smk_root and smk_default are assigned the label of the backing
> >     device.
> >  2. s_root is assigned the transmute property.
> >  3. For existing files:
> >     a. Files with the same label as the backing device are accessible.
> >     b. Files with any other label are not accessible.
> 
> That's right. Accept correct data, reject anything that's not right.
> 
> > If this is right, there are a couple lingering questions in my mind.
> >
> > First, what happens with files created in directories with the same
> > label as the backing device but without the transmute property set? The
> > inode for the new file will initially be labeled with smk_of_current(),
> > but then during d_instantiate it will get smk_default and thus end up
> > with the label we want. So that seems okay.
> 
> Yes.
> 
> > The second is whether files with the SMACK64EXEC attribute is still a
> > problem. It seems it is, for files with the same label as the backing
> > store at least. I think we can simply skip the code that reads out this
> > xattr and sets smk_task for user ns mounts, or else skip assigning the
> > label to the new task in bprm_set_creds. The latter seems more
> > consistent with the approach you've suggested for dealing with labels
> > from disk.
> 
> Yes, I think that skipping the smk_fetch(XATTR_NAME_SMACKEXEC, ...) in
> smack_d_instantiate for unprivileged mounts would do the trick.
> 
> > So I guess all of that seems okay, though perhaps a bit restrictive
> > given that the user who mounted the filesystem already has full access
> > to the backing store.
> 
> In truth, there is no reason to expect that the "user" who did the
> mount will ever have a Smack label that differs from the label of
> the backing store. If what we've got here seems restrictive, it's
> because you've got access from someone other than the "user".
> 
> > Please let me know whether or not this matches up with what you are
> > thinking, then I can procede with the implementation.
> 
> My current mindset is that, if you're going to allow unprivileged
> mounts of user defined backing stores, this is as safe as we can
> make it.

All right, I've got a patch which I think does this, and I've managed to
do some testing to confirm that it behaves like I expect. How does this
look?

What's missing is getting the label from the block device inode; as
Stephen discovered the inode that I thought we could get the label from
turned out to be the wrong one. Afaict we would need a new hook in order
to do that, so for now I'm using the label of the proccess calling
mount.

---

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a143328f75eb..8e631a66b03c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -662,6 +662,8 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
 		skp = smk_of_current();
 		sp->smk_root = skp;
 		sp->smk_default = skp;
+		if (sb_in_userns(sb))
+			transmute = 1;
 	}
 	/*
 	 * Initialize the root inode.
@@ -1023,6 +1025,12 @@ static int smack_inode_permission(struct inode *inode, int mask)
 	if (mask == 0)
 		return 0;
 
+	if (sb_in_userns(inode->i_sb)) {
+		struct superblock_smack *sbsp = inode->i_sb->s_security;
+		if (smk_of_inode(inode) != sbsp->smk_root)
+			return -EACCES;
+	}
+
 	/* May be droppable after audit */
 	if (no_block)
 		return -ECHILD;
@@ -3220,14 +3228,16 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			if (rc >= 0)
 				transflag = SMK_INODE_TRANSMUTE;
 		}
-		/*
-		 * Don't let the exec or mmap label be "*" or "@".
-		 */
-		skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
-		if (IS_ERR(skp) || skp == &smack_known_star ||
-		    skp == &smack_known_web)
-			skp = NULL;
-		isp->smk_task = skp;
+		if (!sb_in_userns(inode->i_sb)) {
+			/*
+			 * Don't let the exec or mmap label be "*" or "@".
+			 */
+			skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
+			if (IS_ERR(skp) || skp == &smack_known_star ||
+			    skp == &smack_known_web)
+				skp = NULL;
+			isp->smk_task = skp;
+		}
 
 		skp = smk_fetch(XATTR_NAME_SMACKMMAP, inode, dp);
 		if (IS_ERR(skp) || skp == &smack_known_star ||
