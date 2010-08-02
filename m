Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o725jsOf024123
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2010 01:45:55 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o725jklk023262
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2010 05:45:47 GMT
Message-ID: <4C565B65.7030004@ak.jp.nec.com>
Date: Mon, 02 Aug 2010 14:45:09 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Kelvin Edmison <kelvin@kindsight.net>
CC: memcached@googlegroups.com,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Reference Policy <refpolicy@oss1.tresys.com>
Subject: Re: memcached permissions
References: <C87851FA.342C3%kelvin@kindsight.net>
In-Reply-To: <C87851FA.342C3%kelvin@kindsight.net>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/07/30 22:55), Kelvin Edmison wrote:
> While I haven't yet read the patch, I would like to understand why there is
> a need for a Calculate permission.  Why would someone be granted 'calculate'
> permission but not 'write' permission?
> 
> Kelvin
> 
The issue depends on individual user's requirement of security.
If they want not to leak anything over the security domains,
they should grant the 'calculate' permission on everybody who
already have both 'read' and 'write' permissions.
It it equivalent to these permissions.
However, it may lack flexibility in configuration of access
controls, if users don't consider 'INCR' and 'DECR' are risk
information leaks/manipulations.
For example, it is not a rare case that we don't want to expose
individual client's items, but want to control a shared reference
counter.

Ideally, I'd like to define more fine grained permissions to
distinguish a security sensitive operations and others.
But here is limitation of protocol. We cannot automatically
determine what is security sensitive data and what is not.

Thanks,

> On 30/07/10 12:49 AM, "KaiGai Kohei"<kaigai@ak.jp.nec.com>  wrote:
> 
>> I'll mainly submit the patch and message to SELinux community,
>> but please don't hesitate to comment anything from memcached
>> community.
>> --------
>>
>> The attached patch adds policies to support access controls
>> on key-value items managed by memcached with SELinux engine.
>>
>> Nowadays, various kind of key-value-stores support memcached
>> compatible protocol as a de-facto standard. So, it will be a
>> reasonable start to consider the protocol to control accesses
>> from clients; typically web applications.
>>
>>    http://github.com/memcached/memcached/blob/master/doc/protocol.txt
>>
>> 1) new permissions
>>
>> This patch adds 'kv_item' class with the following permissions
>>   - create
>>   - getattr
>>   - setattr
>>   - remove
>>   - relabelfrom
>>   - relabelto
>>   - read
>>   - write
>>   - append
>>   - calculate
>>
>>     Most of permission works as literal.
>>     On the 'SET' or 'CAS' operations, it creates a new item when here
>>     is no items with same kye. In this case, 'create' permission shall
>>     be checked. Elsewhere, 'write' permission shall be checked on the
>>     existing items.
>>
>>     When an item get expired, it shall be unlinked internally. In this
>>     case, no permissions are checked, because it does not work according
>>     to the user's request.
>>
>>     On the 'FLUSH_ALL' operation, it unlinks any items older than
>>     a certain watermark. In this case, 'remove' permission shall be
>>     checked on the items to be unlinked. If violated, it skips to
>>     unlink this item.
>>
>>     On 'INCR' or 'DECR' operation, 'calculate' permission shall be checked.
>>     Is it necessary to distinguish between 'INCR' and 'DECR' here?
>>     E.g, an item which can be incremented, but unavailable to decrement.
>>
>> 2) new types
>>   - memcached_db_t
>>     Some of modular memcached engines support on-disk storage, not only
>>     volatile ram. The selinux_engine.so allows us to use a certain file
>>     as a backend storage, but existing policy does not have definition
>>     of data file type. This type allows memcached_t read/write accesses.
>>
>>   - memcached_item_t         (default of unconfined domain)
>>   - memcached_ro_item_t
>>   - memcached_secret_item_t
>>   - user_memcached_item_t    (default of rbac domain)
>>   - unpriv_memcached_item_t  (default of unprivileged domain)
>>     These are types of individual key-value items.
>>     The three default types are read-writable for its domains,
>>     memcached_ro_item_t is read-only for confined domains, and
>>     memcached_secret_t is invisible from confined domains.
>>
>> 3) supplemental policies
>>   - This patch also adds permission on memcached_t to communicate with
>>     SELinux using netlink socket and selinuxfs.
>>   - This patch also adds permission on memcached_t to write out audit
>>     logs onto auditd daemon, although it is not implemented yet.
>>
>> Thanks, Any comments please.
>
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
