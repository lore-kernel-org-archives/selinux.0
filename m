To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>, gregkh@susa.de,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	<4A84EF1D.8060408@schaufler-ca.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 14 Aug 2009 15:02:25 -0700
In-Reply-To: <4A84EF1D.8060408@schaufler-ca.com> (Casey Schaufler's message of "Thu\, 13 Aug 2009 21\:59\:09 -0700")
Message-ID: <m1my62xde6.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs files, directories, and symlinks.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>From a long term maintenance perspective I have to say I like Casey's
version that doesn't require any magic security module compression
hooks to implement this.

>From an implementation point of view Stephen's comments seem accurate.

Is there any debate that Casey's version will get the job done?

If not the only real question is how do we store xattrs efficiently for
in memory filesystems.  

Let me propose a different xattr compression scheme instead of making
the security module responsible for compression.

How about we have:
struct sysfs_xattr *sysfs_store_xattr(const char *name, const void *value, size_t size);
void sysfs_release_xattr(struct sysfs_xattr *xattr);

Where sysfs_xattr looks something like:
struct sysfs_xattr {
       struct hlist_node list;
       atomic_t count;
       const char *name;
       const void *value;
       size_t size;
}

And then at the end of of what is today s_iattr we have something like:
struct sysfs_xattr *xattrs[2];


The key point here is that sysfs_store_xattr will look to see in a
hash table to see if another inode/dentry has already stored the
specified xattr and if so increment the count of sysfs_xattr count
and return it.

My design assumption is that the set of xattrs that people want to
apply to filesystems is small.

By optimizing for a small number of distinct xattrs we keep the
storage size small (even for those filesystems who want to label
everything), and we keep the generality by not making storage of
xattrs a security module responsibility.

Does that sound like it will work?

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
