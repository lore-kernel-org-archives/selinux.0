Date: Wed, 14 Oct 2015 18:41:46 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014164145.GA11363@x250>
References: <20151014133408.GA5222@x250> <561E5EF4.9080606@tycho.nsa.gov>
 <20151014141101.GB5222@x250> <561E63E0.1080609@tycho.nsa.gov>
 <20151014142952.GC5222@x250> <561E7840.50903@tycho.nsa.gov>
 <20151014154828.GA2909@x250> <561E7D47.7090306@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561E7D47.7090306@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 12:05:27PM -0400, Stephen Smalley wrote:
> >
> >>AFAIK, systemd just calls selinux_init_load_policy() in libselinux (aka
> >>load_policy -i).  And the approach to selecting a policy version has been
> >>stable for quite a while, so I wouldn't expect the libselinux in the
> >>initramfs to differ in this respect.

I just reboot that machine, and it happened again! So the dangling 29
file was not at all related.

This issue is so weird, and so hard to narrow down.

I have about 7 systems all with the same policy, same selinux userspace, different form factors,
2 laptops (one rawhide, on fedora 23), one worksstation (rawhide) and
4 qemu/kvm guests (all rawhide)

Theyre pretty much all identical from a config point of view except that
the workstation is a hypervisor and router

The workstation is the issue. I am getting avc denials for the same
access vectors (but only on the workstation):

system {status start }

(obivously the rules to allow it are present in the policy)

Is it Linux 4.3 related -> then why does it work on my rawhide laptop,
and kvm guests fine
Is it my policy -> then why does it work on all my other systems fine
Is it hardware related -> seems to be the only explanation but then why
does it not happen consistently? (it happens most of the time when boot
but not always)
Maybe it is a combination of hardware + linux 4.3?

So many questions and so hard to debug...

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHoXEAAoJENAR6kfG5xmc5loL/0w5t5R0q5xzTnufiwMmFAmE
O8Gm9TYSrH/J5IWYGJveEfjH5TVQ3ZXpmPFk32iUb/RZec0B4oBgvSIhWz+LzEyu
Sx0ygz12sXrFkswKbPHiOD1l8ewo5W2m/hdO2x3XB+EUfajwg1x/zo6D+UF0uvMC
qL3fWHvRaQqyeE20CE6L3iiPAKPQs1Y9oLbKv1Lkci7DTEsbQVN47eygyRqeD6p4
qN8LrH9MIh82kFyFUMBynNlWwXqeZSA2awA7Spfw7vWcoQTQEc8QgnfOn5jTky1a
TryUthLoPIVMqm/TdrxngHPrSNWerOdiFpP+3btq6tLcqGX+fsePsFSW3Yv3jNcq
gkG0d+66IvDnIRxCud+YBnARmm6E/r+78YdvYkgm6J8BSIpiSYGL0RRK3JN3olAd
ohVFfEaM10WoqlTOef2Rls8E7R8ewAqS5livd+aDzkviyuikgby4yRZ2KC3qxzhp
ACLe6uBU5179/sBy70QTeOuy4emi384/P/U1r6b6PA==
=idQ1
-----END PGP SIGNATURE-----
