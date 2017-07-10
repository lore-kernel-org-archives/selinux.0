Message-ID: <1499695718.2707.120.camel@decadent.org.uk>
Subject: Re: [PATCH v2 8/8] exec: Use sane stack rlimit under secureexec
From: Ben Hutchings <ben@decadent.org.uk>
To: Kees Cook <keescook@chromium.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, David Howells <dhowells@redhat.com>,
 Serge Hallyn <serge@hallyn.com>, John Johansen
 <john.johansen@canonical.com>, Casey Schaufler <casey@schaufler-ca.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Michal Hocko <mhocko@kernel.org>, Hugh Dickins
 <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Rik van Riel <riel@redhat.com>, James Morris
 <james.l.morris@oracle.com>, Greg Ungerer <gerg@linux-m68k.org>, Ingo
 Molnar <mingo@kernel.org>, Nicolas Pitre <nicolas.pitre@linaro.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Vivek Goyal <vgoyal@redhat.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Date: Mon, 10 Jul 2017 15:08:38 +0100
In-Reply-To: <1499673451-66160-9-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
 <1499673451-66160-9-git-send-email-keescook@chromium.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-AZ4OiHTT2z20xTg4/kmc"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--=-AZ4OiHTT2z20xTg4/kmc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-07-10 at 00:57 -0700, Kees Cook wrote:
> For a secureexec, before memory layout selection has happened, reset the
> stack rlimit to something sane to avoid the caller having control over
> the resulting layouts.
>=20
> $ ulimit -s
> 8192
> $ ulimit -s unlimited
> $ /bin/sh -c 'ulimit -s'
> unlimited
> $ sudo /bin/sh -c 'ulimit -s'
> 8192
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> =C2=A0fs/exec.c | 10 ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index e0186db02f90..1e3463854a16 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1343,6 +1343,16 @@ void setup_new_exec(struct linux_binprm * bprm)
> =C2=A0
> =C2=A0		/* Make sure parent cannot signal privileged process. */
> =C2=A0		current->pdeath_signal =3D 0;
> +
> +		/*
> +		=C2=A0* For secureexec, reset the stack limit to sane default to
> +		=C2=A0* avoid bad behavior from the prior rlimits. This has to
> +		=C2=A0* happen before arch_pick_mmap_layout(), which examines
> +		=C2=A0* RLIMIT_STACK, but after the point of no return to avoid
> +		=C2=A0* needing to clean up the change on failure.
> +		=C2=A0*/
> +		if (current->signal->rlim[RLIMIT_STACK].rlim_cur > _STK_LIM)
> +			current->signal->rlim[RLIMIT_STACK].rlim_cur =3D _STK_LIM;

As setup_new_exec() is called before install_exec_creds(), I think this
leaves a window where the real user can change the limit again with
prlimit().

Ben.

> =C2=A0	}
> =C2=A0
> =C2=A0	arch_pick_mmap_layout(current->mm);
--=20
Ben Hutchings
Absolutum obsoletum. (If it works, it's out of date.) - Stafford Beer


--=-AZ4OiHTT2z20xTg4/kmc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlljimYACgkQ57/I7JWG
EQm4nQ//W/OIgx1CAVoHlo6WT1EpCxEc/Tfp7rYFu1E/zCyjmPFBB2vno7YTiEqp
LKm0VgKMBGKbxh1DsaIKzzE+u5vWWrPYP7L4+uXRSZC9l7s4OWORHORE9dKmf3WC
m8qLjBFya2nFonfQOhk2yVgZWAdAqg9nJ4BqCUk4b2OnVLgWTh9Q6Tmx1vGDYD/7
zvP6KMaL/c2FrojVx5gZ6MG3ut9rFFxT109DtzGyBD3TaBsVSipN2Qrf0q+t7OyU
0mptNigAIhbO8IyFDWUDocbbFoI6oc6Duzpjs3ECKOmNJyZGBSqpCC738LCy8tr/
vPhy9Qp/vhZj+munGMzsaJ0S72JJG2cNEZmSQR1yBXQmeGRWJ0NIHDpmR7lJodWK
A9TXRaswWA7A9nUcdhY6hQj1wAIt/LNSz1dYOYWpvFQTaiCVpJbJUyYeHt0J184y
RhT3BzAiiOEIFXfkrigAAmddJp2ek3s0EwHrj0upCP+bYvYwHMwVn387yXXARjOH
Hbjn7R1cbzG0/pUcKw85Zp3IX+ajPFIV22jIkPwvq2ss1Fx7og8yE8qs8+Lau3dx
p3go1Fanr/9KveY/mcZS8/izkOin0Q1Ak25d+exHerq+XZXvL3iOczY1/DFjKv46
kp/LFmM6GvvOwiOowiew0LIDOIAr3oRymKKvlCQoYwCzrtuFtQA=
=jPbz
-----END PGP SIGNATURE-----

--=-AZ4OiHTT2z20xTg4/kmc--
