Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14FYu2L006236
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 10:34:56 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m14FYuh9025604
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 15:34:56 GMT
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setools is still broken in rawhide.
References: <47A3F327.8000202@redhat.com>
In-Reply-To: <47A3F327.8000202@redhat.com>
MIME-Version: 1.0
Date: Mon, 4 Feb 2008 10:34:55 -0500
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, setools@tresys.com
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802041034.55986.jmowery@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 01 February 2008 23:35:51 Daniel J Walsh wrote:
> This patch fixes two functions in libqpol/util.c
> 
> is_binpol_valid should return true if the policy version is greater than
> or equal to the policy installed in the kernel.
> 

This function is used to assert that the version of the policy matches
the version for which we were looking. The name may be a bit misleading;
previous versions had more complex validation logic we no longer need
as this logic already exists in libsepol.

> search_binary_policy_file
> 
> Should return 0 on success, meaning it found a policy.
> 
> And return 1 if the return code is < 0;

This change would prevent tools from handling errors in policy searching 
correctly; the difference in a negative and positive return code is
used to distinguish the case where a default policy could not be found
and the case where searching for the policy could not be completed.
> 
> 
> 
> Making these changes allows seinfo and sesearch to find policy.22 on a
> machine running policy.21
> 

This is intentionally not done. If the system cannot load a version 22 policy,
SETools will only search for a policy of version 21 or less.  SETools 
intentionally does not use the policy downgrade code when loading policies;
this would break the assertion that the policy is analyzed "as is" and not
altered by the libraries.


Jeremy A. Mowery
Tresys Technology
410-290-1411 x148

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
