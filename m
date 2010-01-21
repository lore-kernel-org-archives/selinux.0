Subject: Re: [PATCH 1/2] selinux: remove dead code in
 type_attribute_bounds_av()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Jacques Thomas <jthomas@cs.purdue.edu>, SE Linux <selinux@tycho.nsa.gov>,
        method@manicmethod.com
In-Reply-To: <4B57ED6F.6040803@ak.jp.nec.com>
References: <4AF71B05.8030707@cs.purdue.edu>
	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>
	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>
	 <4B14934F.9050401@cs.purdue.edu>
	 <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
	 <4B54339F.8070501@ak.jp.nec.com>  <4B5685D5.7040307@ak.jp.nec.com>
	 <1263994416.24133.4.camel@moss-pluto.epoch.ncsc.mil>
	 <4B57ED6F.6040803@ak.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Jan 2010 09:08:09 -0500
Message-Id: <1264082889.11002.51.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-21 at 15:00 +0900, KaiGai Kohei wrote:
> (2010/01/20 22:33), Stephen Smalley wrote:
> > $ make C=2 security/selinux/ss/services.o
> > security/selinux/ss/services.c: In function ‘type_attribute_bounds_av’:
> > security/selinux/ss/services.c:524: warning: unused variable ‘target’
> > security/selinux/ss/services.c:520: warning: unused variable ‘lo_tcontext’
> 
> Sorry, it was fixed.
> 
> --------
> This patch removes dead code in type_attribute_bounds_av().
> 
> Due to the historical reason, the type boundary feature is delivered
> from hierarchical types in libsepol, it has supported boundary features
> both of subject type (domain; in most cases) and target type.
> 
> However, we don't have any actual use cases in bounded target types,
> and it tended to make conceptual confusion.
> So, this patch removes the dead code to apply boundary checks on the
> target types. I makes clear the TYPEBOUNDS restricts privileges of
> a certain domain bounded to any other domain.
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> --
>  security/selinux/ss/services.c |   43 +++------------------------------------
>  1 files changed, 4 insertions(+), 39 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 3b42b15..4a2bf21 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -516,16 +516,14 @@ static void type_attribute_bounds_av(struct context *scontext,
>  				     u16 tclass,
>  				     struct av_decision *avd)
>  {
> -	struct context lo_scontext;
> -	struct context lo_tcontext;
> -	struct av_decision lo_avd;
>  	struct type_datum *source
>  		= policydb.type_val_to_struct[scontext->type - 1];
> -	struct type_datum *target
> -		= policydb.type_val_to_struct[tcontext->type - 1];
> -	u32 masked = 0;
> 
>  	if (source->bounds) {
> +		struct context lo_scontext;
> +		struct av_decision lo_avd;
> +		u32 masked;
> +
>  		memset(&lo_avd, 0, sizeof(lo_avd));
> 
>  		memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
> @@ -538,40 +536,7 @@ static void type_attribute_bounds_av(struct context *scontext,
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
>  		masked = ~lo_avd.allowed & avd->allowed;
> -	}
> -
> -	if (target->bounds) {
> -		memset(&lo_avd, 0, sizeof(lo_avd));
> -
> -		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
> -		lo_tcontext.type = target->bounds;
> -
> -		context_struct_compute_av(scontext,
> -					  &lo_tcontext,
> -					  tclass,
> -					  &lo_avd);
> -		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> -			return;		/* no masked permission */
> -		masked = ~lo_avd.allowed & avd->allowed;
> -	}
> -
> -	if (source->bounds && target->bounds) {
> -		memset(&lo_avd, 0, sizeof(lo_avd));
> -		/*
> -		 * lo_scontext and lo_tcontext are already
> -		 * set up.
> -		 */
> -
> -		context_struct_compute_av(&lo_scontext,
> -					  &lo_tcontext,
> -					  tclass,
> -					  &lo_avd);
> -		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> -			return;		/* no masked permission */
> -		masked = ~lo_avd.allowed & avd->allowed;
> -	}
> 
> -	if (masked) {
>  		/* mask violated permissions */
>  		avd->allowed &= ~masked;
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
