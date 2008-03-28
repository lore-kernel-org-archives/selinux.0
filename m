MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: policy package names for Debian
Date: Fri, 28 Mar 2008 09:26:59 -0400
Message-ID: <1206710819.16113.310.camel@gorn>
In-Reply-To: <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil>
References: <200803281340.01991.russell@coker.com.au> <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <russell@coker.com.au>, "Manoj Srivastava" <srivasta@debian.org>,
        "SE-Linux," <selinux@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-03-28 at 08:26 -0400, Stephen Smalley wrote:
> BTW, recently noticed that semanage user -a is broken under standard
> (non-mcs/mls) policy as there is a hardcoded :s0 in seobject.py on a
> prefix context check - so that needs to be resolved.  Or we just need to
> give up on non-mcs/mls policies altogether (that would simplify life for
> applications and users - a single format for all contexts).

Gentoo isn't the only one with a TE-only policy, Ubuntu has it too.

Neglecting the above, I still disagree with dropping a TE-only
configuration.  While you can arrive at the same configuration by having
one category and one sensitivity and/or dropping the MLS constraints,
you still get MLS bits leaking through, eg. in semanage.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
