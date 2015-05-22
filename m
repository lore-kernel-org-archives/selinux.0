MIME-Version: 1.0
In-Reply-To: <CAFPpqQHahMR9UeCOUsEH=DV1tVy2ZXSMgrOLRNcV78aNsOiXGA@mail.gmail.com>
References: <CAFPpqQHQ5n=4chF3hCbQMQfU6yZ9KgjoVyotGCg6FA1RDdtxiw@mail.gmail.com>
 <555F5762.8040601@tycho.nsa.gov> <555F5802.3090104@tycho.nsa.gov>
 <CAFPpqQHahMR9UeCOUsEH=DV1tVy2ZXSMgrOLRNcV78aNsOiXGA@mail.gmail.com>
Date: Fri, 22 May 2015 11:36:35 -0500
Message-ID: <CAFPpqQF5OC-M=Lzgx0NORX2go+cifzcsFs1JjABOotRXqmbNVg@mail.gmail.com>
Subject: Re: string_to_av_perm behavior
From: Ted Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

What version of libselinux was selinux_check_access added?

On Fri, May 22, 2015 at 11:26 AM, Ted Toth <txtoth@gmail.com> wrote:
> It would be good if the man page were updated to reflect this
> requirement. I'll take a look at selinux_check_access, thanks.
>
> Ted
>
> On Fri, May 22, 2015 at 11:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/22/2015 12:20 PM, Stephen Smalley wrote:
>>> On 05/22/2015 12:12 PM, Ted Toth wrote:
>>>> ./avperm
>>>> 1 - av_perm 0
>>>> security class: 66
>>>> class db_tuple av select
>>>> 2 - av_perm 8
>>>> 3 - av_perm 8
>>>>
>>>> why does the first call to string_to_av_perm return 0 something seem wrong here.
>>>
>>> You need to call string_to_security_class() first.
>>>
>>> The hardcoded #defines in flask.h and av_permissions.h are deprecated;
>>> you'll get compiler warnings with a recent version of libselinux when
>>> including them.
>>
>> BTW, the preferred interface for SELinux userspace permission checks
>> these days is selinux_check_access().  Then you don't ever need to deal
>> with class or permission values or directly use any of the avc interfaces.
>>
>>
