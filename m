Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t06Drh3N008850
 for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2015 08:53:43 -0500
Message-ID: <54ABE8E1.7010908@redhat.com>
Date: Tue, 06 Jan 2015 08:53:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Miroslav Grepl <mgrepl@redhat.com>, eric gisse <jowr.pi@gmail.com>
Subject: Re: Some of our customers are looking to turn on SELinux but they
 also want to use CSP from Symantec
References: <54945543.7090706@redhat.com>
 <CAHZ_Ajv=-P5baKoGNXgd-v9SAZhXkVmc2DpaBrVh2_ErSoQF_Q@mail.gmail.com>
 <54948279.2030601@redhat.com> <54ABAEBC.90308@redhat.com>
In-Reply-To: <54ABAEBC.90308@redhat.com>
Content-Type: text/plain; charset=windows-1252
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 01/06/2015 04:45 AM, Miroslav Grepl wrote:
> On 12/19/2014 08:54 PM, Daniel J Walsh wrote:
>> On 12/19/2014 02:44 PM, eric gisse wrote:
>>>> Why disabling SELinux is important? Because both SELinux and CSP
>>>> are doing the same thing, except CSP does it better!
>>> I wonder how Symantec backs that claim up.
>> Well that might be the same case in certain things,
> Yes, but really only in certain things.
>>   but when it comes to
>> multi-tenant situations, with MCS Separation. CSP has no answer.
>>> On Fri, Dec 19, 2014 at 10:41 AM, Daniel J Walsh <dwalsh@redhat.com>
>>> wrote:
>>>> Currently Symantec requires SELinux be disabled, claiming there is
>>>> conflicts in the kernel modules.
>>>>
>>>> http://www.symantec.com/connect/forums/does-scsp-agent-support-selinux
>>>>
>>>> As the customer wants to take advantage of certain  SELinux features
>>>> like sVirt for VMs and Docker Containers, this conflict is coming
>>>> to a head.
>>>>
>>>> Is anyone familiar with whether or not this is a real conflict or just
>>>> something assumed by Symantec?
>>>>
>>>> The customer like Symantec's ability to do intrusion detection and
>>>> remote logging and configuration of CSB.
>>>>
>>>> Bottom line the customer wants both.
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
BTW, we have heard back from Semantec and they plan on supporting
SELinux in a soon to be released update.

We shall see.
