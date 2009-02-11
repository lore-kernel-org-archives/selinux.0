Cc: SE Linux <selinux@tycho.nsa.gov>
Message-Id: <BDF7BFC7-EC7D-41D5-8984-5BC2ABFD7D89@nall.com>
From: Joe Nall <joe@nall.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1234362362.12067.104.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: mdadm failure in MLS Enforcing
Date: Wed, 11 Feb 2009 08:47:50 -0600
References: <F2BE7671-FBDA-4F31-AEE7-E75BDA1337D2@nall.com> <1234362362.12067.104.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 11, 2009, at 8:26 AM, Stephen Smalley wrote:

> On Tue, 2009-02-10 at 22:17 -0600, Joe Nall wrote:
>> mdadm runs system_u:system_r:mdadm_t:s0-s15:c0.c1023 during boot and
>> can't access block devices that are
>> system_u:object_r:fixed_disk_device_t:s15:c0.c1023
>> https://bugzilla.redhat.com/show_bug.cgi?id=485006
>>
>> Posted here instead of fedora-selinux because I don't think it is
>> fedora specific.
>>
>> Boot avcs:
>>
>> node=test type=AVC msg=audit(1234315341.183:18): avc:  denied
>> { read } for  pid=1501 comm="mdadm" name="sdb2" dev=tmpfs ino=508
>> scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023
>> tcontext=system_u:object_r:fixed_disk_device_t:s15:c0.c1023
>> tclass=blk_file
>>
>>         Was caused by:
>>                 Policy constraint violation.
>>
>>                 May require adding a type attribute to the domain or
>> type to satisfy the constraint.
>>
>>                 Constraints are defined in the policy sources in
>> policy/constraints (general), policy/mcs (MCS), and policy/mls (MLS).
>>
>> node=test type=AVC msg=audit(1234315341.184:19): avc:  denied
>> { read } for  pid=1457 comm="mdadm" name=".tmp-9-1" dev=tmpfs  
>> ino=5859
>> scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023
>> tcontext=system_u:object_r:device_t:s0 tclass=blk_file
>>
>>         Was caused by:
>>                 Missing type enforcement (TE) allow rule.
>>
>>                 You can use audit2allow to generate a loadable module
>> to allow this access.
>>
>> node=test type=AVC msg=audit(1234315341.188:20): avc:  denied
>> { getattr } for  pid=1457 comm="mdadm" path="/proc/kcore" dev=proc
>> ino=4026531986 scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023
>> tcontext=system_u:object_r:proc_kcore_t:s15:c0.c1023 tclass=file
>>
>>         Was caused by:
>>                 Policy constraint violation.
>>
>>                 May require adding a type attribute to the domain or
>> type to satisfy the constraint.
>>
>>                 Constraints are defined in the policy sources in
>> policy/constraints (general), policy/mcs (MCS), and policy/mls (MLS).
>>
>> so I added this policy:
>>
>> diff -up serefpolicy-3.5.13/policy/modules/system/raid.fc.orig
>> serefpolicy-3.5.13/policy/modules/system/raid.fc
>> --- serefpolicy-3.5.13/policy/modules/system/raid.fc.orig	2009-02-10
>> 19:41:17.000000000 -0600
>> +++ serefpolicy-3.5.13/policy/modules/system/raid.fc	2009-02-10
>> 19:41:31.000000000 -0600
>> @@ -2,4 +2,4 @@
>>  /sbin/mdadm		--	gen_context(system_u:object_r:mdadm_exec_t,s0)
>>  /sbin/mdmpd		--	gen_context(system_u:object_r:mdadm_exec_t,s0)
>>
>> -/var/run/mdadm(/.*)?		 
>> gen_context(system_u:object_r:mdadm_var_run_t,s0)
>> +/var/run/mdadm(/.*)?		
>> gen_context(system_u:object_r:mdadm_var_run_t,mls_systemhigh)
>> diff -up serefpolicy-3.5.13/policy/modules/system/raid.te.orig
>> serefpolicy-3.5.13/policy/modules/system/raid.te
>> --- serefpolicy-3.5.13/policy/modules/system/raid.te.orig	2009-02-10
>> 19:33:59.000000000 -0600
>> +++ serefpolicy-3.5.13/policy/modules/system/raid.te	2009-02-10
>> 19:39:58.000000000 -0600
>> @@ -9,6 +9,10 @@ policy_module(raid, 1.7.0)
>>  type mdadm_t;
>>  type mdadm_exec_t;
>>  init_daemon_domain(mdadm_t,mdadm_exec_t)
>> +ifdef(`enable_mls',`
>> +	init_ranged_daemon_domain(mdadm_t, mdadm_exec_t,mls_systemhigh)
>> +')
>> +
>>  role system_r types mdadm_t;
>>
>>  type mdadm_var_run_t;
>>
>> which does transition to SystemHigh using run_init in permissive, but
>> doesn't affect this bug.
>>
>> Clues?
>
> I'm not sure what you mean by "doesn't affect this bug".  Did mdadm
> transition to systemhigh at boot or not?

no

That is why I went back and tried the run_init (which did transition)  
and verified the /var/run/mdadm directory was SystemHigh. I also used  
seinfo to verify that the patch had bend applied to the running  
policy. Very confusing.

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
