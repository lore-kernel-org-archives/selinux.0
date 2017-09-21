Message-ID: <1506025105.12380.9.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Thu, 21 Sep 2017 16:18:25 -0400
In-Reply-To: <20170919204916.2943-1-nicolas.iooss@m4x.org>
References: <20170919204916.2943-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/1] sepolicy: do not fail when file_contexts.local
 or .subs do not exist
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-09-19 at 22:49 +0200, Nicolas Iooss wrote:
> On a system without any file context customizations, "sepolicy gui"
> fails to load because it tries to read a non-existing file:
> 
>     FileNotFoundError: [Errno 2] No such file or directory:
>     '/etc/selinux/refpolicy-git/contexts/files/file_contexts.local'
> 
> Once this issue is fixed, another one is triggered:
> 
>     FileNotFoundError: [Errno 2] No such file or directory:
>     '/etc/selinux/refpolicy-git/contexts/files/file_contexts.subs
> 
> Use try/except to catch these exceptions and use OSError/errno.ENOENT
> to
> keep the code compatible with Python 2.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  python/sepolicy/sepolicy/__init__.py | 36 +++++++++++++++++++++++---
> ----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/__init__.py
> b/python/sepolicy/sepolicy/__init__.py
> index 03742346caf0..d41fc6ae1543 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -4,6 +4,7 @@
>  # Author: Ryan Hallisey <rhallise@redhat.com>
>  # Author: Jason Zaman <perfinion@gentoo.org>
>  
> +import errno
>  import selinux
>  import setools
>  import glob
> @@ -523,12 +524,15 @@ def find_entrypoint_path(exe, exclude_list=[]):
>  
>  
>  def read_file_equiv(edict, fc_path, modify):
> -    fd = open(fc_path, "r")
> -    fc = fd.readlines()
> -    fd.close()
> -    for e in fc:
> -        f = e.split()
> -        edict[f[0]] = {"equiv": f[1], "modify": modify}
> +    try:
> +        with open(fc_path, "r") as fd:
> +            fc = fd.readlines()
> +            for e in fc:
> +                f = e.split()
> +                edict[f[0]] = {"equiv": f[1], "modify": modify}
> +    except OSError as e:
> +        if e.errno != errno.ENOENT:
> +            raise
>      return edict
>  
>  
> @@ -555,9 +559,13 @@ def
> get_local_file_paths(fc_path=selinux.selinux_file_context_path()):
>      if local_files:
>          return local_files
>      local_files = []
> -    fd = open(fc_path + ".local", "r")
> -    fc = fd.readlines()
> -    fd.close()
> +    try:
> +        with open(fc_path + ".local", "r") as fd:
> +            fc = fd.readlines()
> +    except OSError as e:
> +        if e.errno != errno.ENOENT:
> +            raise
> +        return []
>      for i in fc:
>          rec = i.split()
>          if len(rec) == 0:
> @@ -585,10 +593,12 @@ def
> get_fcdict(fc_path=selinux.selinux_file_context_path()):
>      fc += fd.readlines()
>      fd.close()
>      fcdict = {}
> -    if os.path.exists(fc_path + ".local"):
> -        fd = open(fc_path + ".local", "r")
> -        fc += fd.readlines()
> -        fd.close()
> +    try:
> +        with open(fc_path + ".local", "r") as fd:
> +            fc += fd.readlines()
> +    except OSError as e:
> +        if e.errno != errno.ENOENT:
> +            raise
>  
>      for i in fc:
>          rec = i.split()
