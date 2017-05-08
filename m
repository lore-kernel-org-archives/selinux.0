Message-ID: <1494262043.4621.8.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] sestatus: show checkreqprot status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
 selinux@tycho.nsa.gov
Date: Mon, 08 May 2017 12:47:23 -0400
In-Reply-To: <20170506130848.9128-3-cgzones@googlemail.com>
References: <20170506130848.9128-1-cgzones@googlemail.com>
 <20170506130848.9128-3-cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-05-06 at 15:08 +0200, Christian Göttsche via Selinux
wrote:
> Show the current active checkreqprot state in sestatus

Thanks, applied.  Please add a signed-off-by line in the future.

> ---
>  policycoreutils/sestatus/sestatus.8 |  2 ++
>  policycoreutils/sestatus/sestatus.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/policycoreutils/sestatus/sestatus.8
> b/policycoreutils/sestatus/sestatus.8
> index 51ff0566..a89c53fd 100644
> --- a/policycoreutils/sestatus/sestatus.8
> +++ b/policycoreutils/sestatus/sestatus.8
> @@ -33,6 +33,8 @@ Policy MLS status:           enabled
>  .br
>  Policy deny_unknown status:  allow
>  .br
> +Memory protection checking:  actual (secure)
> +.br
>  Max kernel policy version:   26
>  .RE
>  .sp
> diff --git a/policycoreutils/sestatus/sestatus.c
> b/policycoreutils/sestatus/sestatus.c
> index 2111b15d..b05e794c 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -330,6 +330,20 @@ int main(int argc, char **argv)
>  			break;
>  	}
>  
> +	printf_tab("Memory protection checking:");
> +	rc = security_get_checkreqprot();
> +	switch (rc) {
> +		case 0:
> +			printf("actual (secure)\n");
> +			break;
> +		case 1:
> +			printf("requested (insecure)\n");
> +			break;
> +		default:
> +			printf("error (%s)\n", strerror(errno));
> +			break;
> +	}
> +
>  	rc = security_policyvers();
>  	printf_tab("Max kernel policy version:");
>  	if (rc < 0)
