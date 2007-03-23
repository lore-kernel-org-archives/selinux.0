Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NIYO2j002567
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 14:34:26 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NIYNU1020757
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 18:34:23 GMT
Date: Fri, 23 Mar 2007 14:34:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: Expunging userspace classes and permissions from kernel headers
In-Reply-To: <1174667120.31436.232.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0703231434090.30602@d.namei>
References: <1174569868.31436.22.camel@moss-spartans.epoch.ncsc.mil>
 <1174571162.19924.36.camel@sgc.columbia.tresys.com>
 <1174571459.31436.31.camel@moss-spartans.epoch.ncsc.mil>
 <1174584303.19924.43.camel@sgc.columbia.tresys.com>
 <1174585916.31436.94.camel@moss-spartans.epoch.ncsc.mil>
 <1174666169.19924.47.camel@sgc.columbia.tresys.com>
 <1174667120.31436.232.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Mar 2007, Stephen Smalley wrote:

> Yes, looks sane.  We would then apply that diff (re-based to the kernel
> tree) along with a patch like the following untested one (added a guard
> to both avc_dump_query and validate_classes despite my earlier comment).
> Look reasonable to others?

Yep.

> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index da8caf1..b25cf18 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -217,7 +217,9 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  		audit_log_format(ab, " tcontext=%s", scontext);
>  		kfree(scontext);
>  	}
> -	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> +
> +	if (tclass && tclass < ARRAY_SIZE(class_to_string))
> +		audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
>  }
>  
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1e52356..3668f18 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1050,6 +1050,8 @@ static int validate_classes(struct policydb *p)
>  
>  	for (i = 1; i < kdefs->cts_len; i++) {
>  		def_class = kdefs->class_to_string[i];
> +		if (!def_class)
> +			continue;
>  		if (i > p->p_classes.nprim) {
>  			printk(KERN_INFO
>  			       "security:  class %s not defined in policy\n",
> 
> 
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
