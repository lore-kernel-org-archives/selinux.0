Subject: Re: Patch to make libselinux shut up when SELinux is disabled.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4880CFD1.1040102@redhat.com>
References: <4880CFD1.1040102@redhat.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 13:27:43 -0400
Message-Id: <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-07-18 at 13:16 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> SELinux complains about things like restorecon or rpm when conflicts
> exist in file_context file even when SELinux is disabled.
> 
> It should just shut up....

I think that's the wrong place to do it:
- the fact that the application called libselinux at all except to test
is_selinux_enabled() when SELinux is disabled is either a bug in the
application or an indication that the application wants SELinux behavior
regardless,
- silencing all log messages coming from libselinux is too broad.

And of course, file_contexts conflicts should be caught during policy
build time aside from local customizations; if not, then we need to
change the policy build process to do that even for modular policy
builds.

> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkiAz9AACgkQrlYvE4MpobMO6wCdGC7kvnHsss5gBkQGy1s10MzS
> WgIAn2Ryd93w9zfVihfDKyGa8M78E21W
> =hwEi
> -----END PGP SIGNATURE-----
> plain text document attachment (diff)
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/callbacks.c libselinux-2.0.67/src/callbacks.c
> --- nsalibselinux/src/callbacks.c	2008-06-12 23:25:14.000000000 -0400
> +++ libselinux-2.0.67/src/callbacks.c	2008-07-18 11:15:56.000000000 -0400
> @@ -16,6 +16,7 @@
>  {
>  	int rc;
>  	va_list ap;
> +	if (is_selinux_enabled() == 0) return 0;
>  	va_start(ap, fmt);
>  	rc = vfprintf(stderr, fmt, ap);
>  	va_end(ap);
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
