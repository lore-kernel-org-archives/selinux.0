Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8MLBGS0002426
 for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2014 17:11:16 -0400
From: Paul Moore <pmoore@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] selinux: services: cleanup orphan keywords in audit log
 text
Date: Mon, 22 Sep 2014 17:11:09 -0400
Message-ID: <2323471.BcNNgvtlxN@sifl>
In-Reply-To: <516208b0d38331b8a3318918814e4e321c5117d9.1411086286.git.rgb@redhat.com>
References: <516208b0d38331b8a3318918814e4e321c5117d9.1411086286.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, eparis@redhat.com,
 linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov, sgrubb@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, September 18, 2014 08:47:48 PM Richard Guy Briggs wrote:
> Restructure to keyword=value pairs without spaces.  Drop superfluous words
> in text.  Make invalid_context a keyword.  Change result= keyword to
> seresult=.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/selinux/ss/services.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)

Applied with a minor rewrite to the subject line.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 4bca494..e822910 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -728,7 +728,7 @@ static int security_validtrans_handle_fail(struct
> context *ocontext, if (context_struct_to_string(tcontext, &t, &tlen))
>  		goto out;
>  	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -		  "security_validate_transition:  denied for"
> +		  "op=security_validate_transition seresult=denied"
>  		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
>  		  o, n, t, sym_name(&policydb, SYM_CLASSES, tclass-1));
>  out:
> @@ -877,7 +877,7 @@ int security_bounded_transition(u32 old_sid, u32
> new_sid) audit_log(current->audit_context,
>  				  GFP_ATOMIC, AUDIT_SELINUX_ERR,
>  				  "op=security_bounded_transition "
> -				  "result=denied "
> +				  "seresult=denied "
>  				  "oldcontext=%s newcontext=%s",
>  				  old_name, new_name);
>  		}
> @@ -1351,8 +1351,8 @@ static int compute_sid_handle_invalid_context(
>  	if (context_struct_to_string(newcontext, &n, &nlen))
>  		goto out;
>  	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -		  "security_compute_sid:  invalid context %s"
> -		  " for scontext=%s"
> +		  "op=security_compute_sid invalid_context=%s"
> +		  " scontext=%s"
>  		  " tcontext=%s"
>  		  " tclass=%s",
>  		  n, s, t, sym_name(&policydb, SYM_CLASSES, tclass-1));
> @@ -2584,8 +2584,10 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32
> *new_sid) rc = convert_context_handle_invalid_context(&newcon);
>  		if (rc) {
>  			if (!context_struct_to_string(&newcon, &s, &len)) {
> -				audit_log(current->audit_context, GFP_ATOMIC, 
AUDIT_SELINUX_ERR,
> -					  "security_sid_mls_copy: invalid context %s", s);
> +				audit_log(current->audit_context,
> +					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
> +					  "op=security_sid_mls_copy "
> +					  "invalid_context=%s", s);
>  				kfree(s);
>  			}
>  			goto out_unlock;

-- 
paul moore
security and virtualization @ redhat
