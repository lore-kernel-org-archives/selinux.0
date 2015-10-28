Subject: Re: [PATCH] Load libsepol.so.1 instead of libsepol.so
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <1445985691-15518-1-git-send-email-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5630C8CA.4030907@tycho.nsa.gov>
Date: Wed, 28 Oct 2015 09:08:26 -0400
MIME-Version: 1.0
In-Reply-To: <1445985691-15518-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/27/2015 06:41 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <l.bigonville@edpnet.be>
>
> libsepol.so symlink is usually part of the development package, try to
> load the library directly instead.

Thanks, applied.  Next time, please remember to add your Signed-off-by 
and include a prefix in the subject line indicating the component 
affected (e.g. [PATCH] libsemanage: semanage_migrate_store: Load 
libsepol.so.1 instead of libsepol.so).

> ---
>   libsemanage/utils/semanage_migrate_store | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> index b5eefaa..0ebd285 100755
> --- a/libsemanage/utils/semanage_migrate_store
> +++ b/libsemanage/utils/semanage_migrate_store
> @@ -10,7 +10,7 @@ from optparse import OptionParser
>
>   import ctypes
>
> -sepol = ctypes.cdll.LoadLibrary('libsepol.so')
> +sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
>
>   try:
>   	import selinux
>
