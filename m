Subject: Re: [RFC PATCH v3 5/5] selinux: introduce kdbus access controls
To: Paul Moore <pmoore@redhat.com>, linux-security-module@vger.kernel.org,
 linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230848.7823.68726.stgit@localhost>
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5617D7D6.1090608@tycho.nsa.gov>
Date: Fri, 9 Oct 2015 11:05:58 -0400
MIME-Version: 1.0
In-Reply-To: <20151007230848.7823.68726.stgit@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/07/2015 07:08 PM, Paul Moore wrote:
> Add the SELinux access control implementation for the new kdbus LSM
> hooks using the new kdbus object class and the following permissions:
>
>   [NOTE: permissions below are based on kdbus code from Aug 2015]
>
>   * kdbus:impersonate
>     Send a different security label to kdbus peers.
>   * kdbus:fakecreds
>     Send different DAC credentials to kdbus peers.
>   * kdbus:fakepids
>     Send a different PID to kdbus peers.
>   * kdbus:owner
>     Act as a kdbus bus owner.
>   * kdbus:privileged
>     Act as a privileged endpoint.
>   * kdbus:activator
>     Act as a kdbus activator.
>   * kdbus:monitor
>     Act as a kdbus monitor.
>   * kdbus:policy_holder
>     Act as a kdbus policy holder.
>   * kdbus:connect
>     Create a new kdbus connection.
>   * kdbus:own
>     Own a kdbus service name.
>   * kdbus:talk
>     Talk between two kdbus endpoints.
>   * kdbus:see
>     See another kdbus endpoint.
>   * kdbus:see_name
>     See a kdbus service name.
>   * kdbus:see_notification
>     See a kdbus notification.
>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
>
> ---
> ChangeLog:
> - v3
>   * Ported to the 4.3-rc4 based kdbus tree
>   * Fix the missing NULL terminator in the kdbus obj class definition
> - v2
>   * Add the selinux_kdbus_init_inode() hook
>   * Add some very basic info on the permissions to the description
>   * Add kdbus service name auditing in the AVC records
> - v1
>   * Initial draft
> ---
>   security/selinux/hooks.c            |  153 +++++++++++++++++++++++++++++++++++
>   security/selinux/include/classmap.h |    4 +
>   2 files changed, 155 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e4369d8..5581990 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -9,8 +9,10 @@
>    *	      James Morris <jmorris@redhat.com>
>    *
>    *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
> - *  Copyright (C) 2003-2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
> - *					   Eric Paris <eparis@redhat.com>
> + *  Copyright (C) 2003-2008,2015 Red Hat, Inc.
> + *					James Morris <jmorris@redhat.com>
> + *					Eric Paris <eparis@redhat.com>
> + *					Paul Moore <paul@paul-moore.com>
>    *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
>    *			    <dgoeddel@trustedcs.com>
>    *  Copyright (C) 2006, 2007, 2009 Hewlett-Packard Development Company, L.P.
> @@ -2035,6 +2037,143 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>   			    &ad);
>   }
>
> +static int selinux_kdbus_conn_new(const struct cred *creds,
> +				  const struct kdbus_creds *fake_creds,
> +				  const struct kdbus_pids *fake_pids,
> +				  const char *fake_seclabel,
> +				  bool owner, bool privileged,
> +				  bool is_activator, bool is_monitor,
> +				  bool is_policy_holder)
> +{
> +	int rc;
> +	u32 tsid = current_sid();
> +	u32 av = KDBUS__CONNECT;
> +
> +	if (fake_creds)
> +		av |= KDBUS__FAKECREDS;
> +	if (fake_pids)
> +		av |= KDBUS__FAKEPIDS;
> +	if (owner)
> +		av |= KDBUS__OWNER;
> +	if (privileged)
> +		av |= KDBUS__PRIVILEGED;
> +	if (is_activator)
> +		av |= KDBUS__ACTIVATOR;
> +	if (is_monitor)
> +		av |= KDBUS__MONITOR;
> +	if (is_policy_holder)
> +		av |= KDBUS__POLICY_HOLDER;
> +
> +	rc = avc_has_perm(tsid, cred_sid(creds), SECCLASS_KDBUS, av, NULL);
> +	if (rc)
> +		return rc;
> +
> +	if (fake_seclabel) {
> +		u32 sid;
> +		if (security_context_to_sid(fake_seclabel,
> +					    strlen(fake_seclabel),
> +					    &sid, GFP_KERNEL))
> +			return -EINVAL;
> +
> +		rc = avc_has_perm(tsid, sid,
> +				  SECCLASS_KDBUS, KDBUS__IMPERSONATE, NULL);
> +	}
> +
> +	return rc;
> +}
> +
> +static int selinux_kdbus_own_name(const struct cred *creds, const char *name)
> +{
> +	int rc;
> +	u32 name_sid;
> +	struct common_audit_data ad;
> +
> +	rc = security_kdbus_sid(name, &name_sid);
> +	if (rc)
> +		return rc;
> +
> +	ad.type = LSM_AUDIT_DATA_KDBUS;
> +	ad.u.kdbus_name = name;
> +
> +	return avc_has_perm(cred_sid(creds), name_sid,
> +			    SECCLASS_KDBUS, KDBUS__OWN, &ad);
> +}
> +
> +static int selinux_kdbus_conn_talk(const struct cred *creds,
> +				   const struct cred *creds_to)
> +{
> +	return avc_has_perm(cred_sid(creds), cred_sid(creds_to),
> +			    SECCLASS_KDBUS, KDBUS__TALK, NULL);
> +}
> +
> +static int selinux_kdbus_conn_see(const struct cred *creds,
> +				  const struct cred *creds_whom)
> +{
> +	return avc_has_perm(cred_sid(creds), cred_sid(creds_whom),
> +			    SECCLASS_KDBUS, KDBUS__SEE, NULL);
> +}
> +
> +static int selinux_kdbus_conn_see_name(const struct cred *creds,
> +				       const char *name)
> +{
> +	int rc;
> +	u32 name_sid;
> +	struct common_audit_data ad;
> +
> +	rc = security_kdbus_sid(name, &name_sid);
> +	if (rc)
> +		return rc;
> +
> +	ad.type = LSM_AUDIT_DATA_KDBUS;
> +	ad.u.kdbus_name = name;
> +
> +	return avc_has_perm(cred_sid(creds), name_sid,
> +			    SECCLASS_KDBUS, KDBUS__SEE_NAME, &ad);
> +}
> +
> +static int selinux_kdbus_conn_see_notification(const struct cred *creds)
> +{
> +	return avc_has_perm(SECINITSID_KERNEL, cred_sid(creds),
> +			    SECCLASS_KDBUS, KDBUS__SEE_NOTIFICATION, NULL);
> +}
> +
> +static int selinux_kdbus_proc_permission(const struct cred *creds,
> +					 struct pid *pid)
> +{
> +	int rc;
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	task = pid_task(pid, PIDTYPE_PID);
> +	rc = avc_has_perm(cred_sid(creds), task_sid(task),
> +			  SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
> +	rcu_read_unlock();
> +
> +	return rc;
> +}
> +
> +static int selinux_kdbus_init_inode(struct inode *inode,
> +				    const struct cred *creds)
> +{
> +	struct inode_security_struct *isec = inode->i_security;
> +	u32 sid = cred_sid(creds);
> +
> +	/* XXX - this is very simple, e.g. no transitions, no special object
> +	 *       class, etc. since this inode is basically an IPC socket ...
> +	 *       however, is this too simple?  do we want transitions?  if we
> +	 *       do, we should do the transition in kdbus_node_init() and not
> +	 *       here so that endpoint is labeled correctly and not just this
> +	 *       inode */
> +
> +	isec->inode = inode;
> +	isec->task_sid = sid;
> +	isec->sid = sid;
> +	isec->sclass = SECCLASS_FILE;
> +	isec->initialized = 1;

These are used for files exposed in the filesystem namespace, unlike 
sockets (sockfs can't be mounted by userspace, and the socket objects 
themselves have their own class, so there is no ambiguity).  Currently 
the only such files that are labeled with the same SID as the associated 
task are /proc files.  So if we label the kdbusfs files with the same 
SID, then you can't allow read/write to kdbusfs nodes owned by another 
task without also exposing its /proc/pid files in the same manner. 
Doubt we want that.  Probably should compute a transition from the task 
SID and the kdbusfs SID.

> +
> +	return 0;
> +}
> +
