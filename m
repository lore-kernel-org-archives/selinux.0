Subject: Re: The new audit2allow.
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Brian M. Williams" <bwilliams@tresys.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1187186013.2674.40.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588EDEA2F@exchange.columbia.tresys.com>
	 <1187094627.26008.149.camel@moss-spartans.epoch.ncsc.mil>
	 <1187186013.2674.40.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 10:11:01 -0400
Message-Id: <1187187061.2674.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 09:53 -0400, Karl MacMillan wrote:
> On Tue, 2007-08-14 at 08:30 -0400, Stephen Smalley wrote:

[...]

> ere are specific regressions in the new audit2allow, then
> > yes, those should be corrected.  Can you provide specific examples where
> > interface matching is worse - those would be useful test cases going
> > forward.  The -v output was never rigorously defined (they were just
> > comment lines, after all, and just to help a human reader with
> > supplemental information so that he wouldn't have to go back to the
> > original audit message and correlate it), and I'm not sure how TYPE=AVC
> > is helpful.  Retaining the audit serial number would likely be useful.
> > 
> 
> Yes - please send me logs where you get unexpected results. Also - can
> you explain more what you object to in the formatting. I made the
> formatting change because I found the old formatting to be very
> difficult to read. I'd be happy to change the formatting to something
> that makes me happy and fans of the old way happy, but I need to
> understand what you object to more clearly.
> 
> Other than the audit serial number, what would you like to see in the -v
> output. Also, have you found the -e output that gives lots of
> information?
> 

When I went to add the serial number I remembered why it wasn't there. I
compress all of the audit messages for a specific access vector down to
a single rule. So I can print the first serial number, but it is
somewhat misleading as the allow rule may have been generated from
several audit messages. If you use the -e flag you get every audit
message that contributed to the allow rule.

Any thoughts on how this should be handled?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
