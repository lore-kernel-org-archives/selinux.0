Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26IgEHH012367
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 13:42:14 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l26Ihexq012886
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 18:43:40 GMT
Message-ID: <45EDB652.90306@redhat.com>
Date: Tue, 06 Mar 2007 13:43:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Don't audit restart of nscd daemon in strict policy
References: <200702261729.l1QHTPdT030641@localhost.localdomain> <1173196621.917.0.camel@sgc>
In-Reply-To: <1173196621.917.0.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------080501080205070607030503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080501080205070607030503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Mon, 2007-02-26 at 12:29 -0500, dwalsh@localhost.localdomain wrote:
>   
>> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_nscd.patch===
>> --- nsaserefpolicy/policy/modules/services/nscd.te	2007-02-19 11:32:53.000000000 -0500
>> +++ serefpolicy-2.5.5/policy/modules/services/nscd.te	2007-02-26 11:02:34.000000000 -0500
>> @@ -117,6 +117,9 @@
>>  	term_dontaudit_use_unallocated_ttys(nscd_t)
>>  	term_dontaudit_use_generic_ptys(nscd_t)
>>  	files_dontaudit_read_root_files(nscd_t)
>> +',`
>> +	userdom_dontaudit_use_sysadm_ttys(nscd_t)
>> +	userdom_dontaudit_use_sysadm_ptys(nscd_t)
>>  ')
>>  
>>  optional_policy(`
>>     
>
> This should go with a run interface, then you get the transition, the
> role and these dontaudits.
>
>   
Ok how about this one.

--------------080501080205070607030503
Content-Type: text/x-patch;
 name="nscd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nscd.patch"

--- nsaserefpolicy/policy/modules/services/nscd.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/nscd.if	2007-03-06 13:33:06.000000000 -0500
@@ -173,3 +173,35 @@
 
 	allow $1 nscd_t:nscd *;
 ')
+
+########################################
+## <summary>
+##	Execute nscd in the nscd domain, and
+##	allow the specified role the nscd domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the nscd domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the nscd domain to use.
+##	</summary>
+## </param>
+#
+interface(`nscd_run',`
+	gen_require(`
+		type nscd_t;
+	')
+
+	nscd_domtrans($1)
+	role $2 types nscd_t;
+	dontaudit nscd_t $3:chr_file rw_term_perms;
+')
+
--- nsaserefpolicy/policy/modules/system/userdomain.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/system/userdomain.te	2007-03-06 13:33:25.000000000 -0500
@@ -423,6 +438,10 @@
 	')
 
 	optional_policy(`
+		nscd_run(sysadm_t,sysadm_r,admin_terminal)
+	')
+
+	optional_policy(`
 		usermanage_run_admin_passwd(sysadm_t,sysadm_r,admin_terminal)
 		usermanage_run_groupadd(sysadm_t,sysadm_r,admin_terminal)
 		usermanage_run_useradd(sysadm_t,sysadm_r,admin_terminal)

--------------080501080205070607030503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
