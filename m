MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: policy package names for Debian
Date: Fri, 28 Mar 2008 10:50:18 -0400
Message-ID: <1206715818.16113.324.camel@gorn>
In-Reply-To: <1206712622.3302.460.camel@moss-spartans.epoch.ncsc.mil>
References: <200803281340.01991.russell@coker.com.au> <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil> <1206710819.16113.310.camel@gorn> <1206712622.3302.460.camel@moss-spartans.epoch.ncsc.mil>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <russell@coker.com.au>, "Manoj Srivastava" <srivasta@debian.org>,
        "SE-Linux," <selinux@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Chad Sellers" <csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-03-28 at 09:57 -0400, Stephen Smalley wrote:
> > Neglecting the above, I still disagree with dropping a TE-only
> > configuration.  While you can arrive at the same configuration by having
> > one category and one sensitivity and/or dropping the MLS constraints,
> > you still get MLS bits leaking through, eg. in semanage.
> 
> That's the point - the presence/absence of a context field is visible to
> users and applications no matter how much we try to encapsulate the
> contexts, and having the two different configurations makes maintenance
> and user experience more difficult/confusing.

I think the confusion is worse for the TE-only case (emulated by no mls
constraints or only one category/sensitivity).  For example, if you
short circuit the level translation to "", then people get confused when
their setexecon() fails because they haven't put :s0 at the end of the
context, but none of their ps -AZ processes have it.  Thats
significantly more obtuse than people thinking "Fedora has that MCS
stuff, and Ubuntu doesn't."  There is always configuration/support
variances between distros.

I'm not convinced many people actually use MCS at all.  Users have a
hard enough time dealing with TE.  If it wasn't for MCS I don't think
we'd even be having this discussion.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
