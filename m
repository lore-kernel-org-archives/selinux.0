Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0QHPpsj012838
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2005 12:25:51 -0500 (EST)
Subject: Re: users with weird names
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: steven harp <steven.harp@adventiumlabs.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200501252153.55866.steven.harp@adventiumlabs.org>
References: <200501252153.55866.steven.harp@adventiumlabs.org>
Content-Type: text/plain
Message-Id: <1106759967.23386.284.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Jan 2005 12:19:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 22:53, steven harp wrote:
> Failed to find this in the archives, but somebody must have
> tripped across the problem of linux users with names that
> are policy compiler keywords, e.g. Mr allow cannot be handled
> by:
> 
>   user allow roles { staff_r };
> 
> rbac:108:ERROR 'syntax error' at token 'allow' on line 56248:
> 
> Same for Mr source and Ms. target, etc., all "ok" identifiers.
> I am not trying to be perverse--somebody else picked several
> names that will not parse.
> 
> And the correct way to quote them is.... ?

There is no way to "quote" them.  You'd have to patch
checkpolicy/policy_parse.y to accept such tokens in the username field. 
A more general solution (and one needed for other purposes as well)
would be to change libselinux to support a mapping from Linux user
properties (username, group membership, etc) to SELinux usernames, which
has been discussed previously on the list but no one has done it yet. 
This would also require adjusting any programs like newrole that rely on
the SELinux username, possibly having them using the audit loginuid
instead once it is exported to userspace.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
