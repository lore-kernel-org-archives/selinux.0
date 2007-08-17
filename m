Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7HLLUmW017184
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 17:21:30 -0400
Received: from web36615.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7HLLSK3016010
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 21:21:29 GMT
Date: Fri, 17 Aug 2007 14:21:28 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 1/2] VFS/Security: Rework inode_getsecurity and callers to return resulting buffer
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: jmorris@namei.org, selinux@tycho.nsa.gov
In-Reply-To: <1187380698.24950.50.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <874159.25428.qm@web36615.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> On Fri, 2007-08-17 at 12:37 -0700, Casey Schaufler wrote:
> > --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> > 
> > > From: David P. Quigley <dpquigl@tycho.nsa.gov>
> > > 
> > > This patch modifies the interface to inode_getsecurity to have the
> function
> > > return a buffer containing the security blob and its length via
> parameters
> > > instead of relying on the calling function to give it an appropriately
> sized
> > > buffer. Security blobs obtained with this function should be freed using
> the
> > > release_secctx LSM hook.
> > 
> > You are making the assumption that the LSM is going to return a secctx
> > for all possible named attributes. The caller already has to know the
> > name of the interesting attribute, that should imply that the caller
> > has enough information to get the right size for a buffer. I don't think
> > much of interfaces that require you to allocate memory that you're
> > just going to throw away after you glance at the data, especially in
> > the file system lookup path.
> 
> Ok sorry I read this a couple of more times and I understand this now.
> Your issue isn't a concern. This is going to be done somewhere for an
> lsm since it has to allocate space to store the information internally
> and then copy it into the buffer provided by getxattr. In your case
> there isn't even an allocation and freeing of data here. In SELinux we
> had to allocate a string to store the converted sid in and then copy it
> up into the buffer internally. Regardless a copy is going to happen the
> question is where.

I checked and indeed everyone who calls this is allocating a
buffer anyway (no one is using the stack) so replacing the
caller allocated buffer with an LSM managed scheme ought not
to be a concern.

> > > This alleviates the problem of the caller having to
> > > guess a length and preallocate a buffer for this function allowing it to
> be
> > > used elsewhere for Labeled NFS. The patch also removed the unused err
> > > parameter. The same conversion is similar to the one used by Al Viro for
> the
> > > security_getprocattr hook.
> > 
> > These are very different use frequency cases.
> > 
> > 
> > 
> > Casey Schaufler
> > casey@schaufler-ca.com
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
