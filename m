Message-ID: <47A75FBC.8000102@redhat.com>
Date: Mon, 04 Feb 2008 13:55:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Jeremy A. Mowery" <jmowery@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, setools@tresys.com
Subject: Re: setools is still broken in rawhide.
References: <47A3F327.8000202@redhat.com> <200802041034.55986.jmowery@tresys.com> <1202140804.3070.87.camel@moss-spartans.epoch.ncsc.mil> <200802041319.16285.jmowery@tresys.com>
In-Reply-To: <200802041319.16285.jmowery@tresys.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy A. Mowery wrote:
> On Monday 04 February 2008 11:00:04 Stephen Smalley wrote:
>> On Mon, 2008-02-04 at 10:34 -0500, Jeremy A. Mowery wrote:
>>> On Friday 01 February 2008 23:35:51 Daniel J Walsh wrote:
>>>> This patch fixes two functions in libqpol/util.c
>>>>
>>>> is_binpol_valid should return true if the policy version is greater than
>>>> or equal to the policy installed in the kernel.
>>>>
>>> This function is used to assert that the version of the policy matches
>>> the version for which we were looking. The name may be a bit misleading;
>>> previous versions had more complex validation logic we no longer need
>>> as this logic already exists in libsepol.
>>>
>>>> search_binary_policy_file
>>>>
>>>> Should return 0 on success, meaning it found a policy.
>>>>
>>>> And return 1 if the return code is < 0;
>>> This change would prevent tools from handling errors in policy searching 
>>> correctly; the difference in a negative and positive return code is
>>> used to distinguish the case where a default policy could not be found
>>> and the case where searching for the policy could not be completed.
>>>>
>>>>
>>>> Making these changes allows seinfo and sesearch to find policy.22 on a
>>>> machine running policy.21
>>>>
>>> This is intentionally not done. If the system cannot load a version 22 policy,
>>> SETools will only search for a policy of version 21 or less.  SETools 
>>> intentionally does not use the policy downgrade code when loading policies;
>>> this would break the assertion that the policy is analyzed "as is" and not
>>> altered by the libraries.
>> Doesn't that mean that users won't be able to use setools on systems
>> where the kernel supports an older policy version than the userland,
>> since libsemanage only generates the latest policy version supported by
>> the toolchain?  There will be no policy.21 file around to analyze.
>>
> 
> This means the user will have to specify the policy to load rather than
> rely on the auto-detect feature in this case. If libsepol can load the policy,
> the tools can read it; the tools will not, however, downgrade it.
> 
> Jeremy A. Mowery
> Tresys Technology
> 410-290-1411 x148
Then this is unacceptable from a usability point of view.  If you expect
your tools to be used then you can not rely on the user having to figure
out why they are broken.  And they are broken.  seinfo and sesearch are
tools used to analyze the "default policy"

man seinfo
...

       If no policy file is  provided,  seinfo  will  search  for  the
system
       default  policy:  checking first for a source policy, next for a
binary
       policy matching the running kernel’s preferred version, and
finally for
       the  highest  version  that  can  be found.  If no policy can be
found,
       seinfo will print an error message and exit.

So the tool better find the same policy that the kernel/init found.  If
you force me to carry a patch, we will, but I think this is
unreasonable.  These tools are being used by people who barely
understand SELinux and forcing them to search for a path like
/etc/selinux/targeted/policy/policy.22 is wrong.  Also you will force
other tools like system-config-selinux to build in the smarts to figure
out what policy is used.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkenX7wACgkQrlYvE4MpobMQfgCeLTKjoYlODW36rbptSxDkNjYQ
4hIAoJq+6rt3NBRif9WfAZSH9uUTPduK
=hHJj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
