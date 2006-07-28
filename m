Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for
	expliciteipc object labeling
From: Eric Paris <eparis@parisplace.org>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        jbrindle@tresys.com
In-Reply-To: <200607272116.k6RLGrFC026797@turing-police.cc.vt.edu>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015882989A9@exchange.columbia.tresys.com>
	 <1154019529.5028.19.camel@localhost.localdomain>
	 <200607272116.k6RLGrFC026797@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 10:12:37 -0400
Message-Id: <1154095957.5028.79.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-27 at 17:16 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 27 Jul 2006 12:58:49 EDT, Eric Paris said:
> 
> > I also decided to leave the name ipccreate even though this does not
> > clearly express that the patch does not cover posix message queues.  The
> > only name that seemed descriptive enough was sysvipccreate which just
> > seemed incredibly long for little to no gain.  I will address the issue
> > of controlling posix message queue explicit labeling in a future patch.
> 
> Will that require another bit?

The thought at the moment does not require another bit.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
