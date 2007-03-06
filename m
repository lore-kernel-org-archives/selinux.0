Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26Ftp8l003643
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 10:55:51 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l26FvHF8009719
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 15:57:17 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Don't audit restart of nscd daemon in strict policy
Date: Tue, 6 Mar 2007 10:56:56 -0500
Message-ID: <1173195747.31976.0.camel@sgc>
In-Reply-To: <200702261729.l1QHTPdT030641@localhost.localdomain>
References: <200702261729.l1QHTPdT030641@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:29 -0500, dwalsh@localhost.localdomain wrote:
> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_nscd.patch===
> --- nsaserefpolicy/policy/modules/services/nscd.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/nscd.te	2007-02-26 11:02:34.000000000 -0500
> @@ -117,6 +117,9 @@
>  	term_dontaudit_use_unallocated_ttys(nscd_t)
>  	term_dontaudit_use_generic_ptys(nscd_t)
>  	files_dontaudit_read_root_files(nscd_t)
> +',`
> +	userdom_dontaudit_use_sysadm_ttys(nscd_t)
> +	userdom_dontaudit_use_sysadm_ptys(nscd_t)
>  ')
>  
>  optional_policy(`

This should go with a run interface.  Then you can get the transition,
the role, and dontaudit the terminals.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
