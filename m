MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Install SELinux policies from rpm package header
Date: Fri, 10 Jul 2009 16:26:44 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E012CD8FB@exchange2.columbia.tresys.com>
In-Reply-To: <1247241489.30551.86.camel@moss-lions.epoch.ncsc.mil>
References: <C67BD5B0.A89C1%csellers@tresys.com> <4A575664.4040805@manicmethod.com> <1247241489.30551.86.camel@moss-lions.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <jwcart2@tycho.nsa.gov>, "Joshua Brindle" <method@manicmethod.com>
Cc: "Chad Sellers" <csellers@tresys.com>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "Paul Howarth" <paul@city-fan.org>, "SE Linux" <selinux@tycho.nsa.gov>,
        "Stephen Lawrence" <slawrence@tresys.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: James Carter [mailto:jwcart2@tycho.nsa.gov] 
> 
> > Its alot worse than that. What about files on backup 
> drives? Offline drives? 
> > transient files that will get relabeled to something inappropriate? 
> > I'm not confortable relabeling databases with potentially sensitive 
> > data to var_lib_t because mysql was uninstalled.
> > 
> 
> The argument seems to be for removing the ability to remove modules.
> It would be the roach motel style of policy management.
> 

I like it, policies check in but don't check out. I haven't heard an
argument about 1) how I'm crazy and wrong or 2) how to keep systems
running as expected otherwise though.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
