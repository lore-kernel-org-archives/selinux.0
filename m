Subject: Re: [PATCH 2/2] mempolicy: Insert security hook calls for
	setmempolicy (Attempt 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Quigley <dpquigl@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1150831142.19882.0.camel@moss-terrapins.epoch.ncsc.mil>
References: <1150828226.19385.13.camel@moss-terrapins.epoch.ncsc.mil>
	 <1150829406.17557.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1150831142.19882.0.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 15:29:20 -0400
Message-Id: <1150831760.17557.244.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-20 at 15:19 -0400, David Quigley wrote:
> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch inserts the security hook calls into the setmempolicy
> function to enable security modules to mediate this operation between
> tasks.
> 
> Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> ---
> 
>  mm/mempolicy.c |    4 ++++
>  mm/migrate.c   |    5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/mm/mempolicy.c linux-2.6.17-rc6-mm2-mempolicy/mm/mempolicy.c
> --- linux-2.6.17-rc6-mm2/mm/mempolicy.c	2006-06-20 10:38:00.000000000 -0400
> +++ linux-2.6.17-rc6-mm2-mempolicy/mm/mempolicy.c	2006-06-20 15:07:51.000000000 -0400
> @@ -946,6 +946,10 @@ asmlinkage long sys_migrate_pages(pid_t 
>  		goto out;
>  	}
>  
> +	err = security_task_setmempolicy(task);
> +	if (err)
> +		goto out;
> +
>  	err = do_migrate_pages(mm, &old, &new,
>  		capable(CAP_SYS_NICE) ? MPOL_MF_MOVE_ALL : MPOL_MF_MOVE);
>  out:
> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-rc6-mm2/mm/migrate.c linux-2.6.17-rc6-mm2-mempolicy/mm/migrate.c
> --- linux-2.6.17-rc6-mm2/mm/migrate.c	2006-06-20 10:38:00.000000000 -0400
> +++ linux-2.6.17-rc6-mm2-mempolicy/mm/migrate.c	2006-06-20 15:09:18.000000000 -0400
> @@ -903,6 +903,11 @@ asmlinkage long sys_move_pages(pid_t pid
>  		goto out2;
>  	}
>  
> + 	err = security_task_setmempolicy(task);
> + 	if (err)
> + 		goto out2;
> + 	
> +
>  	task_nodes = cpuset_mems_allowed(task);
>  
>  	/* Limit nr_pages so that the multiplication may not overflow */
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
