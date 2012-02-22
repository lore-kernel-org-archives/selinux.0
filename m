Message-ID: <4F44EEEF.8090506@redhat.com>
Date: Wed, 22 Feb 2012 08:34:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: Another change we would like to make to libselinux
References: <4F3D16EF.6080904@redhat.com> <1329857024.12501.85.camel@moss-pluto> <4F44114F.4080005@redhat.com> <4F44ED53.5040807@tresys.com>
In-Reply-To: <4F44ED53.5040807@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/22/2012 08:27 AM, Christopher J. PeBenito wrote:
> On 02/21/12 16:49, Daniel J Walsh wrote:
>> On 02/21/2012 03:43 PM, Stephen Smalley wrote:
>>> On Thu, 2012-02-16 at 09:47 -0500, Daniel J Walsh wrote:
>>>> Currently we have lots of apps trying to figure out which
>>>> policy is installed on the system,  We have a function 
>>>> selinux_binary_policy_path which returns a path like 
>>>> '/etc/selinux/targeted/policy'
>>>> 
>>>> Then these apps do stuff like:
>>>> 
>>>> VER=`cat /sys/fs/selinux/policyver` while [ -e 
>>>> '/etc/selinux/targetd/policy. + $VER' ]; do VER=$VER-1 done
>>>> 
>>>> While we have had /sys/fs/selinux/policy for a while now.
>>>> 
>>>> I wanted to add an interface to return this path, but I was 
>>>> trying to figure out a name selinux_loaded_policy_path for 
>>>> example, but as Eric pointed out to me, 
>>>> selinux_binary_policy_path is what most users would expect
>>>> to return this.  If you look at the man page it even suggest
>>>> this.
>>>> 
>>>> man selinux_binary_policy_path ...
>>>> selinux_binary_policy_path() - binary policy file loaded into
>>>> kernel
>>>> 
>>>> 
>>>> Currently the users of this function are the libselinux
>>>> package, setools and policycorutils (sepolgen-ifgen).
>>>> 
>>>> 
>>>> I am torn between adding stealing this function to return the
>>>>  /sys/fs/selinux/policy and then adding 
>>>> selinux_installed_policy_path for the original function,
>>>> then updating the effected packages.
>>>> 
>>>> The problem with this is we would have different behaviour 
>>>> between older versions of the library. The other options
>>>> would be to come up with a better name for the new function
>>>> and fix the man pages.
>>>> 
>>>> Suggestions welcomed.
>> 
>>> Most applications should not be using /sys/fs/selinux/policy,
>>> as that requires the kernel to generate the policy image from
>>> its in-core data structures and is expensive.  So you certainly
>>> should not change selinux_binary_policy_path() to return that
>>> pathname. That also would be an incompatible interface change
>>> due to the version suffix, as you note.
>> 
>>> So I think you need a new interface.
>>> selinux_kernel_policy_path() or selinux_active_policy_path() or
>>> selinux_loaded_policy_path() seem fine to me.
>> 
>> 
>> Right now we added selinux_current_policy_path and we are using
>> it as the default for seinfo, audit2allow, sepolgen-ifgen
> 
> So why is it so critical that the in-kernel policy is used for any
> of these tools?  I can see that for certain high assurance systems
> that, for example, want to measure policy integrity, would want
> this, but for 99.9% of the users, its unnecessary.  Its just extra
> overhead, when the policy is already on disk.  I think it should be
> an option to use the kernel policy interface, but not the default.
> 


Well I see for multiple reasons.

One the stupid algorithm for finding what was the currect policy to
read was spreading to multiple tools places.  (setools,
sepolgen-ifgen, load_policy, audit2why, each one doing it slightly
differently.

We had apps like setroubleshoot that are trying to analyze the policy
at the time that an AVC happened and potentially analyzing a different
policy.  (Theoretically try for audit2allow/audit2why also.)

sepolgen-ifgen was not figuring out the correct policy to analyze if
policy.27 was installed but the kernel was looking at policy.26

We had the ability to analyze the loaded policy and no one was using it.

I hate the algorithm for finding the path to the policy on disk.  And
would rather only expose it to one tool load_policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9E7u8ACgkQrlYvE4MpobMclACfesQC/naQ0z6tppObyKN8wXsl
hawAnRYEu7xbcuLjuvFZN9CERr32uPH4
=11Fr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
