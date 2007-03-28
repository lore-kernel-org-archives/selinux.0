Subject: Re: promoting printk for FS mounting back from KERN_DEBUG
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1175027419.13618.45.camel@localhost.localdomain>
References: <1175025162.13618.32.camel@localhost.localdomain>
	 <1175026064.3864.407.camel@moss-spartans.epoch.ncsc.mil>
	 <1175027419.13618.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 07:27:20 -0400
Message-Id: <1175081240.3864.412.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-27 at 16:30 -0400, Eric Paris wrote:
> On Tue, 2007-03-27 at 16:07 -0400, Stephen Smalley wrote:
> > On Tue, 2007-03-27 at 15:52 -0400, Eric Paris wrote:
> > > So with my recent printk demotions lots of thing were made KERN_DEBUG
> > > from INFO.  The whole reason for the patch was the messages in hooks.c
> > > were spamming people's logs when they had lots of auto fs mounts coming
> > > and going.  Relevant code to the discussion below:
> > > 
> > >  303 static char *labeling_behaviors[6] = {
> > >  304         "uses xattr",
> > >  305         "uses transition SIDs",
> > >  306         "uses task SIDs",
> > >  307         "uses genfs_contexts",
> > >  308         "not configured for labeling",
> > >  309         "uses mountpoint labeling",
> > >  310 };
> > > 
> > >  655         if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
> > >  656                 printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
> > >  657                        sb->s_id, sb->s_type->name);
> > >  658         }
> > >  659         else {
> > >  660                 printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
> > >  661                        sb->s_id, sb->s_type->name,
> > >  662                        labeling_behaviors[sbsec->behavior-1]);
> > >  663         }
> > > 
> > > I think that marking all of these behaviors as KERN_DEBUG is right
> > > except maybe when sbsec->behavior == 5 ("not configured for labeling").
> > > Do we want to warn users that they are mounting a FS we know nothing
> > > about?  If we do want to promote that message do we want to give more
> > > descriptive output so the user knows what to do?  Possibly suggest to
> > > them to include the FS in their policy or use a context mount?  If so
> > > any suggestions on wording that message?  Maybe we want to still print
> > > the same debug but att a new printk just for the behavior == 5 case?
> > > 
> > > This comes about because as more and more fuse FS's get used we hit more
> > > and more FS's which don't have defined labeling behavior in policy.
> > 
> > Won't such cases show up indirectly anyway through avc messages on
> > unlabeled_t files?
> 
> Yes they will, which is when we finally hear about them.  But since we
> know up front something is wrong wouldn't it be a good idea to point
> them in the right direction?  Very few people are going to see the
> unlabeled_t denial and know right away what needs to be done to fix it.
> If we don't think a printk is the right way maybe I could make the one
> case in question an audit message and get the setroubleshoot gui to make
> a semi-intelligent comment about it...

More people are likely to see the unlabeled_t denial due to
setroubleshoot, right?  We can't rely on users to even think of checking
their system logs (at least that seemed to be part of the rationale for
setroubleshoot).  And we can write a plugin for setroubleshoot that
catches such denials, extracts the filesystem information, and proposes
a solution.  Versus introducing an entirely new message that users won't
see and nothing will automatically process.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
