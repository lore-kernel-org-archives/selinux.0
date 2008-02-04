Subject: Re: setools is still broken in rawhide.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Jeremy A. Mowery" <jmowery@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, setools@tresys.com
In-Reply-To: <200802041034.55986.jmowery@tresys.com>
References: <47A3F327.8000202@redhat.com>
	 <200802041034.55986.jmowery@tresys.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 11:00:04 -0500
Message-Id: <1202140804.3070.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 10:34 -0500, Jeremy A. Mowery wrote:
> On Friday 01 February 2008 23:35:51 Daniel J Walsh wrote:
> > This patch fixes two functions in libqpol/util.c
> > 
> > is_binpol_valid should return true if the policy version is greater than
> > or equal to the policy installed in the kernel.
> > 
> 
> This function is used to assert that the version of the policy matches
> the version for which we were looking. The name may be a bit misleading;
> previous versions had more complex validation logic we no longer need
> as this logic already exists in libsepol.
> 
> > search_binary_policy_file
> > 
> > Should return 0 on success, meaning it found a policy.
> > 
> > And return 1 if the return code is < 0;
> 
> This change would prevent tools from handling errors in policy searching 
> correctly; the difference in a negative and positive return code is
> used to distinguish the case where a default policy could not be found
> and the case where searching for the policy could not be completed.
> > 
> > 
> > 
> > Making these changes allows seinfo and sesearch to find policy.22 on a
> > machine running policy.21
> > 
> 
> This is intentionally not done. If the system cannot load a version 22 policy,
> SETools will only search for a policy of version 21 or less.  SETools 
> intentionally does not use the policy downgrade code when loading policies;
> this would break the assertion that the policy is analyzed "as is" and not
> altered by the libraries.

Doesn't that mean that users won't be able to use setools on systems
where the kernel supports an older policy version than the userland,
since libsemanage only generates the latest policy version supported by
the toolchain?  There will be no policy.21 file around to analyze.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
