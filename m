Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3L120sS015261
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 21:02:00 -0400
Received: from tyo200.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3L11vf9021816
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 01:01:58 GMT
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n3KNS9pR013095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 08:28:09 +0900 (JST)
Message-ID: <49ED04DF.8050306@ak.jp.nec.com>
Date: Tue, 21 Apr 2009 08:27:27 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [refpolicy] [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com>	 <49D4743C.2010000@ak.jp.nec.com>	<49D4CB6E.1090900@manicmethod.com>	 <1238684951.32379.311.camel@gorn.columbia.tresys.com>	 <49D563A9.1000607@ak.jp.nec.com>  <49D965CA.4030908@ak.jp.nec.com> <1240258044.19211.767.camel@gorn.columbia.tresys.com>
In-Reply-To: <1240258044.19211.767.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2009-04-06 at 11:15 +0900, KaiGai Kohei wrote:
>> The attached patch provides some of reworks and bugfuxes
>> except for new object classes and permissions.
>>
>> - rework: Add a comment of "not currently in use" for deprecated
>>   permissions, but its definitions are not removed.
> 
> "deprecated" should be sufficient.

OK

>> - rework: All the newly created database objects by unprivileged
>>   clients are prefixed with "user_", and these are controled via
>>   sepgsql_enable_users_ddl.
> 
> I don't think we should be mixing user content with other unpriv
> clients.

I would like to discriminate between a procedure declared by unpriv
client and by administrative client, because the policy allows the
unprefixed "sepgsql_proc_exec_t" to be installed as a system internal
component, but it is undesirable to install unpriv-user defined
procedures as is.

If the "user_" prefix is unpreferable, how do you think other prefixes
something like "anon_", "unpriv_" and so on?

>>   The current policy allows httpd_t to created a function labeled
>>   as sepgsql_proc_t which is also allowed to be installed as a
>>   system internal entity (db_procedure:{install}).
>>   It is a potentially risk for trojan horse.
>>
>> - rework: postgresql_role() shares most part of postgresql_unpriv_client().
> 
> See above comment.
> 
>> - bugfix: some of permissions in db_procedure class are allowed
>>   on sepgsql_trusted_proc_t, but it is a domain, not a procedure.
>>   It should allow them on sepgsql_trusted_proc_exec_t.
>>   I also aliased sepgsql_proc_t as sepgsql_proc_exec_t to avoid
>>   such kind of confusion, as Chris suggested before.
>>
>> - rework: we should not allow db_procedure:{install} on the
>>   sepgsql_trusted_proc_exec_t, because of a risk to invoke trusted
>>   procedure implicitly.
>>
>> - rework: db_table:{lock} is moved to reader side, because it makes
>>   impossible to refer read-only table with foreign-key constraint.
>>   (FK checks internally acquire explicit locks.)
>>
>> - bugfix: MLS policy dealt db_blob:{export} as writer-side permission,
>>   but it is required whrn the largeobject is refered.
>>
>> - bugfix: MLS policy didn't constrain the db_procedure class.
> 
> Seems ok.
> 
> It would be helpful to break up the patch into a set to make it easier
> to review in the future.

OK,

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
