Message-ID: <559194E2.20501@tycho.nsa.gov>
Date: Mon, 29 Jun 2015 14:56:34 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Miroslav Grepl <mgrepl@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: type inheritance in CIL
References: <5590F3DE.8070202@redhat.com> <20150629075651.GA8191@x250>
 <559129C1.4010201@redhat.com>
In-Reply-To: <559129C1.4010201@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/29/2015 07:19 AM, Miroslav Grepl wrote:
> On 06/29/2015 09:56 AM, Dominick Grift wrote:
>> On Mon, Jun 29, 2015 at 09:29:34AM +0200, Miroslav Grepl wrote:
>>> Trying to make sandbox working using CIL but I see it does not
>>> support typeinherit statement.
>>
>> One of those features that really define CIL but that is currently
>> not available or fully working yet.
>>

Inheritance in CIL is handled with blocks.

The following policy:

(block b1
   (type t)
   (allow t self (CLASS (PERM)))
)

(block b2
   (blockinherit b1))

Would result in two types (b1.t and b2.t) and two rules.

See block_test.cil and name_resolution_test.cil in secilc/test/ for more 
examples. Everything should work, but, of course, it has seen less testing at 
this point.

Jim

>> My suggestion is to study the "cilpolicy" (which is really just a
>> snapshot of reference policy transformed to cil with hll i
>> believe)
>>
>> This will give you some pointers as to how to create an alternative
>> implementation that achieves a similar result.
>>
>> When you write CIL policy, there are some "bugs" to take into
>> account and to workaround.
>>
>
> Sure there are different ways how to write it. I just wanted to
> combine it with the current Fedora policy as much as possible without
> re-writing the current Fedora policy.
>
>>>
>>> -- Miroslav Grepl Senior Software Engineer, SELinux Solutions Red
>>> Hat, Inc. _______________________________________________ Selinux
>>> mailing list Selinux@tycho.nsa.gov To unsubscribe, send email to
>>> Selinux-leave@tycho.nsa.gov. To get help, send an email
>>> containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
>>
>> _______________________________________________ Selinux mailing
>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>> "help" to Selinux-request@tycho.nsa.gov.
>>
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
