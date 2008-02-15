Subject: RE: how to implement permissive domains + an old bug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>,
        dwalsh@redhat.com, jmorris@namei.org, method@manicmethod.com,
        Karl MacMillan <kmacmillan@tresys.com>, setools <setools@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, pmoore@hp.com
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880181FACF@exchange.columbia.tresys.com>
References: <1203097803.2843.49.camel@localhost.localdomain>
	 <1203099272.16038.223.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880181FACF@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 15 Feb 2008 13:57:47 -0500
Message-Id: <1203101867.16038.251.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-15 at 13:35 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Fri, 2008-02-15 at 12:50 -0500, Eric Paris wrote:
> >> So after many months of trying to avoid it Dan finally beat me into
> >> looking at permissive domains.  I'm coming to the list to ask how
> >> people feel the transfer of knowledge that a domain is permissive
> >> between the policy and the kernel should be implemented.  (And to
> >> point out what I think is a bug I found while trolling around the
> >> code today) 
> >> 
> >> Old discussion of permissive domains.
> >> http://marc.info/?l=selinux&m=118953810913436&w=2
> >> 
> >> The basic idea is that we want a domain in which a process can run
> >> without any permission enforcement and without flooding the audit
> >> logs. After much discussion I think everyone agreed with (or at least
> >> stopped arguing against) a couple of things.
> >> 
> >> 1) do this in policy (not selinuxfs)
> >> 2) have it act just like 'setenforce 0'
> >> 
> >> My question today is about #1.  How to implement?  Karl suggested
> >> stealing a bit from the type_datum->primary field to indicate to the
> >> kernel that a certain type was a permissive domain.  Can I do this? 
> >> I guess this is a question for the setools group.  Do you make use of
> >> the actual value stored in 'primary'?  The kernel does not.  Does
> >> anything make use of the actual value outside of the tool chain? 
> >> Please say 'no' and make this easier for me. 
> >> 
> >> I want to throw away the 'primary' field all together in the final
> >> binary policy and create a 'new' field called 'flags' in its place.
> >> After my change flags would make use of 2 bits.
> >> 
> >> #define F_PRIMARY		0x00000001
> >> #define F_PERMISSIVE		0x80000000
> >> if (type_datum->old_primary)
> >> 	type_datum->flags = F_PRIMARY;
> >> if (permissive domain)
> >>     type_datum->flags |= F_PERMISSIVE
> >> 
> >> This only works if noone makes actual use of the value in ->primary.
> >> If someone makes use of the value in primary I can't really reuse
> >> that area on disk and I think I'm going to have to bump the policy
> >> version and add a whole new ->flags field on disk (I don't think
> >> pmoore's capability stuff really helps).  Maybe the tools could just
> >> agree to ignore the last bit?  To be honest I'm not personally
> >> terribly concerned about setools backwards compatibility.  I'm
> >> really only thinking about function backwards compatibility, so
> >> maybe the tools people would be ok with me just userping a bit (but
> >> I'd much rather have a more clear 'flags' than 'primary + one bit
> >> stolen for some other random crap).  For backwards compatibility I
> >> might have to bump the policy number even if noone has a problem
> >> with me redefining the meaning of the ->primary field, not sure yet
> >> haven't really wrapped my brain around it.  I think there is a
> >> kernel bug which actually makes it possible to reuse the field in my
> >> new way and maintain 
> > backwards kernel compatibility.
> >> 
> >> **The Bug**
> >> In the binary policy on disk ->primary is a uint32_t but in the
> >> kernel ->primary is an unsigned char.  When we load policy we just
> >> have 
> >> 
> >> typdatum->primary = le32_to_cpu(buf[2]);
> >> 
> >> So we are truncating to 8 bits.  I think that means that if the on
> >> disk ->primary value is greater than 0xFF but the lower 8 bits are
> >> all 0 we are going to screw this up (maybe this is impossible, but I
> >> don't see why looking at libsepol quickly).  Thanks to this bug
> >> though I think I could use the 32nd bit of the on disk
> >> representation on old kernels and they wouldn't even realize it. 
> >> New kernels could be made to pay attention to that bit.  Backwards
> >> compatibility through bugs, I love it. It also means I don't really
> >> want to fix this bug right now *smile* **End bug**
> > 
> > Kernel policy representation only uses ->primary as a boolean
> > flag (is it a primary name or an alias, with the type index
> > value in ->value regardless).  Modular policy introduced the
> > notion of using it to store the primary type index for
> > aliases (when ->flavor == TYPE_ALIAS).  By the time we reach
> > kernel policy (after expansion), it should only be a boolean again.
> > 
> 
> The problem is how to propagate the permissive bit through the module
> format if we choose to do it that way. Foruntately the type id's can
> only be 16 bit per the version 20 avtab changes but I'm still concerned
> about changing the format without actually telling anything we are
> changing it (via a policy vers bump).

Yes, just explaining why it isn't a bug per se.

You not only have to propagate it through the module format but you have
to make sure that it propagates from type aliases to the primary datums
so that final primary datum has it set.

And whereas the kernel will ignore it, libsepol policydb_read won't,
even for the kernel policy (and that can happen upon downgrade or
boolean preservation or in the setlocaldefs case).

So, I think introducing a new version is likely required.  And in that
case, you might as well roll in other desired changes simultaneously.

> >> There are other options on how to represent permissive domains in
> >> policy, I think someone suggested
> >> 
> >> allow domain domain:process permissive
> >> 
> >> which would mean 2 passes through the avc for denials (at least the
> >> first time for every sub/obj/class triple).  But this method got poo
> >> poohd because of * and ^ usage.  Do we really use * and ^ any more? 
> >> I honestly don't know.  It also makes all denials a little slower,
> >> but shouldn't be noticeable on a system with a 'proper' policy.
> >> 
> >> What other ideas exist?  I'm looking for any ingenious ideas on how
> >> we can transfer 'this is a permissive domain' from the policy into
> >> the kernel.  What I really want is a way to do it being backwards
> >> compatible and without bumping the policy version....
> >> 
> >> Please, thoughts and brilliance requested, I'll do the coding, just
> >> point me in the direction you see brightest.  Can I redefine
> >> ->primary to be ->flags?  Do I need to just make a new ->flags? 
> >> Should I go through the avc twice to see if we are a permissive
> >> domain? 
> >  Is there
> >> a better way to communicate this information from the policy into
> >> the kernel? 
> >> 
> >> -Eric
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
