Subject: Re: libselinux patch to add interfaces in avc.h to python bindings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <485000A8.4090705@redhat.com>
References: <485000A8.4090705@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 15:05:25 -0400
Message-Id: <1213211125.17842.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-06-11 at 12:43 -0400, Daniel J Walsh wrote:
> plain text document attachment (libselinux-rhat.patch)
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-2.0.64/src/selinuxswig.i
> --- nsalibselinux/src/selinuxswig.i	2008-05-06 14:33:15.000000000 -0400
> +++ libselinux-2.0.64/src/selinuxswig.i	2008-05-07 13:08:06.000000000 -0400
> @@ -5,6 +5,7 @@
>  %module selinux
>  %{
>  	#include "selinux/selinux.h"
> +	#include "../include/selinux/avc.h"
>  	#include "../include/selinux/selinux.h"
>  	#include "../include/selinux/get_default_type.h"
>  	#include "../include/selinux/get_context_list.h"
> @@ -47,6 +48,10 @@
>  %ignore set_matchpathcon_invalidcon;
>  %ignore set_matchpathcon_canoncon;
>  
> +%ignore avc_add_callback;
> +
>  %include "../include/selinux/selinux.h"
> +%include "../include/selinux/avc.h"
>  %include "../include/selinux/get_default_type.h"
>  %include "../include/selinux/get_context_list.h"
> +
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_python.i libselinux-2.0.64/src/selinuxswig_python.i
> --- nsalibselinux/src/selinuxswig_python.i	2007-10-01 09:54:35.000000000 -0400
> +++ libselinux-2.0.64/src/selinuxswig_python.i	2008-05-07 13:08:06.000000000 -0400
> @@ -16,6 +16,20 @@
>  	$result = SWIG_Python_AppendOutput($result, list);
>  }
>  
> +/* return a sid along with the result */
> +%typemap(argout) (security_id_t * sid) {
> +	if (*$1) {
> +                %append_output(SWIG_NewPointerObj(*$1, $descriptor(security_id_t), 0));
> +	} else {
> +		Py_INCREF(Py_None);
> +		%append_output(Py_None);
> +	}
> +}
> +
> +%typemap(in,numinputs=0) security_id_t *(security_id_t temp) {
> +  $1 = &temp;
> +}
> +
>  /* Makes security_compute_user() return a Python list of contexts */
>  %typemap(argout) (security_context_t **con) {
>  	PyObject* plist;

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
