Message-ID: <4E5FD968.9050002@manicmethod.com>
Date: Thu, 01 Sep 2011 15:13:44 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
CC: Kohei KaiGai <kaigai@kaigai.gr.jp>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: sepgsql and process transition
References: <4E5D2DBA.9060201@manicmethod.com> <CADyhKSVBhXHsfyXVkWZxuJqAZ9-QgPjfhPZOdGyfBEEGb-iVbA@mail.gmail.com> <4E5E933B.6060604@manicmethod.com> <CADyhKSVcA2LtxMnVvcAZ5zvWbs8E=RtFrV9bvLYo6ukDpRYc-Q@mail.gmail.com> <D0C1A1F8BF513F469926E6C71461D9EC051E85@EX10MBX02.EU.NEC.COM> <4E5F9921.6020102@manicmethod.com> <D0C1A1F8BF513F469926E6C71461D9EC0523B8@EX10MBX02.EU.NEC.COM>
In-Reply-To: <D0C1A1F8BF513F469926E6C71461D9EC0523B8@EX10MBX02.EU.NEC.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kohei Kaigai wrote:
>>> I think it is not a situation that we should allow staff_t:SystemLow-SystemHigh
>>> to translate into sepgsql_trusted_proc_t:SystemHigh, because this rule intends
>>> to prevent to switch lower range without special attributes, and it eventually
>>> prevents violated references of information.
>>> Even if we have individual object class to represent a subject entity of database
>>> system, its fundamental is not changed, is it?
>> If staff running at system low need to use a trusted procedure to get (and
>> redact, remove precision, etc) system high data they must be able to transition
>> like that. Even if the user is running at systemlow-systemhigh, since their
>> active clearance is systemlow, their user type must have privrangetrans which is
>> not desirable.
>>
> If we add "db_client" as a new object class for a subject entity of database system,
> How does the MLS constraint of db_client control the domain transition?
> I guess the rule shall follow the process class:
>
>    mlsconstrain db_client transition
>            (( h1 dom h2 ) and
>              (( l1 eq l2 ) or ( t1 == mlsprocsetsl ) or
>              (( t1 == privrangetrans ) and ( t2 == mlsrangetrans ))));
>
> However, in this case, staff_t still requires privrangetrans and sepgsql_trusted_proc_t
> requires mlsrangetrans. If we exceptionally allows to upgrade/downgrade range of subject
> entity on database system, unlike operating system, it is arguable...
>

I assume we'll have different attributes so that OS privileges and DB privileges 
can be separated.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
