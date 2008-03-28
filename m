Subject: Re: policy package names for Debian
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: russell@coker.com.au, Manoj Srivastava <srivasta@debian.org>,
        "SE-Linux," <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1206710819.16113.310.camel@gorn>
References: <200803281340.01991.russell@coker.com.au>
	 <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil>
	 <1206710819.16113.310.camel@gorn>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 09:57:02 -0400
Message-Id: <1206712622.3302.460.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-28 at 09:26 -0400, Christopher J. PeBenito wrote:
> On Fri, 2008-03-28 at 08:26 -0400, Stephen Smalley wrote:
> > BTW, recently noticed that semanage user -a is broken under standard
> > (non-mcs/mls) policy as there is a hardcoded :s0 in seobject.py on a
> > prefix context check - so that needs to be resolved.  Or we just need to
> > give up on non-mcs/mls policies altogether (that would simplify life for
> > applications and users - a single format for all contexts).
> 
> Gentoo isn't the only one with a TE-only policy, Ubuntu has it too.

Not surprising given who has packaged selinux for Ubuntu.  Doesn't
really add an independent data point for TE-only configurations. 

> Neglecting the above, I still disagree with dropping a TE-only
> configuration.  While you can arrive at the same configuration by having
> one category and one sensitivity and/or dropping the MLS constraints,
> you still get MLS bits leaking through, eg. in semanage.

That's the point - the presence/absence of a context field is visible to
users and applications no matter how much we try to encapsulate the
contexts, and having the two different configurations makes maintenance
and user experience more difficult/confusing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
