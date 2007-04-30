Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UF49F1000759
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 11:04:09 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UF48bP003174
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 15:04:08 GMT
Subject: Re: aide has a new directory
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201928.l3KJSCXC027282@redsox.boston.devel.redhat.com>
References: <200704201928.l3KJSCXC027282@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 11:03:48 -0400
Message-Id: <1177945428.3570.96.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 15:28 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/aide.fc	2006-11-16 17:15:21.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/services/aide.fc	2007-04-18 22:31:58.000000000 -0400
> @@ -3,3 +3,4 @@
>  /var/lib/aide(/.*)		gen_context(system_u:object_r:aide_db_t,mls_systemhigh)
>  
>  /var/log/aide.log	--	gen_context(system_u:object_r:aide_log_t,mls_systemhigh)
> +/var/log/aide(/.*)?		gen_context(system_u:object_r:aide_log_t,mls_systemhigh)
> --- nsaserefpolicy/policy/modules/services/aide.te	2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/services/aide.te	2007-04-18 22:31:08.000000000 -0400
> @@ -32,7 +32,7 @@
>  manage_files_pattern(aide_t,aide_db_t,aide_db_t)
>  
>  # logs
> -allow aide_t aide_log_t:file manage_file_perms;
> +manage_files_pattern(aide_t, aide_log_t, aide_log_t)
>  logging_log_filetrans(aide_t,aide_log_t,file)
>  
>  files_read_all_files(aide_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
