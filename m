Subject: Re: [Patch 2/2] libsemanage: remember and retrieve dontaudit
 settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A4C17D1.3060208@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C17D1.3060208@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:46:37 -0400
Message-Id: <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 22:13 -0400, Christopher Pardy wrote:
> On 07/01/2009 10:08 PM, Christopher Pardy wrote:
> > This is a heavily modified version of the patch I recently submitted. 
> > It provides 3 new functions: in libsepol sepol_get_disable_dontaudit; 
> > in libsemanage semanage_get_disable_dontaudit; in libselinux 
> > is_dontaudit_disabled. It also fixes issues with the previous patch.
> >
> > The justification for this patch is the same as the one I posted 
> > earlier. Simply, there is currently no way to know if dontaudit rules 
> > are  enabled. Additionally once don't audit rules are turned they turn 
> > themselves off after policy rebuild (is that the desired 
> > functionality?) This patch provides  a way to check on both the 
> > current and pending state of the dontaudit rules and it maintains this 
> > state between policy rebuilds.
> >
> > Signed-off-by Christopher Pardy <cpardy@redhat.com>
> This patch implements the functions in libsemanage and libselinux.
> 
> diff -urN selinux.orig2/libselinux/include/selinux/selinux.h 
> selinux/libselinux/include/selinux/selinux.h

diff with -p (or just git diff) is nicer in that it shows function names
too.

> --- selinux.orig2/libselinux/include/selinux/selinux.h    2009-07-01 
> 21:15:17.009238289 -0400
> +++ selinux/libselinux/include/selinux/selinux.h    2009-07-01 
> 21:44:57.264509874 -0400
> @@ -8,6 +8,9 @@
>   extern "C" {
>   #endif
> 
> +/* Return 1 if the dont audit rules have been turned off or 0 if not. */
> +extern int is_dontaudit_disabled(void);

I'm not sure why we'd push this out to libselinux and expose the file
location to both libselinux and libsemanage.  What programs would use
this that couldn't just link against libsemanage?

> diff -urN selinux.orig2/libselinux/src/dontaudit.c 
> selinux/libselinux/src/dontaudit.c
> --- selinux.orig2/libselinux/src/dontaudit.c    1969-12-31 
> 19:00:00.000000000 -0500
> +++ selinux/libselinux/src/dontaudit.c    2009-07-01 21:48:48.635521208 
> -0400
> @@ -0,0 +1,21 @@
> +#include <unistd.h>
> +#include <selinux/selinux.h>
> +#include "selinux_internal.h"
> +#include <stdlib.h>
> +#include <limits.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +int is_dontaudit_disabled(void)
> +{
> +    char path[PATH_MAX];
> +    snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
> +
> +    if (access(path,F_OK) == 0)
> +        return 1;
> +    else
> +        return 0;
> +}
> +
> +hidden_def(is_dontaudit_disabled)

We don't need a hidden def unless libselinux internally calls the
function as well.

> diff -urN selinux.orig2/libselinux/src/selinux_internal.h 
> selinux/libselinux/src/selinux_internal.h
> --- selinux.orig2/libselinux/src/selinux_internal.h    2009-07-01 
> 21:15:17.074235819 -0400
> +++ selinux/libselinux/src/selinux_internal.h    2009-07-01 
> 21:44:57.272486689 -0400
> @@ -24,6 +24,7 @@
>       hidden_proto(security_compute_create_raw)
>       hidden_proto(security_compute_member_raw)
>       hidden_proto(security_compute_relabel_raw)
> +    hidden_proto(is_dontaudit_disabled)

Ditto.

> diff -urN selinux.orig2/libsemanage/include/semanage/handle.h 
> selinux/libsemanage/include/semanage/handle.h
> --- selinux.orig2/libsemanage/include/semanage/handle.h    2009-07-01 
> 21:15:17.224235939 -0400
> +++ selinux/libsemanage/include/semanage/handle.h    2009-07-01 
> 21:44:57.274484577 -0400
> @@ -69,6 +69,9 @@
>    * 1 for yes, 0 for no (default) */
>   void semanage_set_create_store(semanage_handle_t * handle, int 
> create_store);
> 
> +/*Get whether or not to dontaudits will be disabled upon commit */
> +int semanage_get_disable_dontaudit(semanage_handle_t * handle);

As before, I don't know why we'd export this transient information
outside of the library, vs. only exporting the persistent dontaudit
setting.

> diff -urN selinux.orig2/libsemanage/src/handle.c 
> selinux/libsemanage/src/handle.c
> --- selinux.orig2/libsemanage/src/handle.c    2009-07-01 
> 21:15:17.288238017 -0400
> +++ selinux/libsemanage/src/handle.c    2009-07-01 21:55:04.525487189 -0400
<snip>
> @@ -264,11 +276,22 @@
>       assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
>       if (!sh->is_in_transaction) {
>           ERR(sh,
> -            "Will not commit because caller does not have a tranaction 
> lock yet.");
> +            "Will not commit because caller does not have a transaction 
> lock yet.");
>           return -1;
>       }
>       retval = sh->funcs->commit(sh);
>       sh->is_in_transaction = 0;
>       sh->modules_modified = 0;
> +    if (retval == 0){
> +        char path[PATH_MAX];
> +        
> snprintf(path,PATH_MAX,"%s/disable_dontaudit",selinux_policy_root());
> +        if(semanage_get_disable_dontaudit(sh) == 1){
> +            FILE *touch;
> +            touch = fopen(path,"w");
> +            fclose(touch);
> +        }else{
> +            remove(path);
> +        }
> +    }

This doesn't make sense to me - we check whether we've already set
disable dontaudit and use that to decide whether to create the file?
But the existence of the file is what would have triggered setting
disable dontaudit in the first place.  Round and round we go...

Also, I think it makes more sense to keep all of this private to
libsemanage and to keep this file in the module store, as Joshua already
said.

>       return retval;
>   }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
