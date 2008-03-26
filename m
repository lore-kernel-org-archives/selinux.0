Message-ID: <47EA0D4F.4040102@redhat.com>
Date: Wed, 26 Mar 2008 09:46:07 +0100
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Caleb Case <ccase@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
References: <47E7E7A5.6090603@manicmethod.com>	 <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>	 <47E80EBE.4090508@manicmethod.com>	 <1206390986.3302.113.camel@moss-spartans.epoch.ncsc.mil>	 <47E8DC2B.6010205@manicmethod.com> <1206446939.3302.139.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206446939.3302.139.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2008-03-25 at 07:04 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Mon, 2008-03-24 at 16:27 -0400, Joshua Brindle wrote:
>>>   
>>>> Stephen Smalley wrote:
>>>>     
>>>>> On Mon, 2008-03-24 at 13:40 -0400, Joshua Brindle wrote:
>>>>>   
>>>>>       
>>>>>> This implements user_transition in the toolchain. It should help on
>>>>>> distro's like Ubuntu that can't use run_init due to the user not knowing
>>>>>> the root password. It also seems like a more eloquent way to handle
>>>>>> service restarts than assigning system_r to user accounts and having the
>>>>>> daemons run as someuser:system_r:foo_t.
>>>>>>     
>>>>>>         
>>>>> Yes, that's something that has been wanted in Fedora for quite some
>>>>> time.
>>>>>
>>>>> The real issue with run_init isn't the re-authentication stage, as that
>>>>> can always be disabled via pam config (and was just a weak form of
>>>>> confirming user intent, not an authorization mechanism), but rather the
>>>>> difficulty in transparently interposing it into all situations where
>>>>> services get started/re-started.  Only Gentoo seemed to have a good
>>>>> story there.
>>>>>
>>>>>   
>>>>>       
>>>>>> This has some issues in policy due to users not always being known in
>>>>>> the policy (eg., semanage users). I hope Chris or Dan will be able to
>>>>>> give some suggestions there.
>>>>>>     
>>>>>>         
>>>>> I'm not sure why anyone needs to add users to policy via semanage users
>>>>> given the base set of generic users and the ability to map Linux users
>>>>> to them via seusers aka semanage login.
>>>>>
>>>>>   
>>>>>       
>>>>>> The kernel patch (forthcoming after this is accepted) so far only
>>>>>> implements the transition on process transitions. Later on I plan on
>>>>>> doing a patch to expand role_transition to object classes (this is a
>>>>>> change needed for policy rbac support to work). I suspect I'll do the
>>>>>> same for user at that time. The question here is, do we think its worth
>>>>>> it to do fine grained transitions like we did for range_trans? (I don't).
>>>>>>     
>>>>>>         
>>>>> Offhand, I can't see a use for per-class user transitions, if that is
>>>>> what you mean.
>>>>>
>>>>> I don't think per-class role transitions is really the fundamental
>>>>> obstacle to enabling use of roles on objects - more thought is required
>>>>> there.  What will be fun there is role/type and user/range validation,
>>>>> which presently gets to ignore everything that has object_r.
>>>>>   
>>>>>       
>>>> Ah, another thing. While going through the policyrep implementation the 
>>>> question of object_r came up. My thought is to start adding object_r 
>>>> magic into the toolchain (adding all types, etc) and eventually purge 
>>>> object_r from the kernel. at least one magic instance of object_r will 
>>>> be removed by object role_transitions, the others are really short 
>>>> circuits in the security server that can be removed after sufficient 
>>>> support is in the toolchain. What are your thoughts on that (for future 
>>>> reference)?
>>>>     
>>> Well, the interesting question is what should the default role be in the
>>> new context in security_compute_sid, if not object_r.  Even aside from
>>> the support for per-class role transitions.  User defaults to the source
>>> context, type defaults to the related object context, and MLS range
>>> defaults to the low level of the source context.  Role could be the
>>> subject's role or the related object's role.
>>>
>>>   
>> Good question. My original assumption was that we'd use the related 
>> object role. That would require that home directories be correctly 
>> labeled with the role of the user. If we start using the source role 
>> then things will quickly change from object_r to system_r, so maybe the 
>> policy should do that anyway. Chris, any opinions on this?
> 
> Yes, related object role would likely cause the least breakage.  It
> would preserve the existing default for existing filesystems (as they
> already have object_r in the directory contexts), while allowing us to
> switch over to the user's role for home directories upon a relabel or
> new filesystem.  Source role might create more conflicts, as we enforce
> the role/type relationship for contexts and there might be a mismatch
> between the creating process role and the parent directory type.
> 
I am not sure where this is going, but I believe that separation based
on role in the home directory is a mistake.  It assumes that the home
directory will always be used by the same user with the same role.   And
will not work when you have a network file system that supports labels.

In Red Hat I can login to people.redhat.com people.fedoraproject.com
which I should use the guest_r.  While logging into my laptop I would be
unconfined_t and on test machines I might get staff_r or user_r.  All of
them would use the same homedirectory.  So how would this work in this
environment?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfqDU8ACgkQrlYvE4MpobPK2QCZARp10Z4BcqTHKGywNPo49F06
uJoAoLMYX3lHtyZkzDpS+BquTBFT4uoZ
=/URn
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
