Subject: Re: inode security state and cluster file systems
From: Eric Paris <eparis@redhat.com>
To: Yuri L Volobuev <volobuev@us.ibm.com>
Cc: Eric Paris <eparis@parisplace.org>,
        Casey Schaufler
 <casey@schaufler-ca.com>,
        Joel Becker <jlbec@evilplan.org>,
        LSM List
 <linux-security-module@vger.kernel.org>,
        Mark Fasheh <mfasheh@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@davequigley.com, SELinux@tycho.nsa.gov, swhiteho@redhat.com
Date: Tue, 22 Feb 2011 11:05:32 -0500
In-Reply-To: <OFC30DDCC5.CAFCD9BB-ON8625783F.0052D06B-8625783F.0054BB06@us.ibm.com>
References: 
	<OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>
		<1298035684.23592.6.camel@moss-pluto>
	 <OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>
		<1298046341.23592.16.camel@moss-pluto>
	 <OFAB2AD310.C60A1CF4-ON8625783B.007027A3-8625783B.0071BDC6@us.ibm.com>
		<AANLkTimtVyT-7p+6H9=8KGE=cmHNr7kgramsdH5coWwv@mail.gmail.com>
	 <AANLkTik76eqvav9NvFbKSacitH-aZ14vxUeDRc_JWYGY@mail.gmail.com>
		<4D6176AD.3000807@schaufler-ca.com>
	 <AANLkTimE5_WdsVVp-LtTGYoUMGstW7H1poj8o6PdWow-@mail.gmail.com>
	 <OFC30DDCC5.CAFCD9BB-ON8625783F.0052D06B-8625783F.0054BB06@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1298390734.30513.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-02-22 at 09:25 -0600, Yuri L Volobuev wrote:
> > >>> If we made the invalidation point an explicit refresh of the
> label at
> > >>> least the filesystems would be able to control both of those
> > >>> problems.....
> > >
> > > So far the only case that has been discussed is one in which there
> > > is one security attribute on the file. While we don't have it yet
> there
> > > are a couple of efforts underway to support multiple concurrent
> LSMs.
> > > It is also plausible for an LSM to use more than one security
> attribute
> > > on a given file. An approach based on a secid interface may not
> work
> > > in either scenario. If you want a comparative example, look at
> directory
> > > default ACLs, which are important security information, but are
> nor used
> > > to make access decisions on the object to which they are attached.
> > 
> > I'm still leaning towards a solution in which the filesystem needs
> to
> > tell the LSM that it's labels are invalid (I suggest that be done on
> > any change in the security.* namespace) and that same call needs to
> > cause the LSM to refresh its labels.  I seem to think that such a
> call
> > would work just fine with any LSM stacker or even
> > multi-attribute/multi-label LSM (which uses the security.*
> namespace).
> 
> In the "pull" model that GFS2, OCFS2, and GPFS apparently follow, on a
> given node the file system code doesn't know that an xattr in a
> security.* namespace got modified on another node.  All that is known
> is that the lock protecting inode xattrs has been lost, so now
> everything protected by this lock is invalid.  The next time this
> information is needed, it has to be re-initialized (e.g. by reading
> data from disk).  The security attribute label may or may not have
> changed, that is not known at that point, but the inode security state
> has to be re-initialized in case it did.  So it sounds like all
> distributed file systems would benefit from an LSM API call that
> invalidates inode security state.
> 
> I think the tricky part here is how/when to drive inode security state
> refresh, once it has been invalidated.  File system code could do this
> easily at dentry revalidation time, possibly even using existing API,
> like security_d_instantiate (provided it does a full re-init, using
> getxattr, if it sees that the inode state has been invalidated).  A
> dentry is conveniently available at this juncture.  
> Permission checking prior to a write on an already open file is a
> somewhat different problem.  In the current code, the permission check
> is made before file system code gets involved, so the call to re-init
> inode security state has to be made in VFS or LSM code, before the
> permission check.  It would probably be easier/more logical to do this
> in security_file_permission.  Since the latter is passed struct file
> *file, a dentry could be easily obtained as file->f_path.dentry.

The two problems I see with doing the refresh 'when needed' is that FS
code is almost certainly not designed to have a ->getxattr call during a
read/write and not all permissions checks have a dentry.  Namely any
calls to fs/namei.c::inode_permission() are going to end up in the LSM
without a dentry and with an 'invalid' security struct.  I feel like the
invalidate and refresh need to be done at the same time....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
