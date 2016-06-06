Subject: Re: [PATCH] policycoreutils/semodule: Fix the documentation of
 -l,--list
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <6a2dd3fa-1b9d-f2a8-a39d-7b72ac9570a0@tycho.nsa.gov>
 <1464076949-27068-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5e86e3dc-0ec4-3dff-5412-414a614e04c4@tycho.nsa.gov>
Date: Mon, 6 Jun 2016 13:12:13 -0400
MIME-Version: 1.0
In-Reply-To: <1464076949-27068-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/24/2016 04:02 AM, Petr Lautrbach wrote:
> It wasn't clear how to use -l option with full/standard KIND and the
> example in semodule.8 man page was wrong.
>
> Based on a patch by Laurent Bigonville <bigon@bigon.be>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,

> ---
>  policycoreutils/semodule/semodule.8 | 4 ++--
>  policycoreutils/semodule/semodule.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
> index 68e95ab..0c5fdf7 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -38,7 +38,7 @@ deprecated, alias for --install
>  .B  \-r,\-\-remove=MODULE_NAME
>  remove existing module
>  .TP
> -.B  \-l,\-\-list-modules=[KIND]
> +.B  \-l[KIND],\-\-list-modules[=KIND]
>  display list of installed modules (other than base)
>  .TP
>  .B  \-E,\-\-extract=MODULE_PKG
> @@ -116,7 +116,7 @@ $ semodule \-d alsa
>  # Install a module at a specific priority.
>  $ semodule \-X 100 \-i alsa.pp
>  # List all modules.
> -$ semodule \-l full
> +$ semodule \-\-list=full
>  # Set an alternate path for the policy root
>  $ semodule \-B \-p "/tmp"
>  # Set an alternate path for the policy store root
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index bcfaa2b..63900f4 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -127,7 +127,7 @@ static void usage(char *progname)
>  	printf("  -B, --build		    build and reload policy\n");
>  	printf("  -i,--install=MODULE_PKG   install a new module\n");
>  	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
> -	printf("  -l,--list-modules=[KIND]  display list of installed modules\n");
> +	printf("  -l[KIND],--list-modules[=KIND]  display list of installed modules\n");
>  	printf("     KIND:  standard  list highest priority, enabled modules\n");
>  	printf("            full      list all modules\n");
>  	printf("  -X,--priority=PRIORITY    set priority for following operations (1-999)\n");
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
