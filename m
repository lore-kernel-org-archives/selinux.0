Message-ID: <1484845044.28584.3.camel@tycho.nsa.gov>
Subject: Re: [PATCH 5/5] libselinux: fix argument order in
 get_default_context_with_rolelevel() doc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Thu, 19 Jan 2017 11:57:24 -0500
In-Reply-To: <20170115130359.6108-5-nicolas.iooss@m4x.org>
References: <20170115130359.6108-1-nicolas.iooss@m4x.org>
 <20170115130359.6108-5-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, 2017-01-15 at 14:03 +0100, Nicolas Iooss wrote:
> libselinux/src/get_context_list.c defines
> 
>     get_default_context_with_rolelevel(user, role, level...
> 
> libselinux/utils/getdefaultcon.c uses
> 
>     get_default_context_with_rolelevel(seuser, role, level...
> 
> but libselinux/include/selinux/get_context_list.h declares
> 
>     get_default_context_with_rolelevel(user, level, role...
> 
> and libselinux/man/man3/get_ordered_context_list.3 follows this
> declaration.
> 
> Fix the header and the man page.

Thanks, applied all 5 patches.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/include/selinux/get_context_list.h  | 2 +-
>  libselinux/man/man3/get_ordered_context_list.3 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/include/selinux/get_context_list.h
> b/libselinux/include/selinux/get_context_list.h
> index 8bd8f99d004c..a15b9c4ec34e 100644
> --- a/libselinux/include/selinux/get_context_list.h
> +++ b/libselinux/include/selinux/get_context_list.h
> @@ -57,8 +57,8 @@ extern "C" {
>     that has the specified role and level.  If no reachable context
> exists
>     for the user with that role, then return -1. */
>  	int get_default_context_with_rolelevel(const char *user,
> -					       const char *level,
>  					       const char *role,
> +					       const char *level,
>  					       char * fromcon,
>  					       char ** newcon);
>  
> diff --git a/libselinux/man/man3/get_ordered_context_list.3
> b/libselinux/man/man3/get_ordered_context_list.3
> index 8de90b744c72..e084da406af1 100644
> --- a/libselinux/man/man3/get_ordered_context_list.3
> +++ b/libselinux/man/man3/get_ordered_context_list.3
> @@ -17,7 +17,7 @@ get_ordered_context_list,
> get_ordered_context_list_with_level, get_default_conte
>  .sp
>  .BI "int get_default_context_with_role(const char *" user ", const
> char *" role ", char *" fromcon ", char **" newcon ");
>  .sp
> -.BI "int get_default_context_with_rolelevel(const char *" user ",
> const char *" level ", const char *" role ", char *" fromcon ", char
> **" newcon ");
> +.BI "int get_default_context_with_rolelevel(const char *" user ",
> const char *" role ", const char *" level ", char *" fromcon ", char
> **" newcon ");
>  .sp
>  .BI "int query_user_context(char **" list ", char **" newcon );
>  .sp
