Message-ID: <47E80EBE.4090508@manicmethod.com>
Date: Mon, 24 Mar 2008 16:27:42 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Caleb Case <ccase@tresys.com>,
        jmowery@tresys.com
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
References: <47E7E7A5.6090603@manicmethod.com> <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-03-24 at 13:40 -0400, Joshua Brindle wrote:
>   
>> This implements user_transition in the toolchain. It should help on
>> distro's like Ubuntu that can't use run_init due to the user not knowing
>> the root password. It also seems like a more eloquent way to handle
>> service restarts than assigning system_r to user accounts and having the
>> daemons run as someuser:system_r:foo_t.
>>     
>
> Yes, that's something that has been wanted in Fedora for quite some
> time.
>
> The real issue with run_init isn't the re-authentication stage, as that
> can always be disabled via pam config (and was just a weak form of
> confirming user intent, not an authorization mechanism), but rather the
> difficulty in transparently interposing it into all situations where
> services get started/re-started.  Only Gentoo seemed to have a good
> story there.
>
>   
>> This has some issues in policy due to users not always being known in
>> the policy (eg., semanage users). I hope Chris or Dan will be able to
>> give some suggestions there.
>>     
>
> I'm not sure why anyone needs to add users to policy via semanage users
> given the base set of generic users and the ability to map Linux users
> to them via seusers aka semanage login.
>
>   
>> The kernel patch (forthcoming after this is accepted) so far only
>> implements the transition on process transitions. Later on I plan on
>> doing a patch to expand role_transition to object classes (this is a
>> change needed for policy rbac support to work). I suspect I'll do the
>> same for user at that time. The question here is, do we think its worth
>> it to do fine grained transitions like we did for range_trans? (I don't).
>>     
>
> Offhand, I can't see a use for per-class user transitions, if that is
> what you mean.
>
> I don't think per-class role transitions is really the fundamental
> obstacle to enabling use of roles on objects - more thought is required
> there.  What will be fun there is role/type and user/range validation,
> which presently gets to ignore everything that has object_r.
>   

Ah, another thing. While going through the policyrep implementation the 
question of object_r came up. My thought is to start adding object_r 
magic into the toolchain (adding all types, etc) and eventually purge 
object_r from the kernel. at least one magic instance of object_r will 
be removed by object role_transitions, the others are really short 
circuits in the security server that can be removed after sufficient 
support is in the toolchain. What are your thoughts on that (for future 
reference)?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
