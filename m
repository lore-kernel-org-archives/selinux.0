Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6CD026m024869
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2012 09:00:02 -0400
Message-ID: <1342097941.8057.18.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android: 4.1/JB merged, 4.1.1 branch created
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Thu, 12 Jul 2012 08:59:01 -0400
In-Reply-To: <1342034724.29461.72.camel@moss-pluto.epoch.ncsc.mil>
References: <1342034724.29461.72.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 15:25 -0400, Stephen Smalley wrote:
> Android 4.1/JB was released to AOSP on Monday, and we have now merged it
> into the master seandroid branch.  We have also created a
> seandroid-4.1.1 branch forked from the android-4.1.1_r1 tag.  Make sure
> you update your local manifest file before performing a repo sync.  AOSP
> recommends creating a new client (i.e. repo init and sync in an empty
> directory) for 4.1 to yield smaller clients that will sync faster.  The
> usual instructions apply, as per:
> http://selinuxproject.org/page/SEAndroid

We discovered a few problems with the seandroid-4.1.1 local manifest
file and branches that have now been corrected.  Please obtain an
updated local manifest file and re-sync if you checked out a copy of the
4.1.1 branch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
