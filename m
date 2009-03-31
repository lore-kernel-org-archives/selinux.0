Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VKkhBP017497
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 16:46:43 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VKkgQ0027593
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 20:46:42 GMT
Message-ID: <49D2812B.50504@manicmethod.com>
Date: Tue, 31 Mar 2009 16:46:35 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        cpebenito@tresys.com, selinux@tycho.nsa.gov, refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com> <49D1EAE7.8050100@rubix.com> <49D21FD5.7020600@kaigai.gr.jp> <49D23288.2030807@rubix.com> <49D27E6C.5000106@kaigai.gr.jp> <49D27F77.4040906@rubix.com>
In-Reply-To: <49D27F77.4040906@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> 
> 
> KaiGai Kohei wrote:
>>> I am referring to things like:
>>>
>>> mlsconstrain { db_tuple } { use select }
>>>     (( l1 dom l2 ) or
>>>      (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
>>>      ( t1 == mlsdbread ) or
>>>      ( t2 == mlstrustedobject ));
>>>     
>>
>> I noticed the db_xxx:{use} permission remained here. :-)
>>   
> The example I used above is from an older version of the reference policy.
>>   
>>> where t1 == mlsdbread seems to imply an object is trusted to read 
>>> strictly dominating objects. Unless I am missing the meaning here, I 
>>> would call this a MAC override. I realize there is no concept of a TE 
>>> override, but MLS is part of MAC, no? And, this violates B&L rules. This 
>>> is something we would control with a Security Administrator "role". Or, 
>>> is this mlsdbread something that is impossible to give to a domain in a 
>>> DBMS policy?
>>>     
>>
>> It is different from my usage of terms.
>> Some of domains are allowed to access the tuple, and others are
>> disallowed as the result of access controls using the security
>> policy.
>>
>> I understood the term of "MAC override" to express what actions
>> are allowed without any checks based on security policy, as if
>> root stuff can ignore DAC checks.
>>   
> Ya, definitions, definitions :-) Coming from an MLS world, MAC override 
> meant superseding the B&L policy. In a general sense we use special 
> authorizations for that (our Security Admin role), while SELinux has a 
> built in mechanism (mlsdbread)

SELinux doesn't have a built in mechanism, mlsdbread is an attribute that you
give to domains that can violate this particular MLS constraint. Rather than
having a generic MAC_OVERRIDE like other MLS implementations we went with finer
grained overrides, you can see them all in kernel/mls.te.

there are also interfaces in mls.if to do the various overrides (rather than
adding the attribute yourself), for example if you wanted foo_t to be able to
read files of all levels you could call:

mls_file_read_all_levels(foo_t)

http://oss.tresys.com/docs/refpolicy/api/kernel_mls.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
