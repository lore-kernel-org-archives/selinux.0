Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j48J00gA028139
	for <selinux@tycho.nsa.gov>; Sun, 8 May 2005 15:00:01 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j48IvuUT028834
	for <selinux@tycho.nsa.gov>; Sun, 8 May 2005 18:57:57 GMT
Message-ID: <427E6159.4090804@gentoo.org>
Date: Sun, 08 May 2005 21:58:33 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: gentoo diffs
References: <427CBAD8.6060901@gentoo.org> <200505090349.22645.russell@coker.com.au>
In-Reply-To: <200505090349.22645.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6C77386137FD48741352C17D"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C77386137FD48741352C17D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Hi,

Russell Coker wrote:

[snip]

> +daemon_base_domain(svc_start)
> +domain_auto_trans(init_t, svc_start_exec_t, svc_start_t)
> 
> Is this for daemons that may be started either from /etc/inittab 
> or /etc/init.d scripts?

yes, basicaly it's about svscanboot that acording to the documentation is started from inittab.
gentoo's default is to start svscan from an init script, but some users asked for the other way arround.
these two binaries are somewhat equivalent and both have a svc_start_exec_t label.

>>* kerberos: gentoo file locations
> 
> Those should have ifdef(`distro_gentoo' around them.  Ideally we want as many 
> ifdef(`distro_... rules in the file contexts as possible.  The more stuff 
> that can be removed because of being applicable to distributions other than 
> the one you use the better.  setfiles still has performance issues...

ok, I'll keep that in mind.

>>* postfix: gentoo file locations for 64bit systems
> 
> Are you seriously planning to have both 32bit and 64bit versions of Postfix 
> installed on the same system at the same time
>  If not then you shouldn't be using special names for 64bit versions. 
> If you are then I suspect you are
> doing something vastly different from what everyone else is doing and 
> ifdef(`distro_gentoo' would be appropriate.
>
> We should probably have ifdef(`distro_redhat' and ifdef(`distro_debian' in any 
> case.
> 
> Also I'm quite certain that you are not using all four combinations 
> of /usr/lib(exec)?(64)?/postfix/.

http://bugs.gentoo.org/show_bug.cgi?id=89321

we have /usr/lib/postfix and /usr/lib64/postfix depending on the profile under which it was compiled.
having it like lib(exec)?(64)? means that it's very easy to maintain, but if that's not possible, no problem.

> I plan to extend the stem compression support in setfiles to two levels, 
> taking full advantage of that means removing such conditionals from the 
> policy.

thanks,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig6C77386137FD48741352C17D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCfmFeGSBEIeh4AEYRAid5AJ48eiEDvSZGu2hhBcwfJ+96mjcDQQCdGXQD
e3or4NzcLlwc1lq4PY6mJ/U=
=f2g4
-----END PGP SIGNATURE-----

--------------enig6C77386137FD48741352C17D--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
