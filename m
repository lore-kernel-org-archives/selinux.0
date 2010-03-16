Date: Wed, 17 Mar 2010 08:47:42 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux:  Reduce max avtab size to avoid page allocation
 failures
In-Reply-To: <1268747151.27024.17.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.1003170845450.23536@tundra.namei.org>
References: <1268664131.15512.54.camel@moss-pluto.epoch.ncsc.mil>  <alpine.LRH.2.00.1003160831220.13330@tundra.namei.org> <1268747151.27024.17.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Mar 2010, Stephen Smalley wrote:

> > Applied to
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next
> 
> Candidate for -stable?  for 2.6.34?

I'm not sure -- it's not really a bug or a regression.  I think we want to 
keep changes to -stable and the -rc series as essential as possible.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
