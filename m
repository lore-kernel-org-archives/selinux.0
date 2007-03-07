Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27KJtoR003827
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 15:19:55 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l27KLMuo013355
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 20:21:22 GMT
Message-ID: <45EF1EB9.3030307@redhat.com>
Date: Wed, 07 Mar 2007 15:21:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Don't audit restart of nscd daemon in strict policy
References: <200702261729.l1QHTPdT030641@localhost.localdomain>	 <1173196621.917.0.camel@sgc>  <45EDB652.90306@redhat.com> <1173284638.10747.15.camel@sgc>
In-Reply-To: <1173284638.10747.15.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------010104010107000707050208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010104010107000707050208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Tue, 2007-03-06 at 13:43 -0500, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Mon, 2007-02-26 at 12:29 -0500, dwalsh@localhost.localdomain wrote:
>>>       
>>>> +',`
>>>> +    userdom_dontaudit_use_sysadm_ttys(nscd_t)
>>>> +    userdom_dontaudit_use_sysadm_ptys(nscd_t)
>>>>         
>>> This should go with a run interface, then you get the transition, the
>>> role and these dontaudits.
>>>   
>>>       
>> Ok how about this one.
>>     
>
> Yes, thats what I had in mind, but I thought that the purpose was that
> nscd was restarted from usermanage_t.  If so, the nscd_run() call should
> go in usermanage_run_useradd().  See rpm_run() for what I was thinking.
>
>   
>> +interface(`nscd_run',`
>> +       gen_require(`
>> +               type nscd_t;
>> +       ')
>> +
>> +       nscd_domtrans($1)
>> +       role $2 types nscd_t;
>> +       dontaudit nscd_t $3:chr_file rw_term_perms;
>> +')
>> +
>> --- nsaserefpolicy/policy/modules/system/userdomain.te  2007-02-19 11:32:53.000000000 -0500
>> +++ serefpolicy-2.5.8/policy/modules/system/userdomain.te       2007-03-06 13:33:25.000000000 -0500
>> @@ -423,6 +438,10 @@
>>         ')
>>  
>>         optional_policy(`
>> +               nscd_run(sysadm_t,sysadm_r,admin_terminal)
>> +       ')
>> +
>> +       optional_policy(`
>>                 usermanage_run_admin_passwd(sysadm_t,sysadm_r,admin_terminal)
>>                 usermanage_run_groupadd(sysadm_t,sysadm_r,admin_terminal)
>>                 usermanage_run_useradd(sysadm_t,sysadm_r,admin_terminal) 
>>     
Ok one more pass. 



--------------010104010107000707050208
Content-Type: text/x-patch;
 name="nscd_run.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nscd_run.patch"

--- nsaserefpolicy/policy/modules/admin/usermanage.if	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/admin/usermanage.if	2007-03-07 15:06:39.000000000 -0500
@@ -69,6 +69,7 @@
 	files_search_usr($1)
 	corecmd_search_sbin($1)
 	domtrans_pattern($1,groupadd_exec_t,groupadd_t)
+	nscd_run(groupadd_t, $2, $3);
 ')
 
 ########################################
@@ -206,6 +207,7 @@
 	usermanage_domtrans_admin_passwd($1)
 	role $2 types sysadm_passwd_t;
 	allow sysadm_passwd_t $3:chr_file rw_term_perms;
+	nscd_run(sysadm_passwd_t, $2, $3);
 ')
 
 ########################################
@@ -258,6 +260,7 @@
 	usermanage_domtrans_useradd($1)
 	role $2 types useradd_t;
 	allow useradd_t $3:chr_file rw_term_perms;
+	nscd_run(useradd_t, $2, $3);
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/nscd.if	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/nscd.if	2007-03-06 14:13:31.000000000 -0500
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
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/admin/usermanage.te	2007-03-06 14:13:31.000000000 -0500
@@ -257,10 +257,6 @@
 ')
 
 optional_policy(`
-	nscd_domtrans(groupadd_t)
-')
-
-optional_policy(`
 	rpm_use_fds(groupadd_t)
 	rpm_rw_pipes(groupadd_t)
 ')
@@ -444,7 +440,6 @@
 ')
 
 optional_policy(`
-	nscd_domtrans(sysadm_passwd_t)
 	nscd_socket_use(sysadm_passwd_t)
 ')
 
@@ -540,10 +535,6 @@
 ')
 
 optional_policy(`
-	nscd_domtrans(useradd_t)
-')
-
-optional_policy(`
 	rpm_use_fds(useradd_t)
 	rpm_rw_pipes(useradd_t)
 ')

--------------010104010107000707050208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
