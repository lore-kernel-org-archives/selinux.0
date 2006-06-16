Subject: RE: Type transition rules in conditionals
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
        selinux-dev <selinux-dev@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1150401839.3574.253.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588210A4F@exchange.columbia.tresys.com>
	 <1150401839.3574.253.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 08:22:14 -0400
Message-Id: <1150460534.18071.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-15 at 16:03 -0400, Stephen Smalley wrote:
> On Thu, 2006-06-15 at 15:41 -0400, Joshua Brindle wrote:
> > > - Why can't it be handled in the same manner as in a monolithic build?
> > 
> > It is handled the same, the only difference is the order that the
> > type_transitions are 
> 
> Hmm..well, unwinding to a pre-modular libsepol/checkpolicy, checkpolicy
> does issue a warning about duplicate type transitions in different
> conditionals (although it incorrectly calls them conflicting) and notes
> that it is discarding them.  So the only thing that has changed is that
> checkpolicy stopped reporting them, which led to them creeping into
> policy.
> 
> Bug in policy.  Factor out the type_transition rules from the
> conditionals.

And we should restore error reporting for this case in the expander, and
turn it into a fatal error at expand time once the policy is fixed.

Makes me wonder whether we should prohibit type transition/member/change
rules altogether in conditional blocks, as they don't fit very well
there.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
