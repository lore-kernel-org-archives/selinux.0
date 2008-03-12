Subject: RE: Getting started with SELinux and Slackware
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Martin J. Green" <mail@martinjgreen.me.uk>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <54EE10FFA0116B408D3A5172CB52729F01311A12DAC2@exchange.home.martinjgreen.me.uk>
References: 
	 <77FD49B9B8D2394FB1B63A63934913126A55770EA8@exchange.home.martinjgreen.me.uk>
	 <54EE10FFA0116B408D3A5172CB52729F012DC48610D7@exchange.home.martinjgreen.me.uk>
	 <54EE10FFA0116B408D3A5172CB52729F01311A12DABD@exchange.home.martinjgreen.me.uk>
	 <1205249079.23866.145.camel@moss-spartans.epoch.ncsc.mil>
	 <54EE10FFA0116B408D3A5172CB52729F01311A12DABF@exchange.home.martinjgreen.me.uk>
	 <1205260397.23866.175.camel@moss-spartans.epoch.ncsc.mil>
	 <54EE10FFA0116B408D3A5172CB52729F01311A12DAC2@exchange.home.martinjgreen.me.uk>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 08:46:49 -0400
Message-Id: <1205326009.23866.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 20:35 +0000, Martin J. Green wrote:
> Solved the compile issues, I symlinked the libs in /lib to /usr/lib -
> but should I actually have them in /usr/lib instead? (I followed Tim
> Wood's scripts which used /lib).

Fedora has the following layout (example for libselinux, other libraries
are the same way):
/lib/libselinux.so.1 - the shared library
/usr/lib/libselinux.a - the static library
/usr/lib/libselinux.so - symlink to /lib/libselinux.so.1

> 
> The buildscripts for slackware at http://www.firstinternetservices.com/selinux are complete & working for the base selinux packages for the new version (I'm working on userland now - will post to the same when I'm done)
> 
> I take it since this is linking against sepol its probably safe to assume that the patch upstreamed into ssh is relatively up-to-date? (util-linux had a similar compile problem so the same should be true)

Look for a call to getseuserbyname() in it.

Changes that are still patches in the Fedora package against openssh
4.7p1 include:
- support for specifying desired role and level rather than always using
the user's default context,
- LSPP-related changes (MLS/audit).

Neither of which are critical unless you are specifically targeting LSPP
functionality.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
