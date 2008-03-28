Subject: Re: Debian SE Linux status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jwcart2@epoch.ncsc.mil
Cc: Joshua Brindle <method@manicmethod.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1206711402.29088.21.camel@moss-lions.epoch.ncsc.mil>
References: <200803281106.47699.russell@coker.com.au>
	 <1206708790.3302.414.camel@moss-spartans.epoch.ncsc.mil>
	 <47ECEAF0.4090304@manicmethod.com>
	 <1206709188.3302.419.camel@moss-spartans.epoch.ncsc.mil>
	 <1206711402.29088.21.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 09:51:30 -0400
Message-Id: <1206712290.3302.455.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-28 at 09:36 -0400, James Carter wrote:
> On Fri, 2008-03-28 at 08:59 -0400, Stephen Smalley wrote:
> > On Fri, 2008-03-28 at 08:56 -0400, Joshua Brindle wrote:
> > > Stephen Smalley wrote:
> > > > On Fri, 2008-03-28 at 11:06 +1100, Russell Coker wrote:
> > > >   
> > > >> http://etbe.coker.com.au/2008/03/28/debian-se-linux-status/
> > > >>
> > > >> Those of you who don't read Planet SE Linux but who are interested in Debian 
> > > >> may want to read the above.
> > > >>     
> > > >
> > > > Regarding the mismatch in policy version between your domU vs. dom0, you
> > > > should be able to build older policy versions via the config setting
> > > > in /etc/selinux/semanage.conf (modular build) or via the OUTPUT_POLICY=
> > > > setting in build.conf, overridable on the make command line (monolithic
> > > > build).
> > > >
> > > > Or you could install newer selinux core userland in your dom0 such that
> > > > it can read and downgrade the latest policy to the one supported by your
> > > > kernel (libselinux policy load logic will convert a newer policy to an
> > > > older one at load time for you).
> > > >
> > > > Agree that converting between non-MLS and MLS/MCS is very painful at
> > > > present.  Part of that we can fix (inappropriate dependencies in
> > > > semanage/seobject.py that should be querying the policy store via
> > > > libsemanage/libsepol rather than checking the running policy), and part
> > > > we cannot (still won't be able to switch the kind of policy at policy
> > > > reload in the kernel).  I'd actually prefer that we just always enable
> > > > the MLS engine and field for simplification, presenting the same
> > > > experience to all users, and ensuring that we are all testing the same
> > > > code paths.  
> 
> I thought that MLS just added additional code paths.  Are there code
> paths that are only taken for non-MLS policies?
> 
> > I don't know how others feel about that though - I know
> > > > that Gentoo has historically not enabled MCS/MLS, and that upstream
> > > > refpolicy still defaults to not enabling it (standard).
> > > >
> > > > I'm not sure why MLS support significantly increases policy build time
> > > > though.
> > > >   
> 
> Isn't that an argument for keeping non-MLS support? ;)

I don't believe that it actually does significantly increase policy
build time (or if it does, that would be a bug).  Possibly Russell just
means that building both MLS and non-MLS takes longer, or that the mls
modules.conf includes more modules, or something along those lines?

> What is the difference in overhead between an MLS and a non-MLS system?
> Would there be a noticeable difference in resources used by a non-MLS
> system and one that had a single level of s0 and no categories?  (Can
> you actually define only one level and no categories?)

If you don't define any actual MLS constraints in policy, then it
shouldn't impose any real runtime overhead (and even when you do, that's
all masked by the AVC, of course).  Yes, you should be able to define
just one level and no categories, although I doubt that defining
categories significantly expands the policy (just because they are
defined doesn't mean you have to use them in contexts).

With the mainstreaming of the MLS support and turning it from a
compile-time option into a runtime load option, there isn't any real
difference in the in-core context structures even when you have MLS
disabled.  So you aren't saving anything there.

> > > Also note that the default (and only) policy on Ubuntu is non-mls.
> > 
> > Why?
> > 
> > I think we set ourselves up for application and user confusion and
> > incompatibility by having different context formats in the different
> > distributions that support SELinux.  And it definitely creates a
> > maintenance burden - having to test both cases always.  Which apparently
> > we aren't doing a good job of, as semanage user -a will presently always
> > fail on a non-MCS/MLS system.
> > 
> 
> I don't think that we should address deficiencies in the tool-chain by
> reducing flexibility.

No - it isn't just deficiencies in the tool chain.  It increases our
maintenance burden to have multiple options and code paths to exercise,
and it is user- and application visible since it affects the context
format.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
