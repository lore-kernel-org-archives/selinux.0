Subject: Re: [RFC][selinux] Tuning SELinux permission check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        jmorris@namei.org, eparis@parisplace.org, kaigai@ak.jp.nec.com
In-Reply-To: <20070830231222.3a75737e.himainu-ynakam@miomio.jp>
References: <20070830142757.58A4.YNAKAM@hitachisoft.jp>
	 <1188476863.26572.257.camel@moss-spartans.epoch.ncsc.mil>
	 <20070830231222.3a75737e.himainu-ynakam@miomio.jp>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 10:21:08 -0400
Message-Id: <1188483668.26572.328.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 23:12 +0900, Yuichi Nakamura wrote:
> On Thu, 30 Aug 2007 08:27:43 -0400
> Stephen Smalley  wrote:
> > On Thu, 2007-08-30 at 14:45 +0900, Yuichi Nakamura wrote:
> <snip>
> > > Are such changes acceptable ??
> > > Below is a patch to linux-2.6.22.
> > 
> > Given such an improvement, I'm certainly open to the idea, but I find it
> > a bit troubling that we have to engage in such manual optimization when
> > it seems that the compiler should be able to do this automatically, and
> > that function call overhead shouldn't be that high.
> > 
> > I'd also like to separately explore a different approach for improving
> > the overhead on read/write that has come up previously, namely don't
> > recheck at all unless one of the following conditions is met:
> > 1) process SID has changed since open-time check (i.e. exec with SID
> > transition or setcon),
> > 2) file SID has changed since open-time check (i.e. setxattr) ,
> > 3) policy seqno has changed since open-time check (i.e. policy reload or
> > boolean change).
> > 
> > The original SELinux optimized the read/write case by caching a
> > reference to the AVC entry used for the open-time check in the struct
> > file's security blob, then re-using that if it was still valid and the
> > SID hadn't changed.  But those AVC entry references were eliminated by
> > the conversion to RCU.
> > 
> > > ---
> > >  security/selinux/avc.c   |    7 +++++--
> > >  security/selinux/hooks.c |   31 ++++++++++++++++++++++++++-----
> > >  2 files changed, 31 insertions(+), 7 deletions(-)
> > > diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/avc.c linux-2.6.22/security/selinux/avc.c
> > > --- linux-2.6.22.orig/security/selinux/avc.c	2007-07-09 08:32:17.000000000 +0900
> > > +++ linux-2.6.22/security/selinux/avc.c	2007-08-29 16:24:37.000000000 +0900
> > > @@ -845,7 +845,7 @@ int avc_ss_reset(u32 seqno)
> > >   * auditing, e.g. in cases where a lock must be held for the check but
> > >   * should be released for the auditing.
> > >   */
> > > -int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> > > +inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> > >                           u16 tclass, u32 requested,
> > >                           struct av_decision *avd)
> > >  {
> > > @@ -910,6 +910,9 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
> > >  	int rc;
> > >  
> > >  	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, &avd);
> > > -	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
> > > +
> > > +	if ((requested & ~avd.allowed) | rc | (requested & avd.auditallow))
> > 
> > Why not make this test identical to the one within avc_audit, and remove
> > the test from avc_audit?  
> > 
> > I think we can actually turn the last remaining use of avc_audit()
> > outside of the avc into a normal avc_has_perm() check and make
> > avc_audit() private to avc.c.  At which point avc_audit() can be inline,
> > so you don't even need to move the test out of it.
> > 
> > > +		avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
> > > +
> > >  	return rc;
> > >  }
> > > diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/hooks.c linux-2.6.22/security/selinux/hooks.c
> > > --- linux-2.6.22.orig/security/selinux/hooks.c	2007-07-09 08:32:17.000000000 +0900
> > > +++ linux-2.6.22/security/selinux/hooks.c	2007-08-29 16:21:51.000000000 +0900
> > > @@ -2462,6 +2462,11 @@ static int selinux_file_permission(struc
> > >  {
> > >  	int rc;
> > >  	struct inode *inode = file->f_path.dentry->d_inode;
> > > +	struct avc_audit_data ad;
> > > +	struct task_security_struct *tsec = current->security;
> > > +	struct file_security_struct *fsec = file->f_security;
> > > +	struct inode_security_struct *isec = inode->i_security;
> > > +	u32 av;
> > >  
> > >  	if (!mask) {
> > >  		/* No permission to check.  Existence test. */
> > > @@ -2472,11 +2477,27 @@ static int selinux_file_permission(struc
> > >  	if ((file->f_flags & O_APPEND) && (mask & MAY_WRITE))
> > >  		mask |= MAY_APPEND;
> > >  
> > > -	rc = file_has_perm(current, file,
> > > -			   file_mask_to_av(inode->i_mode, mask));
> > > -	if (rc)
> > > -		return rc;
> > > -
> > > +	AVC_AUDIT_DATA_INIT(&ad, FS);
> > > +	ad.u.fs.mnt = file->f_path.mnt;
> > > +	ad.u.fs.dentry =  file->f_path.dentry;
> > > +	if (tsec->sid != fsec->sid) {
> > > +		rc = avc_has_perm(tsec->sid, fsec->sid,
> > > +					  SECCLASS_FD,
> > > +					  FD__USE,
> > > +					  &ad);
> > > +			if (rc)
> > > +				return rc;
> > > +	}
> > > +
> > > +	av = file_mask_to_av(inode->i_mode, mask);
> > > +	if (av) {
> > > +		if (unlikely (IS_PRIVATE (inode)))
> > > +			return 0;
> > > +		rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
> > > +				 av, &ad);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > >  	return selinux_netlbl_inode_permission(inode, mask);
> > >  }
> > 
> > This kind of manual inlining of functions seems wrong conceptually,
> > although I can't argue with those numbers.
> I see.
> I would like to try other approaches as you say.
> 
> > Are you sure about your data?  Ran it for many trials?  While in
> > single-user mode after a fresh boot?  
> Yes, at first I could not believe that result.
> So I ran benchmark again and again this week, 
> result was almost the same.
> 
> My gcc is a little old and is cross compiler, gcc 3.4.4(for SH).
> Optimization may not working well.
> But even if I was wrong in SH, 
> in ARM, there is also overhead(smaller than SH however).
> 
> And thanks for ideas!
> making selinux_file_permission optional looks the easiest, 
> but I would like to consider more.

On second thought, making selinux_file_permission optional may lead to
insecurity for policies and/or applications that depend on it, and there
is presently no mechanism for a policy or application to check what set
of hooks/permissions are applied by a given kernel.  Seems somewhat
related to the idea of versioning the permission checks and binding them
to a particular policy as discussed in the handle unknown thread.

So let's focus for now on improving selinux_file_permission.  I'm not
opposed to inlining if it truly helps that much, but I think we should
also look at the recheck-only-if-something-changed approach. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
