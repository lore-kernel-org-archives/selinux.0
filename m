Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1DevXZ025710
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 08:40:57 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1DerUU009194
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 13:40:54 GMT
Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   "'Chad Hanson'" <chanson@TrustedCS.com>
In-Reply-To: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 08:37:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-10-31 at 17:47, Frank Mayer wrote:
> > 	The MLS model is another reason for this functionality. We have
> > chosen to create MLS policy overrides using a new SELinux MLS
> > capability class. 
> 
> I have not thought greatly about this choice, but I wonder if it was wise to
> make the MLS mechanism dependent on the capability mechanism.  Orthogonal
> mechanisms would seem smarter.  

Point of clarification:  These MLS capabilities only exist as TE
abstractions, not as part of the Linux capabilities logic, IIUC.  Using
TE to control MLS privileges is desirable.

> Ah and here we have the beginning of the slippery slope.  This might be easy in
> terms of lines of code, but the conceptual complexity of what you describe above
> scares me.  I still wonder why we have to change TE to support a MLS convention.
> I'd much rather you did not make these mechanisms dependent on each other.  

TE was originally developed to fill in the gaps of MLS, including
privilege management for trusted subjects.  Using TE to control MLS
privileges is a good thing.  Whether or not privilege bracketing is a
good thing is more open to debate, although it is clearly entrenched in
applications today, and not just MLS applications; the prior requests
for such a feature have been to support traditional Unix applications
that presently use seteuid/setfsuid.

Devil's advocate:  Would you argue for removing the ability to reload
policy at runtime from SELinux?  For removing the ability to relabel
files at runtime from SELinux?  Or is it sufficient that these "unsafe"
operations are controlled by the policy?  The dynamic context
transitions can be controlled on a pairwise context basis, so you do get
much finer control than a traditional setuid-like operation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
