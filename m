Subject: RE: how to implement permissive domains + an old bug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        method@manicmethod.com, Karl MacMillan <kmacmillan@tresys.com>,
        setools <setools@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, pmoore@hp.com
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880195C806@exchange.columbia.tresys.com>
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
Content-Type: text/plain
Date: Mon, 25 Feb 2008 14:48:18 -0500
Message-Id: <1203968898.2804.220.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-25 at 09:53 -0500, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Stephen Smalley wrote:
> >> On Fri, 2008-02-15 at 15:17 -0500, Joshua Brindle wrote:
> >>> Stephen Smalley wrote:
> >>>> On Fri, 2008-02-15 at 14:43 -0500, Eric Paris wrote:
> >>>>> On Fri, 2008-02-15 at 13:57 -0500, Stephen Smalley wrote:
> >>>>>> On Fri, 2008-02-15 at 13:35 -0500, Joshua Brindle wrote:
> >>>>>>> Stephen Smalley wrote:
> >>>>>>>> On Fri, 2008-02-15 at 12:50 -0500, Eric Paris wrote:
> >>>>>>>>> So after many months of trying to avoid it Dan finally beat me
> >>>>>>>>> into looking at permissive domains.  I'm coming to the list to
> >>>>>>>>> ask how people feel the transfer of knowledge that a domain is
> >>>>>>>>> permissive between the policy and the kernel should be
> >>>>>>>>> implemented.  (And to point out what I think is a bug I found
> >>>>>>>>> while trolling around the code today)
> >>>>>>>>> 
> >>>>>>>>> Old discussion of permissive domains.
> >>>>>>>>> http://marc.info/?l=selinux&m=118953810913436&w=2
> >>>>>>>>> 
> >>>>>>>>> The basic idea is that we want a domain in which a process can
> >>>>>>>>> run without any permission enforcement and without flooding
> >>>>>>>>> the audit logs. After much discussion I think everyone agreed
> >>>>>>>>> with (or at least stopped arguing against) a couple of things.
> >>>>>>>>> 
> >>>>>>>>> 1) do this in policy (not selinuxfs)
> >>>>>>>>> 2) have it act just like 'setenforce 0'
> >>>>>>>>> 
> >>>>>>>>> My question today is about #1.  How to implement?  Karl
> >>>>>>>>> suggested stealing a bit from the type_datum->primary field to
> >>>>>>>>> indicate to the kernel that a certain type was a
> >>>> permissive domain.  Can I do this?
> >>>>>>>>> I guess this is a question for the setools group. Do you make
> >>>>>>>>> use of the actual value stored in 'primary'?  The kernel does
> >>>>>>>>> not.  Does anything make use of the actual value outside of
> >>>>>>>>> the tool chain? Please say 'no' and make this easier for me.
> >>>>>>>>> 
> >>>>>>>>> I want to throw away the 'primary' field all together in the
> >>>>>>>>> final binary policy and create a 'new' field called 'flags' in
> >>>>>>>>> its place. After my change flags would make use of 2 bits.
> >>>>>>>>> 
> >>>>>>>>> #define F_PRIMARY		0x00000001
> >>>>>>>>> #define F_PERMISSIVE		0x80000000
> >>>>>>>>> if (type_datum->old_primary)
> >>>>>>>>> 	type_datum->flags = F_PRIMARY; if (permissive domain)
> >>>>>>>>>     type_datum->flags |= F_PERMISSIVE
> >>>>>>>>> 
> >>>>>>>>> This only works if noone makes actual use of the value in
> >>>>>>>>> ->primary. If someone makes use of the value in primary I
> >>>>>>>>> can't really reuse that area on disk and I think I'm going to
> >>>>>>>>> have to bump the policy version and add a whole new ->flags
> >>>>>>>>> field on disk (I don't think pmoore's capability stuff really
> >>>>>>>>> helps). 
> >>>>  Maybe the
> >>>>>>>>> tools could just agree to ignore the last bit?  To be honest
> >>>>>>>>> I'm not personally terribly concerned about setools backwards
> >>>>>>>>> compatibility.  I'm really only thinking about function
> >>>>>>>>> backwards compatibility, so maybe the tools people would be ok
> >>>>>>>>> with me just userping a bit (but I'd much rather have a more
> >>>>>>>>> clear 'flags' than 'primary + one bit stolen for some other
> >>>>>>>>> random crap).  For backwards compatibility I might have to
> >>>>>>>>> bump the policy number even if noone has a problem with me
> >>>>>>>>> redefining the meaning of the ->primary field, not sure yet
> >>>>>>>>> haven't really wrapped my brain around it.  I think there is a
> >>>>>>>>> kernel bug which actually makes it possible to reuse the field
> >>>>>>>>> in my new way and maintain
> >>>>>>>> backwards kernel compatibility.
> >>>>>>>>> **The Bug**
> >>>>>>>>> In the binary policy on disk ->primary is a uint32_t but in
> >>>>>>>>> the kernel ->primary is an unsigned char.  When we load
> >>>>>>>>> policy we just have 
> >>>>>>>>> 
> >>>>>>>>> typdatum->primary = le32_to_cpu(buf[2]);
> >>>>>>>>> 
> >>>>>>>>> So we are truncating to 8 bits.  I think that means that if
> >>>>>>>>> the on disk ->primary value is greater than 0xFF but the
> >>>>>>>>> lower 8 bits are all 0 we are going to screw this up (maybe
> >>>>>>>>> this is impossible, but I don't see why looking at libsepol
> >>>>>>>>> quickly). Thanks to this bug though I think I could use the
> >>>>>>>>> 32nd bit of the on disk representation on old kernels and
> >>>>>>>>> they wouldn't even realize it. New kernels could be made to
> >>>>>>>>> pay attention to that bit. Backwards compatibility through
> >>>>>>>>> bugs, I love it. It also means I don't really want to fix
> >>>>>>>>> this bug right now *smile* **End bug**
> >>>>>>>> Kernel policy representation only uses ->primary as a boolean
> >>>>>>>> flag (is it a primary name or an alias, with the type index
> >>>>>>>> value in ->value regardless).  Modular policy introduced the
> >>>>>>>> notion of using it to store the primary type index for aliases
> >>>>>>>> (when ->flavor == TYPE_ALIAS).  By the time we reach kernel
> >>>>>>>> policy (after expansion), it should only be a boolean again.
> >>>>> I guess this being done in src/expand.c::type_copy_callback().
> >>>>> 
> >>>>> All my thought is for nothing though.  Somehow in the language we
> >>>>> have to represent permissive domains.  That in and of itself
> >>>>> requires a version bump doesn't it?  Drat.
> >>>>> 
> >>>>> So what format do we want to go with?
> >>>>> 
> >>>>> permissive httpd_t;
> >>>>> 
> >>>>> anyone got anything better?
> >>>>> 
> >>>>> So with the policy version bump should I add a new field, ->flags
> >>>>> to the on disk type_datum represenation?  Should I instead just
> >>>>> rename ->primary to ->flags and teach libsepol to mask off the
> >>>>> flag?  I don't know the toolchain well enough to know if we ever
> >>>>> write more than a boolean to disk in ->primary.  Guess that's
> >>>>> what I'll look for now but first glance tells me I might as well
> >>>>> use another 32 bits on disk since it seems as though we have such
> >>>>> disperate usage of primary for POLICY_KERNEL vs everything else.
> >>>> Crazy idea:  Make "permissive" a special type attribute name, and
> >>>> mark types that should be permissive with that attribute via
> >>>> typeattribute. Then let the usual type attribute handling
> >>>> propagate it throughout. 
> >>>> 
> >>> Aaahhh! Here we got rid of those magic mls attributes and you want
> >>> to add more :) 
> >>> 
> >>> I'd much prefer a proper feature instead of special cased attribute
> >>> names, just me though.
> >> 
> >> I'm not as convinced, so possibly others should chime in too.
> >> 
> >> Type attributes are intended to indicate "properties" of types.  It
> >> just happens that at present, the names and semantics of those
> >> properties are entirely defined within the policy configuration.  But
> >> reserving some attribute names to have well-defined semantics encoded
> >> in the policy engine itself seems a natural extension, and we did do
> >> that in the original MLS implementation for trusted subjects (and I
> >> didn't view that as necessarily a bad thing).
> >> 
> >> Introducing a new language primitive each time we want to mark a set
> >> of types for special handling by the policy engine logic seems less
> >> clean to me, even aside from implementation aspects.
> >> 
> >> It also makes Eric's life a lot simpler ;)  No need to modify
> >> checkpolicy or the policy module logic at all.  A new kernel policy
> >> version would still be required, but we would get a side benefit from
> >> it in addition to permissive domains - preservation of type
> >> attribute names in the kernel policy. 
> >> 
> 
> I understand. I want to note though, that the TE part of the SS has not
> had policy logic built into it, at least since I've been using SELinux.
> The old hardcoded attributes were part of the hardcoded MLS logic but
> we've even replaced that with a flexible system. 
> 
> I'm going to borrow a page from Chad's book here and say, during SELinux
> tutorials and classes we reiterate "types and attributes have no meaning
> other than what you give them in policy" say it over and over til it
> sink in.. Oh yea, and there is this one that does (d'oh).
> 
> >>> The last time we got rid of magic attributes with new contraints,
> >>> maybe we need an 'unconstrain' :)
> >> 
> > I tend to agree.  I think we are making policy writing far to
> > complex, with additional semantics.
> > 
> 
> Eh? When was the last time you saw a user have to modify a constraint or
> mlsconstraint? Those additional semantics were to make the policy more
> flexible, the users almost never interact with them.

I think that's the point - here we want users to be able to make
existing domains permissive or introduce permissive domains w/o having
to write or modify a constraint at all.

Also, this notion of permissive domains goes beyond the existing
security server interface.  As I recall, it doesn't just change what
gets returned by security_compute_av() but rather is something that the
AVC queries (based on SID) on the permission denied code path, like
current enforcing mode.

Maybe it would help if Eric could post or point to prior posting if one
exists of his earlier experimental patch (offhand, I couldn't dig it up
quickly).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
