Subject: RE: [PATCH] MLS context contains policy/libselinux changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: James Antill <jantill@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514DF0@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588514DF0@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 09:00:19 -0500
Message-Id: <1162994419.3009.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-08 at 08:31 -0500, Joshua Brindle wrote:
> > From: James Antill [mailto:jantill@redhat.com] 
> > 
> > On Wed, 2006-11-08 at 01:32 -0500, Joshua Brindle wrote:
> > > James Antill wrote:
> > > >  Here is the policy changes needed for the context 
> > contains security 
> > > > checking in PAM and cron.
> > > > 
> > > 
> > > er, where did this come from? I haven't seen any discussions about 
> > > this and have no idea what its about (perhaps I've just 
> > totally missed 
> > > it somehow though..)
> > 
> >  The gory details were under the thread "MLS enforcing PTYs, 
> > sshd, and newrole"
> > 
> 
> Ah, well that explains it, that thread was way too long and had MLS in
> the subject.....
> 
> Any way I could get a summary/conclusion and description of the new
> permission?

If we allow users to enter a level at login time (or specify a level for
a cron job), then we need to check that the Linux user was authorized
for that level (based on seusers).  As this gets into level comparisons,
which are policy-specific, it requires a permission check to the
security server.  The check is applied between a context generated from
the seusers entry for the user and the context modified with the
user-specified level.  The TE policy then authorizes it for the self
relationship (since the types are the same in both contexts), and the
MLS constraints ensure that the user-specified level is within the
seusers-specified clearance.  Same basic idea as the existing context
translate permission used to similarly check the ability of the user to
translate a given MLS level.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
