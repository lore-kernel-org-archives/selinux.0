Message-ID: <1492104956.31284.5.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] sestatus: show checkreqprot status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
 selinux@tycho.nsa.gov
Date: Thu, 13 Apr 2017 13:35:56 -0400
In-Reply-To: <20170412220038.9792-3-cgzones@googlemail.com>
References: <20170412220038.9792-1-cgzones@googlemail.com>
 <20170412220038.9792-3-cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-13 at 00:00 +0200, Christian Göttsche wrote:
> From: cgzones <cgzones@googlemail.com>
> 
> Show the current active checkreqprot state in sestatus
> ---
>  policycoreutils/sestatus/sestatus.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/policycoreutils/sestatus/sestatus.c
> b/policycoreutils/sestatus/sestatus.c
> index 2111b15d..f9ed5b66 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -330,6 +330,20 @@ int main(int argc, char **argv)
>  			break;
>  	}
>  
> +	printf_tab("Policy checkreqprot status:");

checkreqprot isn't defined by the policy (like Current mode/enforcing),
so it isn't really the "Policy checkreqprot status", unlike MLS or
deny_unknown.  It is more like Current mode (i.e. enforcing).

> +	rc = security_checkreqprot();
> +	switch (rc) {
> +		case 0:
> +			printf("kernel\n");
> +			break;
> +		case 1:
> +			printf("application\n");
> +			break;
> +		default:
> +			printf("error (%s)\n", strerror(errno));
> +			break;
> +	}
> +

Trying to think how understandable and meaningful this would be to a
user.  Possible alternatives:
Check requested protection: false/true
Memory protection checking: actual/requested

Or if we want to convey a value judgment on preferred settings:
Memory protection checking: secure/insecure

Open to discussion on it, just not sure that
checkreqprot status: kernel/application
will make sense to users.

>  	rc = security_policyvers();
>  	printf_tab("Max kernel policy version:");
>  	if (rc < 0)
