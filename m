Message-ID: <52566.166.196.188.15.1234568677.squirrel@webmail.umbc.edu>
In-Reply-To: <1234556555.24702.242.camel@localhost.localdomain>
References: <20090212200059.25810.72120.stgit@paris.rdu.redhat.com>
    <20090212200104.25810.9927.stgit@paris.rdu.redhat.com>
    <1234556555.24702.242.camel@localhost.localdomain>
Date: Fri, 13 Feb 2009 18:44:37 -0500 (EST)
Subject: Re: [PATCH -v2 2/3] SELinux: call capabilities code directory
From: hmarti2@umbc.edu
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Eric Paris" <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        paul.moore@hp.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen (Neil, Tony),

I keep following this, hoping it's going to be able to 'step up' for
things, but it just
seems to be always 'not ready for primetime'. Any idea when it'll be ready
to be
shown to us? r/HAL


 On Thu, 2009-02-12 at 15:01 -0500, Eric Paris wrote:
>> For cleanliness and efficiency remove all calls to secondary-> and
>> instead
>> call capabilities code directly.  capabilities are the only module that
>> selinux stacks with and so the code should not indicate that other
>> stacking
>> might be possible.
>>
>> Signed-off-by: Eric Paris <eparis@redhat.com>
>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
>> ---
>>
>>  security/selinux/hooks.c |   30 +++++++++++++-----------------
>>  1 files changed, 13 insertions(+), 17 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 44f2170..e733fc1 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -1863,7 +1863,7 @@ static int selinux_ptrace_may_access(struct
>> task_struct *child,
>>  {
>>  	int rc;
>>
>> -	rc = secondary_ops->ptrace_may_access(child, mode);
>> +	rc = cap_ptrace_may_access(child, mode);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -1880,7 +1880,7 @@ static int selinux_ptrace_traceme(struct
>> task_struct *parent)
>>  {
>>  	int rc;
>>
>> -	rc = secondary_ops->ptrace_traceme(parent);
>> +	rc = cap_ptrace_traceme(parent);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -1896,7 +1896,7 @@ static int selinux_capget(struct task_struct
>> *target, kernel_cap_t *effective,
>>  	if (error)
>>  		return error;
>>
>> -	return secondary_ops->capget(target, effective, inheritable,
>> permitted);
>> +	return cap_capget(target, effective, inheritable, permitted);
>>  }
>>
>>  static int selinux_capset(struct cred *new, const struct cred *old,
>> @@ -1906,7 +1906,7 @@ static int selinux_capset(struct cred *new, const
>> struct cred *old,
>>  {
>>  	int error;
>>
>> -	error = secondary_ops->capset(new, old,
>> +	error = cap_capset(new, old,
>>  				      effective, inheritable, permitted);
>>  	if (error)
>>  		return error;
>> @@ -1929,7 +1929,7 @@ static int selinux_capable(struct task_struct
>> *tsk, const struct cred *cred,
>>  {
>>  	int rc;
>>
>> -	rc = secondary_ops->capable(tsk, cred, cap, audit);
>> +	rc = cap_capable(tsk, cred, cap, audit);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -2055,7 +2055,7 @@ static int selinux_syslog(int type)
>>  {
>>  	int rc;
>>
>> -	rc = secondary_ops->syslog(type);
>> +	rc = cap_syslog(type);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -2086,10 +2086,6 @@ static int selinux_syslog(int type)
>>   * mapping. 0 means there is enough memory for the allocation to
>>   * succeed and -ENOMEM implies there is not.
>>   *
>> - * Note that secondary_ops->capable and task_has_perm_noaudit return 0
>> - * if the capability is granted, but __vm_enough_memory requires 1 if
>> - * the capability is granted.
>> - *
>>   * Do not audit the selinux permission check, as this is applied to all
>>   * processes that allocate mappings.
>>   */
>> @@ -2116,7 +2112,7 @@ static int selinux_bprm_set_creds(struct
>> linux_binprm *bprm)
>>  	struct inode *inode = bprm->file->f_path.dentry->d_inode;
>>  	int rc;
>>
>> -	rc = secondary_ops->bprm_set_creds(bprm);
>> +	rc = cap_bprm_set_creds(bprm);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -2233,7 +2229,7 @@ static int selinux_bprm_secureexec(struct
>> linux_binprm *bprm)
>>  					PROCESS__NOATSECURE, NULL);
>>  	}
>>
>> -	return (atsecure || secondary_ops->bprm_secureexec(bprm));
>> +	return (atsecure || cap_bprm_secureexec(bprm));
>>  }
>>
>>  extern struct vfsmount *selinuxfs_mount;
>> @@ -3334,7 +3330,7 @@ static int selinux_task_setnice(struct task_struct
>> *p, int nice)
>>  {
>>  	int rc;
>>
>> -	rc = secondary_ops->task_setnice(p, nice);
>> +	rc = cap_task_setnice(p, nice);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -3345,7 +3341,7 @@ static int selinux_task_setioprio(struct
>> task_struct *p, int ioprio)
>>  {
>>  	int rc;
>>
>> -	rc = secondary_ops->task_setioprio(p, ioprio);
>> +	rc = cap_task_setioprio(p, ioprio);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -3375,7 +3371,7 @@ static int selinux_task_setscheduler(struct
>> task_struct *p, int policy, struct s
>>  {
>>  	int rc;
>>
>> -	rc = secondary_ops->task_setscheduler(p, policy, lp);
>> +	rc = cap_task_setscheduler(p, policy, lp);
>>  	if (rc)
>>  		return rc;
>>
>> @@ -4633,7 +4629,7 @@ static int selinux_netlink_send(struct sock *sk,
>> struct sk_buff *skb)
>>  {
>>  	int err;
>>
>> -	err = secondary_ops->netlink_send(sk, skb);
>> +	err = cap_netlink_send(sk, skb);
>>  	if (err)
>>  		return err;
>>
>> @@ -4648,7 +4644,7 @@ static int selinux_netlink_recv(struct sk_buff
>> *skb, int capability)
>>  	int err;
>>  	struct avc_audit_data ad;
>>
>> -	err = secondary_ops->netlink_recv(skb, capability);
>> +	err = cap_netlink_recv(skb, capability);
>>  	if (err)
>>  		return err;
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
> --
> Stephen Smalley
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
