Subject: Re: userspace object managers get confused if an update changes
 object classes and access vectors
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Lukas Vrabec <lvrabec@redhat.com>, Miroslav Grepl <mgrepl@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>, Paul Moore <paul@paul-moore.com>
References: <d7fef34c-0b38-63f3-4a37-464930a03806@gmail.com>
 <385dc3db-6bfc-9724-0a51-6fe8530bd292@tycho.nsa.gov>
 <8c37e15e-67c2-5310-6522-bca44805bced@tycho.nsa.gov>
 <3933c88d-2eaa-8fd6-3fb5-fa61bd98982b@gmail.com>
 <5f077fc6-73b7-29b7-e99d-4c68fdfcb025@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <65b0661e-3688-4317-b23c-13daad8d2143@gmail.com>
Date: Mon, 2 May 2016 16:04:14 +0200
MIME-Version: 1.0
In-Reply-To: <5f077fc6-73b7-29b7-e99d-4c68fdfcb025@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 05/02/2016 03:58 PM, Stephen Smalley wrote:
> On 05/02/2016 09:18 AM, Dominick Grift wrote:
>> On 05/02/2016 03:14 PM, Stephen Smalley wrote:
>>> On 04/29/2016 03:53 PM, Stephen Smalley wrote:
>>>> On 04/29/2016 01:04 PM, Dominick Grift wrote:
>>>>> 
>>>>> I have mentioned this before (probably a few times), and i
>>>>> am not sure if this issue is actually what i think it is
>>>>> but i will once again mention this issue i observed many
>>>>> times.
>>>>> 
>>>>> Excuse me if i am wrong here.
>>>>> 
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1331668
>>>>> 
>>>>> https://github.com/fedora-selinux/selinux-policy/commit/971e97a2b8
cb
>>
>>>>> 
cc14
>>>>> 
>>>>> 
>> 3fc82badfaaf7900b4760399
>>>>> 
>>>>> When you change (user space?) access vectors then user
>>>>> space object managers get confused and stop working. This
>>>>> is now becoming an issue since core components are object
>>>>> managers (systemd/dbus)
>>>>> 
>>>>> So basically there is no way for distributions to
>>>>> add/remove access vectors without breaking the running
>>>>> system.
>>>>> 
>>>>> The only solution is immediately switch to permissive mode
>>>>> and to reboot the system after such an update. And you
>>>>> might not even be able to cleanly shutdown due to these
>>>>> confused components
>>>> 
>>>> (cc'd redhat folks so they can provide more context on what
>>>> the actual bug/issue was, since it wasn't entirely clear to
>>>> me from the bugzilla or commit above)
>>>> 
>>>> In general, the safest approach is to only add permissions at
>>>> the end of an existing class or add new classes at the end of
>>>> the current list of classes.  That avoids perturbing the
>>>> values of any existing permission or class and thus shouldn't
>>>> cause any breakage.  It looks like the commit you referenced
>>>> was adding/removing permissions at the end of the class
>>>> though, so I'm not clear on what broke there. There is
>>>> something very odd there though - I don't understand how
>>>> Fedora policy got into a state where those permissions
>>>> weren't defined in the first place, or why they are
>>>> inconsistent in their order with upstream refpolicy.
>> 
>>> I looked a bit more closely at this bug, and it appears to me
>>> that the issue was simply that they added definitions for start
>>> and stop _without_ allowing those permissions for any confined
>>> domains that needed them.  So then SELinux correctly denied
>>> those permissions and the system stopped working.  That's
>>> operating as intended, not a bug in SELinux or anything to do
>>> with the potential race in class/permission lookup and policy
>>> reload.
>> 
>> 
>> Strange that then the solution seems to be removing the av perms
>> again instead of adding the required rules.
> 
> Yes, I actually fixed the problem locally via a local policy module
> that allowed the permissions (prior to the update that undefined
> them again). I don't know why the latter approach was taken - maybe
> they didn't understand the cause of the bug or just viewed it as
> safer to undo what led to the bug.  I also don't understand why
> these permissions became undefined in Fedora (they were originally
> defined by Fedora for systemd, so I would think they must have been
> defined at some point in the past in the Fedora policy) or the
> inconsistency between Fedora policy and current refpolicy. Current
> refpolicy has:
> 
> class system { ipc_info syslog_read syslog_mod syslog_console 
> module_request
> 
> # these are overloaded userspace # permissions from systemd halt 
> reboot status start stop enable disable reload }
> 
> Fedora has:
> 
> class system { ipc_info syslog_read syslog_mod syslog_console 
> module_request halt reboot status undefined enable disable reload 
> }
> 
> So they have an "undefined" permission for some reason where
> refpolicy has "start", and their values of "enable", "disable", and
> "reload" won't match upstream because they omit "stop". And they
> were trying to add "start" and "stop" at the end, so their values
> also won't match upstream.
> 
>> noneless, you've said it yourself (maybe not in so many words)
>> that the userspace object manager functionality is fragile in the
>> sense that object managers are not "fully safe against arbitrary
>> changes to class/permission definitions at runtime"
> 
> Sure, but that isn't relevant for the bug above. Also, with the
> selinux userspace commit I mentioned, which is included in
> libselinux 2.5 and later, while there is still a potential race 
> condition between policy reload and a permission check, that would
> only affect a permission check that is interleaved with the policy
> reload. So you might get a stray denial during the policy reload if
> it just so happens that one of these systemd permission checks is
> triggered at the same time, but you aren't going to keep getting
> denials indefinitely until systemd is restarted (which was the
> situation prior to that commit).

Thanks for the clarification, i didnt know. This sounds good enough
indeed.

> 
> Consequently, it might be safe enough to just sync the Fedora
> system class to the refpolicy one in an update, as long as you also
> make sure you are allowing those permissions where appropriate.
> Obviously testing any such update carefully would be a good idea.
> 
> The other option if you want 100% safety would be to add back
> "start" and "stop" to the end of the Fedora system class while
> simultaneously allowing them as appropriate, but then you are
> essentially forever forked from refpolicy's system class
> definition.
> 
> Meanwhile, it would be good to look at migrating systemd to using
> a class of its own and decoupling it from the kernel's system
> class.
> 
>> 
>>>> The fact that userspace code is using the system class at all
>>>> is a bug that has previously been pointed out; userspace
>>>> needs to use its own classes and not share one with the
>>>> kernel.  The kernel recently took another permission from
>>>> that class, so there is a conflict looming.
>>>> 
>>>> For userspace, selinux commit 
>>>> b408d72ca9104cb0c1bc4e154d8732cc7c0a9190 was intended to
>>>> help with these kinds of changes, but as noted in the commit 
>>>> description, there is still the potential interleaving of a 
>>>> policy reload and a call to selinux_check_access() that
>>>> could cause problems.
>>>> 
>>>> The kernel is presently the only component fully safe
>>>> against arbitrary changes to class/permission definitions at
>>>> runtime, and that is because it can atomically update its
>>>> class/permission mappings with the policy reload transaction.
>>>> I think making userspace fully safe would require introducing
>>>> a new selinuxfs interface (e.g. /sys/fs/selinux/access2) that
>>>> takes and returns class and permission strings rather than
>>>> values, so that the kernel can internally handle the mapping
>>>> and ensure it is updated atomic with policy reloads too.  And
>>>> one would then need to rework the userspace AVC and
>>>> selinux_check_access() to use that interface, and convert any
>>>> remaining userspace components that are still using something
>>>> other than selinux_check_access() for SELinux permission
>>>> checking.


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXJ15aAAoJECV0jlU3+Udp1TwL/ik01fpTZ6RyMv2Ev+GW/Ysa
8LOsJUxTIIk4oFGJHts8+hH4jvgww/gQ+x2EPQO805VvpkRraa8AXvYL1Bf7S6Xv
tu0PsQZ7rmeirWA/zwAutyY63CCk0S37ZFYPR00CClBuLlxoI0gowW1nL6O/QDBa
mTQVEXKf0UhBz6DCYKh+gMLM3+C78lorezfuicUHWu5BfSwAYV9eJXvqAWhJI3Nn
EN2CSubxgk96vSDDX/06xh3sB0K+JSGpFxpCFDKEgwzhy9ExgbSRUxv7uaJAYkvp
CXujYTw5hith+lYzI3vViBlXGlR3gW7GbqGVULBkb6Al8/K7iAxSSeV7/NMPWzsg
5Nvz2FBlIJLdYXt9fZwoKVmutFirCP1uKBEQfduhbN3qTcIJTys5YIRbf1CDEEDn
E/iiknPDjYpl3Mt/Wp/gQkpjU5DXh3mMA52EvMGAzwDBdiZPCjwjHu9OSQ0OyxWt
8c7NiKdI9ZSQR9pBc6PRNCWfdnzHRfNZdcPazophwg==
=NGvo
-----END PGP SIGNATURE-----
