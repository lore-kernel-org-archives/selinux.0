Subject: RE: [PATCH 3/2] comments and format fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832A7FA@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832A7FA@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 11:33:55 -0400
Message-Id: <1153928035.11769.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-26 at 11:19 -0400, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > 
> > On Wed, 2006-07-26 at 10:59 -0400, Joshua Brindle wrote:
> > > This patch applies on the previous 2 and adds comments and 
> > fixes some 
> > > formatting as discussed on list. BTW, I've never heard any 
> > > authoritative style preferences for this repository. While I agree 
> > > with these particular changes (* going with var rather than type) 
> > > clearly not everyone does (such as the original author of 
> > that code) 
> > > and I'd prefer not to make subjective/arbitrary style 
> > changes without 
> > > some input on what the upstream preferred style is.
> > 
> > Personally, I prefer that as well, but we did apply Lindent 
> > to the entire tree, so it seems best to stay with its style...
> > 
> 
> I don't think lindent changes where the * is, since its like that all
> over the repo still..

It appears to move it, but the behavior varies depending on whether you
use a typedef'd type or not.

Before:
extern void f(int* a, struct foo* b, uint32_t* c);

After:
extern void f(int *a, struct foo *b, uint32_t * c);

Moral of the story:  Don't use typedefs ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
