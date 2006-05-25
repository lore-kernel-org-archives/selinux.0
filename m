Subject: RE: [RFC][PATCH] selinux:  introduce support for deferred
	mappingof inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Jeremy Katz <katzj@redhat.com>, selinux@tycho.nsa.gov,
        selinux-dev <selinux-dev@tresys.com>, Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588170B0B@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588170B0B@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 12:03:46 -0400
Message-Id: <1148573026.20976.153.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 11:42 -0400, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > 
> > On Thu, 2006-05-25 at 11:19 -0400, Stephen Smalley wrote:
> > > The alternative model to post checking after policy load would be to
> > > either:
> > > 1) Precheck the file contexts from the header against the 
> > .pp file in 
> > > some manner at install time (in which case rpm can abort early), or
> > 
> 
> I'm not sure this works. As noted earlier the policy module insertion
> can fail for a number of reasons so the labels would still be
> inconsistent after installation (even if they were valid in the module).
> Further its very tricky to determine whether a label is valid without
> going through a full link/expand since the role types, attributes, etc
> need to be expanded to decide if labels are valid.

Details, details ;)  Yes, I'm not sure if this is workable, but it
seemed worth exploring.  Might even be useful on the rpmbuild side for
checking purposes.

> > > 2) Have load_policy fail if any of these labelpriv-created contexts 
> > > were not made valid by the new policy, reverting to the old 
> > policy and 
> > > returning an error all the way back to rpm (in which case rpm still 
> > > has to take some corrective action).
> > 
> 
> Implemented in the kernel? (trying to think this through) the sidtab
> will be updated with the symbolic labels of the files but mapped to
> unlabeled, the reload would check any label<->symbolic inconsistencies.
> If a policy reload invalidates a label do you store the symbolic version
> of it? If so how can you tell the difference between labels created with
> labelpriv or otherwise invalidated labels?

Yes, we'd need a separate flag in the SID table to distinguish
invalidated-by-reload vs. invalid-at-creation (labelpriv).  In the
latter case, if the context doesn't become valid upon the reload,
instead of just leaving it in the unmapped (symbolic) state, we'd bail
and return an error to the caller, leaving the old policy in place in
the kernel, and causing libsemanage to revert the store and propagate an
error back to semodule and thus to rpm.   That avoids requiring rpm to
perform any extra checking, but does still require it to perform
corrective action after having already set down the files.  It also
helps with another problem that was bothering me - the potential for the
SID table to just keep growing without bound with an endless set of
invalid file labels.  That would still be an issue for the
invalidated-by-reload contexts, so we'd still want some way to force a
purge of those, possibly a selinuxfs interface.

> I agree that this is very important from a robustness POV, specifically
> the propagation of label inconsistencies that will happen if executables
> stay unlabeled on the filesystem and therefore are unaffected by the
> type_transition rules that would normally apply to them (which keep the
> file labels consistent). This propagation could get worse and worse as
> the system runs in an inconsistent state.

Particularly since rpm itself would never see an error condition under
the current patch (w/o separate checking).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
