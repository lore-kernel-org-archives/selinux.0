Subject: Re: [RFC][PATCH] collect security labels on user
	processes	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <1140209880.752.12.camel@localhost>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
	 <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
	 <1139960902.326.5.camel@localhost>  <43F39797.1050602@trustedcs.com>
	 <1140209880.752.12.camel@localhost>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 09:21:18 -0500
Message-Id: <1140618078.31467.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-17 at 14:58 -0600, Timothy R. Chavez wrote:
> Thanks Darrel!  New patch attached... so... assuming this is good... how
> are we going to do this API merger :] ?

> +/**
> + *     selinux_task_getsecid - return the SID of task
> + *	@tsk: the task whose SID will be returned
> + *
> + * 	Returns 0 if SELinux is disabled, otherwise the SID is returned.
> + */
> +int selinux_task_getsecid(struct task_struct *tsk);

Ryan noticed that you didn't update this to return u32 yet, unlike the
#else case.

> +u32 selinux_task_getsecid(struct task_struct *tsk)
> +{
> +	u32 sid = 0;
> +
> +	if (ss_initialized)
> +		sid = ((struct task_security_struct *)tsk->security)->sid;
> +	
> +	return sid;
> +}

You don't strictly need to check ss_initialized in this function; all
tasks are assigned the kernel SID until policy is loaded, so you can
always access the SID.  As a matter of style, I'd prefer an explicit
task_security_struct* local variable with separate assignment, i.e.
	struct task_security_struct *tsec = tsk->security;
	sid = tsec->sid;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
