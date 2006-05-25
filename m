MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] selinux:  introduce support for deferredmappingof inode security contexts
Date: Thu, 25 May 2006 12:56:35 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588170B27@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Jeremy Katz" <katzj@redhat.com>, <selinux@tycho.nsa.gov>,
        "selinux-dev" <selinux-dev@tresys.com>,
        "Paul Nasrat" <pnasrat@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Thu, 2006-05-25 at 12:03 -0400, Stephen Smalley wrote:
> > Yes, we'd need a separate flag in the SID table to distinguish 
> > invalidated-by-reload vs. invalid-at-creation (labelpriv).  In the 
> > latter case, if the context doesn't become valid upon the reload, 
> > instead of just leaving it in the unmapped (symbolic) 
> state, we'd bail 
> > and return an error to the caller, leaving the old policy 
> in place in 
> > the kernel, and causing libsemanage to revert the store and 
> propagate an
> > error back to semodule and thus to rpm.   That avoids 
> requiring rpm to
> > perform any extra checking, but does still require it to perform 
> > corrective action after having already set down the files.  It also 
> > helps with another problem that was bothering me - the 
> potential for 
> > the SID table to just keep growing without bound with an 
> endless set 
> > of invalid file labels.  That would still be an issue for the 
> > invalidated-by-reload contexts, so we'd still want some way 
> to force a 
> > purge of those, possibly a selinuxfs interface.
> 
> Of course, since there is nothing to tie a given labelpriv 
> event to a given policy load, if we ever have multiple 
> processes setting down invalid file labels in the same window 
> and then trying to insert different policy modules, they 
> could both end up failing (since neither module would 
> validate all of the file labels by itself), and you'd have to 
> insert both policy modules in a single transaction to recover.
> 

Ouch. Does RPM put down files from separate packages (within the same
transaction) at the same time? Jeremy already said the postinstall
scripts might not run right after the package installation so this seems
to be the case. 

So the mutually dependant policy modules problem and now this really
seem to indicate that RPM needs to be aware that policy was installed
and build the new policy all at once at the end of the transaction.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
