Date: Mon, 31 Aug 2015 16:24:25 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: simplify procattr cache
Message-ID: <20150831142424.GA17416@x250>
References: <1437412266-6462-1-git-send-email-sds@tycho.nsa.gov>
 <20150829170214.GA15275@x250> <55E455D5.7000608@tycho.nsa.gov>
 <55E45B82.2050705@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <55E45B82.2050705@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, Aug 31, 2015 at 09:49:54AM -0400, Stephen Smalley wrote:
> On 08/31/2015 09:25 AM, Stephen Smalley wrote:
<snip>

> 
> For me, the example from the systemd-nspawn man page of:
> 
> # chcon system_u:object_r:svirt_sandbox_file_t:s0:c0,c1 -R /srv/container
> # systemd-nspawn -L system_u:object_r:svirt_sandbox_file_t:s0:c0,c1 -Z
> system_u:system_r:svirt_lxc_net_t:s0:c0,c1 -D /srv/container /bin/sh
> 
> On F22: succeeded (no change required to libselinux),
> 
> On F23: failed with
> setexeccon("system_u:system_r:svirt_lxc_net_t:s0:c0,c1") failed: No such
> file or directory
> with libselinux-2.4-1.fc23
> 
> But if I install upstream SELinux userspace, ala
> # cd selinux
> # make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> 
> It then succeeds:
> # systemd-nspawn -L system_u:object_r:svirt_sandbox_file_t:s0:c0,c1 -Z
> system_u:system_r:svirt_lxc_net_t:s0:c0,c1 -D /srv/container /bin/sh
> Spawning container container on /srv/container.
> Press ^] three times within 1s to kill container.
> sh-4.3#
> 
> From outside the container:
> # ps -eZ | grep svirt
> system_u:system_r:svirt_lxc_net_t:s0:c0,c1 11950 pts/3 00:00:00 sh
> 
> So it appears to fix the problem there.

Okay, thanks. I think it is better for me to just wait for an updated
libselinux package in Fedora Rawhide (please Fedora give us rawhide
users something recent to work with).

I basically just "synced" the procattr.c file provided by
upstream libselinux HEAD with fedora's latest libselinux in Rawhide.

Using the remainder of SELinux user space as is provided by
Fedora, and using systemd v225. Maybe the functionality depends somehow
on changes elsewhere in SELinux user space instead of just procattr.c

Aug 31 16:23:34 d30 systemd-nspawn[23531]:
setexeccon("sys.id:sys.role:sd_nspawn_container.subj:s0") failed:
Invalid argument

Maybe i made a mistake somewhere else.

You have tested it and confirmed that it works so I trust that it is
fixed.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV5GOUAAoJENAR6kfG5xmcWTcL/RF4+0cd2y4tsJ1NOLFPcSk+
ozR1lOJa99PB9X/VAblW10znPdBgyG2DWcIUX5qCqd5QgrRP4TGuVD2XDoEVQieL
vL/Xy281i7fk171hk/Y4KlIhker2EbZeni1uK5zWUaRe+QIsqcU04HaLSv2vNZmt
1O+PQjoS6CEyZdZe6Y3ruPtst9cdp6z/pyD6UsKOadgQJMa3bqMJBHfNrpTALL27
VFHOGU7xNXa3acEBfHpGf6t831qmeWX5buVjdKUu09NunRz+Kg7mC8p/qtUOc+69
ysPZY53zLWe+Zho5NyjD9hNOC04Izq7ZibMaOpet/5zSNaeB2yCpe78rRdhT0WQ3
gubGXVwZ6AA9VjMTchW7/ZinCnzixChAASyJvrVUXhcPlpREYrWR+Wh7n8KX/bgJ
e/QmD60ynRcXcJz1+wLehW0kPdiTY1nHewM4S13q/R3r1J3/XVFhQcsjkwxANW00
rd7JF8/q5/HeNy5kU+9MK46uKC7fR3RVByh+o9VkUA==
=UNg+
-----END PGP SIGNATURE-----
