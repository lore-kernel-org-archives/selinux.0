Subject: Re: [PATCH v2] libselinux: Add clean-pywrap and clean-rubywrap targets
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20161026214154.32509-1-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <748a0b5a-812a-bbab-0a3c-51102e08678f@tycho.nsa.gov>
Date: Thu, 27 Oct 2016 10:45:23 -0400
MIME-Version: 1.0
In-Reply-To: <20161026214154.32509-1-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/26/2016 05:41 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Add clean targets to just clean the python and ruby wrapper objects
> 
> Also clean $(SWIGRUBYSO) and $(AUDIT2WHYLOBJ) objects
> 
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>

Thanks, applied.

> ---
>  libselinux/Makefile     |  6 ++++++
>  libselinux/src/Makefile | 12 +++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index ef971f4..979e225 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -57,4 +57,10 @@ install-pywrap:
>  install-rubywrap: 
>  	$(MAKE) -C src install-rubywrap $@
>  
> +clean-pywrap:
> +	$(MAKE) -C src clean-pywrap $@
> +
> +clean-rubywrap:
> +	$(MAKE) -C src clean-rubywrap $@
> +
>  test:
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index ccd8442..c9f35b1 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -187,8 +187,14 @@ install-rubywrap: rubywrap
>  relabel:
>  	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
>  
> -clean: 
> -	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGRUBYLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
> +clean-pywrap:
> +	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
> +
> +clean-rubywrap:
> +	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
> +
> +clean: clean-pywrap clean-rubywrap
> +	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) *.o *.lo *~
>  
>  distclean: clean
>  	rm -f $(GENERATED) $(SWIGFILES)
> @@ -196,4 +202,4 @@ distclean: clean
>  indent:
>  	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>  
> -.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
> +.PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
> 
