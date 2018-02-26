To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180222133320.6111-1-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7488158e-5cc8-3ad8-150d-6e0423281dc7@tycho.nsa.gov>
Date: Mon, 26 Feb 2018 09:52:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180222133320.6111-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] semodule-utils/semodule_package: fix semodule_unpackage
 man page
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/22/2018 08:33 AM, Vit Mojzis wrote:
> Fix command line arguments and description in man page.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1334834
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied.

> ---
>  semodule-utils/semodule_package/semodule_unpackage.8 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/semodule-utils/semodule_package/semodule_unpackage.8 b/semodule-utils/semodule_package/semodule_unpackage.8
> index d6e1be0a..5c92bf51 100644
> --- a/semodule-utils/semodule_package/semodule_unpackage.8
> +++ b/semodule-utils/semodule_package/semodule_unpackage.8
> @@ -1,14 +1,14 @@
>  .TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
>  .SH NAME
> -semodule_unpackage \- Extract policy module and file context file from an SELinux policy module unpackage.
> +semodule_unpackage \- Extract policy module and file context file from an SELinux policy module package.
>  
>  .SH SYNOPSIS
> -.B semodule_unpackage <module> [<file contexts>]
> +.B semodule_unpackage ppfile modfile [fcfile]
>  .br
>  .SH DESCRIPTION
>  .PP
> -semodule_unpackage is the tool used to extract the SELinux policy module
> - and file context file from an SELinux Policy Package.
> +semodule_unpackage is a tool used to extract SELinux policy module
> +file and file context file from an SELinux Policy Package.
>  
>  .SH EXAMPLE
>  .nf
> 
