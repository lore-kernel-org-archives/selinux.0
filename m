Subject: Re: [PATCH] libselinux: 1/2 Introduce {get,set}procattrcon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1151340535.21012.150.camel@localhost.localdomain>
References: <1151340535.21012.150.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 14:31:20 -0400
Message-Id: <1151346680.5264.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-26 at 12:48 -0400, Eric Paris wrote:
> The below attached patch implements two new function, get and set
> procattrcon.  These are generic functions that take a context and a path
> and attempt to write that context to that path.  These are used by of
> exported libselinux interfaces, like getfscreatecon, as a generic
> backend to reduce duplication of code.

> --- libselinux-1.30.15/include/selinux/selinux.h.p1	2006-06-26 12:00:54.000000000 -0400
> +++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-26 12:00:54.000000000 -0400
> @@ -24,6 +24,14 @@ extern void freeconary(security_context_
>  
>  /* Wrappers for the /proc/pid/attr API. */
>  
> +/* Generic /proc pid attr handlers.  These will either get or set the context
> +   from or into the proc location passed to them.  Should only be called from 
> +   inside libselinux */
> +extern int getprocattrcon(security_context_t *con, char *path);
> +extern int getprocattrcon_raw(security_context_t *con, char *path);
> +extern int setprocattrcon(security_context_t con, char *path);
> +extern int setprocattrcon_raw(security_context_t con, char *path);
> +
>  /* Get current context, and set *con to refer to it.
>     Caller must free via freecon. */
>  extern int getcon(security_context_t *con);

If they should only be called from inside libselinux, why are they
defined in selinux/selinux.h, and exported to users of the library?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
