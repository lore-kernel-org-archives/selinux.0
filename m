Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
	 <Pine.LNX.4.64.0605071136100.8588@d.namei>
	 <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:28:41 -0400
Message-Id: <1147109322.32719.45.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-08 at 12:40 -0400, Stephen Smalley wrote:
> On Sun, 2006-05-07 at 11:37 -0400, James Morris wrote:
> > This patch adds new per-packet access controls to SELinux, replacing the 
> > old packet controls.
> > 
> > Packets are labeled with the iptables SECMARK target then security policy 
> > for the packets is enforced with these controls.
> > 
> > To allow for a smooth transition to the new controls, the old code is 
> > still present, but not active by default.  To restore previous behavior, 
> > the old controls may be activated at runtime by writing a '1' to 
> > /selinux/compat_net.  Switching between the network control models 
> > requires the security load_policy permission.  The old controls will 
> > probably eventually be removed.
> 
> Should we provide alternative ways of specifying the initial value for
> selinux_compat_net as well, as we do with checkreqprot (it can be
> initialized via kernel config option or via boot parameter as well as
> modified via selinuxfs)?  That way a distribution can choose to build
> with compatibility enabled by default without patching, and users can
> boot a kernel with a particular mode of operation if desired.
> 

load_policy could check for the existence of the packet object class and
by default set the flag if it is not found. A boot parameter to override
the default would probably be helpful as well.

Karl


-- 
Karl MacMillan
Tresys Technology
www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
