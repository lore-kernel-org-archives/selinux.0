Subject: Re: [PATCH] policycoreutils: audit2* - ignore setlocale errors
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1440493030-21469-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55DCBD78.7030400@tycho.nsa.gov>
Date: Tue, 25 Aug 2015 15:09:44 -0400
MIME-Version: 1.0
In-Reply-To: <1440493030-21469-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/25/2015 04:57 AM, Petr Lautrbach wrote:
> When a user has invalid locales set, audit2allow and audit2why fail with
> a traceback. This could be safely ignored as it will stay with 'C'
> locale.
> 
> Fixes:
> Traceback (most recent call last):
>   File "policycoreutils/audit2allow/audit2allow", line 35, in <module>
>     locale.setlocale(locale.LC_ALL, '')
>   File "/usr/lib64/python2.7/locale.py", line 579, in setlocale
>     return _setlocale(category, locale)
> locale.Error: unsupported locale setting
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>  policycoreutils/audit2allow/audit2allow | 5 ++++-
>  policycoreutils/audit2allow/audit2why   | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
> index 6bbab40..e23e418 100644
> --- a/policycoreutils/audit2allow/audit2allow
> +++ b/policycoreutils/audit2allow/audit2allow
> @@ -32,7 +32,10 @@ import sepolgen.module as module
>  from sepolgen.sepolgeni18n import _
>  import selinux.audit2why as audit2why
>  import locale
> -locale.setlocale(locale.LC_ALL, '')
> +try:
> +    locale.setlocale(locale.LC_ALL, '')
> +except:
> +    pass
>  
>  
>  class AuditToPolicy:
> diff --git a/policycoreutils/audit2allow/audit2why b/policycoreutils/audit2allow/audit2why
> index 3909b97..b1489ed 100644
> --- a/policycoreutils/audit2allow/audit2why
> +++ b/policycoreutils/audit2allow/audit2why
> @@ -32,7 +32,10 @@ import sepolgen.module as module
>  from sepolgen.sepolgeni18n import _
>  import selinux.audit2why as audit2why
>  import locale
> -locale.setlocale(locale.LC_ALL, '')
> +try:
> +    locale.setlocale(locale.LC_ALL, '')
> +except:
> +    pass
>  
>  
>  class AuditToPolicy:
> 
