MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] selinux:  introduce support for deferred mappingof inode security contexts
Date: Thu, 25 May 2006 11:42:26 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588170B0B@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Jeremy Katz" <katzj@redhat.com>
Cc: <selinux@tycho.nsa.gov>, "selinux-dev" <selinux-dev@tresys.com>,
        "Paul Nasrat" <pnasrat@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Thu, 2006-05-25 at 11:19 -0400, Stephen Smalley wrote:
> > The alternative model to post checking after policy load would be to
> > either:
> > 1) Precheck the file contexts from the header against the 
> .pp file in 
> > some manner at install time (in which case rpm can abort early), or
> 

I'm not sure this works. As noted earlier the policy module insertion
can fail for a number of reasons so the labels would still be
inconsistent after installation (even if they were valid in the module).
Further its very tricky to determine whether a label is valid without
going through a full link/expand since the role types, attributes, etc
need to be expanded to decide if labels are valid.

> And as I suspect that you'll say that since those contexts 
> were generated from the .pp file in the first place, no such 
> checking is required, let me note that:
> a) the contexts will have been generated from the file 
> contexts part of the .pp, not from the policy module itself, 
> so there could be an inconsistency between the two that 
> leaves the context invalid under the new policy, and
> b) having rpm recheck at install time provides us with both 
> greater robustness (in the event of a bug in rpmbuild or a 
> package corrupted in some manner along the way) and security 
> (in the event of a maliciously constructed package).
> 
> > 2) Have load_policy fail if any of these labelpriv-created contexts 
> > were not made valid by the new policy, reverting to the old 
> policy and 
> > returning an error all the way back to rpm (in which case rpm still 
> > has to take some corrective action).
> 

Implemented in the kernel? (trying to think this through) the sidtab
will be updated with the symbolic labels of the files but mapped to
unlabeled, the reload would check any label<->symbolic inconsistencies.
If a policy reload invalidates a label do you store the symbolic version
of it? If so how can you tell the difference between labels created with
labelpriv or otherwise invalidated labels?


I agree that this is very important from a robustness POV, specifically
the propagation of label inconsistencies that will happen if executables
stay unlabeled on the filesystem and therefore are unaffected by the
type_transition rules that would normally apply to them (which keep the
file labels consistent). This propagation could get worse and worse as
the system runs in an inconsistent state.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
