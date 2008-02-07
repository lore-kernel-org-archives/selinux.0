Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m17Aw6O6015212
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 05:58:06 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m17Aw5bu003168
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 10:58:05 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <479901A8.3000706@oracle.com>
References: <479901A8.3000706@oracle.com> <20080123172038.11107.86025.stgit@warthog.procyon.org.uk> <20080123172246.11107.62216.stgit@warthog.procyon.org.uk>
To: chuck.lever@oracle.com
Cc: dhowells@redhat.com, Trond.Myklebust@netapp.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/27] NFS: Use local caching [try #2]
Date: Thu, 07 Feb 2008 10:57:49 +0000
Message-ID: <28135.1202381869@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chuck Lever <chuck.lever@oracle.com> wrote:

> > @@ -95,12 +100,25 @@ struct nfs_server {
> >  	unsigned int		acdirmin;
> >  	unsigned int		acdirmax;
> >  	unsigned int		namelen;
> > +	unsigned int		options;	/* extra options enabled by mount */
> > +#define NFS_OPTION_FSCACHE	0x00000001	/* - local caching enabled */
> 
> Why did you choose to create a new field for this rather than setting up a new
> NFS_MNT flag?  The new in-kernel NFS mount option parser uses the NFS_MNT
> flags too.

There aren't any NFS_MNT flags, so I presume you mean NFS_MOUNT flags.  As I
understood Trond, it's not permitted to add new such flags except in really
special circumstances as these are part of the mount syscall interface.  I
took this to mean that I should record the option elsewhere than in
server->flags.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
