Date: Tue, 2 Dec 2008 09:49:48 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: deprecate and schedule the removal of the the
 compat_net functionality
In-Reply-To: <200812011615.17013.paul.moore@hp.com>
Message-ID: <alpine.LRH.1.10.0812020949020.21992@tundra.namei.org>
References: <20081201203833.16302.16424.stgit@flek.lan> <1228165415.18720.257.camel@moss-spartans.epoch.ncsc.mil> <200812011615.17013.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Dec 2008, Paul Moore wrote:

> On Monday 01 December 2008 4:03:35 pm Stephen Smalley wrote:
> > On Mon, 2008-12-01 at 15:38 -0500, Paul Moore wrote:
> > > This patch is the first step towards removing the old "compat_net"
> > > code from the kernel.  Secmark, the "compat_net" replacement has
> > > been around for several kernel releases
> >
> > FWIW, secmark was first included in the Linux 2.6.18 release in Sep
> > 2006.  That's a bit more than "several kernel releases" ;)
> 
> Po-tay-to ... Po-tah-to ;)
> 
> If the patch gets bounced for some reason I'll update the text.  Which 
> brings up a good point; James, assuming there are no objections do you 
> want to pull this into the security-testing tree for 2.6.29 or would 
> you prefer I keep it in the lblnet tree?

Doesn't matter, unless there's a conflict.


Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
