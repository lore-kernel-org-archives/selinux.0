Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9RJsXXZ024103
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 15:54:34 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9RJsVFh023398
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 19:54:31 GMT
Subject: Re: sysadm_r for Staff Users
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130F8@maat.darkhonor.net>
References: <A52BEA1D8EE8634B9196A136333637B130F8@maat.darkhonor.net>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1098906666.30470.298.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 27 Oct 2004 15:51:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-27 at 12:56, Alex Ackerman wrote:
> Ok, this is probably mentioned somewhere already, but I have been
> unable to have my standard user account effectively use the sysadm_r
> role.  A simple example to illustrate.  My “ackerman” account is setup
> with a default role of staff_r and a supplementary role of sysadm_r
> similar to the jadmin user example in /src/policy/users. After
> reloading the updated policy, relabeling the filesystem, and logging
> in as “ackerman”, I switch to the sysadm_r role using newrole. To test
> out my new found powers, I try to update the system via yum. (yum
> update).  I get the following error:

At present, SELinux is purely restrictive, i.e. it only denies accesses
that might otherwise be granted.  Hence, you must both be in sysadm_r
and have Linux uid 0 to perform administrative tasks.  In the pre-Fedora
(and still in other distros) SELinux, one would run newrole -r sysadm_r
and then run su to gain full administrative access, and su would not
change the SELinux user identity at all (so you would be
ackerman:sysadm_r:sysadm_t and uid 0 after doing so).  In the Fedora
SELinux, one can simply run su, since the Fedora su calls pam_selinux
and sets the SELinux security context as well as the Linux uid, so you
end up as root:sysadm_r:sysadm_t.  Note that staff_r can still serve a
purpose here; if you disable the user_canbe_sysadm tunable in the Fedora
policy, then only staff_r users will be able to use su to reach
sysadm_r; a user_r user will be unable to do so even if he knows the
root password.

While it would be possible to have SELinux authoritatively grant Linux
capabilities based on role/domain, doing so safely will require further
tightening of the policy configuration and further changes to userspace
(to not make hardcoded assumptions about uid 0).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
