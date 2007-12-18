Subject: Re: [RFC PATCH v8 10/18] SELinux: Add a network node caching
	mechanism similar to the sel_netif_*() functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <200712171556.21136.paul.moore@hp.com>
References: <20071214213548.10069.59135.stgit@flek.lan>
	 <20071214215046.10069.12365.stgit@flek.lan>
	 <1197923728.17307.135.camel@moss-spartans.epoch.ncsc.mil>
	 <200712171556.21136.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 08:26:35 -0500
Message-Id: <1197984395.7967.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-17 at 15:56 -0500, Paul Moore wrote:
> On Monday 17 December 2007 3:35:28 pm Stephen Smalley wrote:
> > On Fri, 2007-12-14 at 16:50 -0500, Paul Moore wrote:
> > > This patch adds a SELinux IP address/node SID caching mechanism similar
> > > to the sel_netif_*() functions.  The node SID queries in the SELinux
> > > hooks files are also modified to take advantage of this new
> > > functionality.  In addition, remove the address length information from
> > > the sk_buff parsing routines as it is redundant since we already have the
> > > address family.
> >
> > This is very nice - we also need the same kind of cache for port SIDs.
> 
> Thanks.  Any problem if we wait until 2.6.26 for a port SID cache?  It 
> shouldn't be any worse than it is now (the new code is not concerned with 
> ports) and the current patchset is already large enough that it keeps me up 
> at night thinking about all the places it could go wrong ...

Yes, that's fine - just a note to file away for the future.  We'll still
want the cache eventually though since the name_bind and name_connect
checks are based on the port SIDs and will remain even when the compat
checks are obsoleted.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
