Message-ID: <4A92A981.8000608@manicmethod.com>
Date: Mon, 24 Aug 2009 10:53:53 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
Subject: Re: object context records for Xen
References: <1250865733.2390.85.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1250865733.2390.85.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Hi,
>
> Xen needs its own object context (ocontext) records in the policy for
> various resources (pirq, iomem, ioport, device), and has no need for the
> Linux object context records other than initial SIDs.  Thus, rather than
> just add new OCON_ indices and waste space in both the Linux and Xen
> policies, I'd like to be able to interpret OCON_ indices differently
> depending on some other value in the policy that identifies the target
> kernel (Linux, Xen, FreeBSD, Solaris, ...). Possible ways to identify
> the target kernel within the policy image:
>
> - Use different policydb strings ("SE Linux", "Xen Flask", ...) in the
> header.  I already introduced support for at least one other policydb
> string ("Flask") in policydb_read() in libsepol so that we didn't have
> to use "SE Linux" as the string in the OpenSolaris FMAC policy files.
> Each kernel would only need to support reading files with its own string
> identifier and would reject all others.  Only libsepol would support all
> of them for reading and writing.
>

I am a fan of this. One question is how do you build policydb's with the correct 
string? libsemanage option? checkpolicy option? It seems like only checkpolicy 
would be able to build policies for other systems since it doesn't make sense to 
have the policy be 'managed'. OTOH maybe it does make sense to have them 
managed, if there is extra infrastructure to load policies into e.g., Xen (like 
load_xen_policy) from domain 0.

> - Use the config flags in the header.  We are presently only using 3
> bits in the config field (MLS, reject_unknown, allow_unknown), so we can
> easily use a bit for each target kernel.  Not very general/scalable, but
> it isn't clear that we need this for very many cases.
>

I don't think this is the purpose of the config flag. What if the destination 
systems have their own config flags?

> - Introduce an entirely new field to the header to select the target
> kernel.  In which case it could just be an unsigned integer with defined
> values for Linux, Solaris, Xen, FreeBSD, etc.  This is the only one that
> absolutely requires a new policy version (policy.25).
>

boo to bumping policydb versions if not necessary.

> Other aspects of the policy might likewise get interpreted differently
> based on the target kernel, such as policy capabilities (the current
> ones are very Linux-specific).
>
> Then we'd have to decide how we want to drive selection of the target
> kernel when building the policy; it could be an option to
> checkpolicy/checkmodule (ala MLS and handle_unknown behavior) or it
> could be an actual directive within the source policy configuration.
>

Ah, yes. If we were using modules to build policies for other systems would 
every module have to identify its platform? Is SELinux default? Will refpolicy 
ever be able to build policies for different targets?

In the spirit of standard compilers this seems like a --target sort of thing 
rather than sticking it in the language.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
