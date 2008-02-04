Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14GFfGo011124
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 11:15:41 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14GFeg3016392
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 16:15:41 GMT
Message-ID: <47A736DB.4030909@redhat.com>
Date: Mon, 04 Feb 2008 11:01:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Jeremy A. Mowery" <jmowery@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, setools@tresys.com
Subject: Re: setools is still broken in rawhide.
References: <47A3F327.8000202@redhat.com> <200802041034.55986.jmowery@tresys.com>
In-Reply-To: <200802041034.55986.jmowery@tresys.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy A. Mowery wrote:
> On Friday 01 February 2008 23:35:51 Daniel J Walsh wrote:
>> This patch fixes two functions in libqpol/util.c
>>
>> is_binpol_valid should return true if the policy version is greater than
>> or equal to the policy installed in the kernel.
>>
> 
> This function is used to assert that the version of the policy matches
> the version for which we were looking. The name may be a bit misleading;
> previous versions had more complex validation logic we no longer need
> as this logic already exists in libsepol.
> 
>> search_binary_policy_file
>>
>> Should return 0 on success, meaning it found a policy.
>>
>> And return 1 if the return code is < 0;
> 
> This change would prevent tools from handling errors in policy searching 
> correctly; the difference in a negative and positive return code is
> used to distinguish the case where a default policy could not be found
> and the case where searching for the policy could not be completed.
>>
>>
>> Making these changes allows seinfo and sesearch to find policy.22 on a
>> machine running policy.21
>>
> 
> This is intentionally not done. If the system cannot load a version 22 policy,
> SETools will only search for a policy of version 21 or less.  SETools 
> intentionally does not use the policy downgrade code when loading policies;
> this would break the assertion that the policy is analyzed "as is" and not
> altered by the libraries.
> 
> 
> Jeremy A. Mowery
> Tresys Technology
> 410-290-1411 x148

So when we have a legitimate case like, we have now the user is out of
Luck.  There should be an option that says I want exact match, or the
default to search for a close enough match.  Tools are starting to use
seinfo/sesearch and we give this to users as a way to examine policy.

Why sacrifice usability for the goal of having an exact match.  My fix
might not be correct but sesearch/seinfo have got to work, in the
situation where the kernel has downgraded the policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkenNtsACgkQrlYvE4MpobMqnACfc9PBYX0rhEd3NZDsp/SrC30x
hBEAoObjwYXvk2Blmhyu1R1Jf/RlmV9m
=TWVy
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
