Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9KHpIi015794
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:17:51 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9KHpEj008403
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:17:53 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Colin Walters <walters@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41B8A9BF.2080405@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <41B8A9BF.2080405@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 07:17:49 +1100
Message-Id: <1102623469.4509.91.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 14:38 -0500, Daniel J Walsh wrote:
> If we move to this plan, we would turn off the compatability between 
> user and staff.
> So only staff users could su, usermod, newrole.  The reason they are the 
> same now is because
> of the labeling problem, and the inability to easily change from a user 
> to a staff role.  Why would
> you not have access to your old files, if you switch roles.  I agree 
> this might be good in some cases
> but can't we develop a less stringent rule that does not require relabeling.

If the aim is to have two roles with the same file access but different
access to su etc then it would be better achieved by having two roles
with the same default domain.

So you could have user:staff_user_r:staff_t and user:staff_r:staff_t and
only allow staff_su_t to be in role staff_r.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
