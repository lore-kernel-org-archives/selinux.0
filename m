Subject: Re: policy package names for Debian
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: russell@coker.com.au, Manoj Srivastava <srivasta@debian.org>,
        "SE-Linux," <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1206715818.16113.324.camel@gorn>
References: <200803281340.01991.russell@coker.com.au>
	 <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil>
	 <1206710819.16113.310.camel@gorn>
	 <1206712622.3302.460.camel@moss-spartans.epoch.ncsc.mil>
	 <1206715818.16113.324.camel@gorn>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 11:37:06 -0400
Message-Id: <1206718626.3302.511.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-28 at 10:50 -0400, Christopher J. PeBenito wrote:
> On Fri, 2008-03-28 at 09:57 -0400, Stephen Smalley wrote:
> > > Neglecting the above, I still disagree with dropping a TE-only
> > > configuration.  While you can arrive at the same configuration by having
> > > one category and one sensitivity and/or dropping the MLS constraints,
> > > you still get MLS bits leaking through, eg. in semanage.
> > 
> > That's the point - the presence/absence of a context field is visible to
> > users and applications no matter how much we try to encapsulate the
> > contexts, and having the two different configurations makes maintenance
> > and user experience more difficult/confusing.
> 
> I think the confusion is worse for the TE-only case (emulated by no mls
> constraints or only one category/sensitivity).  For example, if you
> short circuit the level translation to "", then people get confused when
> their setexecon() fails because they haven't put :s0 at the end of the
> context, but none of their ps -AZ processes have it.  Thats
> significantly more obtuse than people thinking "Fedora has that MCS
> stuff, and Ubuntu doesn't."  There is always configuration/support
> variances between distros.

Ah, that's likely true.  And people do find the difference between MCS
and MLS confusing as it is.

> I'm not convinced many people actually use MCS at all.  Users have a
> hard enough time dealing with TE.  If it wasn't for MCS I don't think
> we'd even be having this discussion.

For me, the value of MCS is getting the MLS support adequately tested
and supported throughout the distribution.  That's about it.

The ideal scenario from a "mainstreaming MAC" perspective would be to
have the real MLS constraints in place by default, and the only
difference between the default setup and a MLS one would be whether one
actually puts anything in any level other than s0.  That would carry
some cost from the constraint evaluation on compute_av calls, but that
should be largely masked by the AVC.  It shouldn't really affect memory
or disk use as long as everything defaults to s0 and no categories.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
