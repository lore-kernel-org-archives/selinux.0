Subject: Re: [PATCH v2] policycoreutils: Minor fix in a French translation
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <1463495736-4529-1-git-send-email-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3e5ca018-5ccf-d0c5-9f9e-36754d9eeef6@tycho.nsa.gov>
Date: Thu, 19 May 2016 14:34:53 -0400
MIME-Version: 1.0
In-Reply-To: <1463495736-4529-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/17/2016 10:35 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>

Thanks, applied.  Missing signed-off-by though.

> 
> ---
>  policycoreutils/po/fr.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/po/fr.po b/policycoreutils/po/fr.po
> index be33d59..5c797c9 100644
> --- a/policycoreutils/po/fr.po
> +++ b/policycoreutils/po/fr.po
> @@ -1307,7 +1307,7 @@ msgstr "syntaxe :  %s [-q]\n"
>  #: ../load_policy/load_policy.c:71
>  #, c-format
>  msgid "%s:  Policy is already loaded and initial load requested\n"
> -msgstr "La stratégie %s est déjà chargée et un chargement initial est requis\n"
> +msgstr "%s : La stratégie est déjà chargée et un chargement initial est demandé\n"
>  
>  #: ../load_policy/load_policy.c:80
>  #, c-format
> 
