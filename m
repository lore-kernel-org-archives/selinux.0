Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7HJs3YP010688
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 15:54:03 -0400
Subject: Re: [PATCH 1/2] VFS/Security: Rework inode_getsecurity and callers
	to return resulting buffer
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: jmorris@namei.org, selinux@tycho.nsa.gov
In-Reply-To: <295203.62723.qm@web36613.mail.mud.yahoo.com>
References: <295203.62723.qm@web36613.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 17 Aug 2007 15:46:04 -0400
Message-Id: <1187379964.24950.46.camel@moss-terrapins.epoch.ncsc.mil>
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
> has enough information to get the right size for a buffer. 
But why introduce an additional call to get the information when the
interface can just give it to you? Also the only named attribute that
the LSM should be returning is its security information in the void *
blob as your interfaces propose. Perhaps release_secctx should be
renamed to release_security or security_release to make it sound more
inline with these functions. In your case the implementation for this is
trivial and has little to no overhead. In the case of getsecurity you
just return your internal pointer. In the case of release_secctx (or
other name for it) you just have a nop.

> I don't think
> much of interfaces that require you to allocate memory that you're
> just going to throw away after you glance at the data, especially in
> the file system lookup path.

Sorry but I'm having problems parsing this. However if I understand what
I think your trying to say is that not many interfaces have you allocate
the buffer, return a value, quickly look at it, and toss it out. This
isn't really what this is used for. The idea here is to make
inode_getsecurity work as a way of getting an object with an interface
for managing its lifecycle from the security module. There are other
places where this functionality is useful outside of the getxattr
functions and to request that other parts of the kernel either perform
magic guessing on the security blob length or make the call to grab the
length first doesn't seem efficient to me. 

> 
> > This alleviates the problem of the caller having to
> > guess a length and preallocate a buffer for this function allowing it to be
> > used elsewhere for Labeled NFS. The patch also removed the unused err
> > parameter. The same conversion is similar to the one used by Al Viro for the
> > security_getprocattr hook.
> 
> These are very different use frequency cases.

Which one are you arguing is more frequent than the other? 

> 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
