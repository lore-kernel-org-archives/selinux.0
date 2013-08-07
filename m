Message-ID: <52024071.4000206@tycho.nsa.gov>
Date: Wed, 07 Aug 2013 08:41:21 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Pou <danielp@sgi.com>
CC: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: Programmatic domain change to unprivileged role
References: <20130805190732.GT18909@localhost> <52015950.9010906@tycho.nsa.gov> <20130806203751.GA14875@localhost> <52023D7D.7040409@tycho.nsa.gov>
In-Reply-To: <52023D7D.7040409@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/07/2013 08:28 AM, Stephen Smalley wrote:
> On 08/06/2013 04:37 PM, Dan Pou wrote:
>> On Tue, Aug 06, 2013 at 04:15:12PM -0400, Stephen Smalley wrote:
>>> On 08/05/2013 03:07 PM, Dan Pou wrote:
>>>> I have an existing daemon that I am working to enable in an MLS setting,
>>>> but I am running into difficulties with calls to get a context of an
>>>> unprivileged user from the daemon context
>>>> (system_u:system_r:<name-of-service>_t:s0-s15:c0.c1023).
>>>> The deamon will run an executable with ID of an authenticated user, so I
>>>> looked at trying to replicate the method used by sshd.
>>>> When sshd calls get_default_context, there is a transition defined to go
>>>> to the user_u:user_r:user_t domain, but there is not one available from
>>>> the daemon context I have developed.
>>>> Is there a simpler example than ssh that I could look at to understand
>>>> how to specify transitions?
>>>> The daemon uses the fork+execve method, so I don't think that I need the
>>>> dyntransition method, but it is not clear to me how to specify all the
>>>> required transitions for executing any file available to an unprivileged
>>>> user.
>>>
>>> Are you looking for how to write the code to perform the context change,
>>> or how to write the policy to permit it to happen?  Or both?
>>
>> I am looking at both.
>>
>>>
>>> If your question has to do with policy, then the refpolicy list or
>>> fedora selinux list may be better resources, as it will depend on the
>>> specific policy interfaces provided by refpolicy and/or your distribution.
>> I will give those a try as well.
>>
>>>
>>> The result of get_default_context() is of course driven by the policy,
>>> so your ability to use it effectively depends on having the right policy
>>> in place first.  Your daemon's domain will presumably need several of
>>> the interfaces defined in system/userdomain.if to permit the domain
>>> transition, along with interfaces from kernel/domain.if to permit
>>> switching user and role.  Possibly something like:
>>> userdom_spec_domtrans_unpriv_users(X_t)
>>> userdom_bin_spec_domtrans_unpriv_users(X_t)
>>> userdom_entry_spec_domtrans_unpriv_users(X_t)
>>> domain_subj_id_change_exemption(X_t)
>>> domain_role_change_exemption(X_t)
>>
>> I tried a number of these, but without success.  I always get invalid
>> context when I use the get_default_context_with_level() or
>> get_ordered_context_list_with_level() functions with the fromcon set to
>> my daemon context.
>> Should these macros add the transitions? If it were a matter of denials
>> I would be OK, but my confusion arises from how to add all the necessary
>> transitions.
>> I assume I am missing something else that prevents my domain from being
>> a valid "from" context.  The service successfully runs from run_init
>> (through the _exec_ transition).
> 
> Invalid context means that the user-role, role-type, or user-level
> combination are invalid according to policy.  Maybe you are passing in a
> level that is not authorized for the user?
> 
> libselinux has some utilities (under libselinux/utils) that can be used
> to exercise the get_default_context or get_ordered_context_list
> interfaces from the command-line.  In the source, these are getconlist
> and getdefaultcon; they appear to be packaged by Fedora in
> libselinux-utils as selinuxconlist and selinuxdefcon.

Note that you can either run them under gdb to find out exactly where
the error is occurring (and on what context string) or you can run them
under strace and look for the call that is yielding EINVAL, likely when
the context gets written to /sys/fs/selinux/context to check its validity.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
