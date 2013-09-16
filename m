Message-ID: <52371696.2050509@redhat.com>
Date: Mon, 16 Sep 2013 10:32:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Subject: Re: RFC policycoreutils packaging
References: <1379166860.4313.21.camel@d30> <5236F48B.7080407@tycho.nsa.gov> <1379334768.6787.48.camel@d30>
In-Reply-To: <1379334768.6787.48.camel@d30>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2013 08:32 AM, Dominick Grift wrote:
> On Mon, 2013-09-16 at 08:07 -0400, Stephen Smalley wrote:
>> On 09/14/2013 09:54 AM, Dominick Grift wrote:
>>> We were discussing policycoreutils packaging and there are some things 
>>> unclear to me:
>>> 
>>> 1. if one wants to run a monotlitic policy on a embedded system, then, 
>>> besides fixfiles and checkpolicy, which tools from policycoreutils are 
>>> needed?
>> 
>> If you want a truly minimalist SELinux userspace, consider our port to 
>> Android in the SE for Android project.  Policy is built monolithically on
>> the build host, with only the final binary policy installed to the 
>> device, so you don't even need libsepol or checkpolicy on the device, and
>> you don't need libsemanage, semodule, or semanage at all.  We also have a
>> minimalist port of libselinux with glibc dependencies removed, and a port
>> of the SELinux utilities to the Android toolbox, although I suspect you
>> are using busybox and thus picking up its SELinux support instead.
>> 
>>> 1.a How are home dir contexts generated with monolithic policy (  or 
>>> should they be created manually ? ), i ask this because in Fedora the 
>>> genhomedircon is just a script that calls semodule, but i think
>>> semodule does not work with monolithic policy. If true, how then is
>>> someone expected to generate home dir contexts?
>> 
>> Originally IIRC, genhomedircon was a python script that didn't use 
>> semodule or libsemanage at all.  That's how it used to work in the 
>> pre-modular/managed policy days.  Should be able to find it the 
>> selinux-historical git repo.
>> 
>> 
>>> 2. Does the sandbox utility only work ( or only work properly ) in 
>>> policy configurations that have the MCS security model enabled? If so 
>>> should one then depend on a policy model that has MCS enabled?
>> 
>> I think it presumes that the MLS engine is enabled and thus it can use 
>> categories.  Whether or not the configuration is MCS or MLS or something 
>> altogether different doesn't matter so much as long as two processes that
>> have incomparable categories can't observe or modify each other.
> 
> Thanks for the explanation. Just as i expected.
> 
> I am trying to give some constructive criticism, and,
> 
> Without trying to offend anyone it has been on my mind for a while that I
> sense a little lack of "vision" when it comes to how things evolve.
> 
Things evolve in the way that people are willing to do the work.  If people
are doing monolithic policy and contribute back then these things could be fixed.

genhomedircon script disappeared into libsemanage/semodule many years ago, but
no one has complained or replaced the script within something that would work
on monolithic.


> I am not suggesting that i have the kind of vision needed to oversee all 
> this.
> 
> But a lot of this stuff comes from Fedora, and fedora does not support 
> monolithic policy, nor does she support custom policy, or "default" 
> policy.
> 
> This stuff trickles down into the upstream and we end up with what i would
> describe as overall degradation.
> 
> I cant use my own policy in Fedora because applications have identifiers 
> hard-coded all over the place. I can't use monolithic policy because of for
> example no monolithic capable genhomedircon seems to be in policycoreutils.
> I probably cant install a policy without the optional MCS or MLS security
> models without breaking for example sandbox, or who knows what else.
> 
Please open bugzillas on any package that you find that hard codes content.  I
know of sshd, libvirt-sandbox and policycoreutils-sandbox.  We should break
these out into context files.

I am open to fixing any problem that you have with Fedora running your policy,
of course getting patches in would always help.


> I really appreciate the essence of SELinux that its transparent to user 
> space (in essence at least), and i am a bit alarmed to see it lose the 
> flexibility it once had. I feel a bit helpless as well because i see some ,
> what i consider, regression but i don't have what it takes to make it
> better.
> 
> I would as a distribution try to give my customers optimal flexibility, 
> because i want my distribution to be used for any kind of appliance without
> the need of major workarounds.
> 
> Sorry for the rant, but i feel better now
> 
> 
> 
Tools that rely on MCS/MLS Separation will not work well without it.
libvirt/openshift/sandbox/libvirt-sandbox.  Not sure how you can fix this.  I
guess we could reqwrite sandbox to more easily support just type separation,
but I am not sure of the value.
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlI3FpYACgkQrlYvE4MpobPFlgCgtjY17VaxXeH+EGuEeV1+6Dy5
JcsAnjg2H24yxtvhMcBXGLiOcOO9jwu9
=/1Ss
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
