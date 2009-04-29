Subject: Re: [PATCH] SELinux: drop secondary_ops->sysctl
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20090429180025.22109.45638.stgit@paris.rdu.redhat.com>
References: <20090429180025.22109.45638.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 14:11:07 -0400
Message-Id: <1241028667.18249.254.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-29 at 14:00 -0400, Eric Paris wrote:
> We are still calling secondary_ops->sysctl even though the capabilities
> module does not define a sysctl operation.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

And repeating what I said back in January when the other calls to
secondary_ops were removed:

At that point secondary_ops would only be used by selinux_init() to save
the original security_ops pointer for use by selinux_disable() to
restore the original pointer, which ideally would be handled by the
security framework instead (possibly by restoring a limited
unregister_security() that resets to the default_security_ops).

> ---
> 
>  security/selinux/hooks.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 796c16f..9af6624 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2050,10 +2050,6 @@ static int selinux_sysctl(ctl_table *table, int op)
>  	u32 tsid, sid;
>  	int rc;
>  
> -	rc = secondary_ops->sysctl(table, op);
> -	if (rc)
> -		return rc;
> -
>  	sid = current_sid();
>  
>  	rc = selinux_sysctl_get_sid(table, (op == 0001) ?
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
