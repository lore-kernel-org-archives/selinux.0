Subject: Re: changes in ~2.6.13 break postfix policy?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Chris Wright <chrisw@osdl.org>, Russell Coker <russell@coker.com.au>,
   James Morris <jmorris@namei.org>, SELinux@tycho.nsa.gov
In-Reply-To: <1131543371.20591.460.camel@moss-spartans.epoch.ncsc.mil>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
	 <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
	 <20051104183551.GC2837@legolas.drinsama.de>
	 <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
	 <1131148407.1355.21.camel@wintermute.xmldesign.de>
	 <1131382681.20591.102.camel@moss-spartans.epoch.ncsc.mil>
	 <1131478271.17745.6.camel@wintermute.xmldesign.de>
	 <1131543371.20591.460.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 13:50:24 -0500
Message-Id: <1131648624.19626.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 08:36 -0500, Stephen Smalley wrote:
> On Tue, 2005-11-08 at 20:31 +0100, Erich Schubert wrote:
> > Hi,
> > > Hmmm...can you supply any more info to help reproduce the bug?
> > 
> > I've upgraded a box of mine running a self-compiled 2.6.14-rc3 to
> > debians 2.6.14 - and the error has appeared on it, too.
> > So it's not caused by the policy, but either by some .config thing or a
> > patch in the debian kernel. I doubt that there has happened anything
> > relevant between rc3 and final...
> > I'm going to build a 2.6.14 from vanilla sources with the .config of my
> > installed debian kernel to narrow down.
> 
> Thanks.  Could you also send me a copy of that .config file for
> reference?

Ok, I've tracked down the cause of this problem in the Debian kernels:
they are disabling CONFIG_SECURITY_NETWORK, which disables all of the
LSM socket hooks.  Thus, SELinux never gets a chance to classify the
socket inodes as socket objects via its selinux_socket_* hook functions,
and SELinux can no longer distinguish them from sock files at
d_instantiate time because of the removal of the i_sock field in 2.6.12
(which we didn't view as a problem at the time because we had the socket
hooks to address the issue).

I'd suggest asking the Debian kernel maintainers to entertain the notion
of enabling CONFIG_SECURITY_NETWORK.  If they are being driven by
performance considerations (and have actual data to show that the mere
presence of the LSM hooks is having real impact, even with selinux=0),
then possibly CONFIG_SECURITY_NETWORK could be tightened up to only
apply to the hooks that are on the critical path (e.g. sock_rcv_skb is
likely the largest concern).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
