Subject: Re: [PATCH] policycoreutils: fix the extract example in semodule.8
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <ec899032-388e-8ad2-5f58-03e5e052646b@redhat.com>
 <1463413471-23637-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <432b409a-06e3-7869-7201-49877a00e15c@tycho.nsa.gov>
Date: Mon, 16 May 2016 16:47:17 -0400
MIME-Version: 1.0
In-Reply-To: <1463413471-23637-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/16/2016 11:44 AM, Petr Lautrbach wrote:
> The man page's example suggested to use -g instead of -E and used --cil
> and --hll options on the wrong positions.

Thanks, applied.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  policycoreutils/semodule/semodule.8 | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
> index 6db390c..68e95ab 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -88,10 +88,12 @@ Use an alternate path for the policy store root
>  be verbose
>  .TP
>  .B  \-c,\-\-cil
> -Extract module as a CIL file. This only affects the \-\-extract option.
> +Extract module as a CIL file. This only affects the \-\-extract option and
> +only modules listed in \-\-extract after this option.
>  .TP
>  .B  \-H,\-\-hll
> -Extract module as an HLL file. This only affects the \-\-extract option.
> +Extract module as an HLL file. This only affects the \-\-extract option and
> +only modules listed in \-\-extract after this option.
>  
>  .SH EXAMPLE
>  .nf
> @@ -121,7 +123,7 @@ $ semodule \-B \-p "/tmp"
>  $ semodule \-B \-S "/tmp/var/lib/selinux"
>  # Write the HLL version of puppet and the CIL version of wireshark
>  # modules at priority 400 to the current working directory
> -$ semodule \-X 400 \-g wireshark \-\-cil \-g puppet \-\-hll
> +$ semodule \-X 400 \-\-hll \-E puppet \-\-cil \-E wireshark
>  .fi
>  
>  .SH SEE ALSO
> 
