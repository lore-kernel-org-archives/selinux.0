Subject: Re: [PATCH 5/5] SELinux: Move execmod to the common perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100723154415.13217.49052.stgit@paris.rdu.redhat.com>
References: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
	 <20100723154415.13217.49052.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 17:07:57 -0400
Message-ID: <1279919277.32473.48.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-07-23 at 11:44 -0400, Eric Paris wrote:
> execmod "could" show up on non regular files and non chr files.  The current
> implementation would actually make these checks against non-existant bits
> since the code assumes the execmod permission is same for all file types.
> To make this line up for chr files we had to define execute_no_trans and
> entrypoint permissions.  These permissions are unreachable and only existed
> to to make FILE__EXECMOD and CHR_FILE__EXECMOD the same.  This patch drops
> those needless perms as well.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
for the entire series.  Although I think I already did that before.

> ---
> 
>  security/selinux/include/classmap.h |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 41990cb..b4c9eb4 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -3,7 +3,7 @@
>  
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
>      "rename", "execute", "swapon", "quotaon", "mounton", "audit_access", \
> -    "open"
> +    "open", "execmod"
>  
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> @@ -44,7 +44,7 @@ struct security_class_mapping secclass_map[] = {
>  	    "quotaget", NULL } },
>  	{ "file",
>  	  { COMMON_FILE_PERMS,
> -	    "execute_no_trans", "entrypoint", "execmod", NULL } },
> +	    "execute_no_trans", "entrypoint", NULL } },
>  	{ "dir",
>  	  { COMMON_FILE_PERMS, "add_name", "remove_name",
>  	    "reparent", "search", "rmdir", NULL } },
> @@ -52,8 +52,7 @@ struct security_class_mapping secclass_map[] = {
>  	{ "lnk_file",
>  	  { COMMON_FILE_PERMS, NULL } },
>  	{ "chr_file",
> -	  { COMMON_FILE_PERMS,
> -	    "execute_no_trans", "entrypoint", "execmod", NULL } },
> +	  { COMMON_FILE_PERMS, NULL } },
>  	{ "blk_file",
>  	  { COMMON_FILE_PERMS, NULL } },
>  	{ "sock_file",

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
