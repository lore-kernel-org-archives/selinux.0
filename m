Subject: Re: SELinux mixed/virtualisation policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>,
        SELinux@tycho.nsa.gov
In-Reply-To: <4DA3417A.2030009@redhat.com>
References: <4DA1E50F.4060506@linux.vnet.ibm.com>
	 <1302529225.7338.32.camel@moss-pluto>  <4DA31D2D.9060409@redhat.com>
	 <1302539583.7338.43.camel@moss-pluto>  <4DA3417A.2030009@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Apr 2011 08:50:46 -0400
Message-ID: <1302612646.25774.11.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-04-11 at 13:59 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 04/11/2011 12:33 PM, Stephen Smalley wrote:
> > On Mon, 2011-04-11 at 11:24 -0400, Daniel J Walsh wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> On 04/11/2011 09:40 AM, Stephen Smalley wrote:
> >>> On Sun, 2011-04-10 at 14:12 -0300, Ramon de Carvalho Valle wrote:
> >>>> However, I and Dan Walsh (who kindly informed me about libvirt) both
> >>>> agree that dynamic labeling is more secure than manual labeling using
> >>>> MLS policy, for virtual machine environments.
> >>>
> >>> Can you elaborate on what your concern is there?  If it is merely that
> >>> two VMs at the same level are not isolated via the MLS policy, then that
> >>> isn't a MLS concern, and you could use TE instead to isolate the VMs of
> >>> the same level.
> >>>
> >> I think what he is after is the convenience of dynamic labeling, for
> >> isolation.  Yes he could create new types for each instance, which every
> >> virtual machine would need, this could cause a potential explosion in
> >> the number of types and would be subject to failure.  It would be
> >> putting a large onus on the Admin to manage all of these types.  The
> >> real beauty of dynamic labeling is that it just works.
> > 
> > The types could be automatically generated from a template, and managed
> > by libvirt in much the same way it presently manages categories.
> > 
> > In any event, he can do the same thing by use of categories rather than
> > introducing an incomparable set of sensitivities, and that wouldn't
> > require any changes to the policy toolchain or kernel security server.
> > 
> 
> Well yes, but currently svirt can support out of the box ~500,000 svirt
> instances,  If we when with  a type system, this would probably some
> problems adding a couple of million types.  I don't think we want svirt
> recompiling and loading policy every time it launches a virtual machine.
>  :^)
> 
> Reserving a pool of categories at might be the way to go.  But at what
> security level?  s15 or s0?  Also what about shared data between the
> virtual machines, read only content.  Currently that is just labeled s0.

I think this is where Ramon's idea breaks down.  The qemu process does
in fact need access to resources and other services on the host and thus
making the qemu process run in a context that is completely incomparable
with the contexts used by host processes and objects will quickly put
you into a situation where you must grant the qemu process MLS
overrides.  At which point you are no longer deriving much benefit from
the MLS policy at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
