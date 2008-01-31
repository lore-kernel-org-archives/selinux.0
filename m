Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0VNTuo0011362
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 18:29:56 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0VNTtG4001393
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 23:29:55 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8DB49AEC-5DA8-4AC3-A660-689E6BC80D2E@oracle.com>
References: <8DB49AEC-5DA8-4AC3-A660-689E6BC80D2E@oracle.com> <479901A8.3000706@oracle.com> <20080123172038.11107.86025.stgit@warthog.procyon.org.uk> <20080123172246.11107.62216.stgit@warthog.procyon.org.uk> <18686.1201663501@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: dhowells@redhat.com, Trond.Myklebust@netapp.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/27] NFS: Use local caching [try #2]
Date: Thu, 31 Jan 2008 23:29:17 +0000
Message-ID: <28512.1201822157@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chuck Lever <chuck.lever@oracle.com> wrote:

> >>> +struct nfs_fh_auxdata {
> >>> +	struct timespec	i_mtime;
> >>> +	struct timespec	i_ctime;
> >>> +	loff_t		i_size;
> >>> +};
> >>
> >> It might be useful to explain here why you need to supplement the
> >> mtime, ctime, and size fields that already exist in an NFS inode.
> >
> > Supplement?  I don't understand.
> 
> Why is it necessary to add additional mtime, ctime and size fields for NFS
> inodes?  Similar metadata is already stored in nfsi.

Yes, but this is the data that's stored in the cache on disk, not what's
stored in the NFS inode struct in RAM.

I'll add some more comments to the code to make this clearer.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
