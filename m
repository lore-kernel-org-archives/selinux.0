Message-ID: <1495658455.3489.7.camel@tycho.nsa.gov>
Subject: Re: Fedora COPR repositories with builds of latest code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Date: Wed, 24 May 2017 16:40:55 -0400
In-Reply-To: <20170524145330.GE1910@julius.enp8s0.d30>
References: <b95f2f22-9280-2448-9fd2-cede379bff8d@redhat.com>
 <20170524143316.GD1910@julius.enp8s0.d30>
 <20170524145330.GE1910@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-24 at 16:53 +0200, Dominick Grift wrote:
> On Wed, May 24, 2017 at 04:33:16PM +0200, Dominick Grift wrote:
> > On Wed, May 24, 2017 at 04:22:08PM +0200, Petr Lautrbach wrote:
> > > For the motivation see
> > > https://marc.info/?l=selinux&m=149435307518336&w=2
> > 
> > Thanks! I enabled the one with Fedora patches because i need
> > python3 support for setools4
> > 
> > This should allow me to enable extended_socket_class functionality
> > and test it.
> > 
> > I hope this repository will be maintained consistently so that it
> > can be useful
> 
> I just enabled the extended_socket_class capability and in seinfo --
> polcap -x it currently shows up as "redhat1":
> 
> # seinfo --polcap -x
> 
> Polcap: 3
>    policycap network_peer_controls;
>    policycap open_perms;
>    policycap redhat1;
> 
> I know the redhat1 polcap is re-used but not sure if this expected to
> return like that...

Maybe setools4 hasn't been rebuilt to use the updated libsepol, or has
its own internal table of the policy capability string names?

> 
> > 
> > > 
> > > I've restarted building of Fedora packages based on latest
> > > SELinux userspace code in Fedora COPR. Packages are built using
> > > the https://gitlab.com/bachradsusi/selinux-rpm project.
> > > 
> > > There is a new selinux.spec [1] file which allows to build all
> > > Fedora packages from one src.rpm and Makefile which makes the
> > > process simple.
> > > 
> > > Currently there are two COPR projects:
> > > 
> > > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora
> > > /
> > > 
> > > This is built with Python3 support based on Fedora patches which
> > > are rebased against latest upstream code.
> > > 
> > > 
> > > * https://copr.fedorainfracloud.org/coprs/plautrba/selinux-SELinu
> > > xProject/
> > > 
> > > This is based on pure upstream sources and without Python 3.
> > > 
> > > 
> > > Currently I run copr builds manually but the plan is to make it
> > > fully automated.
> > > 
> > > 
> > > Let me know if you find it useful or if you have ideas, comments
> > > and so on.
> > > 
> > > 
> > > [1] https://gitlab.com/bachradsusi/selinux-rpm/blob/master/selinu
> > > x.spec
> > > 
> > > 
> > > Thanks,
> > > 
> > > Petr
> > 
> > -- 
> > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
> > 6B02
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6
> > B02
> > Dominick Grift
> 
> 
> 
