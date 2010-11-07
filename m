Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA7HiRql008349
	for <selinux@tycho.nsa.gov>; Sun, 7 Nov 2010 12:44:28 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oA7HiQNI001423
	for <selinux@tycho.nsa.gov>; Sun, 7 Nov 2010 17:44:27 GMT
Message-ID: <4CD6E57E.5090101@itechfrontiers.com>
Date: Sun, 07 Nov 2010 12:44:30 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Cliffe <cliffe@ii.net>
CC: Behnaz Hassanshahi <behnaz.kallen@yahoo.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: temporal role base access control in Linux
References: <182838.53024.qm@web110814.mail.gq1.yahoo.com> <4CD6BA38.10202@itechfrontiers.com> <4CD6C7B0.90305@ii.net> <4CD6D454.3040709@itechfrontiers.com> <4CD6D8E8.5060108@ii.net>
In-Reply-To: <4CD6D8E8.5060108@ii.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Cliffe,

Not at all, Just sharing point of views, anyway I learn everyday,

I think better not to go off topic and explain a little bit more:

TRBAC  =  Temporal Role-Based Access Control
TRBAC = Time constraint/periodic roles/events (Activate-deactivate) + 
their triggers + RBAC


I wrote it can be SIMULATED using pure SELinux, becasue:

if the triggers do not need to be atomic role entries, in example it 
does not need to be an inline IPS/IDS changing roles in fraction of 
minute/second;

but the event triggers are longer to deal with, in example changing 
personnel shifts (longer time frame),

Then a simple SIMULATION with SELinux would be:

1) Create/generate different policies and their dependencies for 
different events, (The program even can try to generate these on the fly)
2) create a task scheduler or event handler or hierarchical scheduler
3) load/replace generated policies using above task scheduler/event 
handler/hierarchical scheduler based on triggers and events

* Virtually Much like and administrative job automation

* This event handler needs to have higher privileges for loading 
policies (MAC wise)

* This can be done without applying modification to SELinux

* All above can also be done using LSM APIs/SELinux Hooks/APIs as I 
posted their links on my first reply before too (much more complicated 
of course)


NOTICE: In real life scenarios, SELinux itself is complicated enough in 
practice to generate policies that as you all know it is used for 
targeted processes, not everything, so the concept of applying this to 
targeted processes in practice is inherited by TRBAC on top of SELinux

One may want to develop genuine TRBAC, then stick to LSM (Linux Security 
Module) as a standard security interface with Linux kernel.


Best Regards,

Patrick K.


On 11/7/2010 11:50 AM, Cliffe wrote:
> Hi Patrick,
>
> No worries. Yes, I am not a lawyer. It is obviously entirely your
> prerogative, and I am not criticising the help you provided. To be
> honest, I just found it strange that you would choose to point out what
> country they were from and who SELinux was developed by, as if that made
> them less entitled to help with an open source project. Sorry if you
> feel I overreacted.
>
> I don't have anything to add to your implementation suggestions, thanks
> for sharing.
>
> Cliffe.
>
> On 8/11/2010 12:31 AM, cto@itechfrontiers.com wrote:
>> Hello Cliffe,
>>
>> I Believe, I provided enough information to be able to achieve what
>> has been asked here.
>>
>> Anyway I'm bound to the US rules and abide and respect them, and
>> definitely am not a Lawyer, however my concern was not EAR (Export
>> Administration Regulations) the law is much more complicated than just
>> an export control regulation,
>>
>> By considering the source of the message coming from a known
>> University in Iran working on dual purpose subjects, I personally
>> prefer not to help particularly (on implementation basis), and I think
>> I have such right.
>>
>> Tried to help as much as I could.
>>
>> Providing legal advice requires attorney-client privilege/relationship
>> and I don't think just Google search result would be enough in such case.
>>
>> Anyway this is not a legal mailing list, technical aspects have been
>> covered as much as it should, if you would like you may add additional
>> notes.
>>
>> Best Regards,
>>
>> Patrick K.
>>
>>
>> On 11/7/2010 10:37 AM, Cliffe wrote:
>>> On 7/11/2010 10:39 PM, cto@itechfrontiers.com wrote:
>>>> I'm sorry but with all due respects, I don't know if helping people in
>>>> Iran on the subject is legal or not (I'm not a Lawyer) but judging
>>>> from sources of your mail (which is Iran), I prefer not to be involved
>>>> in any particular help.
>>> I have never heard anything that has suggested that there have ever been
>>> US export laws regarding access control software, let alone helping
>>> someone set up their free open source security software (please let me
>>> know if you have heard otherwise). It has been 10 years since US
>>> cryptography export laws have relaxed (and maybe they still apply to
>>> embargoed destinations).
>>>
>>> Just a quick google:
>>> "controls on encryption did not apply to cryptographic equipment and
>>> software if their functionality was limited to any of the following nine
>>> categories:" ... "(5) Access control devices such as ATMs;"
>>>> Anyway this is a project develped primarily by the National Security
>>>> Agency of the USA, and its contributors.
>>> That does not seem relevant to me...
>>>
>>> Cliffe.
>>>
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>
>>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
