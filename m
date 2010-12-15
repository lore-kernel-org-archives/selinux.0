Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBFItB6i020219
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 13:55:16 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oBFItFua020346
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 18:55:15 GMT
Date: Wed, 15 Dec 2010 13:55:13 -0500
Subject: Re: This patch adds some output to load_policy to say which policy
 file it tries to load.
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Message-ID: <C92E7941.BBACE%csellers@tresys.com>
In-Reply-To: <4D066847.4070309@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/10 1:39 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Currently load_policy will just fail without a decent error message.
> 
> Note:
> 
> The patch has to check if load_policy failed on a disabled machine, in
> order to not report an error.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAk0GaEYACgkQrlYvE4MpobMxrwCg6JMdPm28IEuL2Eco++OCHThw
> sYAAn2BTXe1BYCjYdzDAjnA08t0dKquQ
> =N1Uu
> -----END PGP SIGNATURE-----
>
> diff --git a/policycoreutils/load_policy/load_policy.c
> b/policycoreutils/load_policy/load_policy.c
> index 47d9b0f..566565f 100644
> --- a/policycoreutils/load_policy/load_policy.c
> +++ b/policycoreutils/load_policy/load_policy.c
> @@ -1,3 +1,4 @@
> +#define _GNU_SOURCE
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> @@ -23,6 +24,14 @@ void usage(char *progname)
>      exit(1);
>  }
>  
> +char *policy_path(void) {
> +    char *path=NULL;
> +    if (asprintf(&path, "%s.%d", selinux_binary_policy_path(),
> security_policyvers()) < 0) {
> +        return NULL;
> +    }
> +    return path;
> +}
> +

This function will return a bogus result if any error occurs in
security_policyvers(). The only likely candidate for that is if SELinux is
disabled, which this theoretically should not be called in. However, that
isn't true (more on that later). So, I get messages like this:

[root@f14 ~]# load_policy -i
load_policy:  Can't load policy file /etc/selinux/targeted/policy/policy.-1:
No such file or directory

The -1 comes from the error return code from security_policyvers().

More importantly, this just assumes that the path computed here and in
libselinux are the same. Since libselinux searches back for policy versions,
this isn't necessarily true.

>  int main(int argc, char **argv)
>  {
>      int ret, opt, quiet = 0, nargs, init=0, enforce=0;
> @@ -64,6 +73,7 @@ int main(int argc, char **argv)
>              "%s:  Warning!  Boolean file argument (%s) is no longer
> supported, installed booleans file is always used.  Continuing...\n",
>              argv[0], argv[optind++]);
>      }
> +    errno = 0;
>      if (init) {
>          if (is_selinux_enabled() == 1) {
>              /* SELinux is already enabled, we should not do an initial load
> again */
> @@ -76,9 +86,11 @@ int main(int argc, char **argv)
>          if (ret != 0 ) {
>              if (enforce > 0) {
>                  /* SELinux in enforcing mode but load_policy failed */
> +                char *path=policy_path();
>                  fprintf(stderr,
> -                        _("%s:  Can't load policy and enforcing mode
> requested:  %s\n"),
> -                        argv[0], strerror(errno));
> +                        _("%s:  Can't load policy file %s and enforcing mode
> requested: %s\n"),
> +                    argv[0], path, strerror(errno));
> +                free(path);

This assumes errno is set by selinux_init_load_policy() (more on this
below).

>                  exit(3);
>              }
>          }
> @@ -86,9 +98,16 @@ int main(int argc, char **argv)
>      else {
>          ret = selinux_mkload_policy(1);
>      }
> -    if (ret < 0) {
> -        fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
> -            argv[0], strerror(errno));
> +
> +    /* selinux_init_load_policy returns -1 if it did not load_policy
> +         * On SELinux disabled system it will always return -1
> +         * So check errno to see if anything went wrong
> +         */
> +    if (ret < 0 && errno != 0) {
> +        char *path=policy_path();
> +        fprintf(stderr, _("%s:  Can't load policy file %s:  %s\n"),
> +            argv[0], path, strerror(errno));
> +        free(path);

This assumes that errno is set properly by selinux_init_load_policy() or
selinux_mkload_policy(). It's not. For instance, if /selinux can't be
mounted (because SELinux is disabled), errno will be set to ENODEV. So, this
new errno check doesn't seem to help here. For instance, I booted my F14
system with selinux=0 on the kernel command-line. Then:

[root@f14 ~]# load_policy -i
load_policy:  Can't load policy file /etc/selinux/targeted/policy/policy.-1:
No such file or directory

I'd say we either need a proper communication channel (e.g. return code or
start setting errno properly) between libselinux and load_policy, or we need
libselinux to handle everything (including logging) itself.

Thanks,
Chad



>          exit(2);
>      }
>      exit(0);
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
