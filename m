MIME-Version: 1.0
In-Reply-To: <546A5C6F.6030805@redhat.com>
References: <CAOK12DaUYM-Pq5d8E0CGyLZTz_+ihOBF6hPUbp7hh20OuQEi+w@mail.gmail.com>
 <546A1634.1070900@tycho.nsa.gov> <546A5C6F.6030805@redhat.com>
Date: Mon, 17 Nov 2014 21:18:51 +0000
Message-ID: <CAOK12DarQLB3QcmRLd4xTWTDS0kBD+zAXfh_0oHK3_gYxnniiQ@mail.gmail.com>
Subject: Re: Question on unconfined_t
From: "Paddie O'Brien" <paddieobrien@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks. I was under the mistaken impression that unconfined_t got
something for free. My new understanding is that it's by convention
that policy writers give access to unconfined_t to their domains and
they do so by adding explicit rules.

Also I was missing file_type(mytype_exec_t) although I had
domain_type(mytpe_t). Is there a way to see what things like file_type
and domain_type expand to? I want to know what's going on in the
background.

On 17 November 2014 20:37, Daniel J Walsh <dwalsh@redhat.com> wrote:
>
> On 11/17/2014 10:37 AM, Stephen Smalley wrote:
>> On 11/17/2014 09:44 AM, Paddie O'Brien wrote:
>>> Hi,
>>>
>>> As a learning exercise I created a simple policy to sandbox a simple
>>> program in its own domain.
>>>
>>> I had to add rules to the policy to allow the program to be executed
>>> from unconfined_t. Is this normal? My understanding was that a process
>>> in unconfined_t was subject only to DAC so why did I have to add this
>>> rule? What does unconfined_t actually mean?
>> SELinux has no intrinsic concept of unconfined_t; unconfined_t is just a
>> type that is allowed to do most things by policy.
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
> You probably did not define the type as a file_type(mytype_t)
>
> unconfined_t is only allowed to execute file types, if you just define a
> type and put it on a file, SELinux does not know if it is a port_type or
> a process type (domain)
> So it is not allowed.
