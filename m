From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1 1/3] lsm: introduce hooks for kdbus
Date: Fri, 25 Sep 2015 18:09:59 -0400
Message-ID: <1943242.lSlvmFOviS@sifl>
In-Reply-To: <56041D53.3090806@tycho.nsa.gov>
References: <20150923213043.25616.43422.stgit@localhost>
 <20150923214413.25616.29131.stgit@localhost> <56041D53.3090806@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, September 24, 2015 11:57:07 AM Stephen Smalley wrote:
> On 09/23/2015 05:44 PM, Paul Moore wrote:

...

> > diff --git a/ipc/kdbus/connection.c b/ipc/kdbus/connection.c
> > index ef63d65..be8d210 100644
> > --- a/ipc/kdbus/connection.c
> > +++ b/ipc/kdbus/connection.c
> > @@ -26,6 +26,7 @@
> > 
> >  #include <linux/path.h>
> >  #include <linux/poll.h>
> >  #include <linux/sched.h>
> > 
> > +#include <linux/security.h>
> > 
> >  #include <linux/shmem_fs.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> > 
> > @@ -213,6 +214,13 @@ static struct kdbus_conn *kdbus_conn_new(struct
> > kdbus_ep *ep,> 
> >  			goto exit_unref;
> >  	
> >  	}
> > 
> > +	ret = security_kdbus_conn_new(conn->cred, creds, pids, seclabel,
> > +				      owner, privileged,
> > +				      is_activator, is_monitor,
> > +				      is_policy_holder);
> > +	if (ret < 0)
> > +		goto exit_unref;
> > +
> 
> I think this could be moved up much earlier ...

All good suggestions, thank you.  I've incorporated all your suggestions into 
the patchset, I'll send a new version once I've addressed a few other things.

> > diff --git a/ipc/kdbus/metadata.c b/ipc/kdbus/metadata.c
> > index 71ca475..07c45d7 100644
> > --- a/ipc/kdbus/metadata.c
> > +++ b/ipc/kdbus/metadata.c
> > @@ -1182,11 +1182,9 @@ static unsigned int kdbus_proc_permission(const
> > struct pid_namespace *pid_ns,> 
> >  					  const struct cred *cred,
> >  					  struct pid *target)
> >  
> >  {
> > 
> > -	if (pid_ns->hide_pid < 1)
> > -		return KDBUS_META_PROC_NORMAL;
> > -
> > 
> >  	/* XXX: we need groups_search() exported for aux-groups */
> > 
> > -	if (gid_eq(cred->egid, pid_ns->pid_gid))
> > +	if ((pid_ns->hide_pid < 1 || gid_eq(cred->egid, pid_ns->pid_gid)) &&
> > +	    security_kdbus_proc_permission(cred, target) == 0)
> > 
> >  		return KDBUS_META_PROC_NORMAL;
> 
> Not your fault, but I have to wonder why this function can't just return
> a bool like the policy functions; it has only two return values.  Hardly
> worth an enum.

Agreed, I wondered about that too, however, in the interest of keep things 
small and focused I'm going to stay away from changing it.

-- 
paul moore
security @ redhat
