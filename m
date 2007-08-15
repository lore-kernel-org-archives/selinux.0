MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
Date: Wed, 15 Aug 2007 16:47:51 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588EDEBA9@exchange.columbia.tresys.com>
In-Reply-To: <1187210504.2838.56.camel@localhost.localdomain>
References: <20070815204411.705994826@tresys.com> <1187190639.2674.51.camel@localhost.localdomain> <46C31BD0.5060200@tresys.com> <1187192832.2674.74.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com> <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil> <1187205378.2838.12.camel@localhost.localdomain> <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil> <1187209022.2838.38.camel@localhost.localdomain> <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil> <1187210504.2838.56.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Todd Miller" <tmiller@tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Wed, 2007-08-15 at 16:31 -0400, Stephen Smalley wrote:
> 
> So I vote for removing genhomedircon entirely unless some
> other objection comes up. Anyone that wants that behavior
> could certainly set something up fairly easily.
> 

You haven't addressed the other concerns (policy server, user labeling
of home directories, etc). It needs to stay and people that don't want
it don't have to use it. 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
