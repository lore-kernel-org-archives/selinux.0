Subject: Re: [PATCH] libselinux: Change the location of _selinux.so
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1467017173-25285-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fb3dab4b-6082-8ef1-2b2b-3d316bee8eb2@tycho.nsa.gov>
Date: Fri, 1 Jul 2016 12:59:57 -0400
MIME-Version: 1.0
In-Reply-To: <1467017173-25285-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/27/2016 04:46 AM, Petr Lautrbach wrote:
> There was a change in swig-3.10 to use importlib instead of imp. While
> the implementation with imp looked for _selinux.so also into the same directory
> as __init__.py is, a new module with importlib searchs only standard paths.
> It means that we need to move _selinux.so from $(PYLIBDIR)/site-packages/selinux/
> to $(PYLIBDIR)/site-packages/.
> 
> Fixes:
>>>> import selinux
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
>   File "/usr/lib64/python2.7/site-packages/selinux/__init__.py", line 21, in <module>
>     _selinux = swig_import_helper()
>   File "/usr/lib64/python2.7/site-packages/selinux/__init__.py", line 20, in swig_import_helper
>     return importlib.import_module('_selinux')
>   File "/usr/lib64/python2.7/importlib/__init__.py", line 37, in import_module
>     __import__(name)
> ImportError: No module named _selinux
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index d94163e..37d01af 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -156,7 +156,7 @@ install: all
>  
>  install-pywrap: pywrap
>  	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
> -	install -m 755 $(SWIGSO) $(PYLIBDIR)/site-packages/selinux/_selinux.so
> +	install -m 755 $(SWIGSO) $(PYLIBDIR)/site-packages/_selinux.so
>  	install -m 755 $(AUDIT2WHYSO) $(PYLIBDIR)/site-packages/selinux/audit2why.so
>  	install -m 644 $(SWIGPYOUT) $(PYLIBDIR)/site-packages/selinux/__init__.py
>  
> 
