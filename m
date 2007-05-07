Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l47ElCX1023369
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 10:47:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l47ElBPQ007642
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 14:47:11 GMT
Message-ID: <463F3BEE.6060504@redhat.com>
Date: Mon, 07 May 2007 10:47:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: squid patch
References: <46278600.2010806@redhat.com> <1178545161.25271.5.camel@sgc>
In-Reply-To: <1178545161.25271.5.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------090709080201050709010609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090709080201050709010609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Thu, 2007-04-19 at 11:08 -0400, Daniel J Walsh wrote:
>   
>> Added httpd_squid_script_t
>>
>> squid_conf_t can be a directory
>> Squid also needs additional ports to communicate with
>>
>> dovecot and snmp try to read squid files.  (Snuck in a couple of other
>> fixes for dovecot and snmp)
>>     
>
> Merged except for the apache template, plus:
>
>   
>> +interface(`squid_dontaudit_search_squid_cache',`
>> +       gen_require(`
>> +               type squid_cache_t;
>> +       ')
>> +
>> +       dontaudit $1 squid_cache_t:dir search_dir_perms;
>> +')
>>     
>
> Dropped the second squid in the name.
>
>   
>> --- nsaserefpolicy/policy/modules/services/snmp.te      2007-03-26 10:39:04.000000000 -0400
>> +++ serefpolicy-2.5.12/policy/modules/services/snmp.te  2007-04-11 17:07:34.000000000 -0400
>> @@ -134,6 +134,11 @@
>>  ')
>>  
>>  optional_policy(`
>> +       mta_read_config(snmpd_t)
>> +       mta_search_queue(snmpd_t)
>> +')
>>     
>
> The second interface is missing.
>
>   
>>  optional_policy(`
>> +       sendmail_read_log(snmpd_t)
>> +')
>>     
>
> This one is missing too.
>
>   

Ok here is an updated patch with the missing interfaces.

snmp is trying to execute sys_module, we are dontauditing

Switched from using nis_use_ypbind to nsswitch, since snmp is using nsswitch

Also sneaking in a fix for manage sendmail_log_t.



--------------090709080201050709010609
Content-Type: text/x-patch;
 name="snmp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snmp.patch"

--- nsaserefpolicy/policy/modules/services/snmp.te	2007-05-07 10:32:44.000000000 -0400
+++ serefpolicy-2.6.3/policy/modules/services/snmp.te	2007-05-07 10:36:03.000000000 -0400
@@ -26,7 +26,7 @@
 # Local policy
 #
 allow snmpd_t self:capability { dac_override kill net_admin sys_nice sys_tty_config };
-dontaudit snmpd_t self:capability sys_tty_config;
+dontaudit snmpd_t self:capability { sys_module sys_tty_config };
 allow snmpd_t self:fifo_file rw_fifo_file_perms;
 allow snmpd_t self:unix_dgram_socket create_socket_perms;
 allow snmpd_t self:unix_stream_socket create_stream_socket_perms;
@@ -135,18 +135,19 @@
 
 optional_policy(`
 	mta_read_config(snmpd_t)
+	mta_search_queue(snmpd_t)
 ')
 
 optional_policy(`
-	nis_use_ypbind(snmpd_t)
+	auth_use_nsswitch(snmpd_t)
 ')
 
 optional_policy(`
-	nscd_socket_use(snmpd_t)
+	rpc_search_nfs_state_data(snmpd_t)
 ')
 
 optional_policy(`
-	rpc_search_nfs_state_data(snmpd_t)
+	sendmail_read_log(snmpd_t)
 ')
 
 optional_policy(`
--- nsaserefpolicy/policy/modules/services/mta.if	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.6.3/policy/modules/services/mta.if	2007-05-07 10:36:03.000000000 -0400
@@ -847,6 +847,25 @@
 	manage_files_pattern($1,mqueue_spool_t,mqueue_spool_t)
 ')
 
+########################################
+## <summary>
+##	search	mail queue dirs.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mta_search_queue',`
+	gen_require(`
+		type mqueue_spool_t;
+	')
+
+	files_search_spool($1)
+	allow $1 mqueue_spool_t:dir search_dir_perms;
+')
+
 #######################################
 ## <summary>
 ##	Read sendmail binary.
--- nsaserefpolicy/policy/modules/services/sendmail.if	2006-11-16 17:15:21.000000000 -0500
+++ serefpolicy-2.6.3/policy/modules/services/sendmail.if	2007-05-07 10:36:03.000000000 -0400
@@ -76,6 +76,26 @@
 
 ########################################
 ## <summary>
+##	read sendmail logs.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`sendmail_read_log',`
+	gen_require(`
+		type sendmail_log_t;
+	')
+
+	logging_search_logs($1)
+	read_files_pattern($1, sendmail_log_t, sendmail_log_t)
+')
+
+########################################
+## <summary>
 ##	Create, read, write, and delete sendmail logs.
 ## </summary>
 ## <param name="domain">
@@ -91,7 +111,7 @@
 	')
 
 	logging_search_logs($1)
-	allow $1 sendmail_log_t:file manage_file_perms;
+	manage_files_pattern($1, sendmail_log_t, sendmail_log_t)
 ')
 
 ########################################

--------------090709080201050709010609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
