Message-ID: <4E5F9921.6020102@manicmethod.com>
Date: Thu, 01 Sep 2011 10:39:29 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
CC: Kohei KaiGai <kaigai@kaigai.gr.jp>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: sepgsql and process transition
References: <4E5D2DBA.9060201@manicmethod.com> <CADyhKSVBhXHsfyXVkWZxuJqAZ9-QgPjfhPZOdGyfBEEGb-iVbA@mail.gmail.com> <4E5E933B.6060604@manicmethod.com> <CADyhKSVcA2LtxMnVvcAZ5zvWbs8E=RtFrV9bvLYo6ukDpRYc-Q@mail.gmail.com> <D0C1A1F8BF513F469926E6C71461D9EC051E85@EX10MBX02.EU.NEC.COM>
In-Reply-To: <D0C1A1F8BF513F469926E6C71461D9EC051E85@EX10MBX02.EU.NEC.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kohei Kaigai wrote:
>>> I think I hit the exact reason why this bothers me today. As
>>> staff_t:SystemLow-SystemHigh I wanted a stored procedure that ran at
>>> sepgsql_trusted_proc_t:SystemHigh (so that it could read a SystemHigh column
>>> and fuzz the results).
>>>
>>> Because of the current process constraint:
>>>   mlsconstrain process transition
>>>        (( h1 dom h2 ) and
>>>         (( l1 eq l2 ) or ( t1 == mlsprocsetsl ) or
>>>          (( t1 == privrangetrans ) and ( t2 == mlsrangetrans ))));
>>>
>>> it isn't possible unless staff_t is part of privrangetrans and
>>> sepgsql_trusted_proc_t is part of mlsrangetrans. I don't mind the latter but
>>> the former is clearly a violation of how MLS is suppose to work on
>>> multi-level SELinux systems (in general, unprivileged users should not be
>>> able to change their level without going through newrole or logging out and
>>> back in).
>>>
>>> If there was a different object class for procedures-while-executing, akin
>>> to process but called something different we could have a different
>>> constraint that made more sense for this use case.
>>>
>> Hmm. I'd like to consider this matter for more details.
>>
> I think it is not a situation that we should allow staff_t:SystemLow-SystemHigh
> to translate into sepgsql_trusted_proc_t:SystemHigh, because this rule intends
> to prevent to switch lower range without special attributes, and it eventually
> prevents violated references of information.
> Even if we have individual object class to represent a subject entity of database
> system, its fundamental is not changed, is it?

If staff running at system low need to use a trusted procedure to get (and 
redact, remove precision, etc) system high data they must be able to transition 
like that. Even if the user is running at systemlow-systemhigh, since their 
active clearance is systemlow, their user type must have privrangetrans which is 
not desirable.

>
> It seems to me a straightforward solution is to define an individual trusted
> procedure type for MLS range transition (with mlsrangetrans), and restrict
> subject entity to invoke this procedure (using privrangetrans).
>

We don't want to give privrangetrans to unprivileged user domains though.

>> One other point I'm considering is what security label should be delivered to
>> when a database client want to invoke a remote procedure call using functions
>> installed to PostgreSQL. This feature is called 'foreign-data-wrapper' being
>> already merged at v9.1.
>> If we assign a subject entity that performs as an agent of client a security
>> label that is not a part of domain attribute, I'm not certain whether it is an
>> appropriate manner, or not.
>>
> One other confusable situation is invocation of remote procedure from PostgreSQL.
> If we try to set up multiple SE-PostgreSQL systems that communicate via labeled
> networking each other, I'm afraid that analysis of domain transition becomes hard
> because it allows multiple paths to translate other domains.
>

The tools will need to be updated to handle the additional transition via db 
procedure but the analysis is no different than a domain transition or 
transitive information flow analysis of today.

> Right now, my opinion is that process:{translate} permission should be checked
> when a subject entity of (operating|database) system tried to be switched.
>

trusted procedures are not processes and should not use the process object class.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
