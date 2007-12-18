Date: Tue, 18 Dec 2007 19:16:25 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, vyekkirala@TrustedCS.com,
        chanson@TrustedCS.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC PATCH v8 10/18] SELinux: Add a network node caching mechanism
 similar to the sel_netif_*() functions
In-Reply-To: <200712171556.21136.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0712181915530.7892@us.intercode.com.au>
References: <20071214213548.10069.59135.stgit@flek.lan>
 <20071214215046.10069.12365.stgit@flek.lan> <1197923728.17307.135.camel@moss-spartans.epoch.ncsc.mil>
 <200712171556.21136.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Dec 2007, Paul Moore wrote:

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
> Thanks.  Any problem if we wait until 2.6.26 for a port SID cache? 

Nope.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
