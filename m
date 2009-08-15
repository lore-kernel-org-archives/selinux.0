Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7F1idYJ009277
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 21:44:39 -0400
Received: from smtp110.prem.mail.ac4.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7F1jhPk012391
	for <selinux@tycho.nsa.gov>; Sat, 15 Aug 2009 01:45:43 GMT
Message-ID: <4A861291.1030404@schaufler-ca.com>
Date: Fri, 14 Aug 2009 18:42:41 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>, gregkh@susa.de,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs
 files, directories, and symlinks.
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>	<4A84EF1D.8060408@schaufler-ca.com> <m1my62xde6.fsf@fess.ebiederm.org>
In-Reply-To: <m1my62xde6.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric W. Biederman wrote:
> >From a long term maintenance perspective I have to say I like Casey's
> version that doesn't require any magic security module compression
> hooks to implement this.
>   

Thank you.

> >From an implementation point of view Stephen's comments seem accurate.
>   

They usually are.

> Is there any debate that Casey's version will get the job done?
>   

There may be from the SELinux side because they have a specific
behavior that they want for sysfs that is not strictly in touch
with the usual xattr behavior.

> If not the only real question is how do we store xattrs efficiently for
> in memory filesystems.  
>   

Actually, I see that as a justification for the special purpose
scheme rather than a real issue. The real attribute data is going
to take up the same amount of space regardless of how it gets
managed. And Stephen is correct in thinking that is most cases
where there are xattrs there will be only one. I don't see that
a mechanism more elaborate than a list is going to gain much in
real life. On the other hand, if you wanted to take the ball and
run with it, I have a window manager to deal with.

> Let me propose a different xattr compression scheme instead of making
> the security module responsible for compression.
>
> How about we have:
> struct sysfs_xattr *sysfs_store_xattr(const char *name, const void *value, size_t size);
> void sysfs_release_xattr(struct sysfs_xattr *xattr);
>
> Where sysfs_xattr looks something like:
> struct sysfs_xattr {
>        struct hlist_node list;
>        atomic_t count;
>        const char *name;
>        const void *value;
>        size_t size;
> }
>
> And then at the end of of what is today s_iattr we have something like:
> struct sysfs_xattr *xattrs[2];
>
>
> The key point here is that sysfs_store_xattr will look to see in a
> hash table to see if another inode/dentry has already stored the
> specified xattr and if so increment the count of sysfs_xattr count
> and return it.
>
> My design assumption is that the set of xattrs that people want to
> apply to filesystems is small.
>
> By optimizing for a small number of distinct xattrs we keep the
> storage size small (even for those filesystems who want to label
> everything), and we keep the generality by not making storage of
> xattrs a security module responsibility.
>
> Does that sound like it will work?
>
> Eric
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
