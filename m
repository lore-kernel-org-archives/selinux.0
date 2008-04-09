Subject: Re: [PATCH 3/3] SELinux: Add network port SID cache
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200804091337.07861.paul.moore@hp.com>
References: <20080407230647.8052.79603.stgit@flek.lan>
	 <20080407231112.8052.8688.stgit@flek.lan>
	 <1207761331.21223.475.camel@moss-spartans.epoch.ncsc.mil>
	 <200804091337.07861.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 14:08:33 -0400
Message-Id: <1207764513.21223.517.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-09 at 13:37 -0400, Paul Moore wrote:
> On Wednesday 09 April 2008 1:15:31 pm Stephen Smalley wrote:
> > On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> > > Much like we added a network node cache, this patch adds a network
> > > port cache. The design is taken almost completely from the network
> > > node cache which in turn was taken from the network interface
> > > cache.  The basic idea is to cache entries in a hash table based on
> > > protocol/port information.  The hash function only takes the port
> > > number into account since the number of different protocols in use
> > > at any one time is expected to be relatively small.
> >
> > Not necessarily an obstacle to merging, but I was wondering if it
> > would be worthwhile to investigating unifying these caches into a
> > single code base with a more general interface, or if that would be a
> > loss overall.
> 
> Yeah, I thought of that too when I was doing the network node cache but 
> I convinced myself it would probably do more harm than good.  The core 
> problem is that all of the hashing and lookup functions are slightly 
> different.  Not fatal, we can workaround it via case statments, a 
> function table, or something similar but all of these solutions will 
> impose some additional overhead.  For something which is supposed to be 
> fast I thought it better to not go down this path.

Ok - I'm fine with keeping them separate at present, but wanted to toss
out the idea for possible future investigation.  And we have examples
where we have gone the other direction, e.g. the avtab originally
re-used the hashtab code, but we eventually split it out into its own
direct implementation.

So other than that, my comments on the changes to the node cache also
apply to this code I think.

> I'm open to suggestions if you have any.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
