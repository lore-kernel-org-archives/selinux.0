Subject: Re: SELinux mixed/virtualisation policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <4DA579E8.6040404@linux.vnet.ibm.com>
References: <4DA1E50F.4060506@linux.vnet.ibm.com>
	 <1302529225.7338.32.camel@moss-pluto>  <4DA31D2D.9060409@redhat.com>
	 <1302539583.7338.43.camel@moss-pluto>  <4DA3417A.2030009@redhat.com>
	 <1302612646.25774.11.camel@moss-pluto>
	 <4DA579E8.6040404@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Apr 2011 08:19:29 -0400
Message-ID: <1302697169.16451.12.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-04-13 at 07:24 -0300, Ramon de Carvalho Valle wrote:
> On 04/12/2011 09:50 AM, Stephen Smalley wrote:
> > I think this is where Ramon's idea breaks down.  The qemu process does
> > in fact need access to resources and other services on the host and thus
> > making the qemu process run in a context that is completely incomparable
> > with the contexts used by host processes and objects will quickly put
> > you into a situation where you must grant the qemu process MLS
> > overrides.  At which point you are no longer deriving much benefit from
> > the MLS policy at all.
> > 
> Not exactly. Could you give us an example of such a situation?
> 
> The processes representing virtual machine environments and its
> associated resources should belong to the virtualisation sensitivities,
> as well as the libvirt daemon. PCI passthrough should be a case a part,
> as it needs to be detached from the host anyway--It should be explicitly
> allowed and/or have a virtualisation sensitivity, which is the recommended.
> 
> Currently, the libvirt daemon executes with s0-s15:c0.c1023, which is
> far more concerning than sv0-sv15:c0.c1023. So where is MLS?

If you do a sesearch -A -s qemu_t, you'll see that qemu_t interacts with
quite a few types on the host, including both files and processes. And
even more so for libvirtd.  The more you move into your new
sensitivities, the more you'll have to define MLS overrides for more
domains.

At present, virtd_t (i.e. libvirtd) is given many (all?) MLS overrides,
which is unsurprising since it is expected to create and manage VMs at
any level.  But qemu_t (i.e. the qemu process representing the
individual VM) is not given such MLS overrides, nor should it, as that
would allow to escape the confines of its level/range.
 
> So far we have been discussing how to accomplish what was proposed using
> costly non standard methods and workarounds without considering the
> benefits of a far more elegant solution, which until now does not seem
> to have any downsides--despite the development effort.

I can't quite see how your approach is cleaner than just using separate
categories.  Same effect - by allocating a dedicated category to the VMs
and another to the host, you end up with incomparable levels and thus
will achieve automatic isolation except where explicitly overridden
using the type attributes for MLS overrides.  Adding another
incomparable set of sensitivities puts us outside the scope of any
evaluated or even published security model.

Now something that has been suggested in the past would be adding
another level/range component to the security context for use by a
Biba-like integrity model.  That might be interesting, but would
obviously require quite a few changes on both the kernel and userland
side.  It would also require resolving the unfortunate ambiguity in the
current security context format.

> We must consider that virtualisation is not something that is invented
> every decade, and how much more we have the operating system and its
> security mechanisms aware of it, is to be prepared for what comes next.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
