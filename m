Subject: RE: how to implement permissive domains + an old bug
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>,
        jmorris@namei.org, method@manicmethod.com,
        Karl MacMillan <kmacmillan@tresys.com>, setools <setools@tresys.com>,
        pmoore@hp.com, Todd Miller <tmiller@tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880195C8B8@exchange.columbia.tresys.com>
References: <1203097803.2843.49.camel@localhost.localdomain>
	 <1203099272.16038.223.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880181FACF@exchange.columbia.tresys.com>
	 <1203101867.16038.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1203104633.2843.72.camel@localhost.localdomain>
	 <1203105260.16038.280.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880181FB16@exchange.columbia.tresys.com>
	 <1203947476.2804.168.camel@moss-spartans.epoch.ncsc.mil>
	 <47C2CA26.4070800@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B015880195C806@exchange.columbia.tresys.com>
	 <1203968898.2804.220.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880195C8B8@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 16:03:22 -0500
Message-Id: <1203973402.32061.158.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-25 at 15:40 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Mon, 2008-02-25 at 09:53 -0500, Joshua Brindle wrote:
> >> Daniel J Walsh wrote:
> >>> Stephen Smalley wrote:
> >>>> On Fri, 2008-02-15 at 15:17 -0500, Joshua Brindle wrote:
> >>>>> Stephen Smalley wrote:
> >>>>>> Crazy idea:  Make "permissive" a special type attribute name, and
> >>>>>> mark types that should be permissive with that attribute via
> >>>>>> typeattribute. Then let the usual type attribute handling
> >>>>>> propagate it throughout. 
> >>>>>> 
> >>>>> Aaahhh! Here we got rid of those magic mls attributes and you
> >>>>> want to add more :) 
> >>>>> 
> >>>>> I'd much prefer a proper feature instead of special cased
> >>>>> attribute names, just me though.
> >>>> 
> >>>> I'm not as convinced, so possibly others should chime in too.
> >>>> 
> >>>> Type attributes are intended to indicate "properties" of types.  It
> >>>> just happens that at present, the names and semantics of those
> >>>> properties are entirely defined within the policy configuration.
> >>>> But reserving some attribute names to have well-defined semantics
> >>>> encoded in the policy engine itself seems a natural extension, and
> >>>> we did do that in the original MLS implementation for trusted
> >>>> subjects (and I didn't view that as necessarily a bad thing).
> >>>> 
> >>>> Introducing a new language primitive each time we want to mark a
> >>>> set of types for special handling by the policy engine logic seems
> >>>> less clean to me, even aside from implementation aspects.
> >>>> 
> >>>> It also makes Eric's life a lot simpler ;)  No need to modify
> >>>> checkpolicy or the policy module logic at all.  A new kernel policy
> >>>> version would still be required, but we would get a side benefit
> >>>> from it in addition to permissive domains - preservation of type
> >>>> attribute names in the kernel policy.
> >>>> 
> >> 
> >> I understand. I want to note though, that the TE part of the SS has
> >> not had policy logic built into it, at least since I've been using
> >> SELinux. The old hardcoded attributes were part of the hardcoded MLS
> >> logic but we've even replaced that with a flexible system.
> >> 
> >> I'm going to borrow a page from Chad's book here and say, during
> >> SELinux tutorials and classes we reiterate "types and attributes have
> >> no meaning other than what you give them in policy" say it over and
> >> over til it sink in.. Oh yea, and there is this one that does (d'oh).
> >> 
> >>>>> The last time we got rid of magic attributes with new contraints,
> >>>>> maybe we need an 'unconstrain' :)
> >>>> 
> >>> I tend to agree.  I think we are making policy writing far to
> >>> complex, with additional semantics.
> >>> 
> >> 
> >> Eh? When was the last time you saw a user have to modify a constraint
> >> or mlsconstraint? Those additional semantics were to make the policy
> >> more flexible, the users almost never interact with them.
> > 
> > I think that's the point - here we want users to be able to
> > make existing domains permissive or introduce permissive
> > domains w/o having to write or modify a constraint at all.
> > 
> 
> It wouldn't require modifying a constraint any more than making
> something mls privileged currently does.
> 
> > Also, this notion of permissive domains goes beyond the
> > existing security server interface.  As I recall, it doesn't
> > just change what gets returned by security_compute_av() but
> > rather is something that the AVC queries (based on SID) on
> > the permission denied code path, like current enforcing mode.
> > 
> 
> Even better, that means we are using a magic attribute (part of the TE
> system) to change the behavior of the avc. AFAIK nothing in the policy
> really changes the avc behavior (right?).
> 
> I don't want to stand in the way of this feature or anything, I'm just
> concerned about doing it in a hacky way vs. something more elegant. I'd
> like to hear others opinions, Chris? Todd?

I don't like the magic attributes as permissive is a mechanism option.
It has no meaning in the policy, only in the enforcement.  I'd really
prefer some other option in selinuxfs or a proc/pid/attr, but since that
doesn't seem to be an option, I'd rather have a policy primitive.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
