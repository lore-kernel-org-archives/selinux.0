Message-ID: <1507223056.27146.17.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Thu, 05 Oct 2017 13:04:16 -0400
In-Reply-To: <1507218567.27146.16.camel@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-10-sds@tycho.nsa.gov>
 <1507217234.27146.14.camel@tycho.nsa.gov>
 <1507218567.27146.16.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 09/10] selinux: add a selinuxfs interface to unshare
 selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-10-05 at 11:49 -0400, Stephen Smalley wrote:
> On Thu, 2017-10-05 at 11:27 -0400, Stephen Smalley wrote:
> > On Mon, 2017-10-02 at 11:58 -0400, Stephen Smalley wrote:
> > > Provide a userspace API to unshare the selinux namespace.
> > > Currently implemented via a selinuxfs node. This could be
> > > coupled with unsharing of other namespaces (e.g.  mount
> > > namespace,
> > > network namespace) that will always be needed or left
> > > independent.
> > > Don't get hung up on the interface itself, it is just to allow
> > > experimentation and testing.
> > > 
> > > Sample usage:
> > > echo 1 > /sys/fs/selinux/unshare
> > > unshare -m -n
> > > umount /sys/fs/selinux
> > > mount -t selinuxfs none /sys/fs/selinux
> > > load_policy
> > > getenforce
> > > id
> > > echo $$
> > 
> > For added fun, you can do the following after unsharing and loading
> > a
> > policy into your namespace above:
> > # Transition from kernel context to an unconfined context.
> > runcon unconfined_u:unconfined_u:unconfined_t:s0:c0.c1023 /bin/bash

That should be:
runcon unconfined_u:unconfined_r:unconfined_t:s0:c0.c1023 /bin/bash


> > # Allow use of file descriptors inherited from the parent
> > namespace,
> > e.g the pty.
> > cat <<EOF > allowunlabeledfd.cil
> > (allow domain unlabeled_t (fd (use)))
> > EOF
> > semodule -i allowunlabeledfd.cil
> 
> Also:
> restorecon -R /dev
> to fix up the /dev node contexts in your namespace.
> 
> > # Switch namespace to enforcing mode
> > setenforce 1
> > # Run the selinux testsuite
> > cd /path/to/selinux-testsuite
> > make test
> > 
> > inet_socket test failures are expected due to running in a non-init
> > network namespace; they don't work even without unsharing the
> > selinux
> > namespace.
> > 
> > > 
> > > The above will show that the process now views itself as running
> > > in
> > > the
> > > kernel domain in permissive mode, as would be the case at boot.
> > > > From a different shell on the host system, running ps -eZ or
> > > 
> > > cat /proc/<pid>/attr/current will show that the process that
> > > unshared its selinux namespace is still running in its original
> > > context in the initial namespace, and getenforce will show the
> > > the initial namespace remains enforcing.  Enforcing mode or
> > > policy
> > > changes in the child will not affect the parent.
> > > 
> > > This is not yet safe; do not use on production systems.
> > > Known issues include at least the following items:
> > > 
> > > * The policy loading code has not been thoroughly audited
> > > and hardened for use by unprivileged code, both with respect to
> > > ensuring that the policy is internally consistent and restricting
> > > the range of values used from the policy as loop bounds and
> > > memory
> > > allocation sizes to sane limits.
> > > 
> > > * The SELinux hook functions have not been modified to be
> > > namespace-aware, so the hooks only perform checking against the
> > > current namespace.  Thus, unsharing allows the process to escape
> > > confinement by the parent.  Fixing this requires updating each
> > > hook
> > > to
> > > perform its processing on the current namespace and all of its
> > > ancestors
> > > up to the init namespace.
> > > 
> > > * Some of the hook functions can be called outside of process
> > > context
> > > (e.g. task_kill, send_sigiotask, network input/forward) and
> > > should
> > > not use
> > > the current task's selinux namespace. These hooks need to be
> > > updated
> > > to
> > > obtain the proper selinux namespace to use instead from the
> > > caller
> > > or
> > > cached in a suitable data structure (e.g. the file or sock
> > > security
> > > structures).
> > > 
> > > * There are number of issues with the inode and superblock
> > > security
> > > blob
> > > handling for multiple namespaces, see those commits for more
> > > details.
> > > 
> > > * Only a subset of object security blobs have been updated to
> > > be namespace-aware and support multiple namespaces.  The ones
> > > that
> > > have not yet been updated could end up performing permission
> > > checks
> > > or
> > > other operations on SIDs created in a different selinux
> > > namespace.
> > > 
> > > * The network SID caches (netif, netnode, netport) have not yet
> > > been instantiated per selinux namespace, unlike the AVC and SS.
> > > 
> > > * There is no way currently to restrict or bound nesting of
> > > namespaces; if you allow it to a domain in the init namespace,
> > > then that domain can in turn unshare to arbitrary depths and can
> > > grant the same to any domain in its own policy.  Related to this
> > > is the fact that there is no way to control resource usage due to
> > > selinux namespaces and they can be substantial (per-namespace
> > > policydb, sidtab, AVC, etc).
> > > 
> > > * SIDs may be cached by audit and networking code and in external
> > > kernel data structures and used later, potentially in a different
> > > selinux namespace than the one in which the SID was originally
> > > created.
> > > 
> > > * No doubt other things I'm forgetting or haven't thought of.
> > > Use at your own risk.
> > > 
> > > Not-signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > ---
> > >  security/selinux/include/classmap.h |  3 +-
> > >  security/selinux/selinuxfs.c        | 66
> > > +++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 68 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/selinux/include/classmap.h
> > > b/security/selinux/include/classmap.h
> > > index 35ffb29..82c8f9c 100644
> > > --- a/security/selinux/include/classmap.h
> > > +++ b/security/selinux/include/classmap.h
> > > @@ -39,7 +39,8 @@ struct security_class_mapping secclass_map[] =
> > > {
> > >  	  { "compute_av", "compute_create", "compute_member",
> > >  	    "check_context", "load_policy", "compute_relabel",
> > >  	    "compute_user", "setenforce", "setbool",
> > > "setsecparam",
> > > -	    "setcheckreqprot", "read_policy", "validate_trans",
> > > NULL
> > > } },
> > > +	    "setcheckreqprot", "read_policy", "validate_trans",
> > > "unshare",
> > > +	    NULL } },
> > >  	{ "process",
> > >  	  { "fork", "transition", "sigchld", "sigkill",
> > >  	    "sigstop", "signull", "signal", "ptrace",
> > > "getsched",
> > > "setsched",
> > > diff --git a/security/selinux/selinuxfs.c
> > > b/security/selinux/selinuxfs.c
> > > index a7e6bdb..dedb3cc9 100644
> > > --- a/security/selinux/selinuxfs.c
> > > +++ b/security/selinux/selinuxfs.c
> > > @@ -63,6 +63,7 @@ enum sel_inos {
> > >  	SEL_STATUS,	/* export current status using mmap()
> > > */
> > >  	SEL_POLICY,	/* allow userspace to read the in
> > > kernel
> > > policy */
> > >  	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
> > > +	SEL_UNSHARE,	    /* unshare selinux namespace */
> > >  	SEL_INO_NEXT,	/* The next inode number to use */
> > >  };
> > >  
> > > @@ -321,6 +322,70 @@ static const struct file_operations
> > > sel_disable_ops = {
> > >  	.llseek		= generic_file_llseek,
> > >  };
> > >  
> > > +static ssize_t sel_write_unshare(struct file *file, const char
> > > __user *buf,
> > > +				 size_t count, loff_t *ppos)
> > > +
> > > +{
> > > +	struct selinux_fs_info *fsi = file_inode(file)->i_sb-
> > > > s_fs_info;
> > > 
> > > +	struct selinux_ns *ns = fsi->ns;
> > > +	char *page;
> > > +	ssize_t length;
> > > +	bool set;
> > > +	int rc;
> > > +
> > > +	if (count >= PAGE_SIZE)
> > > +		return -ENOMEM;
> > > +
> > > +	/* No partial writes. */
> > > +	if (*ppos != 0)
> > > +		return -EINVAL;
> > > +
> > > +	rc = avc_has_perm(current_selinux_ns, current_sid(),
> > > +			  SECINITSID_SECURITY,
> > > SECCLASS_SECURITY,
> > > +			  SECURITY__UNSHARE, NULL);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	page = memdup_user_nul(buf, count);
> > > +	if (IS_ERR(page))
> > > +		return PTR_ERR(page);
> > > +
> > > +	length = -EINVAL;
> > > +	if (kstrtobool(page, &set))
> > > +		goto out;
> > > +
> > > +	if (set) {
> > > +		struct cred *cred = prepare_creds();
> > > +		struct task_security_struct *tsec;
> > > +
> > > +		if (!cred) {
> > > +			length = -ENOMEM;
> > > +			goto out;
> > > +		}
> > > +		tsec = cred->security;
> > > +		if (selinux_ns_create(ns, &tsec->ns)) {
> > > +			abort_creds(cred);
> > > +			length = -ENOMEM;
> > > +			goto out;
> > > +		}
> > > +		tsec->osid = tsec->sid = SECINITSID_KERNEL;
> > > +		tsec->exec_sid = tsec->create_sid = tsec-
> > > > keycreate_sid =
> > > 
> > > +			tsec->sockcreate_sid = SECSID_NULL;
> > > +		tsec->parent_cred = get_current_cred();
> > > +		commit_creds(cred);
> > > +	}
> > > +
> > > +	length = count;
> > > +out:
> > > +	kfree(page);
> > > +	return length;
> > > +}
> > > +
> > > +static const struct file_operations sel_unshare_ops = {
> > > +	.write		= sel_write_unshare,
> > > +	.llseek		= generic_file_llseek,
> > > +};
> > > +
> > >  static ssize_t sel_read_policyvers(struct file *filp, char
> > > __user
> > > *buf,
> > >  				   size_t count, loff_t *ppos)
> > >  {
> > > @@ -1923,6 +1988,7 @@ static int sel_fill_super(struct
> > > super_block
> > > *sb, void *data, int silent)
> > >  		[SEL_POLICY] = {"policy", &sel_policy_ops,
> > > S_IRUGO},
> > >  		[SEL_VALIDATE_TRANS] = {"validatetrans",
> > > &sel_transition_ops,
> > >  					S_IWUGO},
> > > +		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops,
> > > 0222},
> > >  		/* last one */ {""}
> > >  	};
> > >  
