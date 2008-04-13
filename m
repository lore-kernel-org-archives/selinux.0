Date: Mon, 14 Apr 2008 09:51:40 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH v3 1/2] SELinux: Made netnode cache adds faster
In-Reply-To: <1207938184.21223.932.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0804140951260.17956@us.intercode.com.au>
References: <20080410144452.8521.39381.stgit@flek.lan>
 <20080410144809.8521.5716.stgit@flek.lan> <1207938184.21223.932.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Apr 2008, Stephen Smalley wrote:

> 
> On Thu, 2008-04-10 at 10:48 -0400, Paul Moore wrote:
> > When adding new entries to the network node cache we would walk the entire
> > hash bucket to make sure we didn't cross a threshold (done to bound the cache
> > size).  This isn't a very quick or elegant solution for something which is
> > supposed to be quick-ish so add a counter to each hash bucket to track the
> > size of the bucket and eliminate the need to walk the entire bucket list on
> > each add.
> > 
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to for-akpm.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
