From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>
Subject: Re: [PATCH] selinux: deprecate and schedule the removal of the the compat_net functionality
Date: Mon, 1 Dec 2008 16:15:16 -0500
Cc: selinux@tycho.nsa.gov
References: <20081201203833.16302.16424.stgit@flek.lan> <1228165415.18720.257.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1228165415.18720.257.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812011615.17013.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 01 December 2008 4:03:35 pm Stephen Smalley wrote:
> On Mon, 2008-12-01 at 15:38 -0500, Paul Moore wrote:
> > This patch is the first step towards removing the old "compat_net"
> > code from the kernel.  Secmark, the "compat_net" replacement has
> > been around for several kernel releases
>
> FWIW, secmark was first included in the Linux 2.6.18 release in Sep
> 2006.  That's a bit more than "several kernel releases" ;)

Po-tay-to ... Po-tah-to ;)

If the patch gets bounced for some reason I'll update the text.  Which 
brings up a good point; James, assuming there are no objections do you 
want to pull this into the security-testing tree for 2.6.29 or would 
you prefer I keep it in the lblnet tree?

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
