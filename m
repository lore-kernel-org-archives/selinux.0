Subject: Re: [PATCH] libselinux: add "event" type to X contexts backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <471907FA.7090601@tycho.nsa.gov>
References: <4717A396.6070409@tycho.nsa.gov>
	 <471907FA.7090601@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 15:33:45 -0400
Message-Id: <1192822425.9395.296.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-19 at 15:39 -0400, Eamon Walsh wrote:
> Here is a revised version of the patch that adds not one but two
> backends, one for X event names and one for X "selections" which
> are the clipboard objects used in cut & paste.
> 
> This is so the X Flask module can support labeling these objects
> based on their names.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Acked-by:  Stephen "I want labeled X on my desk" Smalley <sds@tycho.nsa.gov>

> ---
> 
>  include/selinux/label.h |    2 ++
>  src/label_x.c           |    6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> 
> Index: libselinux/include/selinux/label.h
> ===================================================================
> --- libselinux/include/selinux/label.h	(revision 2660)
> +++ libselinux/include/selinux/label.h	(working copy)
> @@ -111,6 +111,8 @@
>  #define SELABEL_X_PROP		1
>  #define SELABEL_X_EXT		2
>  #define SELABEL_X_CLIENT	3
> +#define SELABEL_X_EVENT		4
> +#define SELABEL_X_SELN		5
>  
> 
>  #ifdef __cplusplus
> Index: libselinux/src/label_x.c
> ===================================================================
> --- libselinux/src/label_x.c	(revision 2660)
> +++ libselinux/src/label_x.c	(working copy)
> @@ -65,9 +65,13 @@
>  			data->spec_arr[data->nspec].type = SELABEL_X_EXT;
>  		else if (!strcmp(type, "client"))
>  			data->spec_arr[data->nspec].type = SELABEL_X_CLIENT;
> +		else if (!strcmp(type, "event"))
> +			data->spec_arr[data->nspec].type = SELABEL_X_EVENT;
> +		else if (!strcmp(type, "selection"))
> +			data->spec_arr[data->nspec].type = SELABEL_X_SELN;
>  		else {
>  			selinux_log(SELINUX_WARNING,
> -				    "%s:  line %d has invalid file type %s\n",
> +				    "%s:  line %d has invalid object type %s\n",
>  				    path, lineno, type);
>  			return 0;
>  		}
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
