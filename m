Subject: How to handle NFS and conflicting mount options
From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, casey@schaufler-ca.com
Cc: selinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org
In-Reply-To: <20080305092758.1bfe9687@barsoom.rdu.redhat.com>
References: <1204573372.3216.42.camel@localhost.localdomain>
	 <20080305084815.4d4f54f8@barsoom.rdu.redhat.com>
	 <1204726270.3216.196.camel@localhost.localdomain>
	 <20080305092758.1bfe9687@barsoom.rdu.redhat.com>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 09:42:47 -0500
Message-Id: <1204728167.3216.208.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-03-05 at 09:27 -0500, Jeff Layton wrote:
> On Wed, 05 Mar 2008 09:11:10 -0500
> Eric Paris <eparis@redhat.com> wrote:

> > This is going to use the same superblock but the context= needs to the
> > same.  There is no was to reconcile the 2, so we just reject the second
> > mount.
> > 
> 
> We could just not share superblocks in that case. Maybe add a new
> condition to nfs_compare_mount_options()? When that returns 0 now, I
> believe we spin off a new superblock.

I'll add it to my list of things to look at for .26.
nfs_compare_mount_options doesn't have all the data the LSM would need
but nfs_compare_super probably does.  The selinux code is not going to
change in this regard since most FS don't have such a nice 'just use a
new one' option and the LSM should make sure it isn't doing things under
the covers the user wasn't expecting.  Using this feature is not going
to clean up the necessity for that little if statement you were looking
at but I can probably make NFS and multiple lsm options play nicer
together in a future patch.

-Eric

[pulled from NFS list to just the security people]

Does this even make sense?  Should we allow:

mount -o context=context1 server:/export /mnt/mnt1
mount -o context=context2 server:/export /mnt/mnt2

Same data different label?

How about

mount -o context=context1 server:/export/subdir1 /mnt/mnt1
mount -o context=context2 server:/export/subdir2 /mnt/mnt2

Here we have the same SB but different data and different labels.  I
think the user can easily get this by just setting of them to have a
timeout of 119 seconds and the second to 120, so maybe we should just go
ahead and explicitly allow it?  I don't know, how do people feel about
having NFS spin off a new SB if security mount options don't match?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
