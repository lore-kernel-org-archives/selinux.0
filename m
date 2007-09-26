Message-ID: <46FA8C30.2020303@manicmethod.com>
Date: Wed, 26 Sep 2007 12:43:28 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH 0/2] Series short description
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <200709252312.46945.paul.moore@hp.com> <1190813392.15779.58.camel@moss-spartans.epoch.ncsc.mil> <200709261200.09547.paul.moore@hp.com>
In-Reply-To: <200709261200.09547.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Wednesday 26 September 2007 9:29:52 am Stephen Smalley wrote:
>   
>> On Tue, 2007-09-25 at 23:12 -0400, Paul Moore wrote:
>>     
>>> On Tuesday 25 September 2007 10:19:50 pm Joshua Brindle wrote:
>>>       
>>>> A while back someone (I can't remember if it was me or not) suggested a
>>>> bitmap of policy capabilities that would be determined at compile time
>>>> (eg., does this policy have conditional expressions? turn that bit on.
>>>> Does this policy use class foo? turn that bit on, etc). Why is your
>>>> version scheme better than something like that?
>>>>         
>>> Well, like I said earlier, forget the versioning scheme I proposed. 
>>> However, for the sake or argument one advantage that I can see to a
>>> version number or a capability bitmap (it would most likely need to be an
>>> ebitmap to allow for future growth) is that it is much easier/quicker to
>>> check in the security server.  Comparing two integers is much faster then
>>> checking for a single bit in an ebitmap.
>>>
>>> That said, I agree that your idea of a policy capability bitmap is
>>> interesting and would allow a lot of flexibility.  I'm just not sure the
>>> implementation would be practical, but then again, you have much more
>>> experience in the policy compiler/toolchain than I do.
>>>       
>> I think we'd need a separate content/feature version or bitmap from the
>> format version.
>>
>> The bitmap seems better if we want to support independent selection of
>> subsets.  The version seems better if we want to incrementally build
>> upon each new feature and always require the prior ones to exist or to
>> be obsoleted by the new one.
>>     
>
> Okay, it looks like its probably at least worth investigating the bitmap 
> concept with some RFC patches.
>
> Josh, since you brought up the idea and you have a better grasp of the 
> toolchain, can I talk/bribe/make-you-an-offer-you-can't-refuse into working 
> up some patches for the toolchain if I come up with the matching kernel 
> piece?
>   

I knew I should have kept my mouth shut :)

I'll try to get around to the toolchain patches this week. Some things 
need to be settled, this will require a policy version bump to 22, and 
we can either ignore all the capabilities we have now and start with 
secid reconciliation or actually factor in all the capabilities we have 
now into it. It will be easier short term to do the former, but possibly 
better in the long term to do the latter.

The latter might have some crappy code in it, for example, in the reader 
when reading the binary there would be something like:

if ((policyvers > POLICYDB_VERSION_BOOLS && policyvers < 
POLICYDB_VERSION_CAPS) || (policyvers > POLICYDB_VERSION_CAPS && 
ebitmap_get_bit(cap_bitmap, BOOL_CAP_BIT))

it gets ugly, if we just ignore what we have now it would look alot 
nicer, though I still like the idea of being able to turn off 
unnecessary checks when conditionals aren't used at all.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
