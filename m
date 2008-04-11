From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v3 2/2] SELinux: Add network port SID cache
Date: Fri, 11 Apr 2008 15:02:21 -0400
Cc: selinux@tycho.nsa.gov
References: <20080410144452.8521.39381.stgit@flek.lan> <20080410144814.8521.18725.stgit@flek.lan> <1207938494.21223.936.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207938494.21223.936.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804111502.21453.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 11 April 2008 2:28:14 pm Stephen Smalley wrote:
> On Thu, 2008-04-10 at 10:48 -0400, Paul Moore wrote:
> > Much like we added a network node cache, this patch adds a network
> > port cache. The design is taken almost completely from the network
> > node cache which in turn was taken from the network interface
> > cache.  The basic idea is to cache entries in a hash table based on
> > protocol/port information.  The hash function only takes the port
> > number into account since the number of different protocols in use
> > at any one time is expected to be relatively small.
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
> Have you run any measurements with this added?

Not at present.

> This should address:
> https://bugzilla.redhat.com/show_bug.cgi?id=234531
> http://marc.info/?l=linux-kernel&m=117499007102880&w=2

Yep.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
