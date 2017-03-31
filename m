Message-ID: <1490968406.31110.6.camel@tycho.nsa.gov>
Subject: Re: userspace object manager confused
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 31 Mar 2017 09:53:26 -0400
In-Reply-To: <20170331133613.GB5699@t450.enp8s0.d30>
References: <20170331120905.GA5699@t450.enp8s0.d30>
 <1490966741.31110.2.camel@tycho.nsa.gov>
 <1490967056.31110.4.camel@tycho.nsa.gov>
 <20170331133613.GB5699@t450.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-03-31 at 15:36 +0200, Dominick Grift wrote:
> On Fri, Mar 31, 2017 at 09:30:56AM -0400, Stephen Smalley wrote:
> > On Fri, 2017-03-31 at 09:25 -0400, Stephen Smalley wrote:
> > > On Fri, 2017-03-31 at 14:09 +0200, Dominick Grift wrote:
> > > > I vaguely recall that we discussed this issue or at least that
> > > > i
> > > > mentioned it here but i can't recall the outcome if any:
> > > > 
> > > > So today on my rawhide system i noticed that i somehow forgot
> > > > to
> > > > add
> > > > support for the smc_socket class (i suspect that is part of the
> > > > extended socket class patches)
> > > > 
> > > > I added the class (which i suppose is unordered like the othe
> > > > extended socket classes) but as soon as I loaded up the policy
> > > > with
> > > > the new unordered smc_socket class the system became unusable.
> > > > 
> > > > This is because the dbus object manager became confused due to
> > > > my
> > > > adding a new (unordered) class at runtime, and that the dbus
> > > > class
> > > > was no longer working.
> > > > 
> > > > Modern systems heavily rely on dbus at the heart and so it is
> > > > undesire-able that this happens.
> > > > 
> > > > A reboot clears this issue up but adding (unordered) classes at
> > > > runtime should not cause these issues i suspect
> > > 
> > > dbusd doesn't use selinux_check_access() and therefore does not
> > > yet
> > > support reordering of their classes/permissions at runtime.  The
> > > same
> > > is true of all userspace object managers created before
> > > selinux_check_access() was introduced - anything that directly
> > > calls
> > > security_compute_av() or avc_has_perm(). dbusd does call
> > > selinux_set_mapping() at startup, so it can correctly handle
> > > reordering of classes/permissions across restarts, but not while
> > > it
> > > is
> > > running.  Calling selinux_set_mapping() again upon policy reloads
> > > (e.g.
> > > from policy_reload_callback() if (event == AVC_CALLBACK_RESET)
> > > before
> > > returning) may fix this problem, but requires proper
> > > locking.  Even
> > > better would be to rid the dbusd selinux implementation of
> > > threading
> > > entirely, see https://bugs.freedesktop.org/show_bug.cgi?id=92831#
> > > c4
> 
> Thank you, I suppose i should take this to them then.

No, someone who uses SELinux will need to develop a patch and test it
for them; dbusd maintainer doesn't use SELinux himself.

Looks like I'm also wrong about being able to call
selinux_set_mapping() from an AVC callback, since selinux_set_mapping()
itself calls avc_reset() to flush any cache entries before reloading
the mapping, so that would produce infinite recursion.  Sigh.  Could
change selinux_set_mapping() to not do that in libselinux, but that
won't help on existing releases.  Maybe we should just convert it over
to using selinux_check_access() and drop all direct usage of the AVC.

> > > 
> > > smc_socket was added by the kernel developers as part of the
> > > merge
> > > with
> > > net-next since we now trigger a build failure in the kernel if
> > > any
> > > new
> > > address families are introduced without adding a corresponding
> > > security
> > > class (so that SELinux always supports a separate class per
> > > network
> > > address family going forward). So there have been no policy
> > > patches
> > > submitted yet to define it in refpolicy even AFAIK.
> > > 
> > > [1] https://github.com/SELinuxProject/selinux/issues/34
> 
> So i suppose its an unordered class? or do i have to order this one
> to avoid future issues?
> 
> > 
> > BTW, I'm not sure what you did to trigger the problem.  When I
> > tested
> > the extended socket classes, I added them to my running policy via
> > a
> > CIL module like this:
> 
> Well i just added this commit (ignore the typo in the name) which
> adds the new class to the unordered socket list
> 
> https://github.com/DefenSec/dssp2-base/commit/5e3ada7d12525c8c659f347
> 863f09ec9caeceb56
> 
> then i built rpms using this script:
> 
> https://github.com/DefenSec/dssp2-standard/blob/master/support/rpm/ds
> sp2-standard.sh
> 
> and just rpm -Uvh the new rpm
> 
> > 
> > (policycap extended_socket_class)
> > 
> > (classcommon sctp_socket socket)
> > (class sctp_socket (node_bind))
> > 
> > <snip>
> > 
> > (classcommon qipcrtr_socket socket)
> > (class qipcrtr_socket ())
> > 
> > (classorder (unordered sctp_socket icmp_socket ax25_socket
> > ipx_socket
> > netrom_socket bridge_socket atmpvc_socket x25_socket rose_socket
> > decnet_socket atmsvc_socket rds_socket irda_socket pppox_socket
> > llc_socket ib_socket mpls_socket can_socket tipc_socket
> > bluetooth_socket iucv_socket rxrpc_socket isdn_socket phonet_socket
> > ieee802154_socket caif_socket alg_socket nfc_socket vsock_socket
> > kcm_socket qipcrtr_socket))
> > 
> > The classorder statement at the end ensured that they were appended
> > to
> > the end of the class list and therefore did not break anything.
> > 

Looks like you failed to include a classorder statement for it as I did
above.  That's still required to avoid breaking legacy userspace object
managers.
