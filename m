Subject: Re: [PATCH 2/2] libsepol: remove dead code in
 check_avtab_hierarchy_callback()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: method@manicmethod.com, Jacques Thomas <jthomas@cs.purdue.edu>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B7B2F15.5020909@ak.jp.nec.com>
References: <4AF71B05.8030707@cs.purdue.edu>
	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>
	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>
	 <4B14934F.9050401@cs.purdue.edu>
	 <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
	 <4B54339F.8070501@ak.jp.nec.com> <4B5685EC.1000500@ak.jp.nec.com>
	 <4B6BAFD0.2050607@ak.jp.nec.com>
	 <1265381454.18100.50.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7104C9.30903@ak.jp.nec.com>  <4B7A04C6.9020808@ak.jp.nec.com>
	 <1266333947.5252.51.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7B2F15.5020909@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 17 Feb 2010 08:51:05 -0500
Message-Id: <1266414665.4945.15.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-17 at 08:49 +0900, KaiGai Kohei wrote:
> > I'd say we revert the changeset and restore the prior behavior.
> > I don't think we should impose the latter convention on policy writers.
> 
> OK, fair enough for me.
> 
> This patch revert the commit of 7d52a155e38d5a165759dbbee656455861bf7801
> which removed a part of type_attribute_bounds_av as a dead code.
> However, at that time, we didn't find out the target side boundary allows
> to handle some of pseudo /proc/<pid>/* entries with its process's security
> context well.

Does Jacques' original concern about the code still hold true?
http://marc.info/?l=selinux&m=125770868309928&w=2
http://marc.info/?l=selinux&m=125851264424682&w=2

> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  security/selinux/ss/services.c |   43 ++++++++++++++++++++++++++++++++++++---
>  1 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 4e976f5..42d423c 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -524,14 +524,16 @@ static void type_attribute_bounds_av(struct context *scontext,
>  				     u16 tclass,
>  				     struct av_decision *avd)
>  {
> +	struct context lo_scontext;
> +	struct context lo_tcontext;
> +	struct av_decision lo_avd;
>  	struct type_datum *source
>  		= policydb.type_val_to_struct[scontext->type - 1];
> +	struct type_datum *target
> +		= policydb.type_val_to_struct[tcontext->type - 1];
> +	u32 masked = 0;
> 
>  	if (source->bounds) {
> -		struct context lo_scontext;
> -		struct av_decision lo_avd;
> -		u32 masked;
> -
>  		memset(&lo_avd, 0, sizeof(lo_avd));
> 
>  		memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
> @@ -544,7 +546,40 @@ static void type_attribute_bounds_av(struct context *scontext,
>  		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
>  			return;		/* no masked permission */
>  		masked = ~lo_avd.allowed & avd->allowed;
> +	}
> +
> +	if (target->bounds) {
> +		memset(&lo_avd, 0, sizeof(lo_avd));
> +
> +		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
> +		lo_tcontext.type = target->bounds;
> +
> +		context_struct_compute_av(scontext,
> +					  &lo_tcontext,
> +					  tclass,
> +					  &lo_avd);
> +		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> +			return;		/* no masked permission */
> +		masked = ~lo_avd.allowed & avd->allowed;
> +	}
> +
> +	if (source->bounds && target->bounds) {
> +		memset(&lo_avd, 0, sizeof(lo_avd));
> +		/*
> +		 * lo_scontext and lo_tcontext are already
> +		 * set up.
> +		 */
> +
> +		context_struct_compute_av(&lo_scontext,
> +					  &lo_tcontext,
> +					  tclass,
> +					  &lo_avd);
> +		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> +			return;		/* no masked permission */
> +		masked = ~lo_avd.allowed & avd->allowed;
> +	}
> 
> +	if (masked) {
>  		/* mask violated permissions */
>  		avd->allowed &= ~masked;
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
