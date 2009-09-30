Message-ID: <4AC2C6B5.5020707@ak.jp.nec.com>
Date: Wed, 30 Sep 2009 11:47:17 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux:  dynamic class/perm discovery
References: <1253739220.2870.3.camel@moss-huskers.epoch.ncsc.mil>	 <4ABB30CD.9060804@ak.jp.nec.com> <1254149650.14478.31.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254149650.14478.31.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> * May be a short-tempered requirement.
>>
>> It will be preferable, if userspace object manager can make a query
>> using object class and access vectors with text representation, not
>> the results of string_to_security_class(), because userspaces cannot
>> make sure the string_to_security_class() and security_compute_av()
>> are handled atomically.
>>
>> The security policy may be reloaded between the string_to_security_class()
>> and security_compute_av() in a corner case.
>> BTW, SE-PostgreSQL checks sequencial number of security policy, and redo
>> checks if the security policy reloaded. But it is not perfect. The netlink
>> socket message can be delayed. :-(
>>   http://code.google.com/p/sepgsql/source/browse/branches/pgsql-8.4.x/sepgsql/src/backend/security/sepgsql/avc.c#565
>>
>> If the text -> code translation and lookups of security policy can be done
>> within a single read_lock(&policy_rwlock) block, we can guarantee
>> security_compute_av() is not invoked based on incorrect object class code.
> 
> We could either add a new node to selinuxfs that takes the string
> representation, or just modify the existing handler functions to
> automatically detect whether they were passed an integer or a string and
> act accordingly.  But I'd view that as a separate follow-on patch.

Yes, I'll submit it later.
(But recent my workroad is high due to the pgsql-hackers...)

Maybe, userspace application or libselinux wrapper will write into
a new selinuxfs node as follows:

IN  -> "system_u:system_r:httpd_t:s0 system_u:object_r:sepgsql_table_t:s0 db_table"

OUT <- "allowed:getattr,select,update,insert,delete auditallow: auditdeny:(snip)"

It is important symbolic identifiers are used in both of input/output.
If kernel returns code of the access vectors, it makes nonsense.

It's just an idea. Please don't heat up this topic now.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
