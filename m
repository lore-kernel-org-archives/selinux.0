Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9ANHqmi019154
 for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2017 19:17:55 -0400
To: Thomas Meyer <thomas@m3y3r.de>, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, james.l.morris@oracle.com, serge@hallyn.com,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
 <1507383097088-1068794175-19-diffsplit-thomas@m3y3r.de>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5d4bccdd-c1e9-f32a-2d3b-13fd13d2f5e6@schaufler-ca.com>
Date: Tue, 10 Oct 2017 16:17:45 -0700
MIME-Version: 1.0
In-Reply-To: <1507383097088-1068794175-19-diffsplit-thomas@m3y3r.de>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] selinux: Fix bool initialization/comparison
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/7/2017 7:02 AM, Thomas Meyer wrote:
> Bool initializations should use true and false. Bool tests don't need
> comparisons.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>
> diff -u -p a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -550,7 +550,7 @@ int mls_compute_sid(struct context *scon
>  
>  		/* Fallthrough */
>  	case AVTAB_CHANGE:
> -		if ((tclass == policydb.process_class) || (sock == true))
> +		if ((tclass == policydb.process_class) || (sock))

bool tests don't need parentheses, either.

	+	if ((tclass == policydb.process_class) || sock)

>  			/* Use the process MLS attributes. */
>  			return mls_context_cpy(newcontext, scontext);
>  		else
> diff -u -p a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1656,7 +1656,7 @@ static int security_compute_sid(u32 ssid
>  	} else if (cladatum && cladatum->default_role == DEFAULT_TARGET) {
>  		newcontext.role = tcontext->role;
>  	} else {
> -		if ((tclass == policydb.process_class) || (sock == true))
> +		if ((tclass == policydb.process_class) || (sock))

Likewise

>  			newcontext.role = scontext->role;
>  		else
>  			newcontext.role = OBJECT_R_VAL;
> @@ -1668,7 +1668,7 @@ static int security_compute_sid(u32 ssid
>  	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
>  		newcontext.type = tcontext->type;
>  	} else {
> -		if ((tclass == policydb.process_class) || (sock == true)) {
> +		if ((tclass == policydb.process_class) || (sock)) {

On more time.

>  			/* Use the type of process. */
>  			newcontext.type = scontext->type;
>  		} else {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
