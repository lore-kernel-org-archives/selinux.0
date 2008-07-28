Subject: Re: [patch] SELinux: trivial, unify iterator variable naming, part
	3
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <stephen.smalley@gmail.com>,
        James Morris <jmorris@namei.org>,
        Vesa-Matti J Kari <vmkari@cc.helsinki.fi>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
In-Reply-To: <200807261023.09091.paul.moore@hp.com>
References: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
	 <Xine.LNX.4.64.0807260046250.19915@us.intercode.com.au>
	 <1217033137.14295.11.camel@sulphur>  <200807261023.09091.paul.moore@hp.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 14:13:48 -0400
Message-Id: <1217268828.20373.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 2008-07-26 at 10:23 -0400, Paul Moore wrote:
> On Friday 25 July 2008 8:45:26 pm Stephen Smalley wrote:
> > On Sat, 2008-07-26 at 00:47 +1000, James Morris wrote:
> > > On Fri, 25 Jul 2008, Stephen Smalley wrote:
> > > > On Fri, 2008-07-25 at 23:03 +1000, James Morris wrote:
> > > > > Turns out it was caused by
> > > > > CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE being set to
> > > > > the default of 19.
> > > > >
> > > > > After setting it to 22 (same as the Fedora kernel), the problem
> > > > > went away.
> > > >
> > > > Makes sense - policy.19 predates the avtab memory optimization
> > > > work I did, and requires the policy toolchain to fully expand all
> > > > attribute-based rules into individual type pairs.  So that shows
> > > > how much memory we are saving from that particular optimization
> > > > today.
> > >
> > > Should we bump that value so that kernel developers don't hit the
> > > same problem if they have SELinux enabled?  (Many would assume the
> > > boot hung).
> >
> > No - the whole point of that config option is to avoid breakage on
> > Fedora 3 and 4, as noted in the help text.  And the option on which
> > it depends defaults to n and thus shouldn't be enabled for anyone by
> > default.
> >
> > As to whether or not we need to care about Fedora 3 and 4 anymore is
> > perhaps a reasonable question; if not, then the entire option could
> > go away.
> 
> I'm thinking of Andrew Morton's crufty old Fedora Core 2 laptop right 
> now ...

The last selinux bug reports I got from Andrew were only for Fedora 5,
so I'm hoping he has retired anything before F5.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
