Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5OM7dcD007534
	for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2009 18:07:39 -0400
Received: from e31.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5OM8AKe019629
	for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2009 22:08:11 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5OM306M005835
	for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2009 16:03:00 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5OM7XtW257808
	for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2009 16:07:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5OM7WH8031921
	for <selinux@tycho.nsa.gov>; Wed, 24 Jun 2009 16:07:33 -0600
Date: Wed, 24 Jun 2009 17:07:36 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
Message-ID: <20090624220736.GA21134@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com> <1245779751.27538.14.camel@localhost.localdomain> <20090623181810.GA23644@us.ibm.com> <20090623195703.GA25469@us.ibm.com> <1245849008.9669.13.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245849008.9669.13.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> On Tue, 2009-06-23 at 14:57 -0500, Serge E. Hallyn wrote:
> > Quoting Serge E. Hallyn (serue@us.ibm.com):
> > > Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> > > > On Fri, 2009-06-19 at 20:32 -0500, Serge E. Hallyn wrote:
> > > > > diff --git a/ipc/checkpoint_msg.c b/ipc/checkpoint_msg.c
> > > > > index 51385b0..ca55339 100644
> > > > > --- a/ipc/checkpoint_msg.c
> > > > > +++ b/ipc/checkpoint_msg.c
> > > > <snip>
> > > > > @@ -175,11 +183,26 @@ static int load_ipc_msg_hdr(struct ckpt_ctx *ctx,
> > > > >  			    struct msg_queue *msq)
> > > > >  {
> > > > >  	int ret = 0;
> > > > > +	int secid = 0;
> > > > >  
> > > > >  	ret = restore_load_ipc_perms(&h->perms, &msq->q_perm);
> > > > >  	if (ret < 0)
> > > > >  		return ret;
> > > > >  
> > > > > +	if (h->perms.secref) {
> > > > > +		struct sec_store *s;
> > > > > +		s = ckpt_obj_fetch(ctx, h->perms.secref, CKPT_OBJ_SECURITY);
> > > > > +		if (IS_ERR(s))
> > > > > +			return PTR_ERR(s);
> > > > > +		secid = s->secid;
> > > > > +	}
> > > > > +	ret = security_msg_queue_alloc(msq);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +	ret = security_msg_queue_restore(msq, secid);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > 
> > > > I don't think you want to call security_msg_queue_alloc() here, as that
> > > > both allocates the security struct and performs the create check.  So I
> > > > would just call the _restore() function, and let it internally call
> > > > ipc_alloc_security() to allocate the struct but then apply its own
> > > > distinct restore check.  Likewise for the rest of them.
> > > 
> > > Ok, will change that.
> > 
> > Hmm, but that means that if there is some new LSM which allocates memory
> > in security_msg_queue_alloc(), but which does not define
> > security_msg_queue_restore() (for some stupid reason), it'll end up
> > causing a bug.
> > 
> > It's something we can certainly catch through code review, but do we
> > want to set such a scenario up at all?
> > 
> > Speaking just for SELinux, the security_msg_queue_alloc() hook would
> > return -EPERM only if the task calling sys_restart() wasn't allowed
> > to create a msg queue with its own type, right?  Is that something
> > which is often disallowed?
> 
> Certainly some program domains lack permission to create ipc objects.
> The ipc _alloc hooks are unusual in that they combine both allocation
> and create checking unlike the rest of the object alloc hooks.  I think
> that was discussed at the time, but people didn't want two different
> hook calls at the same call site.

Oh, no.  I wasn't thinking right.

The objects are actually restored through calls to do_shmget() etc,
so that security_xyz_alloc() already gets called.

So I think we'll just leave it as is right now, acknowledging that
it might become problematic if we want to confine a restart_t domain
to be able to restore but not alloc any ipcs.  The actual ramifications
of that still somewhat escape me, but I do prefer having the common
helpers used whenever possible to recreate objects.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
