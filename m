Subject: Re: Stability of libsepol and libsemanage?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20051109134021.GA27310@europium.cip.ifi.lmu.de>
References: <20051109134021.GA27310@europium.cip.ifi.lmu.de>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 08:52:07 -0500
Message-Id: <1131544327.20591.474.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 14:40 +0100, Thomas Bleher wrote:
> I'm currently filing wishlist bugs in the SUSE bugzilla against various
> packages regarding SELinux support. SUSE is currently missing libsepol
> and libsemanage, so I wondered if it is safe to add the development
> versions now, considering the many patches that are applied now.
> Are the libraries as they are now safe to be used in a release or will
> there be incompatible changes so it would be better to wait for a while?

We only guarantee ABI stability for nsa.gov releases, not sourceforge
CVS snapshots.  So, if you want such a guarantee, you should wait.
It likely won't be long now until we make an updated release.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
