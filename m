Subject: Re: Change default error handling in libselinux matchpathcon to
	use syslog instead of stderr.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <46EFF028.4040500@redhat.com>
References: <46EFF028.4040500@redhat.com>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 12:43:25 -0400
Message-Id: <1190133805.14037.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 11:35 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Current behavior causes problems with network applications.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=273081

I'm not sure about changing current behavior, as that is effectively an
"interface" change.  Or if it isn't, then there are other such changes I
would make too (e.g. changing the default for SETLOCALDEFS in libselinux
comes to mind).

What if they used the newer interfaces introduced by Eamon (selabel*)?
setfiles has already been rewritten by him to use those interfaces, and
thus matchpathcon is a legacy interface at this point.  Does the same
problem exist there?

I suppose that doesn't help you though with RHEL 5, as it would only
have the older interfaces.

Changing the interface from one arbitrary default (stderr) to another
arbitrary default (syslog) doesn't seem like an improvement, although it
would fix this particular issue I suppose.  We would need to at least
make sure that setfiles -c continues to report the error messages as
expected.

One comment below on the code itself.  

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFG7/AnrlYvE4MpobMRAksuAJ4uqcUDsSlB9uEpXePUEje39kNAywCeJbDE
> sZ99tA7s4PgSxD/RnS4MHdg=
> =g4kG
> -----END PGP SIGNATURE-----
> plain text document attachment (diff)
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-2.0.33/src/matchpathcon.c
> --- nsalibselinux/src/matchpathcon.c	2007-08-10 11:58:34.000000000 -0400
> +++ libselinux-2.0.33/src/matchpathcon.c	2007-09-18 11:28:07.000000000 -0400
> @@ -2,6 +2,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <stdio.h>
> +#include <syslog.h>
>  #include "selinux_internal.h"
>  #include "label_internal.h"
>  #include "callbacks.h"
> @@ -55,10 +56,12 @@
>  #endif
>      default_printf(const char *fmt, ...)
>  {
> +	char buf[BUFSIZ];
>  	va_list ap;
>  	va_start(ap, fmt);
> -	vfprintf(stderr, fmt, ap);
> +	vsnprintf(buf, sizeof(buf) - 1, fmt, ap);
>  	va_end(ap);
> +	syslog(LOG_ERR, buf, strlen(buf));
>  }

Could you use vsyslog() instead to avoid the need for a fixed size
buffer?

>  
>  void
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
