Subject: Re: [PATCH 4/4] libsepol,libsemanage: write file name in flex output
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161128214018.7861-1-nicolas.iooss@m4x.org>
 <20161128214018.7861-4-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f9df7cba-3d9c-870a-2673-9a4193b380c3@tycho.nsa.gov>
Date: Tue, 29 Nov 2016 08:59:13 -0500
MIME-Version: 1.0
In-Reply-To: <20161128214018.7861-4-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/28/2016 04:40 PM, Nicolas Iooss wrote:
> Tools like lcov (for code coverage) does not like files named
> "<stdout>". For example it reports errors like:
> 
>     genhtml: ERROR: cannot read
>     /usr/src/selinux/libsemanage/src/<stdout>
> 
> When using flex -o option, the output file name gets written in the
> generated C code, which solves this issue.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all four.

> ---
>  libsemanage/src/Makefile | 2 +-
>  libsepol/src/Makefile    | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index ef25902bb019..df5809645a00 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -101,7 +101,7 @@ semanageswig_python_exception.i: ../include/semanage/semanage.h
>  	bash -e exception.sh > $@ || (rm -f $@ ; false)
>  
>  conf-scan.c: conf-scan.l conf-parse.h
> -	$(LEX) $(LFLAGS) -t $< > $@
> +	$(LEX) $(LFLAGS) -o $@ $<
>  
>  conf-parse.c: conf-parse.y
>  	$(YACC) $(YFLAGS) -o $@ $<
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 72724580eb98..497cd5675bd9 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -67,7 +67,8 @@ $(CILDIR)/src/cil_lexer.lo: $(CILDIR)/src/cil_lexer.c
>  	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
>  
>  $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
> -	$(LEX) -t $< > $@
> +	$(LEX) -o $@ $<
> +
>  endif
>  
>  %.o:  %.c 
> 
