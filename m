Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67L1erT008969
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 17:01:41 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67L1daX009317
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 21:01:39 GMT
Subject: Re: New SE-DBUS patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: Matthew Rickard <mjricka@epoch.ncsc.mil>, dbus@freedesktop.org,
   selinux@tycho.nsa.gov
In-Reply-To: <1089230210.31994.8.camel@nexus.verbum.private>
References: <1088088202.6679.35.camel@prometheus.epoch.ncsc.mil>
	 <1088180362.12016.27.camel@localhost.localdomain>
	 <1088690606.2625.34.camel@moss-tarheels.epoch.ncsc.mil>
	 <1089230210.31994.8.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1089234054.1774.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 17:00:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-07 at 15:56, Colin Walters wrote:
> I'm testing out the Matthew's SE-DBUS stuff, and due to the new netlink
> classes, the dbus classes have to be moved later in the flask
> definitions in order to prevent conflict.  It would be a good idea I
> think to apply the flask changes now, so things don't have to be
> adjusted when more new classes are defined.

Thanks, merged.

> Also I needed the following changes to the D-BUS SELinux policy itself
> to get it to run.  Since a number of the changes I think affect any
> userspace object manager, I abstracted it out into a new attribute that
> could also be applied to e.g. SE-X.

Ok, merged.  I moved userspace_objmgr.te under domains/misc.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
