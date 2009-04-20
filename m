Message-ID: <49EC9531.7080609@manicmethod.com>
Date: Mon, 20 Apr 2009 11:30:57 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Chad Sellers <csellers@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: access(2) vs. SELinux
References: <C60D0537.A684E%csellers@tresys.com>	 <49EC8841.7050305@manicmethod.com> <1240240273.2562.67.camel@localhost.localdomain>
In-Reply-To: <1240240273.2562.67.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Mon, 2009-04-20 at 10:35 -0400, Joshua Brindle wrote:
>> Chad Sellers wrote:
>>> On 4/16/09 2:10 PM, "Eric Paris" <eparis@redhat.com> wrote:
>>>> He's some concerns/thoughts.
>>>>
>>>> domain_t calls access(W_OK) on file_t.
>>>>
>>>> This generates a denial
>>>>
>>>> denied  { access_write } scontext=domain_t tcontext=file_t tclass=file
>>>>
>>>> Which audit2allow will gladly turn into:
>>>>
>>>> allow domain_t file_t:file { access_write }
>>>>
>>>> Load that module and then, POP the next time
>>>>
>>>> denied { write } scontext=domain_t tcontext=file_t tclass=file
>>>>
>>>> So somewhere we need some sort of synchronization.
>>>>
>>>> ---
>>>>
>>>> I suggested to Dan that audit2allow should should, given the above
>>>> access_write denial output:
>>>> allow domain_t file_t:file { write }
>>>>
>>>> and the tool chain just automatically maps all write rule to both allow
>>>> bits for BOTH write and access_write.
>>>>
>>>> ---
>>>>
>>>> We could also have the tool chain just run in both directions and leave
>>>> audit2allow alone.  Any rule with access_write would cause the tool
>>>> chain to add write and any rule with write would cause us to add
>>>> access_write.
>>>>
>>>>> From the point of view of policy analysis I think think that makes
>>>> things worse.  Now the access_write rule really means something.  That's
>>>> fine with me, but I have a feeling the people who care about policy
>>>> analysis might not like that idea.....
>>>>
>>> I think these issues point to how inelegant this solution is. Relying on the
>>> toolchain to special case this and modify all results is going to be
>>> painful. Another example of this comes up when applying analysis tools to
>>> the policy. SETools will now show rules in a binary policy that can only be
>>> traced back to the source policy if you understand how the compiler mangling
>>> works. Managed policy has allowed us to decrease the amount of policy
>>> mangling we do, and this strategy seems to be going the other direction.
>>>
>>> I'd like to put in a vote for having access call the _noaudit interface to
>>> suppress the audit record. I agree with Alexey though that it would need to
>>> have something in /selinux to toggle this on/off. Then, when debugging a
>>> policy and not getting denials, you'd throw this switch when to the point of
>>> disabling dontaudits. We could even have semodule -D toggle this as well, if
>>> we really want to bake this into the toolchain somewhere. As far as probing
>>> attacks go, systems with more stringent security requirements that want to
>>> see all possible probing attacks could turn this flag on all the time.
>>>
>>>
>> I agree with this, Eric's description of what needs to happen above makes me 
>> cringe. There is very limited utility to having 2 parallel sets of permissions 
>> that need to be synchronized by the toolchain and quite a bit of potential pain.
>>
>> One example of horrific pain would be if both the access_write and write rules 
>> were present in policy, and someone wanted to remove the write access. They do 
>> the necessary searching and find where write is granted, remove it and viola - 
>> nothing happens, write access is still granted. Very confusing, I could see even 
>> experienced policy writers getting bitten by this enough to curse the day these 
>> permissions were added.
> 
> I strongly and vehemently oppose any solution that is a blanket
> dontaudit on access calls, even if there is a flag to dontdonaudit.
> This might be fine in "secure" shops where everyone understands and is
> willing to suffer some extra SELinux pain but not here.  If SELinux gets
> in the way it better scream to high heavens for my customers.
> 
> I agree that having bi-directional synchronization is a difficult idea.
> That's why I suggested audit2allow never output access_* permissions,
> and I can make the tool chain reject any allow rules that include
> access_* permissions (even with a nice message telling you to not use
> access_* in allow rules).
> 
> But maybe people would like a more kernel centric solution?  I don't,
> because i think the userspace tool chain is the right place to do this.
> And it'll be ugly as @#$^ but I'm sure I could fine some atrocious way
> to get the kernel to check permission on "read" output denials that say
> "read" but on access() call it would check dontaudit rules for
> "access_read"     allow or auditallow rules with any of the access_*
> permissions would be meaningless.  Something tells me sds and jmorris
> are going to hate the level of encapsulation and layering violations
> this is going to take....
> 
> I pretty strongly prefer a one way synch from "read" -> "access_read"
> when going from the text to a binary policy and having the tool chain
> reject any rules with access_* set in other types of rules.  But I think
> audit2allow/why should automagically convert the other way for easy of
> use.
> 
> Doesn't make policy analysis any harder since access_* basically means
> nothing at all, solves the problem of us having to dontaudit
> hot/dangerous code paths, doesn't screw up policy writers since you
> can't have both types of permissions in the text version of policy....
> 
> Does it seem too fragile?
> 

It is an awkward abstraction and we are terrible at making leaky abstractions 
that confuse and harm. Even if audit2allow does the correct thing (transparently 
converts access_X to X) what about people writing policy manually? What about 
tools that search for permissions in refpolicy interfaces and try to map denials 
to interfaces? Is it really a good idea to push this abstraction onto everyone 
doing any kind of selinux work in userspace? We already have enough problems 
with people understanding policy, most people don't even understand the divide 
between refpolicy and the checkpolicy language.

I'm fairly unfamiliar with the audit subsystem in the kernel so this might be 
completely impossible but how hard would it be to add a field to the denial that 
specifies the original syscall used to generate a denial, that way tools can 
ignore things coming from uninteresting syscalls?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
