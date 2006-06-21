Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
	socket when they are created
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, kmacmillan@tresys.com, jmorris@namei.org
In-Reply-To: <1150921381.18657.170.camel@sgc>
References: <1150902506.27852.35.camel@localhost.localdomain>
	 <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
	 <1150919192.18657.164.camel@sgc>
	 <1150919411.27531.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1150921381.18657.170.camel@sgc>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 16:25:19 -0400
Message-Id: <1150921519.3432.0.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, but make sure you use the one from June 2nd that has the class
"key", not "retained_key".  Thanks!

On Wed, 2006-06-21 at 16:23 -0400, Christopher J. PeBenito wrote:
> On Wed, 2006-06-21 at 15:50 -0400, Stephen Smalley wrote:
> > On Wed, 2006-06-21 at 15:46 -0400, Christopher J. PeBenito wrote:
> > > On Wed, 2006-06-21 at 12:03 -0400, Stephen Smalley wrote:
> > > > On Wed, 2006-06-21 at 11:08 -0400, Eric Paris wrote:
> > > > > Below is a patch to add a new /proc/self/attr/sockcreate
> > > [cut]
> > > > /proc/self/attr/keycreate is in -mm, so this patch won't apply relative
> > > > to it.  Permission definition also has to be regenerated relative to the
> > > > keycreate refpolicy patch, as that took the same permission slot.
> > > 
> > > I'm going to need a patch for refpolicy that has the the final ordering
> > > of permissions with key and sockcreate patches.  I haven't added the key
> > > class at all yet since I have been waiting for the perm set to finalize.
> > 
> > Apply the key+keycreate patch first.  sockcreate refpolicy patch has to
> > be re-based and re-submitted, but the kernel patch has already been
> > re-based and submitted.
> 
> Is the one from June 2nd the right one ([PATCH] refpolicy: Kernel access
> key retention policy support) to start, and then the one from yesterday
> that has setkeycreate?
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
