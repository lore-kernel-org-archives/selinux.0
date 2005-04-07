Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37HdLue028227
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 13:39:21 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j37HY0sH008195
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 17:34:01 GMT
Date: Thu, 7 Apr 2005 18:45:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I am attempting to add a secadm_r
Message-ID: <20050407174544.GY19784@lkcl.net>
References: <425553ED.1040703@redhat.com> <20050407164645.GX19784@lkcl.net> <1112893253.27110.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112893253.27110.62.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 07, 2005 at 01:00:53PM -0400, Stephen Smalley wrote:
> On Thu, 2005-04-07 at 17:46 +0100, Luke Kenneth Casson Leighton wrote:
> >  if someone knows of a way to have two logins, one of which requires
> >  one password to get to root-with-sysadm_r privileges, and one of which
> >  requires a DIFFERENT password to get to root-with-secadm_r privileges,
> >  and never the two shall meet, i would be DELIGHTED to hear of such a
> >  method.
> 
> What prevents you from doing what you describe via two usernames
> in /etc/passwd that both map to uid 0 but have different role
> authorizations in policy/users?
 
 prevents... nothing ... i remember something appearing to go
 wrong when i did that last - something to do with samba, it
 ended up at the username "root" even though i'd logged in as
 "root2".

 in this instance, it'd not be a problem.

 thanks for prompting me on this, stephen.


> >  i have a customer in the process of testing the system i have set up
> >  for them and i would like to be able to tell them that it is not
> >  necessary to hammer into the operator that they must not do things like
> >  disable selinux, edit the policy, i want to be able to tell them the
> >  operator CANNOT disable selinux, edit the policy - but they can still
> >  run adduser.
> 
> CANNOT is too strong for what Dan is suggesting; the operator could
> still likely ultimately gain access to secadm via subversion of anything
> on which secadm relies; the simple role separation suggested by Dan is
> mostly just to reduce likelihood of mistakes by sysadm affecting the
> policy or labeling.

 in the scenario i describe, which i mention in case dan could
 incorporate it (it may happen to be the same thing), i would like
 secadm to be able to do policy / labelling, and for sysadm to _not_
 be able to.

 if secadm could be drastically restricted to pretty much only be
 able to run policy / labelling selinux command tools - even better.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
