Message-ID: <44591D4A.10005@gentoo.org>
Date: Wed, 03 May 2006 17:14:50 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: Jeremy Katz <katzj@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
Subject: Re: We are attempting once again to split policy	out	into	individual
 RPMS.
References: <44576B91.8060607@redhat.com>  <44577454.5040204@gentoo.org>	 <1146583000.32102.8.camel@orodruin.boston.redhat.com>	 <44577BC5.3050009@gentoo.org>	 <1146584925.32102.36.camel@orodruin.boston.redhat.com>	 <1146669307.6723.20.camel@localhost.localdomain>	 <4458FE33.80908@gentoo.org> <1146683243.2766.42.camel@localhost.localdomain>
In-Reply-To: <1146683243.2766.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Wed, 2006-05-03 at 15:02 -0400, Joshua Brindle wrote:
>   
>> Karl MacMillan wrote:
>>     
>>>>> The comparison to uid/gid is bogus, uid/gid are unambiguous, file 
>>>>> contexts are ordered by specificity because multiple regexes can match 
>>>>> any given filename. The file_contexts *must* be combined and ordered 
>>>>> prior to labeling, and if multiple policy packages are being installed 
>>>>> within a set those must all be included as well. matchpathcon does not 
>>>>> currently have the sorting mechanism that libsemanage does to properly 
>>>>> combine policy package file contexts.
>>>>>       
>>>>>           
>>>> By moving the policy to being maintained by the package maintainer, it's
>>>> moving towards having the file context be unambiguous as well.
>>>> Otherwise, the packager really has no control.
>>>>
>>>>     
>>>>         
>>> Both of these seem like positive changes, particularly having the
>>> package maintainers take responsibility for the SELinux policy
>>> associated with their package.
>>>
>>> Also, how ambiguous are the application file contexts now anyway? Josh,
>>> you are claiming that the labeling requires all of the file contexts to
>>> be combined, but for most applications that come with policy the file
>>> contexts are already a) specific and b) cover the majority of the files
>>> provided by that application. The more general file contexts are most
>>> useful for applications without policy.
>>>   
>>>       
>> Having unambiguous contexts for every package would not be scalable. 
>> Most apps have some sort of fallback now (eg., mysql installs libraries 
>> but doesn't label them, and shouldn't, the base library labeling should 
>> take care of them). I imagine there are very few packages that have 
>> entirely self contained file contexts files. Anything that installs 
>> libraries, man pages, info pages, binaries without unique labels 
>> (mysqladmin doesn't need its own label, only the daemon binary), etc.
>>
>> Not only does adding specific entries for every file in every package 
>> not scale but it breaks encapsulation (why should a policy need to know 
>> that /bin is bin_t, we intentionally abstracted that away in policy, why 
>> regress in file contexts).
>>
>>     
>
> Sure, but the common case is that the application specific file contexts
> can be combined with only the base policy file contexts to create the
> full labeling policy for that application.
>   
This doesn't work every time though. For example, if you are installing 
sendmail and thus installing the mta and sendmail policies the sendmail 
binary _will not_ get labeled correctly just by looking at the sendmail 
policy and the base policy. The sendmail binary is labeled via mta.fc. I 
expect mutually dependent modules like this to increase over time, not 
go away.

I still haven't heard why it is a problem to explicitly combine policy 
packages within the same rpm transaction (since you are trying to 
minimize transaction size) and do a rebuild/commit after that (and 
before installing the apps). This seems pretty clear to me to be the 
best solution but noone seems to be considering it at all.

And noone has addressed the fact that libselinux does not sort the 
file_contexts the same way that libsemanage does when it writes it. This 
leads to matchpathcon(foo.pp) producing different results than would be 
produced if foo.pp were installed and matchpathcon() run.

I am baffled why the advocates of this believe making kernel tolerant of 
inconsistent filesystem labels and allowing strange policy interactions 
for the sake of bandaiding an inadequacy in RPM is better.. .*shrug*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
