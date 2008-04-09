Subject: Re: [PATCH 3/3] SELinux: Add network port SID cache
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080407231112.8052.8688.stgit@flek.lan>
References: <20080407230647.8052.79603.stgit@flek.lan>
	 <20080407231112.8052.8688.stgit@flek.lan>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 13:15:31 -0400
Message-Id: <1207761331.21223.475.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> Much like we added a network node cache, this patch adds a network port cache.
> The design is taken almost completely from the network node cache which in
> turn was taken from the network interface cache.  The basic idea is to cache
> entries in a hash table based on protocol/port information.  The hash
> function only takes the port number into account since the number of different
> protocols in use at any one time is expected to be relatively small.

Not necessarily an obstacle to merging, but I was wondering if it would
be worthwhile to investigating unifying these caches into a single code
base with a more general interface, or if that would be a loss overall.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
