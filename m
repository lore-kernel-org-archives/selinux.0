Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27GM8CA024108
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 11:22:08 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l27GNZ7g024145
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 16:23:35 GMT
Subject: Re: Don't audit restart of nscd daemon in strict policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <45EDB652.90306@redhat.com>
References: <200702261729.l1QHTPdT030641@localhost.localdomain>
	 <1173196621.917.0.camel@sgc>  <45EDB652.90306@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 11:23:58 -0500
Message-Id: <1173284638.10747.15.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-06 at 13:43 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2007-02-26 at 12:29 -0500, dwalsh@localhost.localdomain wrote:
> >> +',`
> >> +    userdom_dontaudit_use_sysadm_ttys(nscd_t)
> >> +    userdom_dontaudit_use_sysadm_ptys(nscd_t)
> >
> > This should go with a run interface, then you get the transition, the
> > role and these dontaudits.
> >   
> Ok how about this one.

Yes, thats what I had in mind, but I thought that the purpose was that
nscd was restarted from usermanage_t.  If so, the nscd_run() call should
go in usermanage_run_useradd().  See rpm_run() for what I was thinking.

> +interface(`nscd_run',`
> +       gen_require(`
> +               type nscd_t;
> +       ')
> +
> +       nscd_domtrans($1)
> +       role $2 types nscd_t;
> +       dontaudit nscd_t $3:chr_file rw_term_perms;
> +')
> +
> --- nsaserefpolicy/policy/modules/system/userdomain.te  2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/userdomain.te       2007-03-06 13:33:25.000000000 -0500
> @@ -423,6 +438,10 @@
>         ')
>  
>         optional_policy(`
> +               nscd_run(sysadm_t,sysadm_r,admin_terminal)
> +       ')
> +
> +       optional_policy(`
>                 usermanage_run_admin_passwd(sysadm_t,sysadm_r,admin_terminal)
>                 usermanage_run_groupadd(sysadm_t,sysadm_r,admin_terminal)
>                 usermanage_run_useradd(sysadm_t,sysadm_r,admin_terminal) 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
