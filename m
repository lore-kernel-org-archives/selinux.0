From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] SELinux: Add network port SID cache
Date: Wed, 9 Apr 2008 13:37:07 -0400
Cc: selinux@tycho.nsa.gov
References: <20080407230647.8052.79603.stgit@flek.lan> <20080407231112.8052.8688.stgit@flek.lan> <1207761331.21223.475.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207761331.21223.475.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804091337.07861.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 April 2008 1:15:31 pm Stephen Smalley wrote:
> On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> > Much like we added a network node cache, this patch adds a network
> > port cache. The design is taken almost completely from the network
> > node cache which in turn was taken from the network interface
> > cache.  The basic idea is to cache entries in a hash table based on
> > protocol/port information.  The hash function only takes the port
> > number into account since the number of different protocols in use
> > at any one time is expected to be relatively small.
>
> Not necessarily an obstacle to merging, but I was wondering if it
> would be worthwhile to investigating unifying these caches into a
> single code base with a more general interface, or if that would be a
> loss overall.

Yeah, I thought of that too when I was doing the network node cache but 
I convinced myself it would probably do more harm than good.  The core 
problem is that all of the hashing and lookup functions are slightly 
different.  Not fatal, we can workaround it via case statments, a 
function table, or something similar but all of these solutions will 
impose some additional overhead.  For something which is supposed to be 
fast I thought it better to not go down this path.

I'm open to suggestions if you have any.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
