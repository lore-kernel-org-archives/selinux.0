Subject: Re: [PATCH 1/1] secilc: do not build secilc man page if it is up to
 date
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161114213324.16130-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b9f0eca2-4418-14ca-56de-61ed3920bb69@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 11:10:38 -0500
MIME-Version: 1.0
In-Reply-To: <20161114213324.16130-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/14/2016 04:33 PM, Nicolas Iooss wrote:
> When running "make all" several times in the root directory of the
> project, the following lines always appear (and the command takes some
> seconds to complete on my system with a slow hard drive):
> 
>     xmlto man secilc.8.xml
>     Note: Writing secilc.8
> 
> This is because "make man" always builds secilc.8 even though
> secilc.8.xml has not been modified. Introduce an intermediate target to
> avoid this behavior.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  secilc/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/secilc/Makefile b/secilc/Makefile
> index 9bea186ba0b9..40254ce44caf 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -25,7 +25,9 @@ $(SECILC): $(SECILC_OBJS)
>  test: $(SECILC)
>  	./$(SECILC) test/policy.cil
>  
> -man: $(MANPAGE).xml
> +man: $(MANPAGE)
> +
> +$(MANPAGE): $(MANPAGE).xml
>  	$(XMLTO) man $(MANPAGE).xml
>  
>  install: all man
> 
