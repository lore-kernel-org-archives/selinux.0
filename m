Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77Dt689025429
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 09:55:06 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77Dt3mT016093
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 13:55:04 GMT
Message-ID: <46B878D9.6090004@ak.jp.nec.com>
Date: Tue, 07 Aug 2007 22:51:21 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, dwalsh@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: Fedora/SE-PostgreSQL
References: <46B079EF.9050909@kaigai.gr.jp> <1186489529.18881.9.camel@gorn>
In-Reply-To: <1186489529.18881.9.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2007-08-01 at 08:17 -0400, KaiGai Kohei wrote:
>> Hi,
>>
>> A week ago, I submitted a review request of SE-PostgreSQL to
>> the Fedora project as follows:
>>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249522
>>
>> The biggest issue is lack of definitions of new object classes
>> and access vectors related to database.
>> Rest of policies can be installed as a binary security policy module
>> packed within the RPM package, but these definitions and MLS/MCS rules
>> cannot be moduled.
>>
>> The attached patch adds these definitions to the base policy.
> [...] 
>> --- refpolicy/policy/flask/security_classes	(revision 2385)
>> +++ refpolicy/policy/flask/security_classes	(working copy)
>> @@ -99,4 +99,12 @@
>>  
>>  class memprotect
>>  
>> +# SE-PostgreSQL relation
>> +class database			# userspace
>> +class table			# userspace
>> +class procedure			# userspace
>> +class column			# userspace
>> +class tuple			# userspace
>> +class blob			# userspace
>> +
>>  # FLASK
> 
> I'm thinking that (with the exception of database) that the object
> classes should probably be prefixed with "db", so you know they are
> related.

Chris, Thanks for your comments.

As Stephen also pointed out, I'll add a prefix of "db_" for each classes.

I don't think the database class should be an exception.
The "db_database" will mean a database object managed by RDBMS working
with SELinux. The name may be a bit strange, but its meaning is clear.

> Interface naming:
> 
>> +interface(`mls_database_read_up',`
> 
> mls_db_read_all_levels
> 
>> +interface(`mls_database_write_down',`
> 
> mls_db_write_all_levels
> 
>> +interface(`mls_database_upgrade',`
> 
> mls_db_upgrade
> 
>> +interface(`mls_database_downgrade',`
> 
> mls_db_downgrade

OK, I'll rename these interfaces more simple.
Is it necessary to make the attribute names shorter?

Thanks,

>> +# the database upgrade/downgrade rule
>> +mlsvalidatetrans { database table procedure column tuple blob }
>> +	((( l1 eq l2 ) or
>> +	  (( t3 == mlsdatabaseupgrade ) and ( l1 domby l2 )) or
>> +	  (( t3 == mlsdatabasedowngrade ) and ( l1 dom l2 )) or
>> +	  (( t3 == mlsdatabasedowngrade ) and ( l1 incomp l2 ))) and
>> +	 (( l1 eq h2 ) or
>> +	  (( t3 == mlsdatabaseupgrade ) and ( h1 domby h2 )) or
>> +	  (( t3 == mlsdatabasedowngrade ) and ( h1 dom h2 )) or
>> +	  (( t3 == mlsdatabasedowngrade ) and ( h1 incomp h2 ))));
>> +
>>  ') dnl end enable_mls

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
