Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s426QiKr002773
 for <selinux@tycho.nsa.gov>; Fri, 2 May 2014 02:26:44 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so2189420oag.28
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 23:26:45 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.16.173])
 by mx.google.com with ESMTPSA id j9sm64686888obh.23.2014.05.01.23.26.43
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 01 May 2014 23:26:44 -0700 (PDT)
Message-ID: <53633A05.2050808@gmail.com>
Date: Fri, 02 May 2014 11:54:05 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a policy configuration file?
References: <53627C9F.9020109@gmail.com>	<CAB9W1A1+Rh0hDW+dNzehTbo0p4r-vaGWdugks9UnfNoZ5xuinQ@mail.gmail.com>	<53628456.8020407@gmail.com>
 <CAB9W1A0-BR_Nu2M2RjQxh9KTye-=x9thiBQbBKaGg+zSQA1Y-w@mail.gmail.com>
In-Reply-To: <CAB9W1A0-BR_Nu2M2RjQxh9KTye-=x9thiBQbBKaGg+zSQA1Y-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/01/14 23:15, Stephen Smalley wrote:
> First reference is talking about source configuration files, and the
> next section of that report describes how policy.conf is created and
> then compiled into the binary policy file.
> Second reference is talking about the configuration files installed on
> the system for use at runtime, which includes both the kernel binary
> policy file and various text configuration files used by userspace
> programs.  The term could apply to either.
>
> On Thu, May 1, 2014 at 10:28 AM, dE <de.techno@gmail.com> wrote:
>> On 05/01/14 22:41, Stephen Smalley wrote:
>>> Typically, but you didn't provide any context or cite the source of
>>> the reference.
>>> One might use the term for an individual source file, the policy.conf
>>> file generated from all of the source files, or the final kernel
>>> binary policy file, although the latter is less likely.
>>>
>>> On Thu, May 1, 2014 at 9:55 AM, dE <de.techno@gmail.com> wrote:
>>>> Is this another name for policy source?
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>
>> http://www.nsa.gov/research/_files/selinux/papers/policy2/x109.shtml
>>
>> http://selinuxproject.org/page/ConfigurationFiles#Policy_Configuration_Files
>>
>> I would like to know what the official website means -- it's definitely the
>> sources. I hope I'll read about policy.conf in the NSA reference.
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.

The policy.conf is used during build time to make small time changes in 
the resulting binary right?
