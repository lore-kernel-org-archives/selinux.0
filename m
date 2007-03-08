Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28E1GWn003092
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:01:16 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28E2iko027998
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:02:44 GMT
Message-ID: <45F01782.4030903@redhat.com>
Date: Thu, 08 Mar 2007 09:02:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: pyzor/spam changes in policy
References: <200702261735.l1QHZrjX030675@localhost.localdomain> <1173299356.10747.25.camel@sgc.columbia.tresys.com>
In-Reply-To: <1173299356.10747.25.camel@sgc.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------020905060606030603060602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020905060606030603060602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Mon, 2007-02-26 at 12:35 -0500, dwalsh@localhost.localdomain wrote:
>   
>> New directory for spamassin /var/lib/
>> spam needs to send signals to pyzor
>> pyzor uses tmp files
>>     
>
> Merged most,  exceptions:
>
>   
>> +interface(`spamassassin_manage_lib_files',`
>> +	gen_require(`
>> +		type spamd_var_lib_t;
>> +	')
>> +
>> +	files_search_var_lib($1)
>> +	manage_dirs_pattern($1,spamd_var_lib_t,spamd_var_lib_t)
>> +	manage_files_pattern($1,spamd_var_lib_t,spamd_var_lib_t)
>> +')
>>     
>
> Removed the dirs part.  If there is an interface needed that has both,
> then there should be a more abstract interface.
>
>   
>> @@ -139,6 +148,7 @@
>>  
>>  	tunable_policy(`spamd_enable_home_dirs',`
>>  		userdom_home_filetrans_generic_user_home_dir(spamd_t)
>> +		userdom_manage_generic_user_home_dirs(spamd_t)
>>  		userdom_manage_generic_user_home_content_dirs(spamd_t)
>>  		userdom_manage_generic_user_home_content_files(spamd_t)
>>  		userdom_manage_generic_user_home_content_symlinks(spamd_t)
>>     
>
> I don't understand why spamd_t would be creating new top level home
> diretories, for example the /home/myuser dir.
>
>   
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203290
>> @@ -184,6 +194,7 @@
>>  
>>  optional_policy(`
>>  	pyzor_domtrans(spamd_t)
>> +	pyzor_signal(spamd_t)
>>  ')
>>     
>
> Dropped this and the following, because the interface looks wrong ($1 is
> the object).
>
>   
>> +########################################
>> +## <summary>
>> +##	Send generic signals to pyzor
>> +## </summary>
>> +## <param name="domain">
>> +##	<summary>
>> +##	Domain allowed access.
>> +##	</summary>
>> +## </param>
>> +#
>> +interface(`pyzor_signal',`
>> +	gen_require(`
>> +		type pyzor_t;
>> +	')
>> +
>> +	allow pyzor_t $1:process signal;
>> +')
>>     
>
>   

This should be reversed,  New patch


--------------020905060606030603060602
Content-Type: text/x-patch;
 name="spam.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spam.diff"

--- nsaserefpolicy/policy/modules/services/spamassassin.te	2007-03-08 08:26:59.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/spamassassin.te	2007-03-08 09:00:04.000000000 -0500
@@ -85,6 +85,7 @@
 corenet_tcp_bind_all_nodes(spamd_t)
 corenet_tcp_bind_spamd_port(spamd_t)
 corenet_tcp_connect_razor_port(spamd_t)
+corenet_tcp_connect_smtp_port(spamd_t)
 corenet_sendrecv_razor_client_packets(spamd_t)
 corenet_sendrecv_spamd_server_packets(spamd_t)
 # spamassassin 3.1 needs this for its
@@ -147,6 +148,7 @@
 
 	tunable_policy(`spamd_enable_home_dirs',`
 		userdom_home_filetrans_generic_user_home_dir(spamd_t)
+		userdom_manage_generic_user_home_dirs(spamd_t)
 		userdom_manage_generic_user_home_content_dirs(spamd_t)
 		userdom_manage_generic_user_home_content_files(spamd_t)
 		userdom_manage_generic_user_home_content_symlinks(spamd_t)
--- nsaserefpolicy/policy/modules/services/pyzor.te	2007-03-08 08:26:59.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/pyzor.te	2007-03-08 08:59:23.000000000 -0500
@@ -44,6 +44,8 @@
 manage_dirs_pattern(pyzor_t,pyzor_tmp_t,pyzor_tmp_t)
 files_tmp_filetrans(pyzor_t, pyzor_tmp_t, { file dir })
 
+fs_search_auto_mountpoints(pyzor_t)
+
 kernel_read_kernel_sysctls(pyzor_t)  
 kernel_read_system_state(pyzor_t)
 
@@ -77,6 +79,7 @@
 ')
 
 optional_policy(`
+	spamassassin_signal_spamd(pyzor_t)
 	spamassassin_read_spamd_tmp_files(pyzor_t)
 ')
 

--------------020905060606030603060602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
