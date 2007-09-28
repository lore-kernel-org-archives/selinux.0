Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <200709281804.l8SI4Cuj031486@cadmus.columbia.tresys.com>
References: <200709281804.l8SI4Cuj031486@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 28 Sep 2007 14:21:27 -0400
Message-Id: <1191003687.22078.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-28 at 14:04 -0400, Todd C. Miller wrote:
> Daniel J Walsh wrote:
> > Yes you are right.
> >
> > The problem is we need to find the failsafe account before writing the
> > general account.
> > 
> > How about this patch.
> 
> There is some missing frees in there and I don't think we really
> need to get the full users list.  I would write it like this.

Thanks, applied.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
