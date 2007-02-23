Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NLkGMk032335
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 16:46:16 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1NLlZPU027161
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 21:47:35 GMT
Message-ID: <45DF60F2.7040507@redhat.com>
Date: Fri, 23 Feb 2007 16:47:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest bluetooth requires net_bind_service
References: <45DB3124.6050905@redhat.com> <1172256975.15371.80.camel@sgc.columbia.tresys.com>
In-Reply-To: <1172256975.15371.80.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2007-02-20 at 12:34 -0500, Daniel J Walsh wrote:
>   
>> Also search inotify
>>     
>
> I don't see any corenet tcp or udp binding rules, so the capability
> seems out of place.
>   
This was a kernel change.  It has nothing to do with UDP/TCP networking, 
but net_bind_service is now required for hidd to listen.
>   
>> --- nsaserefpolicy/policy/modules/services/bluetooth.te 2007-01-02
>> 12:57:43.000000000 -0500
>> +++
>> serefpolicy-2.5.4/policy/modules/services/bluetooth.te      2007-02-19
>> 16:01:52.000000000 -0500
>> @@ -41,7 +41,7 @@
>>  # Bluetooth services local policy
>>  #
>>  
>> -allow bluetooth_t self:capability { net_admin net_raw sys_tty_config
>> ipc_lock };
>> +allow bluetooth_t self:capability { net_bind_service net_admin
>> net_raw sys_tty_config ipc_lock };
>>  dontaudit bluetooth_t self:capability sys_tty_config;
>>  allow bluetooth_t self:process { getsched signal_perms };
>>  allow bluetooth_t self:fifo_file rw_fifo_file_perms;
>> @@ -98,6 +98,7 @@
>>  
>>  fs_getattr_all_fs(bluetooth_t)
>>  fs_search_auto_mountpoints(bluetooth_t)
>> +fs_search_inotifyfs(bluetooth_t)
>>  
>>  term_dontaudit_use_console(bluetooth_t)
>>  #Handle bluetooth serial devices
>>
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
