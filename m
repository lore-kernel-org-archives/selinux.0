Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37HBXue027813
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 13:11:33 -0400 (EDT)
Subject: Re: I am attempting to add a secadm_r
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050407164645.GX19784@lkcl.net>
References: <425553ED.1040703@redhat.com>  <20050407164645.GX19784@lkcl.net>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 13:00:53 -0400
Message-Id: <1112893253.27110.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-07 at 17:46 +0100, Luke Kenneth Casson Leighton wrote:
>  if someone knows of a way to have two logins, one of which requires
>  one password to get to root-with-sysadm_r privileges, and one of which
>  requires a DIFFERENT password to get to root-with-secadm_r privileges,
>  and never the two shall meet, i would be DELIGHTED to hear of such a
>  method.

What prevents you from doing what you describe via two usernames
in /etc/passwd that both map to uid 0 but have different role
authorizations in policy/users?

>  i have a customer in the process of testing the system i have set up
>  for them and i would like to be able to tell them that it is not
>  necessary to hammer into the operator that they must not do things like
>  disable selinux, edit the policy, i want to be able to tell them the
>  operator CANNOT disable selinux, edit the policy - but they can still
>  run adduser.

CANNOT is too strong for what Dan is suggesting; the operator could
still likely ultimately gain access to secadm via subversion of anything
on which secadm relies; the simple role separation suggested by Dan is
mostly just to reduce likelihood of mistakes by sysadm affecting the
policy or labeling.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
