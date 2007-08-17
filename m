Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7HK6IvD011721
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 16:06:18 -0400
Subject: Re: [PATCH 1/2] VFS/Security: Rework inode_getsecurity and callers
	to return resulting buffer
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: jmorris@namei.org, selinux@tycho.nsa.gov
In-Reply-To: <295203.62723.qm@web36613.mail.mud.yahoo.com>
References: <295203.62723.qm@web36613.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 17 Aug 2007 15:58:18 -0400
Message-Id: <1187380698.24950.50.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-17 at 12:37 -0700, Casey Schaufler wrote:
> --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> 
> > From: David P. Quigley <dpquigl@tycho.nsa.gov>
> > 
> > This patch modifies the interface to inode_getsecurity to have the function
> > return a buffer containing the security blob and its length via parameters
> > instead of relying on the calling function to give it an appropriately sized
> > buffer. Security blobs obtained with this function should be freed using the
> > release_secctx LSM hook.
> 
> You are making the assumption that the LSM is going to return a secctx
> for all possible named attributes. The caller already has to know the
> name of the interesting attribute, that should imply that the caller
> has enough information to get the right size for a buffer. I don't think
> much of interfaces that require you to allocate memory that you're
> just going to throw away after you glance at the data, especially in
> the file system lookup path.

Ok sorry I read this a couple of more times and I understand this now.
Your issue isn't a concern. This is going to be done somewhere for an
lsm since it has to allocate space to store the information internally
and then copy it into the buffer provided by getxattr. In your case
there isn't even an allocation and freeing of data here. In SELinux we
had to allocate a string to store the converted sid in and then copy it
up into the buffer internally. Regardless a copy is going to happen the
question is where.

> > This alleviates the problem of the caller having to
> > guess a length and preallocate a buffer for this function allowing it to be
> > used elsewhere for Labeled NFS. The patch also removed the unused err
> > parameter. The same conversion is similar to the one used by Al Viro for the
> > security_getprocattr hook.
> 
> These are very different use frequency cases.
> 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
