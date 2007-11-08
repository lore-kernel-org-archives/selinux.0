Subject: Re: [PATCH] restorecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Litwiniec Robert <linio@wonder.pl>
Cc: SELinux list <selinux@tycho.nsa.gov>
In-Reply-To: <20071108063657.GA21903@asterix.wonder.pl>
References: <20071108063657.GA21903@asterix.wonder.pl>
Content-Type: text/plain
Date: Thu, 08 Nov 2007 12:43:41 -0500
Message-Id: <1194543821.3198.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-08 at 07:36 +0100, Litwiniec Robert wrote:
> Hello,
> i wrote patch for restorecon, which warns, if file has hardlinks, and
> file which has hardlinks is relabeled second time since run restorecon
> (it's a hack, check is based on change time):

Thanks, however, if you look at setfiles, you'll find that it has more
extensive logic for checking for conflicts on multiple hard links
(maintains inode associations).  Also, in the selinux trunk
(policycoreutils 2.0.18 and later), restorecon is no longer a separate
program from setfiles - they have been coalesced into a single program
that selects different default behaviors and command line interfaces
depending on argv[0].

> 
> --- restorecon.orig.c   2007-09-27 21:53:22.000000000 +0200
> +++ restorecon.c        2007-09-27 21:52:31.000000000 +0200
> @@ -40,6 +40,7 @@
>  #include <stdio.h>
>  #define __USE_XOPEN_EXTENDED 1 /* nftw */
>  #include <ftw.h>
> +#include <time.h>
>  
>  static int change = 1;
>  static int verbose = 0;
> @@ -53,6 +54,8 @@
>  #define STAT_BLOCK_SIZE 1
>  static int pipe_fds[2] = { -1, -1 };
>  static unsigned long long count = 0;
> +static time_t starttime;
> +
>  
>  #define MAX_EXCLUDES 100
>  static int excludeCtr = 0;
> @@ -248,6 +251,12 @@
>                                 if (outfile)
>                                         fprintf(outfile, "%s\n", filename);
>                                 if (change) {
> +                                       if ( (st.st_nlink>1) ) {
> +                                               fprintf(stderr, "warning: %s has hard links\n", filename);
> +                                               if ( st.st_ctime>=starttime) {
> +                                                       fprintf(stderr, "warning: %s changed since run restorecon\n", filename);
> +                                               }
> +                                       }
>                                         if (lsetfilecon(filename, scontext) < 0) {
>                                                 fprintf(stderr,
>                                                         "%s set context %s->%s failed:'%s'\n",
> @@ -358,6 +367,7 @@
>         int opt;
>         char *buf = NULL;
>         size_t buf_len;
> +        starttime = time (NULL);
>  
>         memset(excludeArray, 0, sizeof(excludeArray));
> 
> Regards,
> Robert Litwiniec 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
