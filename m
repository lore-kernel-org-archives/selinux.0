Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UHT1Do016655
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 12:29:01 -0500 (EST)
Received: from web31607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j2UHPBph027089
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 17:25:11 GMT
Message-ID: <20050330172751.30281.qmail@web31607.mail.mud.yahoo.com>
Date: Wed, 30 Mar 2005 09:27:51 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Desktop apps interoperability
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
wrote:
> On Wed, Mar 30, 2005 at 09:04:26AM -0800, Casey
> Schaufler wrote:
> 
> > Yes, and I'm sure that you can do a configuration
> > of most application defaults that will be good
> > enough to demo. Application developers tend to
> > have their own ideas regarding data storage and
> > it is a bad idea for a system developer to
> > interfere with said application developer's
> > freedom to inovate.
> 
>  ... application developer's freedom to impose
> insecurity,
>  through ignorance on the part of the app-developer,
> upon
>  the users?

What ignorance? The developer codes to the
published policies (e.g. uids, modes, capabilities)
and everything works *within the published policy*.
Some stranger comes along and without warning
arbitrarily imposes additional policy on the
application that the developer has so carefully
crafted, often without looking at the code to
see what the developer's intent might have been. 
 
>  no offense intended:

None taken. I buy skin thickener in 55 gallon drums.

> freedom in an abstract concept
> [e.g. "the american way"]
> _always_ has limits - laws / rules / policy
> is defined to confine
> that freedom, for good or worse.

Yup. So long as those limits can be known by
the "free" entity all is good. When additional
constraints can be added whimsically there is
bound to be resistance.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
