Message-ID: <4848CBE9.80603@ak.jp.nec.com>
Date: Fri, 06 Jun 2008 14:32:25 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483C6BEA.8040101@tycho.nsa.gov>	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com> <1212496632.31546.105.camel@gorn.columbia.tresys.com> <4846142F.8090100@ak.jp.nec.com> <4846A481.4080805@tresys.com> <48473C35.4060102@ak.jp.nec.com> <48482BC9.10708@tycho.nsa.gov>
In-Reply-To: <48482BC9.10708@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> KaiGai Kohei wrote:
>> Joshua Brindle wrote:
>>   
>>> KaiGai Kohei wrote:
>>>     
>>>> Christopher J. PeBenito wrote:
>>>>       
>>> <snip>
>>>
>>>     
>>>> In addition, I found an unclear point which came from my original policy. :(
>>>>
>>>>   allow sepgsql_unconfined_type postgresql_t:db_blob { import export };
>>>>
>>>> A blob import interface enables to read a file on a server host by the server
>>>> process (postgresql_t), and import to database as several frames of largeobject.
>>>> A export interface works for inversed direction.
>>>>
>>>> In the previous discussion, the meaning of these permission is to indicate
>>>> server process to start importing or exporting.
>>>> However, I'm now considering the following rules are more sensefull:
>>>>
>>>>   1. SE-PostgreSQL checks whether the client has db_blob:{import} for
>>>>      the target large object.
>>>>       
>> db_blob:{write} is also checked here...
>>
>>   
>>>>   2. SE-PostgreSQL checks whether the client has file:{read} for
>>>>      the target file.
>>>>   3. SELinux (kernel) checks whether postgresql_t has file:{read} for the
>>>>      target file, because it uses read(2) system call.
>>>>
>>>> Could you tell me your opinion?
>>>>       
>>> Chris asked me to look at this for him. The access checks above seem completely
>>> reasonable to me, much better than the previous check.
>>>
>>> I wonder though, how you'll do an export check between the client and file type,
>>> since a compute_create between the client and the target directory may be different
>>> than between postgresql_t and the directory? Which context would you attempt to use?
>>>     
>> In export case, the target file is labeled as a newly created one between
>> postgresql_t and its parent directly, as SELinux attaches in default.
>>
>> We can understand the behavior as PostgreSQL owns this file and delivers
>> its file descriptor to the client. Thus, the client should be checked
>> the file:{write} permission for the result of compute_create between
>> postgresql_t and the parent directly.
>>   
> 
> Doesn't the kernel handle this automatically? Which is to say, if you
> give a file descriptor to another process (I'm assuming it gets passed
> through the local socket), the kernel still checks read and write on
> every access.

No, it seems to kernel as if the write() operation is done by postgresql
server process.

The facility of large object allows postgresql server process to read/write
files on server host according to the operations come from client.

e.g)
# SELECT lo_import('/etc/passwd');

This query come from client (but restricted to database super user) enables
postgresql server process to read the given file and insert it as database
records. All interactions between the kernel and userspace are done as
normal i/o operations invoked by a server process, not a client.

Thanks,

>> It does not give us any mismatching between DAC and MAC.
>> So, I think it is more suitable than using setfscreatecon() to force the
>> result between the client and the parent directly.
>>
>> In the conclusion, the following permissions will be checked for blob export.
>>
>> 1. SELinux (kernel) checks file:{write} between postgresql_t and the newly
>>    created file which is labeled as the result between postgresql_t and
>>    the parent directory.
>>    This file is owned by PostgreSQL in DAC world.
>> 2. SE-PostgreSQL checks db_blob:{export read} between the client and the target
>>    large object.
>> 3. SE-PostgreSQL checks file:{write} between the client and the target file.
>>
>> Thanks,
>>   
> 
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
