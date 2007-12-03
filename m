Subject: Re: PATCH: peersid capability support
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, tmiller@tresys.com,
        selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>
In-Reply-To: <200711300929.22874.paul.moore@hp.com>
References: 
	 <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com>
	 <1196371475.24040.74.camel@moss-spartans.epoch.ncsc.mil>
	 <200711300929.22874.paul.moore@hp.com>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 10:53:50 -0500
Message-Id: <1196697230.5854.3.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-30 at 09:29 -0500, Paul Moore wrote:
> On Thursday 29 November 2007 4:24:35 pm Stephen Smalley wrote:
> > On Thu, 2007-11-29 at 14:27 -0500, tmiller@tresys.com wrote:
> > > This is a reworking of the peersid capability patch Joshua sent out
> > > a few weeks ago.  This version requires added explicit declaration of
> > > capabilities in the policy.
> > >
> > > I've used the same strings that Paul's kernel diff used (there is
> > > currently just a single capability).
> > >
> > > Note that capability declarations are not limited to base.conf /
> > > policy.conf as we would like to eventually get rid of the base vs. module
> > > distinction.
> >
> > Taking the union of the capabilities at link time seems worrisome to me.
> > I'd be more inclined to require equivalence or take the intersection.
> 
> I agree with Stephen, to allow a single module to set a capability bit without 
> consideration for the rest of the loaded/installed modules could introduce 
> some very weird behavior

I'm going to have to agree too.  Though I don't know which of
equivalence or intersection is the right answer.

>  ... that is unless you policy folks have some freaky 
> ability to peer* into the future ;)

I can neither confirm nor deny any omniscience. :)

> *intentional pun
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
