Message-ID: <4C658B36.40200@redhat.com>
Date: Fri, 13 Aug 2010 14:13:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris Adams <cmadams@hiwaay.net>
CC: SELinux@tycho.nsa.gov
Subject: Re: Bug in restorecond for the first user logged in
References: <20100812195128.GC897947@hiwaay.net>
In-Reply-To: <20100812195128.GC897947@hiwaay.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/12/2010 03:51 PM, Chris Adams wrote:
> The first user that logs in will not be caught by restorecond.  The utmp
> checking function only returns that there was a change when the previous
> list of users was non-NULL.
> 
> Here's a patch that works for me (this is against the latest Red Hat
> Enterprise Linux 5 policycoreutils release, but I checked the current
> source tree and the same problem is present):
> 
> diff -urN policycoreutils-1.33.12-dist/restorecond/utmpwatcher.c policycoreutils-1.33.12/restorecond/utmpwatcher.c
> --- policycoreutils-1.33.12-dist/restorecond/utmpwatcher.c	2007-01-11 13:01:39.000000000 -0600
> +++ policycoreutils-1.33.12/restorecond/utmpwatcher.c	2010-08-12 14:13:24.000000000 -0500
> @@ -69,10 +69,9 @@
>  
>  	utmp_wd =
>  	    inotify_add_watch(inotify_fd, utmp_path, IN_MOVED_FROM | IN_MODIFY);
> -	if (prev_utmp_ptr) {
> -		changed = strings_list_diff(prev_utmp_ptr, utmp_ptr);
> +	changed = strings_list_diff(prev_utmp_ptr, utmp_ptr);
> +	if (prev_utmp_ptr)
>  		strings_list_free(prev_utmp_ptr);
> -	}
>  	return changed;
>  }
>  
> 
I updated in F14.  If you want to have this fixed in RHEL5 you need to
open a bugzilla.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxlizYACgkQrlYvE4MpobPLxACglrkZAM8302n+7fDvCMc47nsU
9MsAoKMQytFrhxScF5RrP85NG6yx9AvI
=rL26
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
