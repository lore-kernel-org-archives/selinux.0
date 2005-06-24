Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OG2KgA007337
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:02:20 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OG2JUD019828
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:02:19 GMT
Message-Id: <200506241602.j5OG2Gqc016513@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: Alternative user management approach
Date: Fri, 24 Jun 2005 12:02:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've been kicking around the best way to handle users in the future here at
Tresys and have an alternative suggestion.

This starts with some basic assertions:
1) Reloading the kernel policy on user change just seems . . . wrong.
2) Having the users in the kernel can be problematic for large numbers of users.
3) These problems get much worse if we are talking about large, distributed user
databases. Are sites with 10,000 users going to force a policy reload on every
machine every time a user is added? Are all 10,000 users going to be stored in
the kernel?

We have a partial solution to this already with the concept of a generic user
(user_u). Our suggestion is to expand this concept to have multiple generalized
users with rich mappings from Linux users to SELinux users. This would mean that
specific users would no longer be a part of the SELinux policy, removing the
need for libsepol changes.

This makes the SELinux user more what we are calling a 'user role'. For example,
the policy could create 3 user roles with different role authorizations (which
become 'role capabilities'):

user role		role capabilities
------------------------------------
normal		user_r
staff			staff_r sysadm_r
sysadm		sysadm_r

Normal Linux users are then mapped to user roles by username or group membership
(this should be done by libselinux and not involve the kernel). For example, if
the primary group of the user is wheel then they could be assigned to staff,
root assigned to sysadm, and everyone else to normal. This makes the addition of
a user roughly equivalent to adding roles - something done by a policy developer
that does not need to be done as part of normal system administration.

In the future, this can be greatly expanded in the reference policy with more
fine-grained role capabilities. For example:

user role		role capabilities
-----------------------------------
normal		user_r
staff			staff_r webadmin_r logadmin_r genadmin_r
secadmin		staff_r genadmin_r secadmin_r
sysadm		webadmin_r logadmin_r genadmin_r

Questions/Thoughts?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
