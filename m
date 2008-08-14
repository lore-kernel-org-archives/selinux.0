Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EFIGhu017835
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 11:18:16 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EFIGqV008266
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 15:18:16 GMT
Subject: Re: postgresql patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48A42A16.1070209@redhat.com>
References: <48A42A16.1070209@redhat.com>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 11:16:10 -0400
Message-Id: <1218726970.8095.81.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-08-14 at 08:50 -0400, Daniel J Walsh wrote:
> New location for log files
> 
> Uses hugetblfs.

Merged.

> plain text document attachment (services_postgresql.patch)
> --- nsaserefpolicy/policy/modules/services/postgresql.fc	2008-08-07 11:15:11.000000000 -0400
> +++ serefpolicy-3.5.4/policy/modules/services/postgresql.fc	2008-08-11 16:39:48.000000000 -0400
> @@ -34,6 +34,7 @@
>  /var/lib/sepgsql/pgstartup\.log	--	gen_context(system_u:object_r:postgresql_log_t,s0)
>  
>  /var/log/postgres\.log.* 	--	gen_context(system_u:object_r:postgresql_log_t,s0)
> +/var/lib/pgsql/logfile(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
>  /var/log/postgresql(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
>  /var/log/sepostgresql\.log.*	--	gen_context(system_u:object_r:postgresql_log_t,s0)
>  
> --- nsaserefpolicy/policy/modules/services/postgresql.te	2008-08-07 11:15:11.000000000 -0400
> +++ serefpolicy-3.5.4/policy/modules/services/postgresql.te	2008-08-11 16:39:48.000000000 -0400
> @@ -186,6 +189,7 @@
>  
>  fs_getattr_all_fs(postgresql_t)
>  fs_search_auto_mountpoints(postgresql_t)
> +fs_rw_hugetlbfs_files(postgresql_t)
>  
>  selinux_get_enforce_mode(postgresql_t)
>  selinux_validate_context(postgresql_t)
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
