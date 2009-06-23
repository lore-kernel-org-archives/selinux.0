Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5NJvAG6004690
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 15:57:10 -0400
Received: from e32.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5NJvfCG026775
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 19:57:41 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NJrIcH030563
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:53:18 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5NJv1sc182904
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:57:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5NJux4A015498
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:57:00 -0600
Date: Tue, 23 Jun 2009 14:57:03 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
Message-ID: <20090623195703.GA25469@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com> <1245779751.27538.14.camel@localhost.localdomain> <20090623181810.GA23644@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090623181810.GA23644@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> > On Fri, 2009-06-19 at 20:32 -0500, Serge E. Hallyn wrote:
> > > diff --git a/ipc/checkpoint_msg.c b/ipc/checkpoint_msg.c
> > > index 51385b0..ca55339 100644
> > > --- a/ipc/checkpoint_msg.c
> > > +++ b/ipc/checkpoint_msg.c
> > <snip>
> > > @@ -175,11 +183,26 @@ static int load_ipc_msg_hdr(struct ckpt_ctx *ctx,
> > >  			    struct msg_queue *msq)
> > >  {
> > >  	int ret = 0;
> > > +	int secid = 0;
> > >  
> > >  	ret = restore_load_ipc_perms(&h->perms, &msq->q_perm);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > +	if (h->perms.secref) {
> > > +		struct sec_store *s;
> > > +		s = ckpt_obj_fetch(ctx, h->perms.secref, CKPT_OBJ_SECURITY);
> > > +		if (IS_ERR(s))
> > > +			return PTR_ERR(s);
> > > +		secid = s->secid;
> > > +	}
> > > +	ret = security_msg_queue_alloc(msq);
> > > +	if (ret)
> > > +		return ret;
> > > +	ret = security_msg_queue_restore(msq, secid);
> > > +	if (ret < 0)
> > > +		return ret;
> > 
> > I don't think you want to call security_msg_queue_alloc() here, as that
> > both allocates the security struct and performs the create check.  So I
> > would just call the _restore() function, and let it internally call
> > ipc_alloc_security() to allocate the struct but then apply its own
> > distinct restore check.  Likewise for the rest of them.
> 
> Ok, will change that.

Hmm, but that means that if there is some new LSM which allocates memory
in security_msg_queue_alloc(), but which does not define
security_msg_queue_restore() (for some stupid reason), it'll end up
causing a bug.

It's something we can certainly catch through code review, but do we
want to set such a scenario up at all?

Speaking just for SELinux, the security_msg_queue_alloc() hook would
return -EPERM only if the task calling sys_restart() wasn't allowed
to create a msg queue with its own type, right?  Is that something
which is often disallowed?

I suppose we could have the default (cap_msg_queue_restore) call
security_ops->msg_queue_alloc() - feels frail, but maybe it's ok...

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
