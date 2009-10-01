Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: James Morris <jmorris@namei.org>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <200910010946.28121.paul.moore@hp.com>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>
	 <alpine.LRH.2.00.0910010745180.30576@tundra.namei.org>
	 <1254400360.30591.105.camel@moss-pluto.epoch.ncsc.mil>
	 <200910010946.28121.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 01 Oct 2009 11:31:14 -0400
Message-Id: <1254411074.30591.110.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-10-01 at 09:46 -0400, Paul Moore wrote:
> On Thursday 01 October 2009 08:32:40 am Stephen Smalley wrote:
> > On Thu, 2009-10-01 at 07:46 +1000, James Morris wrote:
> > > On Wed, 30 Sep 2009, Stephen Smalley wrote:
> > > > Does anyone think we still need to support policy versions <
> > > > POLICYDB_VERSION_NLCLASS (18)?  If not, then we can just drop the
> > > > dynamic remapping of netlink classes in the security server:
> > > >         if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
> > > >                 if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
> > > >                     tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> > > >                         tclass = SECCLASS_NETLINK_SOCKET;
> > > >
> > > > I think RHEL4 shipped with policy.18.
> > >
> > > Was any distro shipped with a lower policy version?  If not, then I think
> > > it should be ok.
> > 
> > policy.18 was first supported by Linux 2.6.8.
> > I think the only distro to ship with SELinux enabled and Linux < 2.6.8
> > would have been Fedora Core 2, which is long since EOL'd and even akpm
> > doesn't run it anymore.  Not sure about Hardened Gentoo - Chris and/or
> > Joshua?  Debian selinux packages predated Fedora, of course, but weren't
> > mainstreamed into Debian until much later.
> > 
> > I didn't yet remove this logic in my patches, but will do so if there
> > are no objections.
> 
> I'm sure you've already thought about this, but if you do remove the code for 
> policy versions below 18 I would recommend doing so in a standalone patch - 
> that way if somebody does end up with a broken system the bisect will only 
> drag down the policy.18 patch and not the rest of these patches (which are 
> going to be a very nice addition).

Yes, I'll do it as a separate patch relative to the v5 patches.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
