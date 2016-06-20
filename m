Subject: Re: [PATCH 1/2] Modify audit2why analyze function to use loaded policy
To: Joshua Brindle <brindle@quarksecurity.com>, selinux <selinux@tycho.nsa.gov>
References: <1464966566-14597-1-git-send-email-brindle@quarksecurity.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3e33ffae-4cee-9c5f-0e81-71bfe738be7a@tycho.nsa.gov>
Date: Mon, 20 Jun 2016 16:33:41 -0400
MIME-Version: 1.0
In-Reply-To: <1464966566-14597-1-git-send-email-brindle@quarksecurity.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/03/2016 11:09 AM, Joshua Brindle wrote:
> Class and perms should come from the policy being used for analysis,
> not the system policy so use sepol_ interfaces
> 
> Change-Id: Ia0590ed2514249fd98810a8d4fe87f8bf5280561
> Signed-off-by: Joshua Brindle <brindle@quarksecurity.com>
> ---
>  libselinux/src/audit2why.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, applied.

> 
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 12745b3..abe1701 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -343,8 +343,8 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
>  	if (rc < 0)
>  		RETURN(BADTCON)
>  
> -	tclass = string_to_security_class(tclassstr);
> -	if (!tclass)
> +	rc = sepol_string_to_security_class(tclassstr, &tclass);
> +	if (rc < 0)
>  		RETURN(BADTCLASS)
>  
>  	/* Convert the permission list to an AV. */
> @@ -365,8 +365,8 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
>  		permstr = PyString_AsString( strObj );
>  #endif
>  		
> -		perm = string_to_av_perm(tclass, permstr);
> -		if (!perm)
> +		rc = sepol_string_to_av_perm(tclass, permstr, &perm);
> +		if (rc < 0)
>  			RETURN(BADPERM)
>  
>  		av |= perm;
> 
