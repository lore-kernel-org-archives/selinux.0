Message-ID: <53D2B83A.3010302@quarksecurity.com>
Date: Fri, 25 Jul 2014 16:04:10 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] [PATCH] libsemanage: Skip policy module re-link when only
 setting booleans.
References: <53D28DBB.8000905@tycho.nsa.gov>
 <53D2B3ED.2070102@quarksecurity.com> <53D2B4DA.7090504@redhat.com>
 <53D2B64F.5020004@tycho.nsa.gov>
In-Reply-To: <53D2B64F.5020004@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> Effectively it would be another copy of the kernel policy file, just one
> that is generated before merging local customizations (booleans, users,
> ports, nodes, interface), so that we can take that kernel policy, read
> it into a policydb, and mutate it rather than having to re-link the
> modules to generate another one.  Would allow us to avoid module
> re-linking on all non-module semanage changes IIUC.  Could be
> compressed; just means you have to pay the cost of uncompressing it
> before using it in libsemanage.
>

On my Fedora 20 system a linked policy is 32 meg, bzip2 linked policy is 
768k.

> On 07/25/2014 03:49 PM, Daniel J Walsh wrote:
>> How large is it?  Does it matter if it is compressed?
>>
>> On 07/25/2014 03:45 PM, Joshua Brindle wrote:
>>> Stephen Smalley wrote:
>>>> Motivated by:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1098446
>>>>
>>>> I believe this is always safe for booleans because we only set their
>>>> value; we are never adding new ones via semanage, unlike for example
>>>> users, ports, nodes, and interfaces.  For the rest, I was wondering why
>>>> we don't save the linked file and just reuse it on those changes rather
>>>> than re-linking each time - that seems like it would be straightforward
>>> We originally kept the linked copy around and had intended to do what
>>> you are saying above but removed it when the minimal Red Hat guys
>>> complained about the size of it.
>>>
>>>> to do in libsemanage and make those operations significantly faster and
>>>> less memory intensive.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
>
