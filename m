To: Stephen Smalley <sds@tycho.nsa.gov>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
 <1504889003.30607.6.camel@tycho.nsa.gov>
Cc: James Morris <james.l.morris@oracle.com>, gregkh@linuxfoundation.org,
 serge@hallyn.com,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 linux-kernel@vger.kernel.org, SE-Linux <selinux@tycho.nsa.gov>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <f4591181-f94e-2122-bfc3-c656638d0bf4@canonical.com>
Date: Sat, 9 Sep 2017 00:14:24 -0700
MIME-Version: 1.0
In-Reply-To: <1504889003.30607.6.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [Fwd: [PATCH] usb, signal, security: only pass the cred,
 not the secid, to kill_pid_info_as_cred and security_task_kill]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/08/2017 09:43 AM, Stephen Smalley wrote:
> Sorry, meant to cc you on this.
> 
> -------- Forwarded Message --------
> From: Stephen Smalley <sds@tycho.nsa.gov>
> To: james.l.morris@oracle.com
> Cc: gregkh@linuxfoundation.org, serge@hallyn.com, paul@paul-moore.com, 
> casey@schaufler-ca.com, linux-security-module@vger.kernel.org, linux-ke
> rnel@vger.kernel.org, selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho
> .nsa.gov>
> Subject: [PATCH] usb,signal,security: only pass the cred, not the
> secid, to kill_pid_info_as_cred and security_task_kill
> Date: Fri,  8 Sep 2017 12:40:01 -0400
> 
> commit d178bc3a708f39cbfefc3fab37032d3f2511b4ec ("user namespace: usb:
>  make usb urbs user namespace aware (v2)") changed kill_pid_info_as_uid
> to kill_pid_info_as_cred, saving and passing a cred structure instead
> of
> uids.  Since the secid can be obtained from the cred, drop the secid
> fields
> from the usb_dev_state and async structures, and drop the secid
> argument to
> kill_pid_info_as_cred.  Replace the secid argument to
> security_task_kill
> with the cred.  Update SELinux, Smack, and AppArmor to use the cred,
> which
> avoids the need for Smack and AppArmor to use a secid at all in this
> hook.
> Further changes to Smack might still be required to take full advantage
> of
> this change, since it should now be possible to perform capability
> checking based on the supplied cred.  The changes to Smack and AppArmor
> have only been compile-tested.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

this looks good to me

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>  drivers/usb/core/devio.c     | 10 ++--------
>  include/linux/lsm_hooks.h    |  5 +++--
>  include/linux/sched/signal.h |  2 +-
>  include/linux/security.h     |  4 ++--
>  kernel/signal.c              |  6 +++---
>  security/apparmor/lsm.c      | 17 ++++++++++++-----
>  security/security.c          |  4 ++--
>  security/selinux/hooks.c     |  7 +++++--
>  security/smack/smack_lsm.c   | 12 +++++-------
>  9 files changed, 35 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index ebe2759..b44f74c 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -78,7 +78,6 @@ struct usb_dev_state {
>  	const struct cred *cred;
>  	void __user *disccontext;
>  	unsigned long ifclaimed;
> -	u32 secid;
>  	u32 disabled_bulk_eps;
>  	bool privileges_dropped;
>  	unsigned long interface_allowed_mask;
> @@ -108,7 +107,6 @@ struct async {
>  	struct usb_memory *usbm;
>  	unsigned int mem_usage;
>  	int status;
> -	u32 secid;
>  	u8 bulk_addr;
>  	u8 bulk_status;
>  };
> @@ -596,7 +594,6 @@ static void async_completed(struct urb *urb)
>  	struct usb_dev_state *ps = as->ps;
>  	struct siginfo sinfo;
>  	struct pid *pid = NULL;
> -	u32 secid = 0;
>  	const struct cred *cred = NULL;
>  	int signr;
>  
> @@ -612,7 +609,6 @@ static void async_completed(struct urb *urb)
>  		sinfo.si_addr = as->userurb;
>  		pid = get_pid(as->pid);
>  		cred = get_cred(as->cred);
> -		secid = as->secid;
>  	}
>  	snoop(&urb->dev->dev, "urb complete\n");
>  	snoop_urb(urb->dev, as->userurb, urb->pipe, urb-
>> actual_length,
> @@ -626,7 +622,7 @@ static void async_completed(struct urb *urb)
>  	spin_unlock(&ps->lock);
>  
>  	if (signr) {
> -		kill_pid_info_as_cred(sinfo.si_signo, &sinfo, pid,
> cred, secid);
> +		kill_pid_info_as_cred(sinfo.si_signo, &sinfo, pid,
> cred);
>  		put_pid(pid);
>  		put_cred(cred);
>  	}
> @@ -1023,7 +1019,6 @@ static int usbdev_open(struct inode *inode,
> struct file *file)
>  	init_waitqueue_head(&ps->wait);
>  	ps->disc_pid = get_pid(task_pid(current));
>  	ps->cred = get_current_cred();
> -	security_task_getsecid(current, &ps->secid);
>  	smp_wmb();
>  	list_add_tail(&ps->list, &dev->filelist);
>  	file->private_data = ps;
> @@ -1733,7 +1728,6 @@ static int proc_do_submiturb(struct usb_dev_state
> *ps, struct usbdevfs_urb *uurb
>  	as->ifnum = ifnum;
>  	as->pid = get_pid(task_pid(current));
>  	as->cred = get_current_cred();
> -	security_task_getsecid(current, &as->secid);
>  	snoop_urb(ps->dev, as->userurb, as->urb->pipe,
>  			as->urb->transfer_buffer_length, 0, SUBMIT,
>  			NULL, 0);
> @@ -2609,7 +2603,7 @@ static void usbdev_remove(struct usb_device
> *udev)
>  			sinfo.si_code = SI_ASYNCIO;
>  			sinfo.si_addr = ps->disccontext;
>  			kill_pid_info_as_cred(ps->discsignr, &sinfo,
> -					ps->disc_pid, ps->cred, ps-
>> secid);
> +					ps->disc_pid, ps->cred);
>  		}
>  	}
>  }
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ce02f76..b0b663b2 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -674,7 +674,8 @@
>   *	@p contains the task_struct for process.
>   *	@info contains the signal information.
>   *	@sig contains the signal value.
> - *	@secid contains the sid of the process where the signal
> originated
> + *	@cred contains the cred of the process where the signal
> originated, or
> + *	NULL if the current task is the originator.
>   *	Return 0 if permission is granted.
>   * @task_prctl:
>   *	Check permission before performing a process control
> operation on the
> @@ -1533,7 +1534,7 @@ union security_list_options {
>  	int (*task_getscheduler)(struct task_struct *p);
>  	int (*task_movememory)(struct task_struct *p);
>  	int (*task_kill)(struct task_struct *p, struct siginfo *info,
> -				int sig, u32 secid);
> +				int sig, const struct cred *cred);
>  	int (*task_prctl)(int option, unsigned long arg2, unsigned
> long arg3,
>  				unsigned long arg4, unsigned long
> arg5);
>  	void (*task_to_inode)(struct task_struct *p, struct inode
> *inode);
> diff --git a/include/linux/sched/signal.h
> b/include/linux/sched/signal.h
> index 2a0dd40..ae4fe12 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -290,7 +290,7 @@ extern int force_sig_info(int, struct siginfo *,
> struct task_struct *);
>  extern int __kill_pgrp_info(int sig, struct siginfo *info, struct pid
> *pgrp);
>  extern int kill_pid_info(int sig, struct siginfo *info, struct pid
> *pid);
>  extern int kill_pid_info_as_cred(int, struct siginfo *, struct pid *,
> -				const struct cred *, u32);
> +				const struct cred *);
>  extern int kill_pgrp(struct pid *pid, int sig, int priv);
>  extern int kill_pid(struct pid *pid, int sig, int priv);
>  extern __must_check bool do_notify_parent(struct task_struct *, int);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 458e24b..9655621 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -347,7 +347,7 @@ int security_task_setscheduler(struct task_struct
> *p);
>  int security_task_getscheduler(struct task_struct *p);
>  int security_task_movememory(struct task_struct *p);
>  int security_task_kill(struct task_struct *p, struct siginfo *info,
> -			int sig, u32 secid);
> +			int sig, const struct cred *cred);
>  int security_task_prctl(int option, unsigned long arg2, unsigned long
> arg3,
>  			unsigned long arg4, unsigned long arg5);
>  void security_task_to_inode(struct task_struct *p, struct inode
> *inode);
> @@ -1015,7 +1015,7 @@ static inline int security_task_movememory(struct
> task_struct *p)
>  
>  static inline int security_task_kill(struct task_struct *p,
>  				     struct siginfo *info, int sig,
> -				     u32 secid)
> +				     const struct cred *cred)
>  {
>  	return 0;
>  }
> diff --git a/kernel/signal.c b/kernel/signal.c
> index caed913..a397bb9 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -762,7 +762,7 @@ static int check_kill_permission(int sig, struct
> siginfo *info,
>  		}
>  	}
>  
> -	return security_task_kill(t, info, sig, 0);
> +	return security_task_kill(t, info, sig, NULL);
>  }
>  
>  /**
> @@ -1348,7 +1348,7 @@ static int kill_as_cred_perm(const struct cred
> *cred,
>  
>  /* like kill_pid_info(), but doesn't use uid/euid of "current" */
>  int kill_pid_info_as_cred(int sig, struct siginfo *info, struct pid
> *pid,
> -			 const struct cred *cred, u32 secid)
> +			 const struct cred *cred)
>  {
>  	int ret = -EINVAL;
>  	struct task_struct *p;
> @@ -1367,7 +1367,7 @@ int kill_pid_info_as_cred(int sig, struct siginfo
> *info, struct pid *pid,
>  		ret = -EPERM;
>  		goto out_unlock;
>  	}
> -	ret = security_task_kill(p, info, sig, secid);
> +	ret = security_task_kill(p, info, sig, cred);
>  	if (ret)
>  		goto out_unlock;
>  
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index cc5ab23..2fbec6d 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -718,16 +718,23 @@ static int apparmor_task_setrlimit(struct
> task_struct *task,
>  }
>  
>  static int apparmor_task_kill(struct task_struct *target, struct
> siginfo *info,
> -			      int sig, u32 secid)
> +			      int sig, const struct cred *cred)
>  {
>  	struct aa_label *cl, *tl;
>  	int error;
>  
> -	if (secid)
> -		/* TODO: after secid to label mapping is done.
> -		 *  Dealing with USB IO specific behavior
> +	if (cred) {
> +		/*
> +		 * Dealing with USB IO specific behavior
>  		 */
> -		return 0;
> +		cl = aa_get_newest_cred_label(cred);
> +		tl = aa_get_task_label(target);
> +		error = aa_may_signal(cl, tl, sig);
> +		aa_put_label(cl);
> +		aa_put_label(tl);
> +		return error;
> +	}
> +
>  	cl = __begin_current_label_crit_section();
>  	tl = aa_get_task_label(target);
>  	error = aa_may_signal(cl, tl, sig);
> diff --git a/security/security.c b/security/security.c
> index 55b5997..3b67842 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1118,9 +1118,9 @@ int security_task_movememory(struct task_struct
> *p)
>  }
>  
>  int security_task_kill(struct task_struct *p, struct siginfo *info,
> -			int sig, u32 secid)
> +			int sig, const struct cred *cred)
>  {
> -	return call_int_hook(task_kill, 0, p, info, sig, secid);
> +	return call_int_hook(task_kill, 0, p, info, sig, cred);
>  }
>  
>  int security_task_prctl(int option, unsigned long arg2, unsigned long
> arg3,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 45943e1..68bc634 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4041,16 +4041,19 @@ static int selinux_task_movememory(struct
> task_struct *p)
>  }
>  
>  static int selinux_task_kill(struct task_struct *p, struct siginfo
> *info,
> -				int sig, u32 secid)
> +				int sig, const struct cred *cred)
>  {
> +	u32 secid;
>  	u32 perm;
>  
>  	if (!sig)
>  		perm = PROCESS__SIGNULL; /* null signal; existence
> test */
>  	else
>  		perm = signal_to_av(sig);
> -	if (!secid)
> +	if (!cred)
>  		secid = current_sid();
> +	else
> +		secid = cred_sid(cred);
>  	return avc_has_perm(secid, task_sid(p), SECCLASS_PROCESS,
> perm, NULL);
>  }
>  
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 463af86..65fcede 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2259,15 +2259,13 @@ static int smack_task_movememory(struct
> task_struct *p)
>   * @p: the task object
>   * @info: unused
>   * @sig: unused
> - * @secid: identifies the smack to use in lieu of current's
> + * @cred: identifies the cred to use in lieu of current's
>   *
>   * Return 0 if write access is permitted
>   *
> - * The secid behavior is an artifact of an SELinux hack
> - * in the USB code. Someday it may go away.
>   */
>  static int smack_task_kill(struct task_struct *p, struct siginfo
> *info,
> -			   int sig, u32 secid)
> +			   int sig, const struct cred *cred)
>  {
>  	struct smk_audit_info ad;
>  	struct smack_known *skp;
> @@ -2283,17 +2281,17 @@ static int smack_task_kill(struct task_struct
> *p, struct siginfo *info,
>  	 * Sending a signal requires that the sender
>  	 * can write the receiver.
>  	 */
> -	if (secid == 0) {
> +	if (cred == NULL) {
>  		rc = smk_curacc(tkp, MAY_DELIVER, &ad);
>  		rc = smk_bu_task(p, MAY_DELIVER, rc);
>  		return rc;
>  	}
>  	/*
> -	 * If the secid isn't 0 we're dealing with some USB IO
> +	 * If the cred isn't NULL we're dealing with some USB IO
>  	 * specific behavior. This is not clean. For one thing
>  	 * we can't take privilege into account.
>  	 */
> -	skp = smack_from_secid(secid);
> +	skp = smk_of_task(cred->security);
>  	rc = smk_access(skp, tkp, MAY_DELIVER, &ad);
>  	rc = smk_bu_note("USB signal", skp, tkp, MAY_DELIVER, rc);
>  	return rc;
> -- 
> 2.9.4
> 
