Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UEVJ3Y030212
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 10:31:19 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3UEVIbP025666
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:31:18 GMT
Message-ID: <4635FDB4.2030208@redhat.com>
Date: Mon, 30 Apr 2007 10:31:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: kudzu fixes to allow it to edit and restart init for MLS
References: <200704201930.l3KJUJMV027319@redsox.boston.devel.redhat.com> <1177943094.3570.80.camel@sgc>
In-Reply-To: <1177943094.3570.80.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2007-04-20 at 15:30 -0400, dwalsh@redhat.com wrote:
>   
>> p--- nsaserefpolicy/policy/modules/admin/kudzu.te	2007-04-10 12:52:58.000000000 -0400
>> +++ serefpolicy-2.5.12/policy/modules/admin/kudzu.te	2007-04-11 17:07:34.000000000 -0400
>> @@ -21,8 +21,8 @@
>>  # Local policy
>>  #
>>  
>> -allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
>> -dontaudit kudzu_t self:capability { sys_ptrace sys_tty_config };
>> +allow kudzu_t self:capability { dac_override sys_admin sys_ptrace sys_rawio net_admin sys_tty_config mknod };
>> +dontaudit kudzu_t self:capability sys_tty_config;
>>  allow kudzu_t self:process { signal_perms execmem };
>>  allow kudzu_t self:fifo_file rw_fifo_file_perms;
>>  allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };
>> @@ -103,6 +103,8 @@
>>  init_use_fds(kudzu_t)
>>  init_use_script_ptys(kudzu_t)
>>  init_stream_connect_script(kudzu_t)
>> +init_read_init_state(kudzu_t)
>> +init_ptrace_init_domain(kudzu_t)
>>  # kudzu will telinit to make init re-read
>>  # the inittab after configuring serial consoles
>>  init_telinit(kudzu_t)
>>     
>
> Kudzu really needs to ptrace init?
>
>   
I am not sure, you can merge it with a dontaudit, and we can get the 
LSPP People to test without it. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
