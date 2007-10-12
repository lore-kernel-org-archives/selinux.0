MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Are the reference policy abstractions the right ones?
Date: Fri, 12 Oct 2007 12:45:55 -0400
Message-ID: <C3351D03.2EFE6%csellers@tresys.com>
In-Reply-To: <1192134384.21812.43.camel@moss-lions.epoch.ncsc.mil>
From: "Chad Sellers" <csellers@tresys.com>
To: <jwcart2@tycho.nsa.gov>, "Frank L. Mayer" <mayerf@tresys.com>
Cc: "SELinux" <selinux@tycho.nsa.gov>, "Steve Smalley" <sds@epoch.ncsc.mil>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/11/07 4:26 PM, "James Carter" <jwcart2@tycho.nsa.gov> wrote:

> On Thu, 2007-10-11 at 03:18 -0400, Frank L. Mayer wrote:
>>> One of the goals of reference policy is to provide a more modern feel to
>>> the policy by eliminating the use of types in a global manner across the
>>> whole policy.  It does this by allowing interfaces to be defined through
>>> which permissions can be granted to the types of a module.  There seems
>>> to be several problems with this.
>>  
>> Probably the primary motivation for this and other refpol goals was to allow
>> tool manipulation of source policies and the creation of development tools
>> and higher-level/domain-specific languages. Chris can talk better about the
>> challenges with the implementation  (such as the weakness of m4 as an
>> implementation language), but perhaps our real failure is not creating better
>> higher level abstractions/languages/tools upoon the re-structured "assembly"
>> policy language.
>  
> The difficulty with trying to build a higher-level language on top of
> policy language is that, unlike a program that is being executed, there
> is no locality in the policy.  When a problem occurs while a program is
> executing, you can get a stack trace and see what functions were
> executing.  When there is a denial in policy, all you know is that that
> rule does not exist.  There is no way to say where that rule would have
> been if it had existed.  This makes it very hard to abstract away that
> lower level language.
> 
I agree that this is a problem, and it's why our abstraction is so leaky.
The question is how do we solve it. I don't think it makes sense to punt on
the goals of encapsulation and modularity that reference policy was founded
on. Those are real requirements. I know the resultant compiled policy binary
has no concept of modules, but the source definitely does. We have to
support the concept of writing a "policy module" so authors can confine
their applications. As programming and previous policy has shown, modules
without encapsulation are a complete mess.

I guess I'd rather see us complete the abstraction (probably tweaking the
abstraction significantly in the process). Perhaps adding some of the
abstractions to the language itself and storing locality information is a
good step towards this.

This may have been the direction you were already heading. If so, just
dismiss me as being slow.

Chad

>>> 1) The user is constantly presented with types.
>>  
>> Which is perhaps the problem for simplication of development/admin. All I
>> know is that it was impossible to create any type of policy source
>> tools/domain-specific languages when types were gloablly used throughout the
>> sources. Not that I have any concrete suggestions how to improve the
>> situation off hand ;)
>>  
>> Frank
>> 
>>  
>> 
>> 
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
