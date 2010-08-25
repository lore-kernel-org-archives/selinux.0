Subject: Re: Enable selinux in SLES 11
From: Stephen Smalley <sds@tycho.nsa.gov>
To: imsand@puzzle.ch
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <56831.193.5.216.100.1282722811.squirrel@mail.puzzle.ch>
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
	 <4C72A7CB.1020105@gmail.com>
	 <34832.193.5.216.100.1282634053.squirrel@mail.puzzle.ch>
	 <4C73C991.8020100@gmail.com>
	 <18511.193.5.216.100.1282658950.squirrel@mail.puzzle.ch>
	 <4C73DAB1.7080501@gmail.com>
	 <56831.193.5.216.100.1282722811.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Aug 2010 15:03:55 -0400
Message-ID: <1282763035.15348.12.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-08-25 at 09:53 +0200, imsand@puzzle.ch wrote:
> Thank you for your answer.
> Now I'm one step further :)
> SELinux will now be loaded during startup. YEAH!!!
> But now it has a problem with the installed policy. I get this error:
> -----
> SELinux: Could not open policy file <=
> /etc/selinux/refpolicy-standard/policy/policy.23: No such file or
> directory
> Unable to load SELinux Policy. Machine is in enforcing mode. halting now.
> -----
> 
> It is looking for a version 23 policy. but the installed one is
> /etc/selinux/refpolicy-standard/policy/policy.24.
> 
> Simply renaming policy.24 to policy.23 doesn't work.
> ----
> SELinux: policydb version 24 does not match my version range 15-23
> SELinux: Could not load policy file
> /etc/selinux/refpolicy-standard/policy/policy.23: Invalid argument.

This means that the kernel and the libsepol in SLES 11 only supports up
to policy.23, so you need to build a policy with that version or older.

> ----
> 
> Based on this error I have some questions:
> 1) It seems that SELinux is looking for a binary policy. Are there only
> monolithic policies allowed? Or how can I use the newer modular policies?

Either one.  But regardless, in the end, even modular policies are
linked together into a single binary kernel policy for loading into the
kernel.  Policy modules are just a userspace construct.

> 2) Is there a possibility to converting version 24 policies to version 23?
> Or do I have to search a version 23 policy for sles 11?

You can:
a) rebuild the policy package from source on SLES 11.  This should yield
a policy.23 if that is what SLES 11 supports.  -or-
b) install a newer libsepol and checkpolicy that support policy.24.
Then the newer libsepol should allow you to load it (by automatically
converting it to policy.23 at load time).

> 3) How can I upgrade sles 11 so that is accepts version 24 policies? Which
> parts or library are responsible for the version-check?

You would need to upgrade libsepol and checkpolicy.

> 4) The policies from tresys seems to have an other format than the one
> from
> http://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory
> that I've installed. (It is not simply a binary file?!?)

Not sure what you mean.  Tresys distributes a tar file containing the
policy sources that you can build to generate a binary policy file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
