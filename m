Subject: Re: [PATCH] fix PPC compile issues
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1139172035.8084.34.camel@gorn.pebenito.net>
References: <1139172035.8084.34.camel@gorn.pebenito.net>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 09:44:20 -0500
Message-Id: <1139237060.31135.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-02-05 at 15:40 -0500, Chris PeBenito wrote:
> The attached patch changes variables used to store results of getopt()
> from char to int, as int is the return of getopt(), and char is unsigned
> by default on PPC, making tests like if (opt == -1) always false:
> 
> cc -Werror -Wall -W -I/usr/include   -c -o semodule_link.o
> semodule_link.c
> semodule_link.c: In function `main':
> semodule_link.c:84: warning: comparison is always true due to limited
> range of data type
> 
> 
>  semodule_expand/semodule_expand.c |    4 ++--
>  semodule_link/semodule_link.c     |    4 ++--
>  sestatus/sestatus.c               |    3 +--
>  3 files changed, 5 insertions(+), 6 deletions(-)

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
