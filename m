Subject: Re: [PATCH] SELinux: allow userspace to read policy back out of
 the kernel
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1280945513.21957.204.camel@moss-pluto.epoch.ncsc.mil>
References: <20100803181900.30719.37674.stgit@paris.rdu.redhat.com>
	 <1280945513.21957.204.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 16:29:36 -0400
Message-ID: <1280953776.23348.28.camel@dhcp231-200.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-08-04 at 14:11 -0400, Stephen Smalley wrote:
> On Tue, 2010-08-03 at 14:19 -0400, Eric Paris wrote:
> > There is interest in being able to see what the actual policy is that was
> > loaded into the kernel.  The patch creates a new selinuxfs file
> > /selinux/policy which can be read by userspace.  The actual policy that is
> > loaded into the kernel will be written back out to userspace.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 79a1bb6..f2296ba 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -296,6 +299,97 @@ static const struct file_operations sel_mls_ops = {
> >  	.llseek		= generic_file_llseek,
> >  };
> >  
> > +struct policy_load_memory {
> > +	size_t len;
> > +	void *data;
> > +};
> > +
> > +static int sel_open_policy(struct inode *inode, struct file *filp)
> > +{
> > +	struct policy_load_memory *plm = NULL;
> > +	int rc;
> > +
> > +	BUG_ON(filp->private_data);
> > +
> > +	mutex_lock(&sel_mutex);
> > +
> > +	rc = task_has_security(current, SECURITY__READ_POLICY);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc = -EBUSY;
> > +	if (policy_opened)
> > +		goto err;
> > +
> > +	policy_opened = 1;
> 
> Either don't set this flag until you've successfully completed
> security_read_policy(), or clear it on the err path.  Otherwise a failed
> attempt to open will leave it in an un-openable state.  Since you are
> taking sel_mutex around the entire operation, you can defer setting the
> flag until you're done without risking another one starting.

deferred.

> > +int security_read_policy(void **data, ssize_t *len)
> > +{
> > +	int rc;
> > +	struct policy_file fp;
> > +
> > +	if (!ss_initialized)
> > +		return -EINVAL;
> > +
> > +	read_lock(&policy_rwlock);
> > +	*len = security_policydb_len();
> > +	read_unlock(&policy_rwlock);
> 
> I don't think there is any benefit to taking the read-lock since you are
> just reading a single word.  And if the read-lock was needed, then it
> ought to be taken inside of security_policydb_len() rather than in the
> caller so that it is properly taken by all callers.  

I decided to push it down to security_policydb_len() since I want to
make sure we keep locking around the static policydb variable as best we
can.  (In case I ever revive my/KaiGai? 's series which makes it a
pointer)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
