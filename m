Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2V29nfb012425
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 22:09:49 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2V29mAY019888
	for <selinux@tycho.nsa.gov>; Sat, 31 Mar 2007 02:09:48 GMT
Date: Fri, 30 Mar 2007 22:09:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: secmark integration
In-Reply-To: <1175286309.20396.13.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0703302201520.29742@d.namei>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
 <1175284031.3602.24.camel@localhost.localdomain> <1175286309.20396.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 30 Mar 2007, Eric Paris wrote:

> > Is this really needed as long as the distro provides a way to customize
> > the iptables rules?
> 
> It's not just that.  The reason a new table was proposed was because
> people may want to iptables -F and flush their rules.  If the secmark
> stuff is on the main tables (filter and nat) that people use it will get
> blown away and there will be no automation of a boolean setting you talk
> about later.

I think there's also a good case for a separate table on the basis that 
the rules are part of a separate administrative realm (e.g. MAC, rather 
than DAC) and should be maintained separately.  We could also look at 
adding an LSM hook for rules being manipulated in this table (perhaps 
called 'security' to be more general).

Note that there may be tools which parse /proc/net/ip_tables_names when 
flushing (which the LSM hook would possibly help with in terms of stopping 
MAC policy from being modified without the correct authorization).

It still may be difficult to sell upstream, so we'd need more feedback 
from the distro folk possibly after some experimentation.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
