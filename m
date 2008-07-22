Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MBYtmj019654
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 07:34:55 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MBYsgM009340
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 11:34:54 GMT
Message-ID: <4885C5C5.4000108@rubix.com>
Date: Tue, 22 Jul 2008 13:34:29 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: questions about persistent storage of security contexts
References: <48851770.5020002@rubix.com> <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com> <48853AA5.3040607@ak.jp.nec.com> <4885B8EB.9040809@rubix.com> <4885C0D0.7020000@ak.jp.nec.com>
In-Reply-To: <4885C0D0.7020000@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



KaiGai Kohei wrote:
> Andrew Warner wrote:
>> Thanks for the information. I have previously looked at the 
>> SE-PostgreSQL code/documentation. It was helpful and most 
>> interesting. The base DBMS I am using is called Trusted RUBIX, which 
>> is an CC EAL-4 (Trusted Solaris) evaluated MLS DBMS. We have been 
>> contracted to integrate SELinux TE and MLS (Red Hat flavor) into our 
>> DBMS. So, obviously using SE-PostgreSQL is not an option :-) In the 
>> bigger picture, this current work is a small (and rather detached) 
>> step towards a high robustness (EAL-6+) DBMS solution.
>
> It's so amazing!
>
>> Historically, our company (and myself personally) have been involved 
>> in high(er) assurance MLS DBMS products/research for a number of 
>> years. As such, we tend to use a more "traditional" minimized trust, 
>> reference monitor architecture as opposed to inserting hooks and 
>> using query modification for our security enforcement. This means, 
>> for instance, that a label object permeates much of our kernel code 
>> at a fairly low level as well as storage objects. Thus, the runtime 
>> and storage representation must be chosen carefully as it will touch 
>> much of our kernel code. We also support full polyinstantiation of 
>> named objects, which dictates an efficient label mechanism. 
>> (Integration of TE + MLS into traditional MLS polyinstantiation 
>> behavior is an interesting topic!)
>
> I have considered the way to implement polyinstantiation database for
> any object (including rows) on SE-PostgreSQL, but there were several
> difficult matters.
>
> Especially, it is a tough work to keep PK/FK integrities when security
> policy is reloaded...

Yes, PK/FK is one of the more difficult areas of integrating a MAC 
policy into a traditional RDBMS. In the end I have found that you must 
make compromises between the PK/FK integrity and MAC security. You 
simply can't have all of both. Generally, you must compromise the 
integrity constraint and keep the MAC enforcement. Or, at least remove 
any high bandwidth channels that infer values of objects which the MAC 
policy disallows viewing. Polyinstantiation helps, but also raises some 
interesting issues like which version of a polyinstantiated object 
should be presented to a user and which objects you want to 
polyinstantiate. Full polyinstantiation of tables, catalogs, etc can 
make the view of the data model overly dynamic and confusing. If you do 
not provide full polyinstantiation then you are allowing covert 
information flows in violation of the MAC policy.

Being the newbie is SELinux that I am :-), I do not understand why the 
security policy being reloaded makes PK/FK integrity especially tough 
work. Could you expand on that a little? (I am not even sure I fully 
understand what happens when a security policy is "reloaded.)

Blessings,

Andy
>
>> Out of curiosity, KaiGai, a question about how SE-PostgreSQL presents 
>> the security context to a user. From your security guide I see that 
>> the context is a selectable column. But, what SQL type is the column? 
>> For instance, do you define your own SQL type, such as "Security 
>> Context" or is it a VARCHAR that has special constraints placed upon 
>> it to force it to conform to the structure of a security context?
>
> In the latest version, the "security_context" system column is declared
> as TEXT type. Users can give their input as a normal text, then 
> SE-PostgreSQL
> translate it into internal integer value just before actuall 
> INSERT/UPDATE.
>
> Thus, we can describe the following SQL, using operators for TEXT 
> type. :-)
>
>   SELECT security_context || ':s0:c' || id AS security_context, id, 
> name, price
>          INTO new_tbl FROM old_tbl WHERE id < 256;
>
> Thanks,
>
>> Blessings,
>>
>> Andy
>>
>> KaiGai Kohei wrote:
>>>>> I have also considered maintaining my own internal, persistent 
>>>>> mapping
>>>>> between string based contexts and an integer representation, the 
>>>>> mapping
>>>>> being stored/indexed inside the DBMS. This gives me a small 
>>>>> storage overhead
>>>>> with a fixed size.
>>>>
>>>> I don't have a problem with internal mapping like that.
>>>
>>> In SE-PostgreSQL, it maintains own internal mapping between text 
>>> represented
>>> security context and its integer identifier. The 'pg_security' 
>>> system catalog
>>> stores the pair of them.
>>>
>>> Any tuple (including system catalog) has its security context. It is 
>>> stored
>>> within padding area of HeapTupleHeader as an integer value, and it 
>>> means the
>>> primary key of 'pg_security' system catalog.
>>>
>>> It also enables to boost userspace AVC, because this idea makes 
>>> possible to
>>> implement it using a relationship between identifiers (not a text 
>>> representation).
>>>
>>>
>>> When the security policy is reloaded and it makes invalidate the 
>>> stored context,
>>> the stored one is dealt as 'unlabeled_t'.
>>>
>>>> But, don't we already have sepostgresql?  Maybe you should be looking
>>>> to see if that fits your needs or you might get ideas from the work
>>>> that they performed?
>>>
>>> FYI:
>>>   http://code.google.com/p/sepgsql/
>>>
>>> Andrew, what is your intended base RDBMS?
>>>
>>> Currently, SE-PostgreSQL is the only SELinux awared RDBMS.
>>> It is now under reviewing for the next release (v8.4) cycle.
>>>   http://wiki.postgresql.org/wiki/CommitFest:2008-07
>>>
>>> However, I think we can apply SELinux for any other relational model 
>>> implementation.
>>>
>>> Thanks,
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
