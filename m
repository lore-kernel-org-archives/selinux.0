Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42KPn0K017978
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 16:25:49 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l42KPmuY003883
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 20:25:48 GMT
Message-ID: <4638F3CA.6020103@redhat.com>
Date: Wed, 02 May 2007 16:25:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: logwatch tries to look at avahi, avahi needs to use winbind
References: <200704201854.l3KIs47L027135@redsox.boston.devel.redhat.com> <1178128320.445.9.camel@sgc.columbia.tresys.com>
In-Reply-To: <1178128320.445.9.camel@sgc.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------020107080307010904060505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020107080307010904060505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Fri, 2007-04-20 at 14:54 -0400, dwalsh@redhat.com wrote:
>   
>> --- nsaserefpolicy/policy/modules/admin/logwatch.te	2007-04-10 12:52:58.000000000 -0400
>> +++ serefpolicy-2.5.12/policy/modules/admin/logwatch.te	2007-04-11 17:07:34.000000000 -0400
>> @@ -95,6 +95,10 @@
>>  ')
>>  
>>  optional_policy(`
>> +	avahi_dontaudit_search_pid(logwatch_t)
>> +')
>> +
>> +optional_policy(`
>>  	bind_read_config(logwatch_t)
>>  	bind_read_zone(logwatch_t)
>>  ')
>> --- nsaserefpolicy/policy/modules/services/avahi.if	2007-01-02 12:57:43.000000000 -0500
>> +++ serefpolicy-2.5.12/policy/modules/services/avahi.if	2007-04-11 17:07:34.000000000 -0400
>> @@ -39,3 +39,22 @@
>>  	files_search_pids($1)
>>  	stream_connect_pattern($1,avahi_var_run_t,avahi_var_run_t,avahi_t)
>>  ')
>> +
>> +########################################
>> +## <summary>
>> +##	Do not audit attempts to search the AVAHI pid directory.
>> +## </summary>
>> +## <param name="domain">
>> +##	<summary>
>> +##	Domain allowed access.
>> +##	</summary>
>> +## </param>
>> +#
>> +interface(`avahi_dontaudit_search_pid',`
>> +	gen_require(`
>> +		type avahi_var_run_t;
>> +	')
>> +
>> +	dontaudit $1 avahi_var_run_t:dir search_dir_perms;
>> +')
>> +
>> --- nsaserefpolicy/policy/modules/services/avahi.te	2007-03-20 23:38:05.000000000 -0400
>> +++ serefpolicy-2.5.12/policy/modules/services/avahi.te	2007-04-18 16:04:51.000000000 -0400
>> @@ -105,3 +105,7 @@
>>  optional_policy(`
>>  	udev_read_db(avahi_t)
>>  ')
>> +
>> +optional_policy(`
>> +	samba_stream_connect_winbind(avahi_t)
>> +')
>>     
>
> Merged except for this last part.  I can't find any reference in the
> avahi code or wiki for it connecting to windbind.
>
>   


Right, turns out avahi uses nsswitch, and this is causing the avc.  
Attached patch to switch to using nsswitch.




--------------020107080307010904060505
Content-Type: text/x-patch;
 name="avahi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="avahi.patch"

--- nsaserefpolicy/policy/modules/services/avahi.te	2007-05-02 15:04:46.000000000 -0400
+++ serefpolicy-2.6.3/policy/modules/services/avahi.te	2007-05-02 15:19:03.000000000 -0400
@@ -24,7 +24,6 @@
 allow avahi_t self:fifo_file { read write };
 allow avahi_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow avahi_t self:unix_dgram_socket create_socket_perms;
-allow avahi_t self:netlink_route_socket r_netlink_socket_perms;
 allow avahi_t self:tcp_socket create_stream_socket_perms;
 allow avahi_t self:udp_socket create_socket_perms;
 
@@ -73,10 +72,8 @@
 logging_send_syslog_msg(avahi_t)
 
 miscfiles_read_localization(avahi_t)
-miscfiles_read_certs(avahi_t)
 
 sysnet_read_config(avahi_t)
-sysnet_use_ldap(avahi_t)
 
 userdom_dontaudit_use_unpriv_user_fds(avahi_t)
 userdom_dontaudit_search_sysadm_home_dirs(avahi_t)
@@ -95,13 +92,13 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(avahi_t)
+	seutil_sigchld_newrole(avahi_t)
 ')
 
 optional_policy(`
-	seutil_sigchld_newrole(avahi_t)
+	udev_read_db(avahi_t)
 ')
 
 optional_policy(`
-	udev_read_db(avahi_t)
+	auth_use_nsswitch(avahi_t)
 ')

--------------020107080307010904060505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
