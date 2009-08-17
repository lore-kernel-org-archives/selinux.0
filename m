Subject: Re: Not quite MLS.
From: rob myers <rob.myers@gtri.gatech.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <1250509252.3629.84.camel@moss-pluto.epoch.ncsc.mil>
References: <1250285426.3588.87.camel@rxm-581b.stl.gtri.gatech.edu>
	 <1250509252.3629.84.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 17:38:24 -0400
Message-ID: <1250545104.3588.149.camel@rxm-581b.stl.gtri.gatech.edu>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-17 at 07:40 -0400, Stephen Smalley wrote:
> On Fri, 2009-08-14 at 17:30 -0400, rob myers wrote:
> > I would like to create a login that has access to one category at the
> > highest sensitivity level, but in another category only has access at a
> > lower sensitivity level.  For example, on a system where SystemHigh is
> > s0-s3:c0.c3, one login could be defined as something similar to:
> > s0-s1:c0.c3, s2:c2.c3, s3:c3, while another login could be defined as
> > s0-s2:c0.c3, s3:c0.c2 .
> > 
> > Am I correct that MLS policy cannot support this scenario?
> > 
> > Is this possible under any old, current, or developmental SELinux
> > policy?
> > 
> > Would it be possible to write such a policy with the existing SELinux
> > user/kernel land?
> > 
> > Thanks for any pointers,
> 
> I'm not clear on what you are trying to achieve

Let me try and be more clear, or at least state things in a different
way.

I want to build a system that stores category 0 (c0) data at each
sensitivity level (s0-s3).  The system also stores category 1 (c1),
category 2 (c2), and category 3 (c3) data at each sensitivity level
(s0-s3).  Therefore the data on the system falls into the s0-s3:c0.c3
range.

Next, I want to add users to this system.  UserA has access to all
categories at the s0 and s1 levels.  At the s2 level UserA has access to
categories 2 and 3.  At the s3 level UserA has access to category 3
data.  UserA's access to data could be thought of as this set of
{ s0-s1:c0.c3, s2:c2.c3, s3:c3 } ranges.  As you can see, UserA should
not be able to read category 0 or 1 data at the s2 level even though
UserA can read category 3 data at the s3 range.

Similarly UserB has access to all categories at the s0, s1 and s2
sensitivity levels.  At the s3 level UserB has access to categories 0,
1, and 2.  UserB's access to data could be thought of as this set of
{ s0-s2:c0.c3, s3:c0.c2 } ranges.  As you can see, UserB should not be
able to read category 3 data at the s3 level even though UserB has
access to category 3 data at lower sensitivity levels and has access to
other sensitivity level 3 data.

Perhaps a better way to express this is on a per category per user
basis:

UserA's access matrix:

category, sl0, sl1, sl2, sl3
       0, yes, yes, no , no 
       1, yes, yes, no , no 
       2, yes, yes, yes, no 
       3, yes, yes, yes, yes 

UserB's access matrix:

category, sl0, sl1, sl2, sl3
       0, yes, yes, yes, yes
       1, yes, yes, yes, yes
       2, yes, yes, yes, yes
       3, yes, yes, yes, no 


I believe the difference between SELinux with MLS policy and what I am
trying to build is that I want higher sensitivity levels to dominate
lower sensitivity levels only on a per category basis.

For example, it is my understanding that under MLS UserB must have
sensitivity level 3 access to category 3 because UserB has access to
sensitivity level 3 access to other categories.  Another possibility
under MLS would be to remove UserB's access to category 3 for all
sensitivities.  Neither of these is what I want the system to do.

Is that more clear about what my goals are?

> At present, the kernel policy configuration specifies a default level
> and a (single) range for each SELinux user identity defined in the
> policy.  It also defines what categories can be associated with what
> sensitivities, so that you could specify that e.g. c3 can only ever be
> associated with s3, although the current refpolicy merely automatically
> generates a list of all categories for each sensitivity.

Ok, thanks for pointing that out.

> The userland configuration specifies a SELinux user and a (single) range
> for each Linux user / login.  That range has to be a subset of the one
> authorized for the SELinux user.  That lets you specify subranges for
> individual Linux users without having to define each of them within the
> kernel policy.

Perhaps what I'm describing is multiple ranges for each user / login.
Could that be achieved with user space modifications only?

Thanks for reading this far,

rob.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
