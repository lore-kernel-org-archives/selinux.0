Subject: Re: [PATCH] libselinux: Fix restorecon when path has no context
To: Nir Soffer <nirsof@gmail.com>, selinux@tycho.nsa.gov
References: <1442712141-5736-1-git-send-email-nsoffer@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56016C3F.5040500@tycho.nsa.gov>
Date: Tue, 22 Sep 2015 10:57:03 -0400
MIME-Version: 1.0
In-Reply-To: <1442712141-5736-1-git-send-email-nsoffer@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/19/2015 09:22 PM, Nir Soffer wrote:
> When a path has no context, for example, when the file was created when
> selinux was disabled, selinux.restorecon(path) will fail:
> 
>     >>> selinux.restorecon('/etc/multipath.conf.new')
>     Traceback (most recent call last):
>       File "<stdin>", line 1, in <module>
>       File "/usr/lib64/python2.7/site-packages/selinux/__init__.py", line 88,
>       in restorecon
>         status, oldcontext = lgetfilecon(path)
>     OSError: [Errno 61] No data available
> 
> This failure does not seems to be useful, as we can successfully match
> the context for this path using selinux.matchpathcon(), and set it
> successfully using selinux.chcon(). The failure is caused by trying to
> avoid the lsetfilecon() call if the current context is does not need
> update.
> 
> This patch handles this specific error from lgetfilecon(), preventing
> this failure.
> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>

Thanks, applied.

> ---
>  libselinux/src/selinuxswig_python.i | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
> index c9a2341..8cea18d 100644
> --- a/libselinux/src/selinuxswig_python.i
> +++ b/libselinux/src/selinuxswig_python.i
> @@ -8,7 +8,7 @@
>  
>  %pythoncode %{
>  
> -import shutil, os, stat
> +import shutil, os, errno, stat
>  
>  DISABLED = -1
>  PERMISSIVE = 0
> @@ -26,7 +26,12 @@ def restorecon(path, recursive=False):
>          status, context = matchpathcon(path, mode)
>  
>      if status == 0:
> -        status, oldcontext = lgetfilecon(path)
> +        try:
> +            status, oldcontext = lgetfilecon(path)
> +        except OSError as e:
> +            if e.errno != errno.ENODATA:
> +                raise
> +            oldcontext = None
>          if context != oldcontext:
>              lsetfilecon(path, context)
>  
> 
