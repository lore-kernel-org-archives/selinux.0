Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7HJbHaL009597
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 15:37:17 -0400
Received: from web36613.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7HJbFDd012590
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 19:37:15 GMT
Date: Fri, 17 Aug 2007 12:37:00 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 1/2] VFS/Security: Rework inode_getsecurity and callers to return resulting buffer
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org
Cc: selinux@tycho.nsa.gov, "David P. Quigley" <dpquigl@tycho.nsa.gov>
In-Reply-To: <11873700741313-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <295203.62723.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> From: David P. Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch modifies the interface to inode_getsecurity to have the function
> return a buffer containing the security blob and its length via parameters
> instead of relying on the calling function to give it an appropriately sized
> buffer. Security blobs obtained with this function should be freed using the
> release_secctx LSM hook.

You are making the assumption that the LSM is going to return a secctx
for all possible named attributes. The caller already has to know the
name of the interesting attribute, that should imply that the caller
has enough information to get the right size for a buffer. I don't think
much of interfaces that require you to allocate memory that you're
just going to throw away after you glance at the data, especially in
the file system lookup path.

> This alleviates the problem of the caller having to
> guess a length and preallocate a buffer for this function allowing it to be
> used elsewhere for Labeled NFS. The patch also removed the unused err
> parameter. The same conversion is similar to the one used by Al Viro for the
> security_getprocattr hook.

These are very different use frequency cases.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
