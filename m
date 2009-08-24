Subject: Re: object context records for Xen
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
In-Reply-To: <4A92AC4D.7080503@manicmethod.com>
References: <1250865733.2390.85.camel@moss-pluto.epoch.ncsc.mil>
	 <4A92A981.8000608@manicmethod.com>  <4A92AC4D.7080503@manicmethod.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 11:19:27 -0400
Message-Id: <1251127167.2428.44.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-08-24 at 11:05 -0400, Joshua Brindle wrote:
> Joshua Brindle wrote:
> > Stephen Smalley wrote:
> >> Hi,
> >>
> >> Xen needs its own object context (ocontext) records in the policy for
> >> various resources (pirq, iomem, ioport, device), and has no need for the
> >> Linux object context records other than initial SIDs. Thus, rather than
> >> just add new OCON_ indices and waste space in both the Linux and Xen
> >> policies, I'd like to be able to interpret OCON_ indices differently
> >> depending on some other value in the policy that identifies the target
> >> kernel (Linux, Xen, FreeBSD, Solaris, ...). Possible ways to identify
> >> the target kernel within the policy image:
> >>
> >> - Use different policydb strings ("SE Linux", "Xen Flask", ...) in the
> >> header. I already introduced support for at least one other policydb
> >> string ("Flask") in policydb_read() in libsepol so that we didn't have
> >> to use "SE Linux" as the string in the OpenSolaris FMAC policy files.
> >> Each kernel would only need to support reading files with its own string
> >> identifier and would reject all others. Only libsepol would support all
> >> of them for reading and writing.
> >>
> >
> > I am a fan of this. One question is how do you build policydb's with the
> > correct string? libsemanage option? checkpolicy option? It seems like
> > only checkpolicy would be able to build policies for other systems since
> > it doesn't make sense to have the policy be 'managed'. OTOH maybe it
> > does make sense to have them managed, if there is extra infrastructure
> > to load policies into e.g., Xen (like load_xen_policy) from domain 0.
> >
> >> - Use the config flags in the header. We are presently only using 3
> >> bits in the config field (MLS, reject_unknown, allow_unknown), so we can
> >> easily use a bit for each target kernel. Not very general/scalable, but
> >> it isn't clear that we need this for very many cases.
> >>
> >
> > I don't think this is the purpose of the config flag. What if the
> > destination systems have their own config flags?
> >
> >> - Introduce an entirely new field to the header to select the target
> >> kernel. In which case it could just be an unsigned integer with defined
> >> values for Linux, Solaris, Xen, FreeBSD, etc. This is the only one that
> >> absolutely requires a new policy version (policy.25).
> >>
> >
> > boo to bumping policydb versions if not necessary.
> >
> 
> On this topic, do we foresee any target needing policydb changes that will 
> diverge the version between targets? If so, how do we plan to handle that?

I don't think so - we plan to keep them in sync in terms of versions.

> >> Other aspects of the policy might likewise get interpreted differently
> >> based on the target kernel, such as policy capabilities (the current
> >> ones are very Linux-specific).
> >>
> >> Then we'd have to decide how we want to drive selection of the target
> >> kernel when building the policy; it could be an option to
> >> checkpolicy/checkmodule (ala MLS and handle_unknown behavior) or it
> >> could be an actual directive within the source policy configuration.
> >>
> >
> > Ah, yes. If we were using modules to build policies for other systems
> > would every module have to identify its platform? Is SELinux default?
> > Will refpolicy ever be able to build policies for different targets?
> >
> > In the spirit of standard compilers this seems like a --target sort of
> > thing rather than sticking it in the language.
> >
> 
> Also, is it an error condition if there are ocon's unrelated to the target 
> platform? Is it possible to create a general policy that may work on multiple 
> platforms and therefore have a superset of the ocons for each possible platform?

I would plan to have checkpolicy reject invalid ocons for the specified
target platform, much as it rejects mls statements (or requires them)
depending on the MLS flag.

There really isn't any sharing possible between the Xen policy and the
Linux policy, given the significantly different resources and operations
(thus classes and permissions), so I don't think it would be useful to
support a unified policy.

In the case of Linux, Solaris, and FreeBSD, it isn't clear that they
actually need distinct ocontext records since they do happen to share
the same Unix abstractions for the most part.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
