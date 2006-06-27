Subject: Re: [PATCH 1/3] security:  Extend task_kill hook to handle signals
	sent by AIO completion
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: David Quigley <dpquigl@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
References: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 15:43:04 -0500
Message-Id: <1151440985.6863.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-27 at 16:01 -0400, David Quigley wrote:
> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch extends the security_task_kill hook to handle signals sent
> by AIO completion.  In this case, the SID of the task responsible for
> the signal needs to be obtained and saved earlier, so a
> security_task_getsecurityid() hook is added, and then this saved value
> is passed subsequently to the extended task_kill hook for use in
> checking.
> 

I could be missing something here, but why not simply use the public API
call directly, rather than creating another LSM hook?  The one that is
declared in include/linux/selinux.h and defined in
security/selinux/exports.c,

void selinux_get_task_sid(struct task_struct *tsk, u32 *sid);

-tim
<snip>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
