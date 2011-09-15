Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FK8ZTM023100
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 16:08:39 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FK8bHA023277
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 20:08:38 GMT
Subject: Re: [PATCH] policycoreutils: preserve mode bits and ownership of
 /tmp in seunshare
From: Guido Trentalancia <guido@trentalancia.com>
To: dave w <nullcore@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 15 Sep 2011 22:07:36 +0200
In-Reply-To: <CAB04Hprsq9z4qYzO+pTOMYC41ma7d3J7+hrcQ04KSkOQnBEnBQ@mail.gmail.com>
References: 
	<CAB04Hprsq9z4qYzO+pTOMYC41ma7d3J7+hrcQ04KSkOQnBEnBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316117256.2202.104.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Dave.

On Thu, 2011-09-15 at 13:39 -0400, dave w wrote:
> Hi,
> 
> This patch addresses a flaw in seunshare.c that allows unprivileged
> users to arbitrarily modify the contents of /tmp.  This bug is further
> described in CVE 2011-1011
> (http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-1011):

seunshare should not be installed by default and, even if it still
needed to be installed by default, its setuid bit should be carefully
re-evaluated in my opinion.

In any case, good practice says nothing should ever be allowed to mount
under /tmp with suid/exec flags (use noexec,nosuid options in fstab).

That said, have you tested the patch already ? Is it effective ?

Thanks.

Guido

> The seunshare_mount function in sandbox/seunshare.c in seunshare in certain
> Red Hat packages of policycoreutils 2.0.83 and earlier in Red Hat
> Enterprise Linux (RHEL) 6 and earlier, and Fedora 14 and earlier, mounts a
> new directory on top of /tmp without assigning root ownership and the
> sticky bit to this new directory, which allows local users to replace or
> delete arbitrary /tmp files, and consequently cause a denial of service or
> possibly gain privileges, by running a setuid application that relies on
> /tmp, as demonstrated by the ksu application
> 
> This patch preserves the mode bits, and thus permissions, and
> ownership of the destination directory of the bind mount performed by
> seunshare.  The permission check in verify_mount() was relaxed for
> directories who originally had the sticky bit set, as root ownership
> is required for these to ensure that unprivileged users cannot unlink
> arbitrary files in the newly bind mounted directory.
> 
> Thanks,
> David
> 
> 
> 
>  policycoreutils/sandbox/seunshare.c |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)
> 
> diff --git a/policycoreutils/sandbox/seunshare.c
> b/policycoreutils/sandbox/seunshare.c
> index f9bf12c..82b3cb9 100644
> --- a/policycoreutils/sandbox/seunshare.c
> +++ b/policycoreutils/sandbox/seunshare.c
> @@ -149,7 +149,9 @@ static int verify_mount(const char *mntdir, struct
> passwd *pwd) {
>         fprintf(stderr, _("Invalid mount point %s: %s\n"), mntdir,
> strerror(errno));
>         return -1;
>     }
> -   if (sb.st_uid != pwd->pw_uid) {
> +
> +    /* Owners don't have to match if the sticky bit has been set. */
> +   if (sb.st_uid != pwd->pw_uid && !(sb.st_mode && S_ISVTX)) {
>         errno = EPERM;
>         syslog(LOG_AUTHPRIV | LOG_ALERT, "%s attempted to mount an
> invalid directory, %s", pwd->pw_name, mntdir);
>         perror(_("Invalid mount point, reporting to administrator"));
> @@ -245,8 +247,17 @@ static int verify_shell(const char *shell_name)
>  }
> 
>  static int seunshare_mount(const char *src, const char *dst, struct
> passwd *pwd) {
> +    struct stat buf;
> +
>     if (verbose)
>         printf("Mount %s on %s\n", src, dst);
> +
> +    /* Preserve mode bits and ownership */
> +    if (stat(dst, &buf) < 0) {
> +        fprintf(stderr, _("Failed to stat %s: %s\n"), dst, strerror(errno));
> +        return -1;
> +    }
> +
>     if (mount(dst, dst,  NULL, MS_BIND | MS_REC, NULL) < 0) {
>         fprintf(stderr, _("Failed to mount %s on %s: %s\n"), dst, dst,
> strerror(errno));
>         return -1;
> @@ -262,6 +273,16 @@ static int seunshare_mount(const char *src, const
> char *dst, struct passwd *pwd)
>         return -1;
>     }
> 
> +    /* Restore original mode bits and ownership */
> +    if (chmod(dst, buf.st_mode) < 0) {
> +        fprintf(stderr, _("Failed to set permissions on %s: %s\n"),
> dst, strerror(errno));
> +        return -1;
> +    }
> +    if (chown(dst, buf.st_uid, buf.st_gid) < 0) {
> +        fprintf(stderr, _("Failed to set ownership on %s: %s\n"),
> dst, strerror(errno));
> +        return -1;
> +    }
> +
>     if (verify_mount(dst, pwd) < 0)
>         return -1;
>  }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
