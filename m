Message-ID: <52371FF5.5030602@redhat.com>
Date: Mon, 16 Sep 2013 11:12:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Subject: Re: RFC policycoreutils packaging
References: <1379166860.4313.21.camel@d30> <5236F48B.7080407@tycho.nsa.gov>  <1379334768.6787.48.camel@d30> <52371696.2050509@redhat.com> <1379343250.6787.64.camel@d30>
In-Reply-To: <1379343250.6787.64.camel@d30>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2013 10:54 AM, Dominick Grift wrote:
> On Mon, 2013-09-16 at 10:32 -0400, Daniel J Walsh wrote:
>> On 09/16/2013 08:32 AM, Dominick Grift wrote:
>>> On Mon, 2013-09-16 at 08:07 -0400, Stephen Smalley wrote:
>>>> On 09/14/2013 09:54 AM, Dominick Grift wrote:
>>>>> We were discussing policycoreutils packaging and there are some
>>>>> things unclear to me:
>>>>> 
>>>>> 1. if one wants to run a monotlitic policy on a embedded system,
>>>>> then, besides fixfiles and checkpolicy, which tools from
>>>>> policycoreutils are needed?
>>>> 
>>>> If you want a truly minimalist SELinux userspace, consider our port
>>>> to Android in the SE for Android project.  Policy is built
>>>> monolithically on the build host, with only the final binary policy
>>>> installed to the device, so you don't even need libsepol or
>>>> checkpolicy on the device, and you don't need libsemanage, semodule,
>>>> or semanage at all.  We also have a minimalist port of libselinux
>>>> with glibc dependencies removed, and a port of the SELinux utilities
>>>> to the Android toolbox, although I suspect you are using busybox and
>>>> thus picking up its SELinux support instead.
>>>> 
>>>>> 1.a How are home dir contexts generated with monolithic policy (
>>>>> or should they be created manually ? ), i ask this because in
>>>>> Fedora the genhomedircon is just a script that calls semodule, but
>>>>> i think semodule does not work with monolithic policy. If true, how
>>>>> then is someone expected to generate home dir contexts?
>>>> 
>>>> Originally IIRC, genhomedircon was a python script that didn't use 
>>>> semodule or libsemanage at all.  That's how it used to work in the 
>>>> pre-modular/managed policy days.  Should be able to find it the 
>>>> selinux-historical git repo.
>>>> 
>>>> 
>>>>> 2. Does the sandbox utility only work ( or only work properly ) in
>>>>>  policy configurations that have the MCS security model enabled? If
>>>>> so should one then depend on a policy model that has MCS enabled?
>>>> 
>>>> I think it presumes that the MLS engine is enabled and thus it can
>>>> use categories.  Whether or not the configuration is MCS or MLS or
>>>> something altogether different doesn't matter so much as long as two
>>>> processes that have incomparable categories can't observe or modify
>>>> each other.
>>> 
>>> Thanks for the explanation. Just as i expected.
>>> 
>>> I am trying to give some constructive criticism, and,
>>> 
>>> Without trying to offend anyone it has been on my mind for a while that
>>> I sense a little lack of "vision" when it comes to how things evolve.
>>> 
>> Things evolve in the way that people are willing to do the work.  If
>> people are doing monolithic policy and contribute back then these things
>> could be fixed.
>> 
> 
> True but somehow this ended up in upstream policycoreutils, and it affects
> other distros.
> 
>> genhomedircon script disappeared into libsemanage/semodule many years
>> ago, but no one has complained or replaced the script within something
>> that would work on monolithic.
> 
> Agreed, this goes back a long time indeed, and just identified the issue 
> recently in my quest to optimize efficiency.
> 
> Some how this made it into upstream policycoreutils, which i guess, it 
> should have
> 
>> 
>> 
>>> I am not suggesting that i have the kind of vision needed to oversee
>>> all this.
>>> 
>>> But a lot of this stuff comes from Fedora, and fedora does not support
>>>  monolithic policy, nor does she support custom policy, or "default" 
>>> policy.
>>> 
>>> This stuff trickles down into the upstream and we end up with what i
>>> would describe as overall degradation.
>>> 
>>> I cant use my own policy in Fedora because applications have
>>> identifiers hard-coded all over the place. I can't use monolithic
>>> policy because of for example no monolithic capable genhomedircon seems
>>> to be in policycoreutils. I probably cant install a policy without the
>>> optional MCS or MLS security models without breaking for example
>>> sandbox, or who knows what else.
>>> 
>> Please open bugzilln any package that you find that hard codes content.
>> I know of sshd, libvirt-sandbox and policycoreutils-sandbox.  We should
>> break these out into context files.
> 
> The two main culprits are sshd and local_login (these are really breaking
> things) The other ones like i guess systemd, udev (not confirmed) are
> labeling objects using hard coded types. Still problematic but at least
> they aren't fatal i guess.
> 
> The problem is not just fixing this. SELinux is misunderstood. If 
> application developers hook into libselinux but they don't know how they 
> should use it then that's the fundamental issue to tackle in my view.
> 
Yes the tool writers will take the easy way out, but libselinux is not very
flexible with this either.  IE Every time a new policy enforcer like systemd
or libvirt comes along, libselinux needs to change API.  So giving us
flexibility for these tools to define context files structure rather then
constantly changing libselinux.

BTW I am not familiar with anything hard coded into systemd or udev.

>> 
>> I am open to fixing any problem that you have with Fedora running your
>> policy, of course getting patches in would always help.
> 
> My view is that awareness is probably the only sustainable fix.
> 
> But yes i have been thinking about looking into sshd /login code to try a
> fix this but there are only 24 hours in a day, and i dont think it is 
> particularly efficient for me to try and fix this with my coding skills
> 
> I think its probably more efficient for me to do what i am good at
> 
Fine, but lets add bugzillas for these, cause I agree with you here.  These
tools should be using libselinux to find context files to assign rather then
hard coding, and then having a fall back to no labels if the policy does not
define any.
>> 
>> 
>>> I really appreciate the essence of SELinux that its transparent to user
>>>  space (in essence at least), and i am a bit alarmed to see it lose the
>>>  flexibility it once had. I feel a bit helpless as well because i see
>>> some , what i consider, regression but i don't have what it takes to
>>> make it better.
>>> 
>>> I would as a distribution try to give my customers optimal flexibility,
>>>  because i want my distribution to be used for any kind of appliance
>>> without the need of major workarounds.
>>> 
>>> Sorry for the rant, but i feel better now
>>> 
>>> 
>>> 
>> Tools that rely on MCS/MLS Separation will not work well without it. 
>> libvirt/openshift/sandbox/libvirt-sandbox.  Not sure how you can fix
>> this.  I guess we could reqwrite sandbox to more easily support just type
>> separation, but I am not sure of the value.
> 
> It is not a problem that some apps rely on a optional security model, i 
> guess, as long at they check for dependencies. I mean the 
> policycoreutils-sandbox policy requires selinux-policy-targeted
> 
Not on Fedora 20?  Although we are creating a selinux-policy-sandbox which it
will require for sandbox (Not sandbox -X) so that we can not install the huge
sandbox.pp file.

> ( not sure if that is done )
> 
> As for libvirt well one can use libvirt fine without SELinux i suspect. It
> has a configuration option to use no security/selinux/or apparmour
> 
> So thats not a problem (at least i dont see any)
> 
My point being that libvirt/Dynamic labeling would not work with a non MLS/MCS
SELinux Policy.
> 
>>> 
>>> -- This message was distributed to subscribers of the selinux mailing 
>>> list. If you no longer wish to subscribe, send mail to 
>>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
>>> quotes as the message.
>>> 
>> 
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlI3H/UACgkQrlYvE4MpobMBOACgjgdQFsw75Pwk7VviMSngFtDY
BagAoI3Dv5J+GidTPgOCfs5OJfFa+2Ef
=d8NB
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
