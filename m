Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p97AoQWc009758
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2011 06:50:26 -0400
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p97AoPfJ023844
	for <selinux@tycho.nsa.gov>; Fri, 7 Oct 2011 10:50:25 GMT
Message-ID: <4E8ED969.9020504@itechfrontiers.com>
Date: Fri, 07 Oct 2011 06:50:17 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Hramchenko <hramchenko@bk.ru>
CC: selinux@tycho.nsa.gov
Subject: Re: New HIPS based on SELinux
References: <201110060030.05639.hramchenko@bk.ru> <201110061618.31119.hramchenko@bk.ru> <4E8D822D.3040004@itechfrontiers.com> <201110071416.39088.hramchenko@bk.ru>
In-Reply-To: <201110071416.39088.hramchenko@bk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

 > Statistical analysis is not requirement

There are 4 established methods for IDS and IPS detection part of the 
IDPS system, your IDS/IPS should have at least one :


1) Signature based
2) Anomaly Analysis
3) Protocol Analysis
4) Heuristic Analysis

The problem is yours doesn't have any, it is reporting SELinux Logs only 
by alerts,


You want to teach me my profession no problem,

I answered it before,

You are wasting time here,

Your so called "HIPS" only sends alerts of SELinux Logs, Period.

If you call this HIPS I don't care, I just clarified that it is not in 
my opinion. Otherwise we have to call all log watcher daemons HIPS then.

A bicycle has wheels, a car has wheels  too, but surely a bicycle is not 
qualified as a Car due to just having wheels, Otherwise my firecrackers 
would be the Saturn 5 Missiles (same physics)


Your program just reports SELinux Logs and sends alerts, it uses some 
Templates for establishing SELinux Policies,

There is no element of interaction or reaction to threats by detecting 
and responding in it, and There is no extensive system analysis of 4 
types as I mentioned above,

In Example, Snort IDS Uses Signature based analysis, Bro IDS uses 
Protocol Analysis, Commercial ones use Anomaly analysis and Heuristic 
Analysis as well,

Your problem is it has been my profession during past 12 years, and you 
want to change the definition and call a simple program Host Based 
Intrusion Prevention System !!!   no problem, You call it what you want,

You post something to the List for other professional peer-review isn't it?

Sir you are using your own definition not the established ones.



Best,

Patrick K.


On 10/7/2011 4:16 AM, Hramchenko wrote:
> Hello Patrick.
>
> Statistical analysis is not requirement for IDPS according to NIST Guide to
> Intrusion Detection and Prevention Systems (IDPS) by Karen Scarfone and Peter
> Mell :
>
> The types of events detected by host-based IDPSs vary considerably based
> primarily on the detection techniques that they use. Some host-based IDPS
> products offer several of these detection techniques, while others focus on a
> few or one.
>
> One of the most important function of HIPS is:
> – System call monitoring. The agent knows which applications and processes
> should be calling which other applications and processes or performing certain
> actions.
>
> System call monitoring provided by User Data Defence from SELinux messages. Of
> course this system need further development and intellectual analysis of
> events will be appended to this system in the future. But the lack of
> intellectual analysis does not prohibit refer User Data Defence to intrusion
> prevention systems.
>
> With respect, Hramchenko Vitaliy.
>
> Patrick K. wrote:
>> Generating alerts is not Anomaly Based analysis, it is simply generating
>> alerts based on SELinux logs,
>>
>> This is in no way fit into any definition of HIPS/HIDPS as security
>> industry defines it.
>>
>> There is no such deterministic or non-deterministic statistical analysis
>> going on here, that you put your program into that category, those are
>> based on established Math actually, We use Advanced Statistical Math in
>> Anomaly analysis (in item 2: anomaly analysis you referred it to) taking
>> into account system factors and components
>>
>>
>> Best Regards,
>>
>> Patrick K.
>>
>> On 10/6/2011 6:18 AM, Hramchenko wrote:
>>> Hello, Patrick
>>>
>>> Thanks for your reply. I understand your concerns about the term of HIPS.
>>>
>>> I didn't want to mislead users, but User Data Defence is not new another
>>> policies editor.
>>>
>>> User Data Defence also provides customizable alerts notification. User
>>> could specify alert look and set its level. This function helps to
>>> filter critical alerts from other messages.
>>>
>>> I think alerts notification provides detection of program anomalies:
>>> 	2) Anomaly based analysis of threats against the server, in example
>>>
>>> statistical analysis, Integrity analysis and etc.
>>>
>>> Of course, User Data Defence is not so powerful as chkrootkit HBIDS, but
>>> it is an attempt to provide simple instrument for blocking attacks to
>>> user mode applications.
>>>
>>> With respect, Hramchenko Vitaliy.
>>>
>>> Patrick K. wrote:
>>>> Hello,
>>>>
>>>> I think you are misusing the term "HIPS" here, (or using your own
>>>> definition actually)
>>>>
>>>> Sorry to be pedantic but, SELinux as you know is an add-on (platform
>>>> ) to the kernel providing Access Control (RBAC, IBAC, MAC and etc.) and
>>>> MLS (Multi-Level Security)
>>>>
>>>> While encouraging you for your work but I'm afraid it is as you
>>>> explained yourself:
>>>>
>>>> " User Data Defence includes set of template policies, which makes
>>>> process of creation SELinux specifications for user mode applications
>>>> simple .... "
>>>>
>>>> in other words, It is A Graphical user Interface for creating SELinux
>>>> Policies
>>>>
>>>>
>>>> BUT, Host based Intrusion Prevention System,  (HIPS)
>>>>
>>>> or more accurately Host Based Intrusion Detection and Prevention System
>>>> (HIDPS) requires a method to detect attacks and react upon them or
>>>> interact with them (Preemptive approach), taking into account the server
>>>> or workstation parameters and conditions, utilizing either or
>>>> combination of :
>>>>
>>>> 1) Signature based analysis of threats
>>>>
>>>>
>>>> 2) Anomaly based analysis of threats against the server,
>>>> in example statistical analysis, Integrity analysis and etc.
>>>>
>>>>
>>>> 3) Protocol Anomaly Analysis
>>>>
>>>>
>>>> 4) Heuristic analysis
>>>> combination of methods  using Expert systems or other means in
>>>> Artificial Intelligence/Synthetic Intelligence  such as Petri nets,
>>>> Artificial Neural Networks and etc.
>>>>
>>>>
>>>> Best Regards,
>>>>
>>>> Patrick K.
>>>>
>>>> On 10/5/2011 2:30 PM, Hramchenko wrote:
>>>>> Hi all.
>>>>>
>>>>> I have created new host intrusion prevention system based on SELinux.
>>>>> It's focused on protection user's data.
>>>>> One of the main goals was to create lightweight replacement of
>>>>> setroubleshootd.
>>>>>
>>>>> I hope my program will be useful for SELinux users.
>>>>>
>>>>> The project home page:
>>>>> https://github.com/Hramchenko/userdatadefence/
>>>>>
>>>>> With respect, Hramchenko Vitaliy.
>>>>>
>>>>> --
>>>>> This message was distributed to subscribers of the selinux mailing
>>>>> list. If you no longer wish to subscribe, send mail to
>>>>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
>>>>> quotes as the message.
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with the words "unsubscribe selinux" without quotes as the message.
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with the words "unsubscribe selinux" without quotes as the message.
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
