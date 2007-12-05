MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/2] policy capability support
Date: Wed, 5 Dec 2007 14:30:25 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
In-Reply-To: <200712051421.39624.paul.moore@hp.com>
References: <20071205184848.180973622@tresys.com> <200712051421.39624.paul.moore@hp.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Paul Moore" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>,
        "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> The discussion for this appears to have gone quiet (at least I
> haven't seen anything else on this list).  Where do things currently
> stand?

At this point I'd be OK with requiring equivalence and throwing an error
otherwise.  I do think that this will result in usability issues that we
will have to address once people start using the caps.  However, with
only
a single cap defined so far it is not really possible to know how these
will end up being used.

 - todd



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
