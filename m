Message-Id: <200510031347.j93DlFYs014483@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: [10 / 9] [ SEMANAGE ] FIx placement of function table
Date: Mon, 3 Oct 2005 09:47:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128112109.12459.216.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 4:28 PM
> To: Ivan Gyurdiev
> Cc: selinux@tycho.nsa.gov; Karl MacMillan
> Subject: Re: [10 / 9] [ SEMANAGE ] FIx placement of function table
> 
> On Fri, 2005-09-30 at 16:30 -0400, Ivan Gyurdiev wrote:
> > In one of my patches I broke up semanage_private.h into pieces.
> > However, I've placed things incorrectly, because I misunderstood what
> > things were supposed to do.
> >
> > This corrects one of the problems - it moves the function table into a
> > new file called policy_connection.h. It also renames that structure,
> > because I use at least 3 or 4 different types of func_tables in my
> > code.  For consistency this should go into interfaces.h, but perhaps I
> > should split up interfaces.h into several headers instead (?)
> >
> > The other problem is the connection object - module_conn_t. I put that
> > in modules.h, because it said "module", but it doesn't look like it
> > belongs there. Karl, where should I move this? Should it go into
> > direct_api.h ? I see the semanage_store makes use of that... is the
> > semanage_store specific to the direct API?
> >
> > On a related note, where can I put policydb pointers - I need two of
> > them for starters - ACTIVE, and LOCAL_MOD... the actual policydb objects
> > will be created on demand (say when the user decides to query
> > something), or when commit decides to re-create the active policy from
> > scratch, but I need the pointers to them in a data structure linked into
> > the handle (that's specific to direct api?) Should this go into
> > conn.module (renaming that to conn.direct ?)
> 
> Hmmm...I just got done merging the others (available in the sourceforge
> CVS), although naturally all of this is still open to debate and can be
> reverted at any time.
> 
> I think at this point I'll wait for clarification from Karl et al on
> whether this patch (and the prior ones as well) are consistent with
> their plans for libsemanage.
> 

We're looking - should have some thoughts later today.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
