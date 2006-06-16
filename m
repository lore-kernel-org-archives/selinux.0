Subject: RE: Type transition rules in conditionals
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        selinux-dev <selinux-dev@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1150460534.18071.14.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588210A4F@exchange.columbia.tresys.com>
	 <1150401839.3574.253.camel@moss-spartans.epoch.ncsc.mil>
	 <1150460534.18071.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 09:08:08 -0400
Message-Id: <1150463288.18657.91.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-16 at 08:22 -0400, Stephen Smalley wrote:
> On Thu, 2006-06-15 at 16:03 -0400, Stephen Smalley wrote:
> > Hmm..well, unwinding to a pre-modular libsepol/checkpolicy, checkpolicy
> > does issue a warning about duplicate type transitions in different
> > conditionals (although it incorrectly calls them conflicting) and notes
> > that it is discarding them.  So the only thing that has changed is that
> > checkpolicy stopped reporting them, which led to them creeping into
> > policy.
> > 
> > Bug in policy.  Factor out the type_transition rules from the
> > conditionals.
> 
> And we should restore error reporting for this case in the expander, and
> turn it into a fatal error at expand time once the policy is fixed.

I fixed the policy, so it should be ok to do it now.  Now that I know
that duplicate type_transitions in different conditionals are considered
errors, I can also keep an eye out for them (there was only one).

> Makes me wonder whether we should prohibit type transition/member/change
> rules altogether in conditional blocks, as they don't fit very well
> there.

I would be against that, it would cause more problems with refpolicy
interfaces, as domtrans interfaces would either be unusable in
conditionals, or we would have to break up the interface so that the
type_transition part can go outside the conditional, which would be
ugly.  For example, something like:

if( ! secure_mode_myapp ) {
	seutil_domtrans_semanage(myapp_t)
}

would become a problem.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
