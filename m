Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76EOvrT012363
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 10:24:57 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76EOuO0023574
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 14:24:56 GMT
Subject: RE: Now that SELinux supports booleans should we replace tunables
	with booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux-dev@tresys.com
In-Reply-To: <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1091802227.8590.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 10:23:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-02 at 14:53, Stephen Smalley wrote:
> Of the remaining base tunables from tunable.tun, I believe that either
> they are not amenable to the use of policy booleans (i.e. affect type
> declarations or role-based statements) or they would activate many
> additional rules when enabled and it would thus bloat the policy to make
> them runtime conditionals.  However, I'm open to reconsidering some of
> the latter cases, and even to re-thinking how we approach some of the
> former cases to allow us to leverage booleans to some degree.

BTW, I was hoping for a bit more discussion about which tunables should
remain as compile-time tunables, and which ones should be runtime
booleans.  I've converted about half of the base tunables and all of the
named and apache tunables to booleans.  There are still at least some
tunables that I can envision admins wanting to be able to change as
booleans, but would require further reworking of the policy to split out
the parts that cannot be made conditional, and there may be some
booleans I've created that would be better to keep as static tunables. 
Comments are welcome.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
