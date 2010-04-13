Subject: Re: Cannot not open session
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <20100409125223.GV1518@myhost.felk.cvut.cz>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E46493A4@EUSAACMS0703.eamcs.ericsson.se>
	 <1270816722.2650.7.camel@moss-huskers.epoch.ncsc.mil>
	 <20100409125223.GV1518@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Tue, 13 Apr 2010 15:48:05 -0400
Message-Id: <1271188085.9577.97.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-04-09 at 14:52 +0200, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > Early Fedora and RHEL-4 put pam_selinux in /etc/pam.d/su in an effort to
> > automatically change contexts upon user identity changes.  This proved
> > to be a mistake in practice (and a deviation from the original SELinux
> > approach), and was subsequently removed in later Fedora and RHEL-5.
> 
> BTW, is there any further explanation of why this is a mistake? And
> question #2, I think sudo still does this, isn't that a mistake too?

With the original (and current approach), su isn't especially trusted
with respect to SELinux, the set of reachable contexts within a login
session can be bounded with respect to the starting context, and you can
switch Linux uid while staying in the same SELinux context.  With
pam_selinux in /etc/pam.d/su, su becomes highly trusted with respect to
SELinux, any context can potentially be reached from any other context,
and you cannot switch Linux uid while staying in the same SELinux
context (at least via su).

The sudo SELinux support differs in that:
- by default (in the absence of command line options or sudoers
configuration), there is no context change, so we retain the ability to
sudo while staying in context, and
- sudo only supports switching role (and type), not SELinux user or
level, so reachable contexts remain bounded based on the SELinux user
and level is preserved, and the amount of trust extended to sudo is more
alike to that of newrole than to that of login.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
