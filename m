Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBAD0UKK000771
	for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2009 08:00:30 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBAD2liI011264
	for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2009 13:02:47 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id nBAD0VUS021061
	for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2009 08:00:31 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id nBAD0VuO021059
	for selinux@tycho.nsa.gov; Thu, 10 Dec 2009 08:00:31 -0500
Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB9LQ05G018992
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 16:26:00 -0500
Subject: Re: tun/tap and SE Linux in 2.6.32
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: russell@coker.com.au
Cc: Paul Moore <paul.moore@hp.com>, SE-Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <200912100756.24553.russell@coker.com.au>
References: <200912091232.26387.russell@coker.com.au>
	 <200912091548.03369.paul.moore@hp.com>
	 <200912100756.24553.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 09 Dec 2009 16:26:30 -0500
Message-Id: <1260393990.3850.22.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-12-10 at 07:56 +1100, Russell Coker wrote:
> On Thu, 10 Dec 2009, Paul Moore <paul.moore@hp.com> wrote:
> > > Subject: selinux PERMISSIVE blocking tun/tap device creation in v2.6.32
> >
> > I imagine this is because the original reporter is using a SELinux policy
> > without the new TUN socket classes/permissions (which is likely the common
> > case at this point).  The unknown class/permission handling that Eric added
> > _should_ protect us from this - Russel do you have any more information
> > about the distribution and policy in use here?
> 
> Sorry, the original message apparently wasn't clear enough (I've added some 
> caps).
> 
> The problem occurred in permissive mode.  When the system is in permissive 
> mode then SE Linux should not deny any action that Unix permissions will 
> permit.

That would require changing avc_has_perm_noaudit() or
context_struct_compute_av(), which historically have not treated an
error condition (e.g. invalid SID or class) within *compute_av() in the
same manner as lack of permission in the policy.  In the error condition
case, avc_has_perm_noaudit() just propagates the error condition to the
caller and permissive mode doesn't come into play - it doesn't even look
at (or cache) the av_decision.

That said, we've long since made the invalid SID case unreachable
(automatic remapping to the unlabeled SID), and we've now made the
invalid class case only an error if handle_unknown==deny, so possibly we
could change *compute_av() or avc_has_perm() to treat it the same way as
a regular permission denial.  We could possibly make *compute_av()
always "succeed" and just return the empty allowed vector (already
cleared on entry) on all error conditions, in which case avc_has_perm()
would always do the right thing.  And *compute_av() would become void
functions then.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
