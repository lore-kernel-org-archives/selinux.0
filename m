Message-ID: <4846142F.8090100@ak.jp.nec.com>
Date: Wed, 04 Jun 2008 13:03:59 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
References: <483A9137.5050509@ak.jp.nec.com>	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>	 <483C6BEA.8040101@tycho.nsa.gov>	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com> <1212496632.31546.105.camel@gorn.columbia.tresys.com>
In-Reply-To: <1212496632.31546.105.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2008-06-03 at 19:25 +0900, KaiGai Kohei wrote:
>> Christopher J. PeBenito wrote:
> 
>>> I'm out of arguments; clearly I'm in the minority on this issue.  I
>>> already said I wouldn't block the policy over this, so KaiGai, if you
>>> would send a last patch based on the revisions I made [1], let see if we
>>> can finally get this merged.
>>>
>>> [1] http://marc.info/?l=selinux&m=120999566809541&w=2
>> I'll submit a revised version later.
>> (Now we cannot update SVN repository, due to server maintenance.)
>>
>> Before this, I want to modify the following points:
>>
>> - neverallow rule should be removed, as you suggested before.
>>
>> - The type_transition rule for newly created database should be
>>   described with "self" as its target, like:
>>     type_transition sepgsql_client_type self : db_database sepgsql_db_t;
>>   The purpose is to make clear its meanings that this type_transition
>>   has no appropriate parent as socket creation.
> 
> Unfortunately self doesn't work in type_transitions.

Oops,

>> - postgresql_unconfined() interface should also associate a domin
>>   with sepgsql_client_type, not only sepgsql_unconfined_type.
>>   dontaudit rules on row-level logs are not disabled for unconfined
>>   clients. And, it's not useful to write additional policy module.
> 
> I don't understand what you mean about the dontaudits.  Otherwise, you
> should recheck the unconfined rules.  I'm fairly sure I copied anything
> relevant from the client rules into unconfined so I didn't have to add
> both attributes in postgresql_unconfined().

A table can contain massive tuples in generally. If 50% of 1,000,000 tuples
are labaled as "Classified" and hidden from clients (includes unconfined
domain), tuple-level access denied log will make a flood of logs.
The dontaudit rule enables to restain the problem.

I intended sepgsql_client_type means all domains connectable to SE-PostgreSQL.
If it dosen't contain unconfined domains, I think its name is a bit confusable
and something like "sepgsql_unpriv_type" is better for its name.
Then, the above dontaudit rule should be rewritten as follows:

  dontaudit { sepgsql_client_type sepgsql_unpriv_type postgresql_t } \
            { sepgsql_table_type - sepgsql_sysobj_table_type } : db_tuple *;

At first, I used a boolean (sepgsql_enable_audittuple) to turn on/off
tuple-level access logs, but you suggested it is unnecessary, so I removed it.


In addition, I found an unclear point which came from my original policy. :(

  allow sepgsql_unconfined_type postgresql_t:db_blob { import export };

A blob import interface enables to read a file on a server host by the server
process (postgresql_t), and import to database as several frames of largeobject.
A export interface works for inversed direction.

In the previous discussion, the meaning of these permission is to indicate
server process to start importing or exporting.
However, I'm now considering the following rules are more sensefull:

  1. SE-PostgreSQL checks whether the client has db_blob:{import} for
     the target large object.
  2. SE-PostgreSQL checks whether the client has file:{read} for
     the target file.
  3. SELinux (kernel) checks whether postgresql_t has file:{read} for the
     target file, because it uses read(2) system call.

Could you tell me your opinion?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
