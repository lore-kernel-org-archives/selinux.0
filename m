Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <alpine.LRH.2.00.0910010745180.30576@tundra.namei.org>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>
	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>
	 <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4AC2C32D.3010405@ak.jp.nec.com>
	 <1254314361.30591.11.camel@moss-pluto.epoch.ncsc.mil>
	 <1254315215.30591.18.camel@moss-pluto.epoch.ncsc.mil>
	 <alpine.LRH.2.00.0910010745180.30576@tundra.namei.org>
Content-Type: text/plain
Date: Thu, 01 Oct 2009 08:32:40 -0400
Message-Id: <1254400360.30591.105.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-10-01 at 07:46 +1000, James Morris wrote:
> On Wed, 30 Sep 2009, Stephen Smalley wrote:
> 
> > Does anyone think we still need to support policy versions <
> > POLICYDB_VERSION_NLCLASS (18)?  If not, then we can just drop the
> > dynamic remapping of netlink classes in the security server:
> >         if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
> >                 if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
> >                     tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> >                         tclass = SECCLASS_NETLINK_SOCKET;
> > 
> > I think RHEL4 shipped with policy.18.
> 
> Was any distro shipped with a lower policy version?  If not, then I think 
> it should be ok.

policy.18 was first supported by Linux 2.6.8.
I think the only distro to ship with SELinux enabled and Linux < 2.6.8
would have been Fedora Core 2, which is long since EOL'd and even akpm
doesn't run it anymore.  Not sure about Hardened Gentoo - Chris and/or
Joshua?  Debian selinux packages predated Fedora, of course, but weren't
mainstreamed into Debian until much later.

I didn't yet remove this logic in my patches, but will do so if there
are no objections.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
