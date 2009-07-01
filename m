Date: Thu, 2 Jul 2009 08:42:36 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: Re: The problem with TUN/TAP devices
In-Reply-To: <200907011234.52011.paul.moore@hp.com>
Message-ID: <alpine.LRH.2.00.0907020841540.32336@tundra.namei.org>
References: <200906301734.31986.paul.moore@hp.com> <200907011119.11108.paul.moore@hp.com> <1246462939.13464.185.camel@moss-pluto.epoch.ncsc.mil> <200907011234.52011.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Jul 2009, Paul Moore wrote:

> Well, if we can't do it in sk_alloc() then I think we are stuck with a new 
> hook; which just seems wrong.

Why isn't the TUN driver calling the same code as other socket creating 
code?


- James
-- 
James Morris <jmorris@namei.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
