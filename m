Subject: Re: How to cross install policy store?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <4BF28A59.402@redhat.com>
	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>
	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 May 2010 15:22:26 -0400
Message-ID: <1274210546.8879.139.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-18 at 22:40 +0500, Shaz wrote:
> >> The policy is in a binary format, but the binary format is
> >> architecture-independent.  policy is a .noarch package in Fedora.
> >> Policy is always written little endian and converted to cpu order at
> >> load time.
> 
> I still don't get it.

Perhaps you are confusing binary format with executable code.
Many formats are binary (not text) but are portable across
architectures. Consider zip files, on-disk filesystem formats, IP
packets, etc.  It is just a matter of having a standard representation.
The policy data structures are serialized as a sequence of fixed width,
little endian integers when written.  You can compile policy on sparc64
and use it on x86_32 or vice versa.  You'll get the same result.

> > BTW, as Dan noted, if I were building policy for such a system, I would
> > do it entirely on the build/development host and then only deploy the
> > generated policy files to the target system.  Then you don't even
> > need /etc/selinux/$SELINUXTYPE/modules/* or /usr/share/selinux/* on the
> > target system, nor do you need libsemanage, semodule, or semanage on it.
> > When you want to make a change to policy, you do it on the
> > build/development host, regenerate the policy, and then distribute the
> > generated policy files to the target systems using your favorite
> > distribution mechanism.
> 
> Indeed the libs you listed are not required on target even for our
> current usecase but we have a usecase for it in mind so trying to
> figure out all the technical stuff before hand and in one go because
> it's tough to change mental set over and over again. I deal with many
> things all at the same time. We will have problem of performance but
> after all it starts with experiments :) And performance for embedded
> systems is improving at a good pace.
>
> > I'd also consider just building the policy monolithically for such a
> > system rather than modularly.  Then you can easily just install directly
> > to the target image without having to touch /etc/selinux on the
> > build/devel host.
> 
> The usecase as I mentioned earlier is better this way but our future
> usecases need modular policy this and much more then booleans etc.

Sure, it depends on your use case.  But if you find yourself running
afoul of memory or disk space constraints on the target system (which
seem common for such embedded systems), then building policy (whether
modularly or monolithically) on a build/devel host and only distributing
the final generated policy to the target systems will certainly help
with such constraints.  If on the other hand you have adequate memory
and disk space on the target system but are limited in your bandwidth
and need to be able to push policy updates as modules rather than as
complete regenerated policy files, then retaining the modular support on
the target system may be a win.

> > Lastly, I'm not sure I'd start from refpolicy.  It depends on how close
> > the target environment matches a typical Linux distribution.  If it is
> > radically different in the userspace and the filesystem layout (e.g.
> > Android), I'd be tempted to instead start from a minimal policy (e.g.
> > one generated via scripts/selinux/mdp in the kernel source tree or a
> > hand-crafted one) and work my way up to construct a working system.
> 
> We work on debian derivatives and I was thinking to look at the
> reference policy sister policy for ubuntu to try. I was also thinking
> to try the selinux-notebook sources but I am still not sure .... still
> too many priority issues before that.

Ok, just keep in mind that you don't necessarily have to use refpolicy
or one of its derivatives if it proves to be a poor match for your
target environment.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
