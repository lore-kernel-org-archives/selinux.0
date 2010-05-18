Subject: Re: How to cross install policy store?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <4BF28A59.402@redhat.com>
	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 May 2010 09:45:59 -0400
Message-ID: <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-18 at 09:20 -0400, Stephen Smalley wrote:
> On Tue, 2010-05-18 at 18:17 +0500, Shaz wrote:
> > 2010/5/18 Daniel J Walsh <dwalsh@redhat.com>:
> > > You should be able to build the policy on a different maching and just
> > > install it on the ARM box.
> > 
> > You mean it does not require to be cross compiled on a different
> > machine for the target and you can just load it! I cannot agree to
> > this until I try it. If it means that you cross compile it on a
> > different machine and then load it on target seems to be what you mean
> > .... the policy as far as I understand is suppose to be binary when it
> > builds ...
> 
> The policy is in a binary format, but the binary format is
> architecture-independent.  policy is a .noarch package in Fedora.
> Policy is always written little endian and converted to cpu order at
> load time.

BTW, as Dan noted, if I were building policy for such a system, I would
do it entirely on the build/development host and then only deploy the
generated policy files to the target system.  Then you don't even
need /etc/selinux/$SELINUXTYPE/modules/* or /usr/share/selinux/* on the
target system, nor do you need libsemanage, semodule, or semanage on it.
When you want to make a change to policy, you do it on the
build/development host, regenerate the policy, and then distribute the
generated policy files to the target systems using your favorite
distribution mechanism.

I'd also consider just building the policy monolithically for such a
system rather than modularly.  Then you can easily just install directly
to the target image without having to touch /etc/selinux on the
build/devel host.

Lastly, I'm not sure I'd start from refpolicy.  It depends on how close
the target environment matches a typical Linux distribution.  If it is
radically different in the userspace and the filesystem layout (e.g.
Android), I'd be tempted to instead start from a minimal policy (e.g.
one generated via scripts/selinux/mdp in the kernel source tree or a
hand-crafted one) and work my way up to construct a working system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
