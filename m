Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8BHSj8j008147
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 13:28:45 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8BHSiMo010250
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 17:28:45 GMT
Subject: Re: [PATCH] refpolicy: mailscanner policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022050.l72KodAs000456@redsox.boston.devel.redhat.com>
References: <200708022050.l72KodAs000456@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 11 Sep 2007 13:27:16 -0400
Message-Id: <1189531636.7512.4.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:50 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/mailscanner.fc
> 1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-3.0.5/policy/modules/services/mailscanner.fc
> 2007-08-02 11:02:02.000000000 -0400
> @@ -0,0 +1,2 @@
> +/var/spool/MailScanner(/.*)?
> gen_context(system_u:object_r:mailscanner_spool_t,s0)
> +
> --- nsaserefpolicy/policy/modules/services/mailscanner.if
> 1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-3.0.5/policy/modules/services/mailscanner.if
> 2007-08-02 11:02:02.000000000 -0400
> @@ -0,0 +1,59 @@
> +## <summary>Anti-Virus and Anti-Spam Filter</summary>
> +
> +########################################
> +## <summary>
> +##     Search mailscanner spool directories.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`mailscanner_search_spool',`
> +       gen_require(`
> +               type mailscanner_spool_t;
> +       ')
> +
> +       files_search_spool($1)
> +       allow $1 mailscanner_spool_t:dir search_dir_perms;
> +')
> +
> +########################################
> +## <summary>
> +##     read mailscanner spool files.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`mailscanner_read_spool',`
> +       gen_require(`
> +               type mailscanner_spool_t;
> +       ')
> +
> +       files_search_spool($1)
> +       read_files_pattern($1,mailscanner_spool_t,mailscanner_spool_t)
> +')
> +
> +########################################
> +## <summary>
> +##     Create, read, write, and delete
> +##     mailscanner spool files.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`mailscanner_manage_spool',`
> +       gen_require(`
> +               type mailscanner_spool_t;
> +       ')
> +
> +       files_search_spool($1)
> +
> manage_files_pattern($1,mailscanner_spool_t,mailscanner_spool_t)
> +')
> --- nsaserefpolicy/policy/modules/services/mailscanner.te
> 1969-12-31 19:00:00.000000000 -0500
> +++ serefpolicy-3.0.5/policy/modules/services/mailscanner.te
> 2007-08-02 11:02:02.000000000 -0400
> @@ -0,0 +1,5 @@
> +
> +policy_module(mailscanner,1.0.0)
> +
> +type mailscanner_spool_t;
> +files_type(mailscanner_spool_t)

Looks incomplete.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
