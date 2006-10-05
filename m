Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Steve Grubb <sgrubb@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
In-Reply-To: <4525629C.90804@us.ibm.com>
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com>
	 <452519BC.1060204@us.ibm.com>
	 <1160060310.2132.102.camel@moss-spartans.epoch.ncsc.mil>
	 <45252ADE.7080905@us.ibm.com>
	 <1160073550.2132.163.camel@moss-spartans.epoch.ncsc.mil>
	 <4525629C.90804@us.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 16:12:05 -0400
Message-Id: <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 14:53 -0500, Michael C Thompson wrote:
> Stephen Smalley wrote:
> > It is cleaner to make the calls unconditional and just let the
> > configuration vary.  It would be nice if we could do the same thing with
> > the audit support, just letting libaudit do different things in the
> > non-LSPP vs. LSPP configurations.
> 
> What I didn't understand that the desire was to have those actions be 
> dependent on the suid state of newrole, and not the ability to perform 
> the actions.
> 
> It would be possible to stat the newrole binary's permissions to see if 
> newrole is suid, but we then need to watch out for the possibility that 
> argv[0] isn't correct, so we'd need to address that (could hardcode into 
> newrole where it expects to be, for example).

Not a good idea - too susceptible to caller subversion or a simple
mistake leading to newrole failing to drop capabilities and/or skipping
security-relevant processing.

The best option is to make the calls to audit and to pam be
unconditional and provide a way in audit and pam configuration to
effectively make them no-ops (already possible for pam via pam_permit).
Then only the capability dropping and uid switching has to be
conditional, and that processing can be based on whether newrole is able
to perform those actions.

If that isn't possible for audit, then I guess we just live with audit
always being generated when the caller has euid 0, regardless of whether
newrole was suid.  That is better than the alternative.

> >>> 2) I'm not sure how RH plans to set and maintain the suid bit on newrole
> >>> in the LSPP case, since they want to have it off by default.  If another
> >>> package, like the lspp package, modifies the suid bit on newrole, then a
> >>> rpm -V policycoreutils will report a change in mode from the package
> >>> defaults and any update of policycoreutils could reset the mode to the
> >>> original one.
> > 
> > This remains a problem AFAICS.
> 
> Yup, can't really weigh in on that though.

Right.  Dan?  Steve?  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
