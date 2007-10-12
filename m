MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Are the reference policy abstractions the right ones?
Date: Fri, 12 Oct 2007 16:48:44 -0400
Message-ID: <C33555EC.2F049%csellers@tresys.com>
In-Reply-To: <1192218818.28398.45.camel@moss-lions.epoch.ncsc.mil>
From: "Chad Sellers" <csellers@tresys.com>
To: <jwcart2@tycho.nsa.gov>
Cc: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "SELinux" <selinux@tycho.nsa.gov>,
        "Steve Smalley" <sds@epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/12/07 3:53 PM, "James Carter" <jwcart2@tycho.nsa.gov> wrote:

> On Fri, 2007-10-12 at 12:45 -0400, Chad Sellers wrote:
>> On 10/11/07 1:00 PM, "Karl MacMillan" <kmacmillan@mentalrootkit.com> wrote:
>> 
>>> On Wed, 2007-10-10 at 16:39 -0400, Karl MacMillan wrote:
>>>> On Wed, 2007-10-10 at 12:52 -0400, James Carter wrote:
>>>>> On Wed, 2007-10-10 at 11:23 -0400, Karl MacMillan wrote:
>>>>> [...]
>>>>>> 
>>>>>> Here's a suggestion (this assumes that hierarchy stops using dot in
>>>>>> favor of explicit statements):
>>>>>> 
>>>>>> type_group daemon {
>>>>>> type process, domain;
>>>>>> type exec, exec_file;
>>>>>> type conf, file_type;
>>>>>> type log, log_file;
>>>>>> }
>>>>>> 
>>>>> 
>>>>> Why not call it type_class?
>>>> 
>>>> Or type_struct :) I don't really care . . .
>>>> 
>>>>> 
>>>>>> allow daemon.process daemon.exec : file entrypoint;
>>>>>> # etc., etc. for the exec permissions - could
>>>>>> # even have a type_transition.
>>>>>> allow daemon.process daemon.conf : file read;
>>>>>> allow daemon.process daemon.log : file { read write };
>>>>>> 
>>>>> So, process, exec, conf, and log are in scope within the type_group
>>>>> block and are referred to outside of that block by identifying the
>>>>> namespace using a ".".  Sort of like referring to functions in a python
>>>>> module.  Is that right?
>>>>> 
>>>> 
>>>> Yep.
>>>> 
>>>>>> # Apache gets all of the types defined in daemon and
>>>>>> # access to the apache versions - so apache.process
>>>>>> # can read apache.conf.
>>>>>> type_group apache, daemon {
>>>>>> type html_files, file;
>>>>>> }
>>>>>> 
>>>>>> allow apache.process apache.html_files : file read;
>>>>>> 
>>>>> 
>>>>> Would there be allow rules inside the type_group block?  I think that it
>>>>> would be needed to distinguish between rules that can be inherited or
>>>>> not.
>>>>> 
>>>>> For example,
>>>>> 
>>>>> type_group daemon {
>>>>> type process, domain;
>>>>> 
>>>>> allow process foo_t : file read;
>>>>> }
>>>>> allow daemon.process bar_t : file read;
>>>>> 
>>>>> type_group apache, daemon {
>>>>> ...
>>>>> }
>>>>> 
>>>>> apache.process would not have read access on bar_t, but it would on
>>>>> foo_t.
>>>>> 
>>>> 
>>>> That's interesting - I'm having trouble thinking of useful examples
>>>> though. And it would need to allow you to add rules "inside" outside of
>>>> the original declaration.
>>>> 
>>> 
>>> Thinking about this more - this is actually the same mistake we have
>>> already made. Our whole model is that the flexibility has to be
>>> anticipated by the policy author ahead of time. Say I create a firefox
>>> policy and later some admin wants create a different firefox policy
>>> based on that (that, say, limits connections to only the intranet, or
>>> prevents writing to the home directory, etc.). Currently the policy
>>> author must:
>>> 
>>> a) make the whole policy into a template
>>> b) factor out all of the access that the later author may want to
>>> exclude.
>>> 
>>> It is killing us. So I think we need a way to exclude rules on
>>> inheritance. For example:
>>> 
>>> type_group firefox {
>>> type process, domain;
>>> type conf, conf_file;
>>> }
>>> 
>>> # bunch of rules, including reading user home dirs and
>>> # connect / send / receive anywhere
>>> 
>>> type_group intranet_firefox {
>>> except process user_home_t : file all_file_perms;
>>> # also exclude network
>>> }
>>> 
>>> # allow limited network access
>>> 
>>> No idea about that syntax - they idea is to prevent access from being
>>> inherited. These are not deny rules - they only limit inheritance. I
>>> think this solves a lot of problems with deny rules - there is no
>>> ordering, precedence, or any related problems.
>>> 
>>> It also gives the flexibility that we have been needing. I also think we
>>> should make it easy to except lots of access (e.g., except all access on
>>> sockets or all access to a source type). This will make the exception
>>> more robust.
>>> 
>>> So - I'd like to hear from some other people. Are these ideas worth
>>> pursuing? The proposals:
>>> 
>>> 1) remove the distinction between attributes / types.
>>> 2) allow nested types / attributes.
>>> 3) type_class / type_group
>>> 4) exceptions
>>> 
>> I think these are all very nice features that could definitely come in
>> handy. But I'm not sure I see how they address our fundamental problems. I
>> agree with you guys that our fundamental problem is the leaky abstractions
>> in reference policy. I really don't see how these would solve that problem,
>> unless you're proposing that these would negate the need for any
>> abstractions. And I don't think that's what you're saying (or is it?).
>> 
> I am trying to argue that all resources are labeled with types, so it
> does no good to try and hide them.  While I don't want to see types used
> all over the policy like they were in the old example policy, a few here
> and there for inheritance or attribute purposes doesn't seem harmful.
> (Famous last words that will probably come back to haunt me.)
> 
Famous last words indeed ;-)

> I am not arguing that we dump reference policy and get rid of
> interfaces.  I do, however, think that nested types and the ability to
> inherit with exceptions would give Chris and other policy developers the
> ability to write interfaces that fit the common case instead of having
> to target the lowest common denominator.  I just don't know how much
> they would help.
> 
>> Assuming this is a separate part of the conversation geared toward solving
>> other problems (not the leaky abstraction problem), then there are some
>> pretty cool features here. type_group is essentially a language
>> implementation of reference policy templates, so I'd love to see something
>> like it. Adding exceptions overcomes one of the main problems with templates
>> currently. 
>> 
>> Chad
>> 
>>> Karl
>>> 
>>> 
>>> 
>>> 
>>> 
>>> 
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
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
