Message-ID: <486B848B.4020607@manicmethod.com>
Date: Wed, 02 Jul 2008 09:37:15 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch adds permissive to semanage
References: <4869037D.5040208@redhat.com>  <48691EB3.30706@manicmethod.com>	 <1215000045.22447.252.camel@moss-spartans.epoch.ncsc.mil>	 <486B7E03.1060304@manicmethod.com> <1215004621.22447.273.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1215004621.22447.273.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-07-02 at 09:09 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Mon, 2008-06-30 at 13:58 -0400, Joshua Brindle wrote:
>>>> Daniel J Walsh wrote:
>>>>> Gives users the ability to set a domain as permissive
>>>>>
>>>>>
>>>>> semanage permissive -a http_t
>>>>>
>>>>> It created a policy module named permissive_httpd_t.pp with the
>>>>> permissive call.
>>>>>
>>>> So, a really quick glance brings up a couple issues. First you have '-n', '--noheading' which aren't documented in the man page or elsewhere. Second (and more importantly) why are you executing semodule like that? libsemanage is the library that manages modules, and also the library used by semanage for everything else. 
>>>>
>>>> I would prefer a more 'pure' approach where we keep a list of
>>>> permissive types and inject them into the kernel policy after linking
>>>> (like libsemanage does with users, ports, nodes, etc) but I understand
>>>> that adding a whole new set of databases and interfaces is both
>>>> annoying and time consuming so I'm fine with it working on modules,
>>>> I'd just like to see it using libsemanage interfaces instead of
>>>> calling semodule.
>>> Why do you see direct use of the libsemanage interfaces as preferable to
>>> invoking semodule (aside from performance, and this isn't really
>>> performance critical)?
>>>
>>> I'm unclear on the tradeoff being made there, as composing small
>>> programs together to perform more complex operation is the Unix (tm)
>>> way ;)
>>>
>>> The advantage of just invoking semodule is that semodule is already a
>>> well-tested program that performs that function well, does proper error
>>> checking and handling of the various libsemanage calls, etc.  And if we
>>> later fix a bug or introduce new functionality there, we only have to do
>>> it once vs. in multiple places.
>>>
>>> And the semanage permissive code already has to invoke a helper program
>>> to compile the policy module from source to binary, at least today, so
>>> it isn't much different to invoke semodule to install the binary module.
>>>
>>> Then there is the issue of being able to run the semodule stage of
>>> processing in a separate domain, although at present semanage and
>>> semodule operate in the same domain so it makes no difference at
>>> present.
>>>
>> Maybe its just personal preference but I see using library interfaces
>> as much more clean than invoking semodule and grepping. semanage
>> already uses the library interfaces for everything else so this would
>> be the one case where it doesn't. He already fixed it up to use the
>> interfaces so its moot at this point. 
> 
> Well, it doesn't have to be moot - we can always take the first
> implementation if we think it best.  But I'm not fundamentally opposed
> to the latter approach, just wanted to explore the rationale.  One thing
> I would note however is that I see lack of complete error return
> checking in the new code that would have been properly checked by
> semodule...
> 

I'll fix the error checking in the second patch if you are fine with it otherwise. I just think the library is there for a reason, if we didn't want client programs using it we should have just built it into the application code. Feel free to veto me here if my rationale is weak (as it likely is).

Maybe deep down inside I'm just not a unix programmer ;)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
