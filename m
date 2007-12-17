From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v8 06/18] LSM: Add inet_sys_snd_skb() LSM hook
Date: Mon, 17 Dec 2007 15:48:19 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
References: <20071214213548.10069.59135.stgit@flek.lan> <20071214215025.10069.10036.stgit@flek.lan> <1197920750.17307.100.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197920750.17307.100.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712171548.20090.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 17 December 2007 2:45:50 pm Stephen Smalley wrote:
> On Fri, 2007-12-14 at 16:50 -0500, Paul Moore wrote:
> > Add an inet_sys_snd_skb() LSM hook to allow the LSM to provide packet
> > level access control for all outbound packets.  Using the existing
> > postroute_last netfilter hook turns out to be problematic as it is can be
> > invoked multiple times for a single packet, e.g. individual IPsec
> > transforms, adding unwanted overhead and complicating the security
> > policy.
>
> None of the netfilter hooks works for this purpose?

None that we have found, no.  Although if you can prove me wrong I'd be very 
happy.  The problem is that the existing netfilter hooks can get hit multiple 
times in the case of labeled IPsec which was decided to be a no-no.

> Obviously this one needs to get seen on netdev.

Yep.  I just wanted to make sure we were all in agreement on what we 
wanted/needed before I tried to make our case to the netdev folks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
