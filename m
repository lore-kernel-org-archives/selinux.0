Subject: Re: SELinux mixed/virtualisation policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>,
        SELinux@tycho.nsa.gov
In-Reply-To: <4DA31D2D.9060409@redhat.com>
References: <4DA1E50F.4060506@linux.vnet.ibm.com>
	 <1302529225.7338.32.camel@moss-pluto>  <4DA31D2D.9060409@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Apr 2011 12:33:03 -0400
Message-ID: <1302539583.7338.43.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-04-11 at 11:24 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 04/11/2011 09:40 AM, Stephen Smalley wrote:
> > On Sun, 2011-04-10 at 14:12 -0300, Ramon de Carvalho Valle wrote:
> >> However, I and Dan Walsh (who kindly informed me about libvirt) both
> >> agree that dynamic labeling is more secure than manual labeling using
> >> MLS policy, for virtual machine environments.
> > 
> > Can you elaborate on what your concern is there?  If it is merely that
> > two VMs at the same level are not isolated via the MLS policy, then that
> > isn't a MLS concern, and you could use TE instead to isolate the VMs of
> > the same level.
> > 
> I think what he is after is the convenience of dynamic labeling, for
> isolation.  Yes he could create new types for each instance, which every
> virtual machine would need, this could cause a potential explosion in
> the number of types and would be subject to failure.  It would be
> putting a large onus on the Admin to manage all of these types.  The
> real beauty of dynamic labeling is that it just works.

The types could be automatically generated from a template, and managed
by libvirt in much the same way it presently manages categories.

In any event, he can do the same thing by use of categories rather than
introducing an incomparable set of sensitivities, and that wouldn't
require any changes to the policy toolchain or kernel security server.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
