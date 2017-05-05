Message-ID: <1494007804.5745.15.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] sestatus: show checkreqprot status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
 selinux@tycho.nsa.gov
Date: Fri, 05 May 2017 14:10:04 -0400
In-Reply-To: <20170504204538.17853-3-cgzones@googlemail.com>
References: <20170504204538.17853-1-cgzones@googlemail.com>
 <20170504204538.17853-3-cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-04 at 22:45 +0200, Christian Göttsche via Selinux
wrote:
> Show the current active checkreqprot state in sestatus
> ---
>  policycoreutils/sestatus/sestatus.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/policycoreutils/sestatus/sestatus.c
> b/policycoreutils/sestatus/sestatus.c
> index 2111b15d..a461251d 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -330,6 +330,20 @@ int main(int argc, char **argv)
>  			break;
>  	}
>  
> +	printf_tab("Current checkreqprot mode:");
> +	rc = security_get_checkreqprot();
> +	switch (rc) {
> +		case 0:
> +			printf("Kernel preset\n");

As with the other one, "kernel preset" isn't very clear.  The
difference is between the actual protection applied by the kernel and
the protection requested by the application.

> +			break;
> +		case 1:
> +			printf("Application requested\n");
> +			break;
> +		default:
> +			printf("error (%s)\n", strerror(errno));
> +			break;
> +	}
> +
>  	rc = security_policyvers();
>  	printf_tab("Max kernel policy version:");
>  	if (rc < 0)

Don't think this really conveys the right meaning or will be
understandable to users. My previous suggestions were:
Check requested protection: false/true
or
Memory protection checking: actual/requested
or
Memory protection checking: secure/insecure

Even if you really want to stick with "Current checkreqprot mode:", the
values (false/true, actual/requested, secure/insecure) still make
sense.
