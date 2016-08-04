Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74CkSk0003828
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 08:46:28 -0400
Subject: Re: [PATCH] policycoreutils: semodule - remove 'q' from getopt string
To: Petr Lautrbach <plautrba@redhat.com>, <selinux@tycho.nsa.gov>
References: <1470313998-28458-1-git-send-email-plautrba@redhat.com>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <cda41a84-0aa7-b2a2-a87a-0368ef2d5c76@tresys.com>
Date: Thu, 4 Aug 2016 08:46:10 -0400
MIME-Version: 1.0
In-Reply-To: <1470313998-28458-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/04/2016 08:33 AM, Petr Lautrbach wrote:
> Users are confused that this option is not documented or that
> 'semodule -q' doesn't show:
> 
> semodule: invalid option -- 'q'
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied. Thanks!

> ---
>  policycoreutils/semodule/semodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index 63900f4..ce048bc 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -209,7 +209,7 @@ static void parse_command_line(int argc, char **argv)
>  	no_reload = 0;
>  	priority = 400;
>  	while ((i =
> -		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
> +		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
>  			    NULL)) != -1) {
>  		switch (i) {
>  		case 'b':
> 
