Message-ID: <1483986415.20858.80.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libselinux: Rewrite restorecon() python method
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Mon, 09 Jan 2017 13:26:55 -0500
In-Reply-To: <20161222124309.27686-3-plautrba@redhat.com>
References: <20161222124309.27686-1-plautrba@redhat.com>
 <20161222124309.27686-3-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2016-12-22 at 13:43 +0100, Petr Lautrbach wrote:
> When the restorecon method was added to the libselinux swig python
> bindings, there was no libselinux restorecon implementation and it
> he had to call matchpathcon() which is deprecated in favor of
> selabel_lookup().
> 
> The new restorecon method uses selinux_restorecon method from
> libselinux
> and which is exported by the previous commit.
> 
> https://github.com/SELinuxProject/selinux/issues/29
> 
> Fixes:
> > 
> > > 
> > > > 
> > > > selinux.restorecon('/var/lib', recursive=True)
> Traceback (most recent call last):
>   File "/usr/lib64/python3.5/site-packages/selinux/__init__.py", line
> 114, in restorecon
>     status, context = matchpathcon(path, mode)
> FileNotFoundError: [Errno 2] No such file or directory
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied both patches.

> ---
>  libselinux/src/selinuxswig_python.i | 42 +++++++++++++++----------
> ------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/libselinux/src/selinuxswig_python.i
> b/libselinux/src/selinuxswig_python.i
> index a239f30..be17cef 100644
> --- a/libselinux/src/selinuxswig_python.i
> +++ b/libselinux/src/selinuxswig_python.i
> @@ -19,31 +19,23 @@ DISABLED = -1
>  PERMISSIVE = 0
>  ENFORCING = 1
>  
> -def restorecon(path, recursive=False):
> -    """ Restore SELinux context on a given path """
> -
> -    try:
> -        mode = os.lstat(path)[stat.ST_MODE]
> -        status, context = matchpathcon(path, mode)
> -    except OSError:
> -        path = os.path.realpath(os.path.expanduser(path))
> -        mode = os.lstat(path)[stat.ST_MODE]
> -        status, context = matchpathcon(path, mode)
> -
> -    if status == 0:
> -        try:
> -            status, oldcontext = lgetfilecon(path)
> -        except OSError as e:
> -            if e.errno != errno.ENODATA:
> -                raise
> -            oldcontext = None
> -        if context != oldcontext:
> -            lsetfilecon(path, context)
> -
> -        if recursive:
> -            for root, dirs, files in os.walk(path):
> -                for name in files + dirs:
> -                   restorecon(os.path.join(root, name))
> +def restorecon(path, recursive=False, verbose=False):
> +    """ Restore SELinux context on a given path
> +
> +    Arguments:
> +    path -- The pathname for the file or directory to be relabeled.
> +
> +    Keyword arguments:
> +    recursive -- Change files and directories file labels
> recursively (default False)
> +    verbose -- Show changes in file labels (default False)
> +    """
> +
> +    restorecon_flags = SELINUX_RESTORECON_IGNORE_DIGEST |
> SELINUX_RESTORECON_REALPATH
> +    if recursive:
> +        restorecon_flags |= SELINUX_RESTORECON_RECURSE
> +    if verbose:
> +        restorecon_flags |= SELINUX_RESTORECON_VERBOSE
> +    selinux_restorecon(os.path.expanduser(path), restorecon_flags)
>  
>  def chcon(path, context, recursive=False):
>      """ Set the SELinux context on a given path """
