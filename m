Subject: Re: [PATCH 2/2] selinux: implement mmap on /selinux/policy
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1280249271.4789.61.camel@moss-pluto.epoch.ncsc.mil>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <20100726193414.19538.64028.stgit@paris.rdu.redhat.com>
	 <1280249271.4789.61.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 12:50:31 -0400
Message-ID: <1280249431.23427.126.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-07-27 at 12:47 -0400, Stephen Smalley wrote:
> On Mon, 2010-07-26 at 15:34 -0400, Eric Paris wrote:
> > /selinux/policy allows a user to copy the policy back out of the kernel.
> > This patch allows userspace to actually mmap that file and use it directly.
> 
> # checkpolicy -b /selinux/policy
> checkpolicy:  loading policy configuration from /selinux/policy
> Can't map '/selinux/policy':  Invalid argument
> 
> # strace checkpolicy -b /selinux/policy
> ...
> open("/selinux/policy", O_RDONLY)       = 3
> fstat(3, {st_mode=S_IFREG|0400, st_size=5720516, ...}) = 0
> mmap(NULL, 5720516, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = -1 EINVAL
> (Invalid argument)

MAP_SHARED works.  I didn't realize checkpolicy used mmap.  I'll look at
it.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
