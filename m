Subject: Re: PATCH: avoid -Werror for parser-generated sources
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200802271843.m1RIhvvc004382@cadmus.columbia.tresys.com>
References: <200802271843.m1RIhvvc004382@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 13:53:55 -0500
Message-Id: <1204138435.31790.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-27 at 13:43 -0500, Todd C. Miller wrote:
> We've been bitten repeatedly by changes in lex and yacc resulting in
> new compiler warnings.  Now that we build with -Werror this can result
> in broken builds.  Since we have little control over what lex and yacc
> generate, just filter out -Werror when compiling their .c files.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Maybe we should move all of our own functions out of the .y files into
separate .c files too and just #include function prototypes for them
into the .y files.  Otherwise we loose the strict error checking on our
action routines.

> 
>  checkpolicy/Makefile     |    4 ++--
>  libsemanage/src/Makefile |   12 ++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> Index: trunk/libsemanage/src/Makefile
> ===================================================================
> --- trunk/libsemanage/src/Makefile	(revision 2811)
> +++ trunk/libsemanage/src/Makefile	(working copy)
> @@ -71,6 +71,18 @@
>  %.lo:  %.c
>  	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>  
> +conf-parse.o:  conf-parse.c
> +	$(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
> +
> +conf-parse.lo:  conf-parse.c
> +	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
> +
> +conf-scan.o:  conf-scan.c
> +	$(CC) $(filter-out -Werror, $(CFLAGS)) -c -o $@ $<
> +
> +conf-scan.lo:  conf-scan.c
> +	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
> +
>  $(SWIGCOUT): $(SWIGIF)
>  	$(SWIG) $^
>  
> Index: trunk/checkpolicy/Makefile
> ===================================================================
> --- trunk/checkpolicy/Makefile	(revision 2811)
> +++ trunk/checkpolicy/Makefile	(working copy)
> @@ -33,10 +33,10 @@
>  	$(CC) $(CFLAGS) -o $@ -c $<
>  
>  y.tab.o: y.tab.c
> -	$(CC) $(CFLAGS) -o $@ -c $<
> +	$(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
>  
>  lex.yy.o: lex.yy.c
> -	$(CC) $(CFLAGS) -o $@ -c $<
> +	$(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
>  
>  y.tab.c: policy_parse.y
>  	$(YACC) -d policy_parse.y
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
