Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25HFdRj031419
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 12:15:39 -0500
Received: from web36605.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m25HFWxh027793
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 17:15:32 GMT
Date: Wed, 5 Mar 2008 09:15:13 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: How to handle NFS and conflicting mount options
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Cc: jmorris@namei.org, casey@schaufler-ca.com, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
In-Reply-To: <1204728406.1397.36.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <292813.32356.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> On Wed, 2008-03-05 at 09:42 -0500, Eric Paris wrote:
> > On Wed, 2008-03-05 at 09:27 -0500, Jeff Layton wrote:
> > > On Wed, 05 Mar 2008 09:11:10 -0500
> > > Eric Paris <eparis@redhat.com> wrote:
> > 
> > > > This is going to use the same superblock but the context= needs to the
> > > > same.  There is no was to reconcile the 2, so we just reject the second
> > > > mount.
> > > > 
> > > 
> > > We could just not share superblocks in that case. Maybe add a new
> > > condition to nfs_compare_mount_options()? When that returns 0 now, I
> > > believe we spin off a new superblock.
> > 
> > I'll add it to my list of things to look at for .26.
> > nfs_compare_mount_options doesn't have all the data the LSM would need
> > but nfs_compare_super probably does.  The selinux code is not going to
> > change in this regard since most FS don't have such a nice 'just use a
> > new one' option and the LSM should make sure it isn't doing things under
> > the covers the user wasn't expecting.  Using this feature is not going
> > to clean up the necessity for that little if statement you were looking
> > at but I can probably make NFS and multiple lsm options play nicer
> > together in a future patch.
> > 
> > -Eric
> > 
> > [pulled from NFS list to just the security people]
> > 
> > Does this even make sense?  Should we allow:
> > 
> > mount -o context=context1 server:/export /mnt/mnt1
> > mount -o context=context2 server:/export /mnt/mnt2
> > 
> > Same data different label?
> 
> No, that's contrary to the goals of labeled MAC.

Although I've seen people do this in real installations I
agree with Stephen that it is wrong and ought not be allowed.

> > How about
> > 
> > mount -o context=context1 server:/export/subdir1 /mnt/mnt1
> > mount -o context=context2 server:/export/subdir2 /mnt/mnt2
> > 
> > Here we have the same SB but different data and different labels.
> 
> This one would be nice, as it would allow for e.g. different user home
> directories to be mounted at different contexts.

Again, I've seen people do this, but they then allow people to
log onto the server and use it with the security scheme there,
which almost always gives them a way around the restrictions put
in place by the client's mount strategy. So I say that you gain
no value by allowing this.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
