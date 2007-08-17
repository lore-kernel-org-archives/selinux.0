Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Todd Miller <tmiller@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588EDEBAB@exchange.columbia.tresys.com>
References: <20070815204411.705994826@tresys.com>
	 <1187190639.2674.51.camel@localhost.localdomain>
	 <46C31BD0.5060200@tresys.com>
	 <1187192832.2674.74.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1187205378.2838.12.camel@localhost.localdomain>
	 <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1187209022.2838.38.camel@localhost.localdomain>
	 <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1187210504.2838.56.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEBA9@exchange.columbia.tresys.com>
	 <1187212166.2838.73.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEBAB@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 17 Aug 2007 09:33:25 -0400
Message-Id: <1187357605.9435.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 17:12 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Wed, 2007-08-15 at 16:47 -0400, Joshua Brindle wrote:

[...]

> > 
> > a) there is no real way to not use it currently and
> > b) every time there is a choice like this it has a huge
> > impact on maintenance and usability.
> > 
> > I think we should make a choice and support one standard way
> > of doing things. People are still free to customize, but the
> > upstream should have one standard.
> > 
> 
> Then the upstream should have it available. RH doesn't have to use it
> but like I told you off list we have systems that use it and need it. 

I'd really like to here _why_ they need per-role home directory types -
so far you haven't explained that. I think this is an important problem
to fix because I don't see how current practice can possibly work with
users stored in a directory or remote home directories.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
