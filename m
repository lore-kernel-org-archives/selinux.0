Date: Wed, 14 Oct 2015 19:34:17 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014173416.GA15883@x250>
References: <20151014133408.GA5222@x250> <561E5EF4.9080606@tycho.nsa.gov>
 <20151014141101.GB5222@x250> <561E63E0.1080609@tycho.nsa.gov>
 <20151014142952.GC5222@x250> <561E7840.50903@tycho.nsa.gov>
 <20151014154828.GA2909@x250> <561E7D47.7090306@tycho.nsa.gov>
 <20151014164145.GA11363@x250> <561E8872.3090404@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561E8872.3090404@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 12:53:06PM -0400, Stephen Smalley wrote:
> On 10/14/2015 12:41 PM, Dominick Grift wrote:
> >On Wed, Oct 14, 2015 at 12:05:27PM -0400, Stephen Smalley wrote:
> >>>
> >>>>AFAIK, systemd just calls selinux_init_load_policy() in libselinux (aka
> >>>>load_policy -i).  And the approach to selecting a policy version has been
> >>>>stable for quite a while, so I wouldn't expect the libselinux in the
> >>>>initramfs to differ in this respect.
> >
> >I just reboot that machine, and it happened again! So the dangling 29
> >file was not at all related.
> >
> >This issue is so weird, and so hard to narrow down.
> >
> >I have about 7 systems all with the same policy, same selinux userspace, different form factors,
> >2 laptops (one rawhide, on fedora 23), one worksstation (rawhide) and
> >4 qemu/kvm guests (all rawhide)
> >
> >Theyre pretty much all identical from a config point of view except that
> >the workstation is a hypervisor and router
> >
> >The workstation is the issue. I am getting avc denials for the same
> >access vectors (but only on the workstation):
> >
> >system {status start }
> >
> >(obivously the rules to allow it are present in the policy)
> 
> You say "obviously"; how have you verified?  You could run sesearch on the
> kernel's view of the policy (/sys/fs/selinux/policy), or you could run
> compute_av from libselinux.
> 
> If allowed by policy but denied by systemd (since those are systemd
> permissions, not kernel ones, and unfortunately use a kernel class), then
> I've only seen that on a policy reload that alters the class definitions.
> That issue should be fixed by the patch I posted a while back for
> libselinux, which I believe should now be in rawhide.
> 

Yes well setools (3) needs to be updated (only supports up to version 29),
but it does not build without a patch and i was hoping fedora would
update its setools (theres a bugzilla open for that). so far it hasnt
done so, and I haven't done so myself either (was hoping they would do
it instead)

Setools(4) doesnt work with my policy (it can't deal with cil namespaces
seemingly, and returns non-sense)

However I did query the, what should be, same policy on my fedora 23
system and the rules are in there. So that is why i said "obviously"

My libselinux is uptodate to 5aeb4c350b5cba13a68fc11e365bede82ad2cafb
This means that it has your fix for the policy reload issue

Could it be that this fix actually introduced this? I do not believe
that but I am not sure. (at this point I am not sure of anything)

Why does it work sometimes but fail most of the time. why does this only
happen on one system. I am pretty sure i do not have any faulty RAM. Also everything else works fine and the
issue always on applies to the "system { start stop status }" access
vectors. any other ones work fine for example "service { start stop
status }" works fine.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHpITAAoJENAR6kfG5xmcD4IL/16NrcWg7ZNRYR5d2wLr7URM
SROPK2px19UYJi134adC7eFJ7efdyRUeCPmhsvB+08cacI55hdqTBeOr5gi854qD
69RdgMccnwVFmB//hXNXi+utP6msBFKbAIo9TpB5+biLji6iTMNFZKK2GWGGstux
b5v3EcWQTjXj12tRXtgiHqqqZgxunbwJWoAH75eJ+dhgJsDa+bSYk7LDNlnfTp9C
Li79NNrMOsXpdCz9Qaqwwkw9z6FyIhURVibGgvEXeya68rbSlM+hjQYSDT+qWz10
eh9SzAmAcyrJ0/DpwJCTnoSu8JbXI/mQzzE1qEFQROY+9DSpnW/n21t0HJCrAg0H
h2Fvk3mOz8A89IJzVMfSLylHZUh12XgYSM4oJXSdVo/7Wz4hAnusRe7AK2U003uF
oPPck0ESRUysCvKKs90VWnnOo+y/NMM6bgZrJGU2IcqXDU/45Mr5GM81hKEeKeG5
hyQD7PhCeOft4T/Z4JSIxLTHNLCCQ6MwOeg2uvxEqQ==
=AdKN
-----END PGP SIGNATURE-----
