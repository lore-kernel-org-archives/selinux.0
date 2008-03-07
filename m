Subject: Re: PATCH: fix libsepol tests build error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <200803062202.m26M2ddO026165@cadmus.columbia.tresys.com>
References: <200803062202.m26M2ddO026165@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 07:30:38 -0500
Message-Id: <1204893038.1397.385.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-06 at 17:02 -0500, Todd C. Miller wrote:
> Now that the bulk of policy_parse.y has been split out into
> policy_define.c, libsepol/tests/Makefile needs to link against
> policy_define.o too.
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> 
>  Makefile |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: trunk/libsepol/tests/Makefile
> ===================================================================
> --- trunk/libsepol/tests/Makefile	(revision 2843)
> +++ trunk/libsepol/tests/Makefile	(working copy)
> @@ -16,8 +16,9 @@
>  
>  # test program object files
>  objs := $(patsubst %.c,%.o,$(wildcard *.c))
> -parserobjs := $(CHECKPOLICY)queue.o $(CHECKPOLICY)y.tab.o $(CHECKPOLICY)parse_util.o $(CHECKPOLICY)lex.yy.o \
> -	$(CHECKPOLICY)module_compiler.o
> +parserobjs := $(CHECKPOLICY)queue.o $(CHECKPOLICY)y.tab.o \
> +	$(CHECKPOLICY)parse_util.o $(CHECKPOLICY)lex.yy.o \
> +	$(CHECKPOLICY)policy_define.o $(CHECKPOLICY)module_compiler.o
>  
>  # test policy pieces
>  m4support := $(wildcard policies/support/*.spt)
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
