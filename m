Date: Thu, 30 Apr 2009 08:49:32 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: drop secondary_ops->sysctl
In-Reply-To: <1241028667.18249.254.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0904300849080.17014@tundra.namei.org>
References: <20090429180025.22109.45638.stgit@paris.rdu.redhat.com> <1241028667.18249.254.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Apr 2009, Stephen Smalley wrote:

> On Wed, 2009-04-29 at 14:00 -0400, Eric Paris wrote:
> > We are still calling secondary_ops->sysctl even though the capabilities
> > module does not define a sysctl operation.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied.

> 
> And repeating what I said back in January when the other calls to
> secondary_ops were removed:
> 
> At that point secondary_ops would only be used by selinux_init() to save
> the original security_ops pointer for use by selinux_disable() to
> restore the original pointer, which ideally would be handled by the
> security framework instead (possibly by restoring a limited
> unregister_security() that resets to the default_security_ops).

It's listed in the TODO list:

http://selinuxproject.org/page/Kernel_Development

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
