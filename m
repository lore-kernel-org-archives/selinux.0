Subject: Re: [PATCH -v3 2/4] vm: use new has_capability_noaudit
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, jmorris@nameil.org,
        serue@us.ibm.com, morgan@kernel.org, casey@schaufler-ca.com,
        esandeen@redhat.com
In-Reply-To: <20081107152332.10328.12878.stgit@paris.rdu.redhat.com>
References: <20081107152326.10328.44330.stgit@paris.rdu.redhat.com>
	 <20081107152332.10328.12878.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Fri, 07 Nov 2008 10:39:04 -0500
Message-Id: <1226072344.16320.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-11-07 at 10:23 -0500, Eric Paris wrote:
> The oomkiller calculations make decisions based on capabilities.  Since
> these are not security decisions and LSMs should not record if they fall
> the request they should use the new has_capability_noaudit() interface so
> the denials will not be recorded.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
>  mm/oom_kill.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index a0a0190..df259c2 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -128,8 +128,8 @@ unsigned long badness(struct task_struct *p, unsigned long uptime)
>  	 * Superuser processes are usually more important, so we make it
>  	 * less likely that we kill those.
>  	 */
> -	if (has_capability(p, CAP_SYS_ADMIN) ||
> -	    has_capability(p, CAP_SYS_RESOURCE))
> +	if (has_capability_noaudit(p, CAP_SYS_ADMIN) ||
> +	    has_capability_noaudit(p, CAP_SYS_RESOURCE))
>  		points /= 4;
>  
>  	/*
> @@ -138,7 +138,7 @@ unsigned long badness(struct task_struct *p, unsigned long uptime)
>  	 * tend to only have this flag set on applications they think
>  	 * of as important.
>  	 */
> -	if (has_capability(p, CAP_SYS_RAWIO))
> +	if (has_capability_noaudit(p, CAP_SYS_RAWIO))
>  		points /= 4;
>  
>  	/*
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
