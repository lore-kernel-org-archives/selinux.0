Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB9CSggp028895
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 07:28:43 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oB9CSgeE014567
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 12:28:42 GMT
Message-ID: <4D00CB7F.80603@itechfrontiers.com>
Date: Thu, 09 Dec 2010 07:28:47 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Recent status of SE-PostgreSQL
References: <4CFF0564.1080107@ak.jp.nec.com> <AANLkTi=j9OCJ=0iGDEoAzwennWBJMiB=Env376+NoE0g@mail.gmail.com> <4D0017A7.7030605@ak.jp.nec.com> <4D0023C4.8010207@itechfrontiers.com> <4D0094F0.1050108@ak.jp.nec.com>
In-Reply-To: <4D0094F0.1050108@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai,

Thanks for explanation, I see, but it seems I need to explain my points:
(We are talking about designing and implementing secure and robust 
systems) and I had objections based on Practical utilization,

1) From System Wide Perspective, PostgreSQL is another daemon and should 
not be trusted and thus we give it unprivileged user and control its 
entire daemon with MAC and give Postgres its own little island to rule 
  (I'm sure you aware of this)

2) You are going to put the same tool, SELinux to rule that little 
island of PostgreSQL, for internal objectives, access control and 
virtual users:

In my Mumble Opinion, The are objections IN PRACTICAL usage here:


2-1) IMHO, Using the same SELinux for creating control on internal 
daemon architecture (access) is in contrary to "Defense in Depth 
doctrine" (there supposed to be different layers of security and 
defense, and not to rely on a single point of failure which here is 
actually policy making and administration of those policies)

2-2) IMHO, down from hierarchy of system wide (kernel), MAC/RBAC 
INTERNALLY within daemons (programs) should be MAC/RBAC by design not as 
an add-on of external source  , A) because of performance implications 
B) they are not on the same level of trust in contrast to security, and 
Security adminis cannot deal with internal structures and objectives of 
applications in practical daily usages this is why they are isolated, it 
is up to the developers to provide and thus why an external source which 
is resource intensive should be used, Virtual user privileges within 
database are not mapped directly to system resources,


2-3) Adding SE-PostgreSQL does not bring the daemon at the same level of 
trust and it should be sandboxed or isolated anyway, and of course 
internal users of a DBMS should not be mapped from system users, this is 
why VIRTUAL users are used within DBMS , (same defense doctrine)
so why should use an external source for MAC/RBAC, when it should be MAC 
by design not as an add-on


2-4) In secure deployment a MIDDLEWARE is placed between web and a 
totally isolated DBMS for the purpose of Content filtration and analysis 
(not to trust WEB applications or its programmers) and for the purpose 
of load balancing, as well as security isolation, (AT LEAST WE DO SO)
for trusted systems, it is possible to put a single database within a 
single instance of Postgresql and do not share it with other databases,
since postgresql is process based it does not introduces much more 
resource consumption (as it only needs one additional master process per 
instance of PostgreSQL)


2-5) In terms of table space and row and table locking and access, 
separation of system usage and resources are not directly mapped to 
SYSTEM users but to VIRTUAL users of the Database, (I do not object why 
Mandatory access control is implemented but the objection is for VIRTUAL 
users of a database it is not necessary to use SELinux but to implement 
it internally as a MAC/RBAC by design)


in general, such design will have serious performance problems, instead 
of using a Middleware,

Thanks

Patrick K.





On 12/9/2010 3:36 AM, KaiGai Kohei wrote:
> Patrick,
>
> Please assume an analogy between filesystem and database management system.
>
> When we try to access information stored within a certain object managed
> by these systems (being called 'object manager'), we send a request to
> the object manager, it handles the request, then it returns a result.
>
> In the case of filesystem, we send a request as a system call.
> Then, it checks privileges of the caller based on both of DAC/MAC policy.
> The filesystem asks SELinux its access control decision via LSM hooks,
> then SELinux replies either allowed or denied.
> If allowed, the filesystem handles rest of steps; such as reading contents
> of the specified filesystem object.
>
> Don't you think it is similar to something?
>
> In the case of database management system, we send a request as a SQL.
> Then, it checks privileges of the caller based on both of DAC/MAC policy.
> The SE-PostgreSQL asks SELinux its access control decision via libselinux
> interface. Note that SE-PostgreSQL module is also called via security hooks
> in PostgreSQL. Then, SELinux replies either allowed or denied.
> If allowed, the database management system handles rest of steps; such as
> updating contents of the specified database object.
>
> See, the page.8 of:
>    http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.pdf
>
> The point is that SELinux always makes access control decision from the
> viewpoint of MAC policy. It enables to keep consistency in access control
> decision; ideally, independent from the way to store information assets.
>
>> I do not still get it, so you are going to introduce and add Mandatory
>> Access Control in PostgreSQL ?
>
> Yes. SELinux provides MAC policy. SE-PostgreSQL makes access control
> decision based on SELinux. Thus, SE-PostgreSQL provides MAC.
>
>> So when database users are created by admins or design or such, what
>> SE-PostgreSQL is supposed to do?, preventing users to bypass their privileges?
>> or bypassing security of the DBMS engines?  (the latter can already be
>> achieved using SELinux)
>
> Even if SE-PostgreSQL is installed, existing database privilege mechanism
> is still working.
> These features makes its access control decision independently each other.
>
> Also note that, SE-PostgreSQL acquires security context of the peer process
> to apply it as privilege of the client. Its access control decision is not
> affected by database users, even if database superuser.
>
>> since PostgreSQL is process based (not thread based) per connection, what
>> is it saved? by not isolating Databases (DBMS) totally from each other and
>> having multiple instances rather than just introducing another level of
>> access control mechanism?
>
> It seems to me you believe the scope of SELinux is limited to data objects
> managed by kernel features. Every instances are allowed to access database
> files, but these instances voluntary controls execution of the given SQL
> based on MAC policy.
>
> Sorry, I'm not clear where is your point.
> Does my introduction help you to understand?
>
> Thanks,
>
> (2010/12/09 9:33), cto@itechfrontiers.com wrote:
>> KaiGai,
>>
>> I do not still get it, so you are going to introduce and add Mandatory Access Control in PostgreSQL ?
>>
>> I still don't get its practical application, since obviously at system level DAC is not sufficient users have other means of bypassing it, ie. can set things that results in undesired behavior and security breach such as chmod 777, or out of context
>> memory pages
>>
>> So when database users are created by admins or design or such, what SE-PostgreSQL is supposed to do?, preventing users to bypass their privileges? or bypassing security of the DBMS engines? (the latter can already be achieved using SELinux)
>>
>> or to give people possibility of "Creating access" controls then put MAC into practice not to let them to create insecure access !! why we have to give them such grant of privilege at first place in DBMS
>>
>>
>> Or the goal is access control being derived from SELinux Policies (external sources)?
>>
>> in current implementations of a secure database, an external module (Program) can add or remove or delete records to or from the database and being moderated by SELinux for MAC and sandboxing purposes
>>
>> since PostgreSQL is process based (not thread based) per connection, what is it saved? by not isolating Databases (DBMS) totally from each other and having multiple instances rather than just introducing another level of access control mechanism?
>>
>> Complexity is the enemy of Security.
>>
>> Would you mind to shed some light on this.
>>
>> Thanks
>>
>> Patrick K.
>>
>>
>> On 12/8/2010 6:41 PM, KaiGai Kohei wrote:
>>> (2010/12/09 0:29), Ted Toth wrote:
>>>> Thanks for the update. Questions inline.
>>>>
>>>> 2010/12/7 KaiGai Kohei<kaigai@ak.jp.nec.com>:
>>>>> I'd like to report the recent status of SE-PostgreSQL development,
>>>>> since I guess few number of people subscribing pgsql-hackers list.
>>>>>
>>>>> Now, the pgsql community is working on new features to the upcoming
>>>>> v9.1 releases. Although we don't come up the feature freeze yet,
>>>>> several fundamental features to support selinux are already merged,
>>>>> and these shall be released within the v9.1 release.
>>>>>
>>>>> The v9.1 of pgsql shall support label based mandatory access control
>>>>> by external security providers.
>>>>> The external security provider is a similar concept to LSM.
>>>>> It allows plugin modules to make access control decision based on
>>>>> its access control model such as SELinux, and the core pgsql calls
>>>>> the modules via security hooks.
>>>>>
>>>>> So, SE-PostgreSQL is now implemented as a plugin module of pgsql.
>>>>>
>>>>> Anyway, the upcoming v9.1 shall provide a mechanism to assign
>>>>> security label of database objects and security hooks on various
>>>>> strategic points (but not comprehensive yet).
>>>>
>>>> Could you expand upon exactly what you mean here? Since this is not
>>>> 'comprehensive' does that imply potential vulnerabilities?
>>>>
>>> It means we are under construction of the security hooks, so some of
>>> actions (especially, permission checks on ddl statements) are not
>>> hooked by the plugin modules. In short, it is still vulnerable.
>>>
>>> These stuff must be implemented step-by-step, because burden of
>>> reviewers is not ignorable if we try to implement a complete
>>> feature at once. It is a target towards the v9.2 release.
>>>
>>>
>>>>> We will be able to assign security label using SECURITY LABEL
>>>>> statement in SQL (original enhancement of pgsql) by hand.
>>>>> It allows us to assign a certain label on a certain database
>>>>> objects. The given label is validated by plugin modules, then
>>>>> stored within system catalogs.
>>>>> In addition, post-object-creation hook enables to assign a default
>>>>> security label of the new database object on the creation time.
>>>>>
>>>>> Here are other new hooks; 'ExecutorCheckPerms' hook enables to
>>>>> make access control decision on DML statements (SELECT, UPDATE,
>>>>> INSERT and DELETE), 'ClientAuthentication' hook enables to
>>>>> obtain security label of the peer process using getpeercon(3)
>>>>> at beginning of the session, 'object_access' hook will enable
>>>>> to handle DDL permissions but not comprehensive yet.
>>>>>
>>>>> I expect a limited functionalities will be available in the
>>>>> v9.1 of PostgreSQL. It will be far from production level,
>>>>> but a great step towards the full features.
>>>>>
>>>>> The v9.1 will have feature freeze at the 15-Jun, then it may be
>>>>> released half years later. At the same time, merge window to the
>>>>> v9.2 will be open. So, I'll upstream rest of features; such as
>>>>> comprehensive DDL permissions, row-level access controls and so on.
>>>>>
>>>>> Thanks,
>>>>> --
>>>>> KaiGai Kohei<kaigai@ak.jp.nec.com>
>>>>>
>>>>> --
>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>
>>>>
>>>> Ted
>>>>
>>>
>>>
>>
>>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
