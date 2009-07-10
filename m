Message-ID: <4A575664.4040805@manicmethod.com>
Date: Fri, 10 Jul 2009 10:55:32 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Paul Howarth <paul@city-fan.org>,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [RFC] Install SELinux policies from rpm package header
References: <C67BD5B0.A89C1%csellers@tresys.com>
In-Reply-To: <C67BD5B0.A89C1%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On 7/9/09 4:48 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
> <snip>
>> A couple of other problems with including policy with each rpm.  How do you
>> handle different packaging.  MLS, Targeted, minimal.
>>
> That is a problem we'll have to solve, but I don't think it will be too
> difficult. We could easily provide an option to the %policy directive that
> could direct rpm to use a particular policy store.
>
>> If every package includes policy then we need to rely on the package
>> maintainer to write good secure policy.  You have to realize that the goal of
>> a package maintainer is to make the tool run, not necessarily to make sure it
>> is secure or that other componants of the OS integrate well.
>>
>> ftp sometimes need to read any file on the OS, so I will add
>> files_read_all(ftp_t)
>>
>> Now getting the few packages that ship their own policy to work better and the
>> selinux-policy package to work better would be great.
>>
> That's our initial goal. We want better infrastructure for the packages that
> exist today. Policy can transition into other application packages if and
> when it makes sense. If a package maintainer has no business touching
> policy, then they will not be forced to do so.
>
>> How about fixing things like semanage command
>>
>> semanage fcontext ....
>> semanage ports ....
>> restorecon ...
>>
>>
>> Removal of policy packages is a huge problem in that once a type is removed
>> you end up with mislabeled files that can not be indentified.
>>
> Agreed, and we've talked about some potential solutions to this problem that
> do not involve automatic relabeling. This is a likely next step for this
> work after the initial RPM integration.
>

The more I think about this the less I like the idea of uninstalling policy. 
Even if we retain the labels (eg., save the namespace, ditch the rules) the 
files are inaccessible. Leaving the policy ensures that admins/backup 
apps/whatever can do whatever they could do before with the files, even if the 
associated app is gone.

>> You do not know where these files are and you need to relabel the entire
>> machine to make sure there are no longer any mislabeled files around.
>>
>> When you update policy you need to run a diff between the old file context and
>> the new and run a recusive restorecon on the diff.  fixfiles -C
>> PREVIOUS_FILECONTEXT relabel does this for you, but every rpm transaction that
>> does a policy modules update needs to run this at the completion of the
>> transaction.  As well as squirrel away the previous file context before the
>> transaction.
>
> Running fixfiles -C after any rpm transaction that modifies policy seems
> reasonable (as long as there's an option to disable this behavior for those
> that don't like automatic relabeling).
>

Its alot worse than that. What about files on backup drives? Offline drives? 
transient files that will get relabeled to something inappropriate? I'm not 
confortable relabeling databases with potentially sensitive data to var_lib_t 
because mysql was uninstalled.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
