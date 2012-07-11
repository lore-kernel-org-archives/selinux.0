Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6BJQO60010738
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2012 15:26:24 -0400
Message-ID: <1342034724.29461.72.camel@moss-pluto.epoch.ncsc.mil>
Subject: SE Android: 4.1/JB merged, 4.1.1 branch created
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Wed, 11 Jul 2012 15:25:24 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Android 4.1/JB was released to AOSP on Monday, and we have now merged it
into the master seandroid branch.  We have also created a
seandroid-4.1.1 branch forked from the android-4.1.1_r1 tag.  Make sure
you update your local manifest file before performing a repo sync.  AOSP
recommends creating a new client (i.e. repo init and sync in an empty
directory) for 4.1 to yield smaller clients that will sync faster.  The
usual instructions apply, as per:
http://selinuxproject.org/page/SEAndroid

Proprietary binaries are presently only available for Galaxy Nexus and
Nexus 7, although Nexus S and Xoom driver support is expected to follow
once the updates ship.  We have successfully booted 4.1.1 on the Xoom
with the older drivers but YMMV.  Nexus S does not appear to work with
the older drivers (boots but no display).

We have not yet updated the mmac branch, so it is unchanged (i.e. still
4.0.4/ICS-based).  However, you only need to use the mmac branch now if
you want to experiment with the permission revocation and/or tag
propagation mechanisms, as the install-time MAC support has been merged
to the master seandroid branch (and the seandroid-4.0.4 branch).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
