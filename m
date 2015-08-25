Subject: Re: [PATCH] libselinux: get pywrap depends on selinux.py
To: wenzong.fan@windriver.com, selinux@tycho.nsa.gov
References: <1439539721-25847-1-git-send-email-wenzong.fan@windriver.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55DCBC78.30509@tycho.nsa.gov>
Date: Tue, 25 Aug 2015 15:05:28 -0400
MIME-Version: 1.0
In-Reply-To: <1439539721-25847-1-git-send-email-wenzong.fan@windriver.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/14/2015 04:08 AM, wenzong.fan@windriver.com wrote:
> From: Wenzong Fan <wenzong.fan@windriver.com>
> 
> The selinux.py is generated at compile-time and will be installed as
> python module "selinux/__init__.py", just make sure that it has been
> generated completely while starting "make install-pywrap".
> 
> This fixes below errors that caused by an empty "selinux/__init__.py":
> 
>   $ /usr/sbin/semanage -h
> 
>   Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 30, in <module>
>     import seobject
>   File "/usr/lib64/python2.7/site-packages/seobject.py", line 27, in <module>
>     import sepolicy
>   File "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 226, in <module>
>     def get_file_equiv_modified(fc_path = selinux.selinux_file_context_path()):
>   AttributeError: 'module' object has no attribute 'selinux_file_context_path'
> 
> Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index ac25c1f..a81acc7 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -90,7 +90,7 @@ SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
>  
>  all: $(LIBA) $(LIBSO) $(LIBPC)
>  
> -pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
> +pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)
>  
>  rubywrap: all $(SWIGRUBYSO)

Thanks, applied.
