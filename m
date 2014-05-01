Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41HjP67017884
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 13:45:26 -0400
Received: by mail-qa0-f43.google.com with SMTP id ih12so3251526qab.2
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 10:45:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53628456.8020407@gmail.com>
References: <53627C9F.9020109@gmail.com>
 <CAB9W1A1+Rh0hDW+dNzehTbo0p4r-vaGWdugks9UnfNoZ5xuinQ@mail.gmail.com>
 <53628456.8020407@gmail.com>
Date: Thu, 1 May 2014 10:45:26 -0700
Message-ID: <CAB9W1A0-BR_Nu2M2RjQxh9KTye-=x9thiBQbBKaGg+zSQA1Y-w@mail.gmail.com>
Subject: Re: What's a policy configuration file?
From: Stephen Smalley <stephen.smalley@gmail.com>
To: dE <de.techno@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

First reference is talking about source configuration files, and the
next section of that report describes how policy.conf is created and
then compiled into the binary policy file.
Second reference is talking about the configuration files installed on
the system for use at runtime, which includes both the kernel binary
policy file and various text configuration files used by userspace
programs.  The term could apply to either.

On Thu, May 1, 2014 at 10:28 AM, dE <de.techno@gmail.com> wrote:
> On 05/01/14 22:41, Stephen Smalley wrote:
>>
>> Typically, but you didn't provide any context or cite the source of
>> the reference.
>> One might use the term for an individual source file, the policy.conf
>> file generated from all of the source files, or the final kernel
>> binary policy file, although the latter is less likely.
>>
>> On Thu, May 1, 2014 at 9:55 AM, dE <de.techno@gmail.com> wrote:
>>>
>>> Is this another name for policy source?
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>
>
> http://www.nsa.gov/research/_files/selinux/papers/policy2/x109.shtml
>
> http://selinuxproject.org/page/ConfigurationFiles#Policy_Configuration_Files
>
> I would like to know what the official website means -- it's definitely the
> sources. I hope I'll read about policy.conf in the NSA reference.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
