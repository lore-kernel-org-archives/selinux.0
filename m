Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Todd Miller <tmiller@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588EDEB87@exchange.columbia.tresys.com>
References: <20070815204411.705994826@tresys.com>
	 <1187190639.2674.51.camel@localhost.localdomain>
	 <46C31BD0.5060200@tresys.com>
	 <1187192832.2674.74.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB87@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 15:21:39 -0400
Message-Id: <1187205699.2838.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 13:37 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-08-15 at 11:57 -0400, Joshua Brindle wrote:

[...]

> > I'm trying to understand whether the issue here is limited in
> > scope to home directory labels or actually extends to the
> > entire notion of per-role types (tmp files, ttys, derived
> > program domains, etc).  I know that has long been an area of
> > concern, not only for file relabeling but also for e.g.
> > modules (requires templating that would go beyond even simple
> > interfaces). 
> > 
> 
> I agree, however I don't want to rely on DAC for seperation of things
> like tmp files.

But the current role-based separation is not what we want either - for
tmp we really want this to be per-user. For the tmp types we could use
constraints on users (this is easier than the constraints for home
directories because the tmp files will always be created by a user
process and therefore have the correct user labeling without a
genhomedircon like tool).

But again, namespace based separation may be the easiest solution here.
Or type + dac might be sufficient.

>  If it were easier to do automatic user/role transitions
> on domains and files those might serve the purpose fine and still
> provide good isolation via MAC but without that I'd hate to see per-role
> types go away.
> 

I agree that user transitions would be helpful.

> One example I already brought up offlist is webapps, particularly when
> combined with something like se-postgresql there can be policy driven
> seperation of data in one of the most exploited mediums around. It
> doesn't matter if the seperation is via type: user_cgi_t can access
> user_db_t or user: method:user_r:cgi_t can access method:object_r:db_t
> or not, as long as there is some facility for getting a cgi of mine
> running with the context method:user_r:cgi_t. 
> 

Right - and part of my argument here is that if it is really user based
separation then let's do user based separation and not this halfway
role-based / type separation. It's causing more problems than its
solving.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
