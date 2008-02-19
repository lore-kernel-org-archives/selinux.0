Subject: Re: NFS/LSM: allow NFS to control all of its own mount options
From: Eric Paris <eparis@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nfs@vger.kernel.org, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, steved@redhat.com,
        jlayton@redhat.com, sds@tycho.nsa.gov, jmorris@namei.org,
        casey@schaufler-ca.com, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <20080219222408.GB10656@infradead.org>
References: <1203457094.2928.113.camel@localhost.localdomain>
	 <20080219222408.GB10656@infradead.org>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 17:36:46 -0500
Message-Id: <1203460606.2928.127.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-19 at 17:24 -0500, Christoph Hellwig wrote:
> Please don't introduce a special case for just nfs.  All filesystems
> should control their mount options, so please provide some library
> helpers for context= handling and move it into all filesystems that
> can support selinux.

A library helper that looks like what?

Only NFS knows how it is storing that mount option in its blobs.  Only
NFS knows how to translate its blob into the generic LSM interface
needed to set security options.  I'd say the solution is going to have
to be very much NFS specific.

Both in kernel LSMs already provide methods for dealing with mount
options for filesystems that use text strings (see the
security_sb_copy_data stuff called from vfs_kern_mount()).  How is this
'library' going to deal with anything other than a text string, and if
that's all it deals with we already have that.  NFS just can't use it
because it isn't using a string for mount data.  I'm sure I'm just
misunderstanding how to design your solution...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
