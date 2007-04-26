Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3QCsw18031618
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 08:54:58 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3QCsgdH021013
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 12:54:42 GMT
Subject: Re: Remove admin templates from userdom_admin_user_template
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46277806.3050307@redhat.com>
References: <46277806.3050307@redhat.com>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 08:53:52 -0400
Message-Id: <1177592032.3570.2.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 10:09 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/system/userdomain.if  2007-03-26 16:24:13.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/system/userdomain.if      2007-04-19 09:43:55.000000000 -0400
> @@ -1225,22 +1230,6 @@
>         ')
>  
>         optional_policy(`
> -               cron_admin_template($1,$1_t,$1_r)
> -       ')
> -
> -       optional_policy(`
> -               ethereal_admin_template($1,$1_t,$1_r)
> -       ')
> -
> -       optional_policy(`
> -               lpr_admin_template($1,$1_t,$1_r)
> -       ')
> -
> -       optional_policy(`
> -               mta_admin_template($1,$1_t,$1_r)
> -       ')
> -
> -       optional_policy(`
>                 userhelper_exec($1_t)
>         ')
>  ')
> --- nsaserefpolicy/policy/modules/system/userdomain.te  2007-03-26 16:24:13.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/system/userdomain.te      2007-04-19 09:48:39.000000000 -0400
> @@ -101,10 +102,27 @@
>  # Local policy
>  #
>  
> +userdom_unpriv_user_template(user)
>  ifdef(`strict_policy',`
>         userdom_admin_user_template(sysadm)
> +
> +       optional_policy(`
> +               cron_admin_template(sysadm,sysadm_t,sysadm_r)
> +       ')
> +
> +       optional_policy(`
> +               ethereal_admin_template(sysadm,sysadm_t,sysadm_r)
> +       ')
> +
> +       optional_policy(`
> +               lpr_admin_template(sysadm,sysadm_t,sysadm_r)
> +       ')
> +
> +       optional_policy(`
> +               mta_admin_template(sysadm,sysadm_t,sysadm_r)
> +       ')
> +
>         userdom_unpriv_user_template(staff)
> -       userdom_unpriv_user_template(user)
>  
>         # user role change rules:
>         # sysadm_r can change to user roles

The main part has already been done.  Not going to move out the user
definition, as that is what the strict-targeted merge branch is for.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
