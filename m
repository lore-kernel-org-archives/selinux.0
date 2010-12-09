Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB90X4ub030045
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2010 19:33:04 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oB90X3Vk026206
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 00:33:04 GMT
Message-ID: <4D0023C4.8010207@itechfrontiers.com>
Date: Wed, 08 Dec 2010 19:33:08 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Ted Toth <txtoth@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Recent status of SE-PostgreSQL
References: <4CFF0564.1080107@ak.jp.nec.com> <AANLkTi=j9OCJ=0iGDEoAzwennWBJMiB=Env376+NoE0g@mail.gmail.com> <4D0017A7.7030605@ak.jp.nec.com>
In-Reply-To: <4D0017A7.7030605@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai,

I do not still get it, so you are going to introduce and add Mandatory 
Access Control in PostgreSQL ?

I still don't get its practical application, since obviously at system 
level DAC is not sufficient users have other means of bypassing it, ie. 
can set things that results in undesired behavior and security breach 
such as chmod 777, or out of context memory pages

So when database users are created by admins or design or such, what 
SE-PostgreSQL is supposed to do?, preventing users to bypass their 
privileges? or bypassing security of the DBMS engines?  (the latter can 
already be achieved using SELinux)

or to give people possibility of "Creating access" controls then put MAC 
into practice not to let them to create insecure access !! why we have 
to give them such grant of privilege at first place in DBMS


Or the goal is access control being derived from SELinux Policies 
(external sources)?

in current implementations of a secure database, an external module 
(Program) can add or remove or delete records to or from the database 
and being moderated by SELinux for MAC and sandboxing purposes

since PostgreSQL is process based (not thread based) per connection, 
what is it saved? by not isolating Databases (DBMS) totally from each 
other and having multiple instances rather than just introducing another 
level of access control mechanism?

Complexity is the enemy of Security.

Would you mind to shed some light on this.

Thanks

Patrick K.


On 12/8/2010 6:41 PM, KaiGai Kohei wrote:
> (2010/12/09 0:29), Ted Toth wrote:
>> Thanks for the update. Questions inline.
>>
>> 2010/12/7 KaiGai Kohei<kaigai@ak.jp.nec.com>:
>>> I'd like to report the recent status of SE-PostgreSQL development,
>>> since I guess few number of people subscribing pgsql-hackers list.
>>>
>>> Now, the pgsql community is working on new features to the upcoming
>>> v9.1 releases. Although we don't come up the feature freeze yet,
>>> several fundamental features to support selinux are already merged,
>>> and these shall be released within the v9.1 release.
>>>
>>> The v9.1 of pgsql shall support label based mandatory access control
>>> by external security providers.
>>> The external security provider is a similar concept to LSM.
>>> It allows plugin modules to make access control decision based on
>>> its access control model such as SELinux, and the core pgsql calls
>>> the modules via security hooks.
>>>
>>> So, SE-PostgreSQL is now implemented as a plugin module of pgsql.
>>>
>>> Anyway, the upcoming v9.1 shall provide a mechanism to assign
>>> security label of database objects and security hooks on various
>>> strategic points (but not comprehensive yet).
>>
>> Could you expand upon exactly what you mean here? Since this is not
>> 'comprehensive' does that imply potential vulnerabilities?
>>
> It means we are under construction of the security hooks, so some of
> actions (especially, permission checks on ddl statements) are not
> hooked by the plugin modules. In short, it is still vulnerable.
>
> These stuff must be implemented step-by-step, because burden of
> reviewers is not ignorable if we try to implement a complete
> feature at once. It is a target towards the v9.2 release.
>
>
>>> We will be able to assign security label using SECURITY LABEL
>>> statement in SQL (original enhancement of pgsql) by hand.
>>> It allows us to assign a certain label on a certain database
>>> objects. The given label is validated by plugin modules, then
>>> stored within system catalogs.
>>> In addition, post-object-creation hook enables to assign a default
>>> security label of the new database object on the creation time.
>>>
>>> Here are other new hooks; 'ExecutorCheckPerms' hook enables to
>>> make access control decision on DML statements (SELECT, UPDATE,
>>> INSERT and DELETE), 'ClientAuthentication' hook enables to
>>> obtain security label of the peer process using getpeercon(3)
>>> at beginning of the session, 'object_access' hook will enable
>>> to handle DDL permissions but not comprehensive yet.
>>>
>>> I expect a limited functionalities will be available in the
>>> v9.1 of PostgreSQL. It will be far from production level,
>>> but a great step towards the full features.
>>>
>>> The v9.1 will have feature freeze at the 15-Jun, then it may be
>>> released half years later. At the same time, merge window to the
>>> v9.2 will be open. So, I'll upstream rest of features; such as
>>> comprehensive DDL permissions, row-level access controls and so on.
>>>
>>> Thanks,
>>> --
>>> KaiGai Kohei<kaigai@ak.jp.nec.com>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>
>> Ted
>>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
