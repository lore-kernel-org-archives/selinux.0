Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67KcVrT008727
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 16:38:31 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67KcTaX008578
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 20:38:30 GMT
Subject: Re: Serviceusers File Question?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Joseph M.Kusmiss" <jkusmiss@mitre.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <001401c46378$334c4bc0$33395381@MITRE.ORG>
References: <001401c46378$334c4bc0$33395381@MITRE.ORG>
Content-Type: text/plain
Message-Id: <1089228873.1774.234.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 15:34:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-07-06 at 12:42, Joseph M.Kusmiss wrote:
> I am trying to understand the serviceusers file. It seems to have the same
> syntax as the users file, i.e., a userid and its role(s). How are these
> users treated differently from the users in the users file? What would be
> required to start a daemon using a userid and role from this file (and a
> particular domain)? I can take my answer(s) offline. Thank you.

The syntax is the same; as far as the policy compiler (checkpolicy) is
concerned, they are all just user declarations.  I think that they are
in separate files so that the script that generates file contexts
entries for user home directories (genhomedircon) does not attempt to
generate such entries for any of the serviceusers.  The serviceusers
correspond to pseudo user identities that need to be known to the policy
due to their use in calls to su(1), when using pam_selinux with su. 
Note that for each such pseudo user identity, there is an entry in
serviceusers for the user-role declaration as well as a corresponding
domain under domains/program that includes a role-type declaration and
rules for the type (domain).  initrc.te includes rules for running su in
initrc_su_t.  However, it appears that certain necessary elements are
missing for this to work properly, e.g. rules allowing initrc_su_t to
transition to cyrus_t, a modification to constraints for the transition
to a non-userdomain, and an allow rule for the role transition.

Russell Coker has recently questioned whether this is the right approach
on the fedora selinux list.  Conceivably, one could introduce an option
to pam_selinux so that it would just not set the exec context at all
rather than falling back to user_u when there is no user identity in the
SELinux policy, and then use that option for /etc/pam.d/su.  That would
also require an extension to libselinux to offer a flag indicating
whether it should automatically fall back to user_u or not.  That would
allow the old behavior (before using pam_selinux with su) to be retained
for such pseudo user identities, and just perform domain transitions
without affecting user identity or role.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
