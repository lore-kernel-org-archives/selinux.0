Subject: Re: Problems with policy-1.26
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Goo GGooo <googgooo@gmail.com>
Cc: selinux@tycho.nsa.gov, Thomas Bleher <bleher@informatik.uni-muenchen.de>
In-Reply-To: <ef5305790511091413m61a0dc45w23847388910ca32f@mail.gmail.com>
References: <ef5305790511060406x26fb2221mff3168b980b68f27@mail.gmail.com>
	 <1131543572.20591.464.camel@moss-spartans.epoch.ncsc.mil>
	 <ef5305790511091413m61a0dc45w23847388910ca32f@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 08:09:04 -0500
Message-Id: <1131628144.19626.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 11:13 +1300, Goo GGooo wrote:
> It's OpenSUSE 10.0 which comes only with libselinux-1.23.11 and
> noother SElinux related packages. So I downloaded the rest of them
> fromhttp://www.cip.ifi.lmu.de/~bleher/selinux/suse/ and tried to
> configureit with the policies provided on that website as well as
> withpolicy-1.26. Failing that I deinstalled all the RPMs again
> andcompiled SElinux from sources from nsa.gov. However still having
> theproblems described above.
> All I want to achieve for now is permitting everything for
> everyone(even in enforcing mode) and then harden some network-facing
> daemonslike Apache or Bind, i.e. use the targeted policy. But I can't
> evenstart playing with that as I can't load the sample policy :-(
> Any other ideas on how to continue? Using something else than
> OpenSUSE10.0 isn't unfortunately possible.

Newlines are helpful when reading emails ;)

I'd encourage you to work with Thomas Bleher to get his packages working
for you, as he has been packaging SELinux for SuSE for his own use for
some time, as well as contributing to the upstream SELinux.

That said, I don't know if he has ever created a targeted policy for
SuSE.  Note that although the Fedora targeted policy is built from the
same source tree, the build sequence for it isn't part of the upstream
policy Makefile - the targeted policy spec file applies a
targeted-specific policy patch, selectively enables and disables
particular .te files, and overwrites certain files with the contents of
the policy/targeted subdirectory (as well as applying MCS conversion now
in rawhide, but that likely isn't relevant to you).  So you would want
to look at what the spec file does (available from the public Fedora CVS
tree), or even grab a copy of the Fedora targeted policy SRPM.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
