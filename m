Subject: Re: Ruby bindings patch for libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4876284A.5070606@redhat.com>
References: <4876284A.5070606@redhat.com>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 09:03:56 -0400
Message-Id: <1217336636.20373.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-07-10 at 11:18 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I noticed that puppet is not SELinux aware.  We are using this in the
> Fedora Infrastructure.  Puppet is written in Ruby.  In order to get the
> packages to make Puppet SELinux aware we need at least matchpathcon,
> is_selinux_enabled, setfscreatecon and setfilecon to have Ruby bindings.
> 
> 
> So I try to learn as much Ruby in an afternoon as possible and converted
> as much libselinux python bindings to Ruby as I could.   Enough to get
> puppet going on working with selinux.
> 
> If some Ruby expert wants to fix the rest of the bindings that would be
> great. :^)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkh2KEoACgkQrlYvE4MpobND1ACffm5i1ie3FumEXBc+qcm8Fyio
> K+4An0Cur4swzMMFoj9blybxBYhzxUMR
> =ylTu
> -----END PGP SIGNATURE-----
> plain text document attachment (diff)
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile libselinux-2.0.67/src/Makefile
> --- nsalibselinux/src/Makefile	2008-06-22 09:40:25.000000000 -0400
> +++ libselinux-2.0.67/src/Makefile	2008-07-09 16:56:37.000000000 -0400
> @@ -44,11 +54,11 @@
>  
>  SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
>  
> -GENERATED=$(SWIGCOUT)
> +SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
>  
>  all: $(LIBA) $(LIBSO) 
>  
> -pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
> +pywrap: all $(SWIGSO) $(AUDIT2WHYSO) $(SWIGRUBYSO) 

Should there be a separate makefile target for the ruby bindings?

> diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_ruby.i libselinux-2.0.67/src/selinuxswig_ruby.i
> --- nsalibselinux/src/selinuxswig_ruby.i	1969-12-31 19:00:00.000000000 -0500
> +++ libselinux-2.0.67/src/selinuxswig_ruby.i	2008-07-09 16:52:33.000000000 -0400
> @@ -0,0 +1,147 @@
> +/* Author: Dan Walsh, Converted from James Athey python code
> + */
> +
> +%module selinux
> +%{
> +	#include "selinux/selinux.h"
> +%}
> +
> +/* security_get_boolean_names() typemap */
> +/*
> +%typemap(argout) (char ***names, int *len) {
> +	PyObject* list = PyList_New(*$2);
> +	int i;
> +	for (i = 0; i < *$2; i++) {
> +		PyList_SetItem(list, i, PyString_FromString((*$1)[i]));
> +	}
> +	$result = SWIG_Python_AppendOutput($result, list);
> +}

Rather than commenting out or #ifdef'ing python binding code, just
remove it from this file.

> +%typemap(in,noblock=1,numinputs=0) security_context_t * (security_context_t temp = 0) {
> +	$1 = &temp;
> +}
> +%typemap(freearg,match="in") security_context_t * "";
> +%typemap(argout,noblock=1) security_context_t * {
> +	if (*$1) {
> +		%append_output(SWIG_FromCharPtr(*$1));
> +		freecon(*$1);
> +	}
> +/*
> +	else {
> +		Py_INCREF(Py_None);
> +		%append_output(Py_None);
> +	}
> +*/
> +}

Don't you need to handle the else clause in some manner?

What are the build dependencies?  Doesn't build for me on F8 or F9 with
ruby, ruby-libs and ruby-devel installed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
