Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <461530F6.3030407@redhat.com>
References: <461530F6.3030407@redhat.com>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 13:44:58 -0400
Message-Id: <1175795098.5711.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-05 at 13:25 -0400, Daniel J Walsh wrote:
> Fixes for rpm_execcon python binding
> 
> Manpage fix
> 
> Fix for erperm on getsebool.
> 
<snip>
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-2.0.9/src/selinuxswig.i
> --- nsalibselinux/src/selinuxswig.i	2007-02-22 08:53:23.000000000 -0500
> +++ libselinux-2.0.9/src/selinuxswig.i	2007-04-05 11:53:17.000000000 -0400
> @@ -115,9 +115,34 @@
>  extern const char *selinux_path(void);
>  extern int selinux_check_passwd_access(access_vector_t requested);
>  extern int checkPasswdAccess(access_vector_t requested);
> +
> +// This tells SWIG to treat char ** as a special case
> +%typemap(python,in) char ** {
> +  /* Check if is a list */
> +  if (PyList_Check($input)) {
> +    int size = PyList_Size($input);
> +    int i = 0;
> +    $1 = (char **) malloc((size+1)*sizeof(char *));

What happens if the malloc fails?

<snip>
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_wrap.c libselinux-2.0.9/src/selinuxswig_wrap.c
> --- nsalibselinux/src/selinuxswig_wrap.c	2007-02-22 08:53:23.000000000 -0500
> +++ libselinux-2.0.9/src/selinuxswig_wrap.c	2007-04-05 11:45:04.000000000 -0400

Don't need to send diffs on this file; will regenerate upstream upon
changes to the .i file.

> diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getsebool.c libselinux-2.0.9/utils/getsebool.c
> --- nsalibselinux/utils/getsebool.c	2006-11-16 17:15:17.000000000 -0500
> +++ libselinux-2.0.9/utils/getsebool.c	2007-04-05 10:53:29.000000000 -0400
> @@ -72,17 +72,23 @@
>  	for (i = 0; i < len; i++) {
>  		active = security_get_boolean_active(names[i]);
>  		if (active < 0) {
> -			fprintf(stderr, "Error getting active value for %s\n",
> -				names[i]);
> -			rc = -1;
> -			goto out;
> +			if (errno != EACCES) { 
> +				fprintf(stderr, "Error getting active value for %s\n",
> +					names[i]);
> +				rc = -1;
> +				goto out;
> +			}
> +			continue;

I think we had discussed only suppressing the errors if using getsebool
-a; if the user explicitly specified a boolean name and it isn't
accessible, they would presumably want to see an error message in that
case.

 		}
>  		pending = security_get_boolean_pending(names[i]);
>  		if (pending < 0) {
> -			fprintf(stderr, "Error getting pending value for %s\n",
> -				names[i]);
> -			rc = -1;
> -			goto out;
> +			if (errno != EACCES) { 
> +				fprintf(stderr, "Error getting pending value for %s\n",
> +					names[i]);
> +				rc = -1;
> +				goto out;
> +			}
> +			continue;
>  		}

Not sure we need this one, because a permission denial should't happen
on pending if it didn't already happen on active.

>  		if (pending != active) {
>  			printf("%s --> %s pending: %s\n", names[i],
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
