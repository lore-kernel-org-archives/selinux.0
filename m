Date: Mon, 18 Oct 2004 23:04:43 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: More patches for policy.
Message-Id: <20041018210443.GB2536@jmh.mhn.de>
References: <41741D58.2050700@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
In-Reply-To: <41741D58.2050700@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-10-18 22:53]:
> diff --exclude-from=3Dexclude -N -u -r nsapolicy/file_contexts/program/in=
nd.fc policy-1.17.32/file_contexts/program/innd.fc
> --- nsapolicy/file_contexts/program/innd.fc	2004-06-16 13:33:37.000000000=
 -0400
> +++ policy-1.17.32/file_contexts/program/innd.fc	2004-10-18 13:37:22.0000=
00000 -0400
> @@ -8,8 +8,41 @@
>  /var/lib/news(/.*)?		system_u:object_r:innd_var_lib_t
>  /var/run/news(/.*)?	 	system_u:object_r:innd_var_run_t
>  /usr/sbin/in.nnrpd	--	system_u:object_r:innd_exec_t
> -/usr/lib(64)?/news/bin/.*	--	system_u:object_r:innd_exec_t
>  /usr/bin/inews		--	system_u:object_r:innd_exec_t
>  /usr/bin/rnews		--	system_u:object_r:innd_exec_t
> -/usr/lib/news/bin/innd 	--	system_u:object_r:innd_exec_t
> -
> +/usr/lib(64)?/news/bin(/.*)?		system_u:object_r:bin_t
> +/usr/lib(64)?/news/bin/innd 	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/actsync	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/archive	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/batcher	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/buffchan	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/convdate	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/ctlinnd	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/cvtbatch	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/expire	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/expireover	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/fastrm	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/filechan	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/getlist	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/grephistory	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/inews	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/innconfval	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/innd	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/inndf	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/inndstart	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/innfeed	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/innxbatch	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/innxmit	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/makedbz	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/makehistory	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/newsrequeue	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/nnrpd	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/nntpget	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/ovdb_recover	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/overchan	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/prunehistory	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/rnews	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/shlock	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/shrinkfile	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/sm	--	system_u:object_r:innd_exec_t
> +/usr/lib(64)?/news/bin/startinnfeed	--	system_u:object_r:innd_exec_t

This seems a little bit excessive. How many other files are there? Might
make sense to list only the files which should be labeled bin_t.

Additionally, are all these programs entrypoints to innd or are they
only called internally? I know nothing about innd, so please excuse my
ignorance. If these are all internal helper programs, they shouldn't be
labeled innd_exec_t, bin_t or innd_helper_exec_t would be better.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdC/rxWIrrrL0q+cRAq75AJ95Y1LQ5VFE0bPphUsZrKus8194LQCeMHim
kzhW8KNfbJyW1hVoPsVmG88=
=ZyXn
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
