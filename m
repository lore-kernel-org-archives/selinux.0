Date: Wed, 14 Oct 2015 16:29:54 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014142952.GC5222@x250>
References: <20151014133408.GA5222@x250> <561E5EF4.9080606@tycho.nsa.gov>
 <20151014141101.GB5222@x250> <561E63E0.1080609@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <561E63E0.1080609@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Oct 14, 2015 at 10:17:04AM -0400, Stephen Smalley wrote:
> On 10/14/2015 10:11 AM, Dominick Grift wrote:
> >On Wed, Oct 14, 2015 at 09:56:04AM -0400, Stephen Smalley wrote:
> >>On 10/14/2015 09:34 AM, Dominick Grift wrote:
> >>>
> >>>I had some issue that just confused me (to say the least) It seems that
> >>>I have now solved this.
> >>>
> >>>There were two policy.X files in my /etc/selinux/SELINUXTYPE/policy dir,
> >>>on 29 an one 30. The 29 seemingly had a bug in it.
> >>>
> >>>It seems that load_policy (or its libselinux equivalent) defaults to
> >>>the lowest policy available (29 instead of 30 in this case)
> >>>
> >>>Why is that?
> >>>
> >>>I fixed the issue by removing the policy.29 file (i think at least)
> >
> >>What policy versions were supported by your kernel (cat
> >>/sys/fs/selinux/policyvers) and by your libsepol (checkpolicy -V)?
> >
> >/sys/fs/selinux/policyvers says: version 30, and checkpolicy says: 29 (compatibility range 29-15)
> >
> >That is weird because i have the latest libsepol installed (atleast
> >pretty recent):
> >
> ># rpm -qa {libsepol*,libselinux*}
> >libselinux-utils-2.4-9999.git5aeb4c3.fc24.x86_64
> >libselinux-2.4-9999.git5aeb4c3.fc24.x86_64
> >libsepol-2.4-9999.git5aeb4c3.fc24.x86_64
> 
> Last release of libsepol predated policy 30 support.
> 
> However, if your kernel supports it, it should still be loaded.
> The logic is in selinux/libselinux/src/load_policy.c:
> selinux_mkload_policy().  With any modern kernel and configuration,
> libselinux should not need to patch in local definitions or booleans
> (already applied by libsemanage or preserved by the kernel), so maxvers
> should be set to the max of the kernel version (/sys/fs/selinux/policyvers)
> and the libsepol-supported version, and that should get loaded.
> 
> strace of load_policy might be interesting.

That is the thing indeed. It works fine if i manually run
load_policy. But when i reboot it seemed to go back to the old one. (I am
not sure how fedora currently loads the policy)

I removed the policy.29 now so i can't easily reproduce it now. and i do
not think an strace of a manual load_policy will reveal much as that
works fine and as expected. The problem only occurred when i rebooted
(when fedora load policy instead of me)

Ohh , hmm maybe its a fedora initramfs issue... they probably have some
old stuff in there

> 
> 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHmbcAAoJENAR6kfG5xmcH70MAJbBAqr3JkzdJRJsxPZMkr0v
q5VEnlLeKUF4i22YiwY4fkzezpIdF9yfoSrCk/BiWBuFylM+lcTTQxs2RsNHWtM6
X7FPsVdvy+2/PnRNLGqePpMgFzQrBHqoSkY4spRgKpYL6v7psMhCNCTdBGcBHT04
HFx2J6+5dAf2FbDD9NVp2ugMeAU+eJwhvHyWViKyCitc0x8Q9y4ERzVdIrHtBy6J
FJzKY4WRIdBNWjfgQ1a99STArTBIi6M1e+4j3aVqsJ3U52V55mBpGOLZqRs7w3cP
eKMyD+KISP32eIS46pqzJLWpxIp9ALZZVkbANpn+2CYkyghRL3xR+ATBaOwchgdn
RkkfuWRfJhjboH2JSKLKMZ0xKoej9792pAiGVG8H0HnQvSdn6moI++Y/aklBP4al
6tsTI+FcClJwWWykEs+A5rfnzd82T0YyS5UZplZwBnDtlvf5GNLFVd/sCo5q0EZU
6jv9b048kNlGE/9XZJVRQSe/InUa7pdj+p6l72iLDQ==
=2wx1
-----END PGP SIGNATURE-----
