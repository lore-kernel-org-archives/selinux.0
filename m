Subject: Re: [PATCH] policycoreutils: Use "new" sepolicy icon in .desktop file
 for sepolicy gui
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20161102130437.15464-1-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1fcd09f4-96fa-7c93-7b3b-7cae8c328733@tycho.nsa.gov>
Date: Wed, 2 Nov 2016 09:27:46 -0400
MIME-Version: 1.0
In-Reply-To: <20161102130437.15464-1-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/02/2016 09:04 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> New hires icons have been added to the repository end 2013 but the
> sepolicy .desktop file is not using it, let's fix that.

Thanks, applied.  I plan to move these icon files over to the gui/
directory in the splitpolicycoreutils branch.

> ---
>  policycoreutils/sepolicy/sepolicy.desktop | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/sepolicy/sepolicy.desktop b/policycoreutils/sepolicy/sepolicy.desktop
> index f9d0cec..181a1c5 100644
> --- a/policycoreutils/sepolicy/sepolicy.desktop
> +++ b/policycoreutils/sepolicy/sepolicy.desktop
> @@ -1,7 +1,7 @@
>  [Desktop Entry]
>  Name=SELinux Policy Management Tool
>  Comment=Generate SELinux policy modules
> -Icon=system-config-selinux
> +Icon=sepolicy
>  Exec=/usr/bin/sepolicy gui
>  Type=Application
>  Terminal=false
> 
