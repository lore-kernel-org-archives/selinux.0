Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MBDRHv015615
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 07:13:27 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MBDPfY026920
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 11:13:26 GMT
Message-ID: <4885C0D0.7020000@ak.jp.nec.com>
Date: Tue, 22 Jul 2008 20:13:20 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Andrew Warner <warner@rubix.com>
CC: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: questions about persistent storage of security contexts
References: <48851770.5020002@rubix.com> <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com> <48853AA5.3040607@ak.jp.nec.com> <4885B8EB.9040809@rubix.com>
In-Reply-To: <4885B8EB.9040809@rubix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andrew Warner wrote:
> Thanks for the information. I have previously looked at the 
> SE-PostgreSQL code/documentation. It was helpful and most interesting. 
> The base DBMS I am using is called Trusted RUBIX, which is an CC EAL-4 
> (Trusted Solaris) evaluated MLS DBMS. We have been contracted to 
> integrate SELinux TE and MLS (Red Hat flavor) into our DBMS. So, 
> obviously using SE-PostgreSQL is not an option :-) In the bigger 
> picture, this current work is a small (and rather detached) step towards 
> a high robustness (EAL-6+) DBMS solution.

It's so amazing!

> Historically, our company (and myself personally) have been involved in 
> high(er) assurance MLS DBMS products/research for a number of years. As 
> such, we tend to use a more "traditional" minimized trust, reference 
> monitor architecture as opposed to inserting hooks and using query 
> modification for our security enforcement. This means, for instance, 
> that a label object permeates much of our kernel code at a fairly low 
> level as well as storage objects. Thus, the runtime and storage 
> representation must be chosen carefully as it will touch much of our 
> kernel code. We also support full polyinstantiation of named objects, 
> which dictates an efficient label mechanism. (Integration of TE + MLS 
> into traditional MLS polyinstantiation behavior is an interesting topic!)

I have considered the way to implement polyinstantiation database for
any object (including rows) on SE-PostgreSQL, but there were several
difficult matters.

Especially, it is a tough work to keep PK/FK integrities when security
policy is reloaded...

> Out of curiosity, KaiGai, a question about how SE-PostgreSQL presents 
> the security context to a user. From your security guide I see that the 
> context is a selectable column. But, what SQL type is the column? For 
> instance, do you define your own SQL type, such as "Security Context" or 
> is it a VARCHAR that has special constraints placed upon it to force it 
> to conform to the structure of a security context?

In the latest version, the "security_context" system column is declared
as TEXT type. Users can give their input as a normal text, then SE-PostgreSQL
translate it into internal integer value just before actuall INSERT/UPDATE.

Thus, we can describe the following SQL, using operators for TEXT type. :-)

   SELECT security_context || ':s0:c' || id AS security_context, id, name, price
          INTO new_tbl FROM old_tbl WHERE id < 256;

Thanks,

> Blessings,
> 
> Andy
> 
> KaiGai Kohei wrote:
>>>> I have also considered maintaining my own internal, persistent mapping
>>>> between string based contexts and an integer representation, the 
>>>> mapping
>>>> being stored/indexed inside the DBMS. This gives me a small storage 
>>>> overhead
>>>> with a fixed size.
>>>
>>> I don't have a problem with internal mapping like that.
>>
>> In SE-PostgreSQL, it maintains own internal mapping between text 
>> represented
>> security context and its integer identifier. The 'pg_security' system 
>> catalog
>> stores the pair of them.
>>
>> Any tuple (including system catalog) has its security context. It is 
>> stored
>> within padding area of HeapTupleHeader as an integer value, and it 
>> means the
>> primary key of 'pg_security' system catalog.
>>
>> It also enables to boost userspace AVC, because this idea makes 
>> possible to
>> implement it using a relationship between identifiers (not a text 
>> representation).
>>
>>
>> When the security policy is reloaded and it makes invalidate the 
>> stored context,
>> the stored one is dealt as 'unlabeled_t'.
>>
>>> But, don't we already have sepostgresql?  Maybe you should be looking
>>> to see if that fits your needs or you might get ideas from the work
>>> that they performed?
>>
>> FYI:
>>   http://code.google.com/p/sepgsql/
>>
>> Andrew, what is your intended base RDBMS?
>>
>> Currently, SE-PostgreSQL is the only SELinux awared RDBMS.
>> It is now under reviewing for the next release (v8.4) cycle.
>>   http://wiki.postgresql.org/wiki/CommitFest:2008-07
>>
>> However, I think we can apply SELinux for any other relational model 
>> implementation.
>>
>> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
