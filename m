Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05524
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 09:41:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA11652
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 14:39:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id OAA11648 for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 14:39:06 GMT
Message-Id: <200211271448.JAA21999@moss-shockers.ncsc.mil>
Date: Wed, 27 Nov 2002 09:48:22 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: role dominance
To: guttman@mitre.org
Cc: selinux@tycho.nsa.gov, giorgio.zanin@poste.it,
        selinux-list@lists.mitre.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> role dominance seems not to be used in the current example policy.  I
> had the impression that you were planning to deprecate it or remove
> it.   Is that wrong?  

We don't use role dominance in the example policy, but the example
policy only defines a few roles and those roles are relatively orthogonal.
If people start defining more complex sets of roles, then they may wish
to define role dominance hierarchies.  For analysis purposes, you can
just expand the role dominance relation into the user-role and role-domain
relations.

The present RBAC language and logic is very simple; I would expect that
people might want to eventually expand it to directly represent more
complex relationships among roles, drawing from prior work that has
been done on RBAC models.  Our own focus has been more on the TE component.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
