Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB9IHcrq021435
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 13:17:41 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oB9IHeWr010952
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2010 18:17:40 GMT
Message-ID: <4D011D4A.6020504@itechfrontiers.com>
Date: Thu, 09 Dec 2010 13:17:46 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Joshua Brindle <method@manicmethod.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: Recent status of SE-PostgreSQL
References: <4CFF0564.1080107@ak.jp.nec.com> <AANLkTi=j9OCJ=0iGDEoAzwennWBJMiB=Env376+NoE0g@mail.gmail.com> <4D0017A7.7030605@ak.jp.nec.com> <4D0023C4.8010207@itechfrontiers.com> <4D0094F0.1050108@ak.jp.nec.com> <4D00CB7F.80603@itechfrontiers.com> <4D00FF6C.2070204@manicmethod.com> <4D010801.90108@itechfrontiers.com> <4D01162F.5040107@schaufler-ca.com>
In-Reply-To: <4D01162F.5040107@schaufler-ca.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey,

The problem is you just stuck to one part of the argument and do not see 
the broad picture,

I never claimed anything ( here at least ), I just asked what is the 
practical purpose of SE-PostgreSQL and it had one line answer,

"creating trusted DBMS daemon",   and I see that

and of course nobody claims that the SE-PostgreSQL is a done project

so one has to wait until SE-PostgreSQL reaches the point,

I told it is possible to put databases on separate systems by 
classification, NOT SUCH a BIG DEAL, (while maintaining other forms of 
security measure including filesystem encryption and etc.)
THIS IS ACTUALLY BEING UTILIZED as I'm aware of

and there are Trusted Daemons nobody says there is  no trusted daemon,
The point is right now I think PostgreSQL is not qualified as a trusted 
daemon

but even right now you can use something like that in isolation, without 
combining classifications

SO THIS IS MY QUESTION NOW:
I would be very glad if anybody provides any documentation that 
PostgreSQL is currently treated as trusted daemon,

and thanks for your recommendation,

With all due respect to everybody especially KaiGai,

Let me clear that out, there is no objection of any kind on development 
of something, but what you claimed are not available at Postgres right 
now, and there are so many missing parts not just access control, and 
the point that it is being acceptable as trusted system is just a goal



Best Regards,


Patrick K.


On 12/9/2010 12:47 PM, Casey Schaufler wrote:
> On 12/9/2010 8:46 AM, cto@itechfrontiers.com wrote:
>> Joshua,
>>
>>> Postgres is inherently trusted with it's own objects, the kernel cannot  mitigate that.
>>
>> Aha that's the point, daemons cannot be trusted, in case of DBMS it must be isolated anyway, (System Security wise)
>
> I think that we can stop right here. Patrick, you need to go read up
> on the composition of trusted systems. You also need to put a little
> time into learning about their history. There were almost as many
> Orange Book evaluations on multi-level secure databases as there were
> on operating systems. All of the evaluated operating systems, with
> the possible exception of SC/MP, made heavy use of trusted daemons.
> Applications that enforce system policy are an expected and important
> part of any security solution.
>
> Patrick, the evidence is against your claims. Please have a look at
> the literature and come back if you have questions.
>
> Thank you.
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
