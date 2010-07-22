Date: Fri, 23 Jul 2010 08:43:10 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Dan Carpenter <error27@gmail.com>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: Re: [patch 7/7 v2] selinux: fix error codes in symtab_init()
In-Reply-To: <1279810428.11197.38.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.1007230842490.11399@tundra.namei.org>
References: <20100612185739.GV5483@bicker> <1279810428.11197.38.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Jul 2010, Stephen Smalley wrote:

> On Sat, 2010-06-12 at 20:57 +0200, Dan Carpenter wrote:
> > hashtab_create() only returns NULL on allocation failures to -ENOMEM is
> > appropriate here.
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > Acked-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
> for the entire series.

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
