Message-ID: <4BB28AA1.9060508@tycho.nsa.gov>
Date: Tue, 30 Mar 2010 19:34:57 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Add implicit lib requirements to LDLIBS
References: <1269983319-10453-1-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1269983319-10453-1-git-send-email-jbrindle@tresys.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/30/2010 05:08 PM, Joshua Brindle wrote:
> Fedora 13 changed their linker behavior to not link indirect libraries.
> See information at: http://fedoraproject.org/wiki/UnderstandingDSOLinkChange
>   

I skimmed over semodule.c and setsebool.c and I didn't see any
references to bzip2 or ustr symbols.  My reading of the article suggests
the below fix should only be needed if that were the case.  Most likely
I missed them?

Without this patch, do you get the linker error that says to add them?



> Resent, it doesn't look like it made it to the list the first time (and the subject had a typo)
>
> Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
> ---
>  policycoreutils/semodule/Makefile  |    2 +-
>  policycoreutils/setsebool/Makefile |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
> index c96a286..a0bbc21 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -I$(INCLUDEDIR)
> -LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
> +LDLIBS = -lsepol -lselinux -lsemanage -lbz2 -lustr -L$(LIBDIR) 
>  SEMODULE_OBJS = semodule.o
>  
>  all: semodule
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
> index 556b780..1b89d5c 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -7,7 +7,7 @@ LIBDIR ?= ${PREFIX}/lib
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -I$(INCLUDEDIR)
> -LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
> +LDLIBS = -lsepol -lselinux -lsemanage -lbz2 -lustr -L$(LIBDIR)
>  SETSEBOOL_OBJS = setsebool.o
>  
>  all: setsebool
>   


-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
